<p align="center" width="100%">
    <img width="100%" src="Imatges_repositori/logos2.png">
</p>
<p align="center" width="100%">
    <img width="100%" src="Imatges_repositori/GIF_FLAIR.gif">
</p>

# Segmentació de lesions cerebrals procedents d'imatges mèdiques per la seva posterior digitalització i impressió en 3D
Treball Final de Grau (TFG) del grau d'enginyeria biomèdica de la Universitat de Girona.

## PROPÒSIT

La finalitat d'aquest projecte és desenvolupar mètodes d'ajuda per realitzar un preoperatori d'una manera més personalitzada i completa. Concretament, els mètodes que s'han desenvolupat consisteixen en programes  de segmentació del tumor, on per acomplir aquesta tasca, s'han utilitzat algoritmes no supervisats (K-Means) així com tècniques supervisades basades en xarxes neuronals convolucionals (CNNs). Un cop segmentat el tumor, aquest s'ha digitalitzat i imprès en 3D juntament amb el crani del pacient en qüestió.

## REQUERIMENTS D'INSTAL·LACIÓ

Els requeriments per poder executar aquest projecte són els següents:
- CuDNN 7.6.5
- MATLAB R2022a
- Ultimaker Cura
- Plugin Custom Supports
- 3D Builder
- Python 3.6.9
- Tensorflow 1.12
- Numpy 1.19.5
- Matplotlib 3.3.4
- NiBabel 3.2.2
- tqdm 4.63.0
- OpenCV 4.5.5.64
- scikit-image 0.17.2
- pandas 1.1.5
- SciPy 1.4.0

## BASE DE DADES

La base de dades utilitzada en el projecte provenen del repte internacional conegut com a BraTS. Concretament, hem utilitzat les dades que es van utilitzar en aquest repte l'any 2018 [(BraTS'18 web)](https://www.med.upenn.edu/sbia/brats2018/registration.html) 

## MANUAL D'USUARI

Els diferents passos per executar el projecte, són els següents:
1. Primerament hem d'obtenir la segmentació del tumor. Per acomplir aquesta tasca, haurem d'utilitzar algun dels models guardats dintre de la carpeta de la de segmentació binària mitjançant Deep Learning ([Clica per anar a la carpeta])(Treball_Final_de_Grau/Segmentació del tumor/Deep Learning/Segmentació Binària/)
Executar els programes encarregats de la segmentació. En cas d'utilitzar l'algoritme K-means, un cop segmentat el tumor, utilitzar la funció 'niftiwrite()' per guardar la segmentació d'aquest, al ordinador. Altrament, utilitzar el següent codi:


```ruby
import numpy as np
import nibabel as nib

converted_array = numpy.array(normal_array, dtype=numpy.float32) # Canviar normal_array per l'array que volem convertir al format nifti
affine = numpy.eye(4)
nifti_file = nibabel.Nifti1Image(converted_array, affine) 
path_to_save='PATH'
nibabel.save(nifti_file, path_to_save) # Canviar path_to_save pel directori on volem guardar la carpeta. En aquest directori ha d'estar especificat tant el nom de l'arxiu nifti que crearem, com la extensió d'aquest (.nii o .nii.gz)
```
2. Un cop obtinguda la segmentació del tumor, utilitzarem el programa anomenat 'Reconstruction3D' per tal de realitzar la reconstrucció del tumor i del crani del pacient. Si tot s'ha executat correctament, el programa ens hauria de crear 4 fitxers en format STL:
- sagital1.stl
- sagital2.stl
- transversal1.stl
- transversal2.stl
- tumor.stl

3. A continuació observarem les reconstruccions obtingudes mitjançant el software 3D Builder. Aleshores haurem de fixar-nos si la base del tumor està en contacte amb el crani, o per contra, està flotant. En cas que aquesta estigui flotant, haurem de col·locar un suport de forma manual. Per acomplir aquesta tasca, simplement haurem de insertar un cilindre i col·locar-lo de manera que aquest estigui en contacte amb el crani i amb la base del tumor.  
 
 <p align="center" width="100%">
    <img width="50%" src="Imatges_repositori/Insertar_Suport.PNG">
</p>
 

4. Seguidament, obrirem els fitxers resultants del pas anterior amb el software Ultimaker Cura. Aleshores, haurem de col·locar el tumor en orientació cap a vall, per tal d'optimitzar la impressió. Un cop re-orientat el model, donat que la forma del model no es uniforme, haurem de col·locar diferents suports, de forma manual, pel voltant d'aquest. Per fer això utilitzarem el plugin 'Csutom Supports'. En acabar de col·locar els suports, exportarem el model en format '.gcode'i el guardarem en una memòria USB. Imatges_repositori/Exemple_Suports.png
<p align="center" width="100%">
    <img width="50%" src="Imatges_repositori/Exemple_Suports.png">
</p>

5. Finalment, col·locarem la memòria USB en la impressora, i començarem a imprimir el model.

6. Donat que el tamany dels models és molt gran, haurem d'imprimir aquests per separat. Per tant, haurem de repetir els passos 3, 4 i 5 per cada model que volguem imprimir.


## Resultat final
### · Model obtingut mitjançant un tall sagital

<p align="center" width="100%">
    <img width="45%" src="Imatges_repositori/Sagital_1.png">
    <img width="44.2%" src="Imatges_repositori/Sagital_2.png">
    <img width="20%" src="Imatges_repositori/Sagital_3.png">
</p>

 
 ### · Model obtingut mitjançant un tall transversal
<p align="center" width="100%">
    <img width="40%" src="Imatges_repositori/Transversal_1.png">
    <img width="39.8%" src="Imatges_repositori/Transversal_2.png">
</p>

