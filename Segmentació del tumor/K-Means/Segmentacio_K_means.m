
clc, close all, clear all;
path="C:\Users\GESTIO\Desktop\TFG\MICCAI_BraTS_2018_Data_Training\HGG";

accuracy1=[];
mconfusio=[];
list=dir(path);
llista_noms=list(4:288);
llista_test=llista_noms(229:end);
vec_valors_dice=[];
vec_valors_distance=[];
mconfusio_total=[];
hausdorff_total=[];
comptador=1;
sensibilitat=[];
especificitat=[];

for i=1:size(llista_test,1)
    ground_truth=double(niftiread(path+"/"+llista_test(i).name+"/"+llista_test(i).name+"_seg.nii"));
    flair_image=niftiread(path+"/"+llista_test(i).name+"/"+llista_test(i).name+"_flair.nii");
    t1_image=niftiread(path+"/"+llista_test(i).name+"/"+llista_test(i).name+"_t1.nii");
    t2_image=niftiread(path+"/"+llista_test(i).name+"/"+llista_test(i).name+"_t2.nii");
    t1ce_image=niftiread(path+"/"+llista_test(i).name+"/"+llista_test(i).name+"_t1ce.nii");


    %% SENSE INICIALITZAR CENTROIDES AMB NOMÉS IMATGE FLAIR IMSEGKMEANS3
    L = imsegkmeans3(flair_image,4);
    while(comptador<5)
        % PROCESSAT 1     
        if comptador==1
            G=L;
            G(G==1)=0;
            G(G==2)=0;
            G(G==3)=0;
            G(G==4)=1;
        elseif comptador==2
            G=L;
            G(G==1)=0;
            G(G==2)=0;
            G(G==3)=1;
            G(G==4)=0;
        elseif comptador==3
            G=L;
            G(G==1)=0;
            G(G==2)=1;
            G(G==3)=0;
            G(G==4)=0;
        elseif comptador==4
            G=L;
            G(G==1)=1;
            G(G==2)=0;
            G(G==3)=0;
            G(G==4)=0;
        end

        G=bwlabeln(G);
        stats=regionprops3(G,'Volume');
        allVolumes=[stats.Volume];
        vector=[];

        % POST PROCESSAT 2
        for j=1:size(stats,1)
            if allVolumes(j) > max(allVolumes)*20/100
                vector=[vector; j];
            end
        end

        im3=ismember(G,vector);

        %PROCESSAT 3
        im3 = imfill(im3,'holes');
        ground_truth(ground_truth>0)=1; %Binaritzem el vector ground_truth

        %Calculem el DSC
        valor=dice(logical(im3),logical(ground_truth));
        vec_valors_dice=[vec_valors_dice;valor];


        %Calculem la HD
        Distance=imhausdorff(logical(im3),logical(ground_truth));
        vec_valors_distance=[vec_valors_distance,Distance];

        %Calculem la Matriu de Confusió
        A=reshape(ground_truth,1,[]);
        B=reshape(im3,1,[]);
        m=confusionmat(logical(A),B);
        mconfusio=[mconfusio;m(2,2),m(1,2),m(2,1),m(1,1)];
        m=[];
        comptador=comptador+1;

    end
    
    %Ens quedem amb els resultats més alts
    posicio=find(vec_valors_dice==max(vec_valors_dice));
    accuracy1=[accuracy1; vec_valors_dice(posicio)];
    hausdorff_total=[hausdorff_total;vec_valors_distance(posicio)];
    matriu=mconfusio(posicio,:);
    TP=matriu(1);
    FP=matriu(2);
    FN=matriu(3);
    TN=matriu(4);
    sensibilitat=[sensibilitat; TP/(TP+FN)];
    especificitat=[especificitat; TN/(TN+FP)];
    comptador=1;
    vec_valors_dice=[];
    vec_valors_distance=[];
    mconfusio=[];
    TP=0;
    FP=0;
    FN=0;
    TN=0;
end

%% Mostrem els resultats obtinguts

mitjana=mean(accuracy1);
disp("MITJANA - DICE:")
disp(mitjana);

desviacio=std(accuracy1);
disp("DESVIACIÓ ESTÀNDARD - DICE:")
disp(desviacio);

disp("MITJANA - DISTANCIA DE HAUSDORFF:")
mitjana2=mean(hausdorff_total);
disp(mitjana2);
disp("DESVIACIÓ ESTÀNDARD - DISTANCIA DE HAUSDORFF:")
desviacio2=std(hausdorff_total);
disp(desviacio2);

disp("SENSIBILITAT:")
disp(mean(sensibilitat));

disp("ESPECIFICITAT:")
disp(mean(especificitat))

