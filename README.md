# Segmentació de lesions cerebrals procedents d'imatges mèdiques per la seva posterior digitalització i impressió en 3D
Treball Final de Grau (TFG) del grau d'enginyeria biomèdica de la Universitat de Girona.

## PROPÒSIT 
La finalitat d'aquest projecte és desenvolupar mètodes d'ajuda per realitzar un preoperatori d'una manera més personalitzada i completa. Concretament, els mètodes que s'han desenvolupat consisteixen en mètodes de segmentació del tumor utilitzant IA. Concretament, s'han desenvolupats dos mètodes, els quals acompleixen tasques diferents: el primer d'ells realitza una segmentació binària del tumor (segmentació del tumor sencer)i, el segon realitza una segmentació semàntica del tumor ( segmentació en subregions). Cal destacar que pel desenvolupament dels mètodes que acabem d'esmentar, s'han utilitzat mètodes no supervisats així com tècniques supervisades basades en xarxes neuronals convolucionals (CNNs). Finalment, un cop segmentat el tumor, l'hem digitalitzat i imprimit en 3D  juntament amb el crani del pacient en qüestió.

## REQUERIMENTS D'INSTALACIÓ
Els requeriments per poder executar aquest projecte són els següents:
- Tensorflow 1.12
- CuDNN 7.6.5
- MATLAB R2022a
- Base de dades del BraTS'18 [(BraTS'18 web)](https://www.med.upenn.edu/sbia/brats2018/registration.html)

## MANUAL D'USUARI

Els diferents passos per executar el present projecte són els següents:
1. Executar els programes encarregats de la segmentació. En cas d'utilitzar l'algoritme K-means, un cop segmentat el tumor, utilitzar la funció 'niftiwrite' per guardar la segmentació d'aquest al ordinador. Altrament, utilitzar el següent codi:

'''
import numpy as np
import nibabel as nib

converted_array = numpy.array(normal_array, dtype=numpy.float32) # You need to replace normal array by yours
affine = numpy.eye(4)
nifti_file = nibabel.Nifti1Image(converted_array, affine)

nibabel.save(nifti_file, path_to_save) # Here you put the path + the extionsion 'nii' or 'nii.gz'
'''
