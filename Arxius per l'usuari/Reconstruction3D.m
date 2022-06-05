clc, close all, clear all;
path="/Users/xavibeltranurbano/Desktop/UNIVERSITAT/TFG";

skull=niftiread(path+'/PROVA/Brats18_TCIA02_374_1/SPM/c4Brats18_TCIA02_374_1_t1.nii');
%skull=imclose(skull,strel('disk',5));
grey_matter=niftiread(path+'/PROVA/Brats18_TCIA02_374_1/SPM/c1Brats18_TCIA02_374_1_t1.nii');
white_matter=niftiread(path+'/PROVA/Brats18_TCIA02_374_1/SPM/c2Brats18_TCIA02_374_1_t1.nii');
csf=niftiread(path+'/PROVA/Brats18_TCIA02_374_1/SPM/c3Brats18_TCIA02_374_1_t1.nii');
lesio=niftiread(path+'/PROVA/Brats18_TCIA02_374_1/Mask_Brats18_TCIA02_374_1_kmeans.nii');
info=niftiinfo(path+'/PROVA/Brats18_TCIA02_374_1/Mask_Brats18_TCIA02_374_1_kmeans.nii.nii');
voxel_size=info.PixelDimensions
% lesion=isosurface(im);
% skull_2=isosurface(skull);
% %%
% patch(lesion,'FaceColor','r','EdgeColor','none');
% patch(skull_2,'FaceColor','y','EdgeColor','none','FaceAlpha',0.5);
% view(45,45); daspect(1./voxel_size); 
% axis off;
% camlight(-100,-100);  lighting phong;

% final=double(im)+imbinarize(skull);
% figure, imagesc(final(:,:,100))
%%

%SKULL
skull(skull>1)=1;

%LESIO
lesio(lesio>1)=1;
lesio_petita=imerode(lesio, strel('disk',5));
lesio_petita2=~lesio_petita;
lesio2=~lesio;

%GREY_MATTER
grey_matter(grey_matter>1)=1;
grey_matter=imbinarize(grey_matter).*lesio2;
grey_matter1=grey_matter(1:100,:,:);
grey_matter2=grey_matter(101:end,:,:);

%WHITE MATTER
white_matter(white_matter>1)=1;
white_matter=imbinarize(white_matter).*lesio2;
white_matter1=white_matter(1:100,:,:);
white_matter2=white_matter(101:end,:,:);

%CSF
csf(csf>1)=1;
csf=imbinarize(csf).*lesio2;
csf1=csf(1:100,:,:);
csf2=csf(101:end,:,:);

%SKULL+LESIO
final_tot=imbinarize(skull).*lesio2;
final_tot=final_tot+lesio;
final_tot=final_tot.*lesio_petita2;


%FEM TALL SAGITAL
%final_tot1=final_tot(1:100,:,:);
%final_tot2=final_tot(101:end,:,:);
final_tot1=final_tot(:,:,1:81);
final_tot2=final_tot(:,:,81:end);

%% CREEM ARCHIU STL

[Vertices, Triangle, Quads] = make_STL_of_Array('/Users/xavibeltranurbano/Desktop/UNIVERSITAT/TFG/PROVA/Brats18_TCIA02_374_1/MESHLAB/skull_tumor1.stl',final_tot1,1,1,1); 
[Vertices, Triangle, Quads] = make_STL_of_Array('/Users/xavibeltranurbano/Desktop/UNIVERSITAT/TFG/PROVA/Brats18_TCIA02_374_1/MESHLAB/lesio.stl',lesio_petita,1,1,1); 
[Vertices, Triangle, Quads] = make_STL_of_Array('/Users/xavibeltranurbano/Desktop/UNIVERSITAT/TFG/PROVA/Brats18_TCIA02_374_1/MESHLAB/skull_tumor2.stl',final_tot2,1,1,1); 
[Vertices, Triangle, Quads] = make_STL_of_Array('/Users/xavibeltranurbano/Desktop/UNIVERSITAT/TFG/PROVA/Brats18_TCIA02_374_1/MESHLAB/skull_tumor_grey.stl',final_tot,1,1,1);
% [Vertices, Triangle, Quads] = make_STL_of_Array('/Users/xavibeltranurbano/Desktop/UNIVERSITAT/TFG/PROVA/Brats18_TCIA02_374_1/MESHLAB/grey1.stl',grey_matter1,1,1,1);
% [Vertices, Triangle, Quads] = make_STL_of_Array('/Users/xavibeltranurbano/Desktop/UNIVERSITAT/TFG/PROVA/Brats18_TCIA02_374_1/MESHLAB/white1.stl',white_matter1,1,1,1);
% [Vertices, Triangle, Quads] = make_STL_of_Array('/Users/xavibeltranurbano/Desktop/UNIVERSITAT/TFG/PROVA/Brats18_TCIA02_374_1/MESHLAB/csf1.stl',csf1,1,1,1);
% [Vertices, Triangle, Quads] = make_STL_of_Array('/Users/xavibeltranurbano/Desktop/UNIVERSITAT/TFG/PROVA/Brats18_TCIA02_374_1/MESHLAB/grey2.stl',grey_matter2,1,1,1);
% [Vertices, Triangle, Quads] = make_STL_of_Array('/Users/xavibeltranurbano/Desktop/UNIVERSITAT/TFG/PROVA/Brats18_TCIA02_374_1/MESHLAB/white2.stl',white_matter2,1,1,1);
% [Vertices, Triangle, Quads] = make_STL_of_Array('/Users/xavibeltranurbano/Desktop/UNIVERSITAT/TFG/PROVA/Brats18_TCIA02_374_1/MESHLAB/csf2.stl',csf2,1,1,1);
% 
% 
% 
% 
