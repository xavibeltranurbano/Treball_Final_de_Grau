clc, close all, clear all;

path="C:\Users\GESTIO\Desktop\";
crani=niftiread(path+"Imatges Pacient\c4PACIENT_98734_t1.nii");
lesio=niftiread(path+"Resultats Segmentació\Segmentacio.nii");

%CRANI
crani(crani>1)=1;

%LESIO
lesio(lesio>1)=1;
lesio_petita=imerode(lesio, strel('disk',5));
lesio_petita2=~lesio_petita;
lesio2=~lesio;

%CRANI+LESIO
final_tot=imbinarize(crani).*lesio2;
final_tot=final_tot+lesio;
final_tot=final_tot.*lesio_petita2;


%FEM TALL TRANSVERSAL
final_tot1=final_tot(1:100,:,:);
final_tot2=final_tot(101:end,:,:);

%FEM TALL SAGITAL
final_tot3=final_tot(:,:,1:81);
final_tot4=final_tot(:,:,81:end);


%% CREEM ARCHIU STL

[Vertices, Triangle, Quads] = make_STL_of_Array('C:\Users\GESTIO\Desktop\Resultats Reconstrucció\sagital1.stl',final_tot1,1,1,1); 
[Vertices, Triangle, Quads] = make_STL_of_Array('C:\Users\GESTIO\Desktop\Resultats Reconstrucció\sagital2.stl',final_tot2,1,1,1); 
[Vertices, Triangle, Quads] = make_STL_of_Array('C:\Users\GESTIO\Desktop\Resultats Reconstrucció\transversal1.stl',final_tot3,1,1,1); 
[Vertices, Triangle, Quads] = make_STL_of_Array('C:\Users\GESTIO\Desktop\Resultats Reconstrucció\transversal2.stl',final_tot4,1,1,1);
[Vertices, Triangle, Quads] = make_STL_of_Array('C:\Users\GESTIO\Desktop\Resultats Reconstrucció\tumor.stl',lesio_petita,1,1,1);
