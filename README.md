P.TCA - Toolbox
===
This MATLAB Toolbox creates Speech Signal Impairments Following the P.TCA Schema

For further information please read:
F. Köster, F. Schiffner, D. Guse, J. Ahrens, J. Skowronek and S. Möller: Towards a MATLAB Toolbox for Imposing Speech Signal Impairments Following the P.TCA Schema, AES 2015, New York, NY, USA

Contact:
Friedemann Köster:    friedemann.koester@tu-berlin.de
Falk Schiffner:       falk.schiffner@tu-berlin.de


How to use the MATLAB Toolbox
---
The main function of the MATLAB Toolbox is the ptcaexamples.m function.
To use the MATLAB Toolbox you have to follow the subsequent steps:

1. Use the main function of the Toolbox, ptcaexamples.m
2. Make sure that the main function ptcaexamples.m is in the MATLAB path together with a speech file and the folder Subfunction
3. The default speech file to use is the ref_male.wav/ref_female.wav file.
4. To run the code with the default file and output folder the following command must be written into the MATLAB Command Window:

 --> ptcaexamples('ref_male.wav','Output');

The code processes 47 example files for each of the degradations described in the P.TCA schema. 
The files can be found in the "Output" folder.
To use other speech files just add a .wav file (yourfile.wav) in the MATLAB path and run the code: ptcaexamples(‘yourfile.wav’,'Output').
 
Comments
---
Basically any speech file can be used. 
The only restriction of the function is that it is recommended to use speech files with a duration between 8 s and 12 s. 
The functions might also work with longer or shorter files but the authors give no guarantee in this case. 
The restriction is due to the recommended length of speech files for subjective and objective tests given by the ITU-T (ITU96, P.8632011). 
The functions provided in the Toolbox were tested on MatLab versions back to version R2009a (7.8.0.347). 
They should also work on older versions, were not tested though. 
In the provided version of the ptcaexamples.m function the functions audioread and audiowrite are used.
If you want to use older versions of MATLAB, please change the functions to wavread and wavwrite.