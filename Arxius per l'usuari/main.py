import tensorflow as tf
import numpy as np
import os
import nibabel as nib
import cv2

def carreguem_imatge(path,opcio):
    imatge=[]
    data_list = sorted(os.listdir(path))

    t2 = nib.load(path + '\' + data_list[4]).get_fdata()

    flair = nib.load(path + '\' + data_list[0]).get_fdata()

    imatge.append([flair, t2])

    imatge=np.asarray(imatge,dtype=np.float32)
    return imatge

#Codi Usuari
path='C:\Users\GESTIO\Desktop\Imatges Pacient'
model = tf.keras.models.load_model('C:\Users\GESTIO\Desktop\Imatges Pacient\Model_segmentacio')
imatge = carreguem_imatge(path,0)
imatge_segmentada = model.predict(imatge)
imatge_segmentada=np.where(imatge_segmentada < 0.5,0,1)

# Convertim la segmentació en una imatge nifti
converted_array = np.array(imatge_segmentada, dtype=np.float32)
affine = np.eye(4)
nifti_file = nib.Nifti1Image(converted_array, affine)
path_resultat = 'C:\Users\GESTIO\Desktop\Resultats Segmentació\Segmentacio.nii'
nib.save(nifti_file, path_resultat)
