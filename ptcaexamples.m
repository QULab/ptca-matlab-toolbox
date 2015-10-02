function ptcaexamples(inputfile,folder)
%
% This function creates examples for the list of degradation of the P.TCA
% schema follwing the descriptions in [1]. A discription of the files and a
% validation can be found in [2] and [3].
% INPUT:        inputfile: this is supposed to be a string of the input
%               .wav file. Example: 'file_x.wav'
%               folder: This is the string for the name of the folder the
%               example files are saved to. Example+Default: 'Output'
% OUTPUT:       The function saves the corrosponding example files in the 
%               folder 'folder' with the following names:
%               01_loudspeech.wav --> Loud speech
%               02_quietspeech.wav --> Quiet Speech
%               03_loudnessvaries.wav --> Loudness varies
%               04_speechlevfluc.wav --> Speech level fluctuations
%               05_tempspeechclip.wav --> Temporal speech clipping
%               06_choppyspeech.wav --> Choppy speech
%               07_selfclip.wav --> Self clipping
%               08_cutouts.wav --> Speech cut-outs
%               09_timbre_varies.wav --> Timbre varies
%               10_muffled_speech.wav --> Muffled speech
%               11_sharp_speech.wav --> Sharp speech
%               12_colored_speech.wav --> Colored speech
%               13_13_muddy_speech.wav --> Muddy Speech
%               14_warped_speech.wav --> Warped speech
%               15_buzzy_speech.wav --> Buzzy speech
%               16_fuzzy_speech.wav --> Fuzzy speech
%               17_nasaly_speech.wav --> Nasally speech
%               18_hissy_speech.wav --> Hissy speech
%               20_poor_intelligibility.wav --> Poor intelligibility
%               21_poor_speaker_identification.wav --> Poor speaker
%               identification
%               22_poor_localization.wav --> Poor localization
%               23_tunnel.wav --> Tunnel-sounding speech
%               24_listenerecho.wav --> Listener Echo
%               25_line_sounds_dead.wav --> Line sounds dead
%               26_loudnoise.wav --> Loud noise
%               27_noise_level_fluc.wav --> Noise level fluctuations
%               28_temporalnoiseclipping.wav --> Temporal noise clipping
%               29_noisecutouts.wav --> Noise cut outs
%               30_humnoise.wav --> Hum
%               31_buzznoise.wav --> Buzz
%               32_tonalnoise_high.wav --> Whine
%               33_pinknoise.wav --> Pink noise
%               34_whitenoise.wav --> White noise
%               35_hissnoise.wav --> Hiss
%               36_motorboatnoise.wav --> Motorboating
%               37_noise_corr_speech.wav -->Modulation Noise
%               38_noisegating.wav --> Noise gating
%               39_musicaltones.wav --> Musical tones
%               40_distortedbackgroundnoise --> Distorted background noise
%               41_static.wav --> Static
%               42_cracklingnoise --> Crackling noise
%               43_wind_buffeting.wav --> Wind buffeting  
%               44_gsmbuzz.wav --> GSM buzz
%               45_pops --> Pops
%               46_clicks --> Clicks
%               47_pre-echo.wav --> Pre-echo
%
% REFERENCES:
%   [1]:ITU-T Temporary Document TD 650rev1 (GEN/12)(2011). Requirement
%   Specification for P.TCA (Technical Causes Analysis). Source: Rapporteur
%   Q16/12 (L.Malfait), ITU, CH-Geneva
%   [2]:ITU-T Contribution COM 12-105 (2013):P.TCA exemplary listening
%   material processing and validation. Source: Deutsche Telekom AG (F.
%   Köster, J.Skowronek, F.Schiffner, S.Möller), ITU, CH-Gemeva
%   [3]:F. Köster, F. Schiffner, D. Guse, J. Ahrens, J. Skowronek and S.
%   Möller. Towards a MATLAB Toolbox for Imposing Speech Signal Impairments
%   Following the P.TCA Schema, AES 2015, New York,NY, USA
%
% CONTACT:
% Friedemann Köster:    friedemann.koester@tu-berlin.de
% Falk Schiffner:       falk.schiffner@tu-berlin.de
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Created: 11.12.13                                                   %%%
%%% Editor: Friedemann Köster                                           %%%
%%% Version 1.13                                                        %%%
%%% Last modified: 24.07.2015                                           %%%
%%% Last edited by: Friedemann Köster                                   %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
% Start of code:
% Add Folder with subfunctions
c = [pwd,'\subfunction'];
addpath(c);
%%
% Create Output folder
mkdir(folder);
%%
% Read file
[ x, fs ] = audioread(inputfile);
T = ceil( length( x ) / fs );
%%
% Loud speech
xloud = 4.5 * x;
audiowrite( [ folder '/01_loudspeech.wav' ], xloud, fs )
clear xloud
%%
% Quiet speech
xquiet = 0.05 * x;
audiowrite( [ folder '/02_quietspeech.wav' ], xquiet, fs )
clear xquiet
%%
% Loudness varies
[ signalfadeout ] = fadeout( x, fs, 0.05, 2, 2 );
audiowrite( [ folder '/03_loudnessvaries.wav' ], signalfadeout, fs )
clear signalfadeout
%%
% Speech level fluctuations
[signalslf] = speechlevelfluc( x, fs );
audiowrite( [ folder '/04_speechlevfluc.wav' ], signalslf, fs )
clear signalslf
%%
% Temporal speech clipping
voi = ( voiunvoi( x, 25e-3*fs, 0.005 ,0.95 ) ) .* x;
audiowrite( [ folder '/05_tempspeechclip.wav' ], voi, fs )
clear voi
%%
% Choppy speech
[ choppyspeech ] = choppy( x, fs );
audiowrite( [ folder '/06_choppyspeech.wav' ], choppyspeech, fs )
clear choppyspeech
%%
% Self clipping 
[ signalselfclipping ] = selfclipping( x, fs );
audiowrite( [ folder '/07_selfclip.wav' ], signalselfclipping, fs )
clear signalselfclipping
%%
% Speech cut-outs
[ signalcutout ] = cutouts( x, fs );
audiowrite( [ folder '/08_scutout.wav' ], signalcutout, fs )
clear signalcutout
%%
% Timbre varies
[ signaltimbrevaries ] = timbre_shift( x, fs, 5/6, 240 );
audiowrite( [ folder '/09_timbre_varies.wav' ], signaltimbrevaries, fs )
clear signaltimbrevaries
%%
% Muffled Speech
fu = 20*2*pi;
fo = 200*2*pi;
[ muffledspeech ] = bandfilter( x, fs, fu, fo, 4 );
[ signalmuffledspeech ] = normalize( muffledspeech, 1 );
audiowrite( [ folder '/10_muffled_speech.wav' ], signalmuffledspeech, fs )
clear fu fo signalmuffledspeech muffledspeech
%%
% Sharp Speech
fu = 1000*2*pi;
fo = 7600*2*pi;
[ sharpspeech ] = bandfilter( x, fs, fu, fo, 4 );
[ signalsharpspeech ] = normalize( sharpspeech, 1 );
audiowrite( [ folder '/11_sharp_speech.wav' ], signalsharpspeech, fs )
clear fu fo signalsharpspeech sharpspeech
%%
% Colored Speech
fu = 300*2*pi;
fo = 3400*2*pi;
[ coloredspeech ] = bandfilter( x, fs, fu, fo, 4 );
[ signalcoloredspeech ] = normalize( coloredspeech, 1 );
audiowrite( [ folder '/12_colored_speech.wav' ], signalcoloredspeech, fs )
clear fu fo signalcoloredspeech coloredspeech
%%
% Muddy Speech
output = timbre_shift_mod2(x,175);
audiowrite( [ folder '/13_muddy_speech.wav' ], output, fs )
clear output
%%
% Warped Speech
[ warped_speech ] = warpedspeech_mod ( x, fs );
audiowrite( [ folder '/14_warped_speech.wav' ], warped_speech, fs )
clear warped_speech
%%
% Buzzy Speech
signalbuzzy = buzzyspeech( x, fs, 10 );
audiowrite( [ folder '/15_buzzy_speech.wav' ], signalbuzzy, fs )
clear signalbuzzy 
%%
% Fuzzy Speech
signalfuzzy = buzzyspeech( x, fs, 1.5 );
audiowrite( [ folder '/16_fuzzy_speech.wav' ], signalfuzzy, fs )
clear signalfuzzy
%%
% Nasally Speech
signalnasal = nasallyspeech( x, fs );
audiowrite( [ folder '/17_nasaly_speech.wav' ], signalnasal, fs )
clear signalnasal
%%
% Hissy Speech
[ hissynoise ] = hissyspeech( x, fs );
[ noisy ] = addnoise( x, hissynoise, 0 );
audiowrite( [ folder '/18_hissy_speech.wav' ], noisy, fs )
clear noisy hissyspeech
%%
% Rough Speech
output = timbre_shift_mod2( x, 400 );
audiowrite( [ folder '/19_rough_speech.wav' ], output, fs )
clear output
%%
% Poor intelligibility
fu = 30*2*pi;
fo = 250*2*pi;
[ shiftedtimbre ] = timbre_shift_mod( x, fs, 450 );
[ shiftedfilteredtimbre ] = bandfilter( shiftedtimbre, fs, fu, fo, 4 );
[ signalpoorintelligibility ] = normalize( shiftedfilteredtimbre, 1 );
audiowrite( [ folder '/20_poor_intelligibility.wav' ], signalpoorintelligibility, fs )
clear fu fo signalpoorintelligibility shiftedfilteredtimbre
%%
% Poor speaker identification
[ signalpooridentification ] = timbre_shift_mod( x, fs, -200 );
audiowrite( [ folder '/21_poor_speaker_identification.wav' ], signalpooridentification, fs )
clear signalpooridentification 
%%
% Poor localization
signalpoorlocalized = displacement( x ,fs );
audiowrite( [ folder '/22_poor_localization.wav' ], signalpoorlocalized, fs )
clear signalpoorlocalized
%%
% Tunnel-sounding speech
m = abs( max( x ) );
resulttunnel = echo_mod ( x , 200 , fs, 2 );
out = normalize( resulttunnel, m );
audiowrite( [ folder '/23_tunnel.wav' ], out, fs )
clear out m resulttunnel
%%
% Listener Echo
m = abs( max( x ) );
resultecho = echo_mod ( x , 600 , fs, 1 );
out = normalize( resultecho, m );
audiowrite( [ folder '/24_listenerecho.wav' ], out, fs )
clear m out resultecho
%%
% Line sounds dead 
resultlinesoundsdead = linesoundsdead( x );
audiowrite( [ folder '/25_line_sounds_dead.wav' ], resultlinesoundsdead, fs );
clear resultlinesoundsdead
%%
% Loud noise 
[x1] = audioread('noise-wav/loudnoise_wn+bn.wav');
[ noisy ] = addnoise( x, x1, 0 );
audiowrite( [ folder '/26_loudnoise.wav' ], noisy, fs )
clear x1 noisy
%%
% Loud noise 
[ x1 ] = audioread('noise-wav/loudnoise_wn+bn.wav');
[ noisy ] = addnoise( x, x1, 0 );
audiowrite( [ folder '/26_loudnoise.wav' ], noisy, fs )
clear x1 noisy
%%
% Noise level fluctuations 
[ x1,fs1 ] = audioread('noise-wav/whitenoise.wav');
[ signalfluctuation ] = fluctuation( x1, fs1, 0.2, 0 );
[ noisy ] = addnoise( x, signalfluctuation, 10 );
audiowrite( [ folder '/27_noise_level_fluc.wav' ], noisy, fs )
clear x1 fs1 noisy
%%
% Temporal noise clipping 
[ x1 ] = audioread('noise-wav/whitetemporalclipping.wav');
[ noisy ] = addnoise( x, x1, 10 );
audiowrite( [ folder '/28_temporalnoiseclipping.wav' ], noisy, fs )
clear x1 noisy
%%
% Noise cut-outs
[ x1 ] = audioread('noise-wav/whitecutout.wav');
[ noisy ] = addnoise( x, x1, 10 );
audiowrite( [ folder '/29_noisecutouts.wav' ], noisy, fs )
clear x1 noisy
%%
% Hum noise 
% addnoise - % e.g. Hum (and other Noises) created with Audacity 
% and added and Level adjustment in Matlab
% noisetyp = input('Enter Noisetyp (e.g. ''humnoise'' or ''motorboatnoise'etc.): ');
[ x1 ] = audioread('noise-wav/humnoise.wav');
[ noisy ] = addnoise( x, x1, 10 );
audiowrite( [ folder '/30_humnoise.wav' ], noisy, fs )
clear x1 noisy
%%
% Buzz noise 
[ x1 ] = audioread('noise-wav/buzznoise.wav');
[ noisy ] = addnoise( x, x1, 10 );
audiowrite( [ folder '/31_buzznoise.wav' ], noisy, fs )
clear x1 noisy
%%
% Whine noise 
[ x1 ] = audioread('noise-wav/tonalnoise_high.wav');
[ noisy ] = addnoise( x, x1, 10 );
audiowrite( [ folder '/32_tonalnoise_high.wav' ], noisy, fs )
clear x1 noisy
%%
% Pink noise 
[ x1 ] = audioread('noise-wav/pinknoise.wav');
[ noisy ] = addnoise( x, x1, 10 );
audiowrite( [ folder '/33_pinknoise.wav' ], noisy, fs )
clear x1 noisy
%%
% White noise 
[ x1 ] = audioread('noise-wav/whitenoise.wav');
[ noisy ] = addnoise( x, x1, 10 );
audiowrite( [ folder '/34_whitenoise.wav' ], noisy, fs )
clear x1 noisy
%%
% Hiss noise 
[ x1 ] = audioread('noise-wav/hissnoise.wav');
[ noisy ] = addnoise( x, x1, 10 );
audiowrite( [ folder '/35_hissnoise.wav' ], noisy, fs )
clear x1 noisy
%%
% Motorboating noise 
[ x1 ] = audioread('noise-wav/motorboatnoise.wav');
[ noisy ] = addnoise( x, x1, 10 );
audiowrite( [ folder '/36_motorboatnoise.wav' ], noisy, fs )
clear x1 noisy
%%
% Modulation noise
[ x1 ] = audioread('noise-wav/pinknoise.wav');
[ pinkcorrelated ] = correlatedspeech( x, fs, x1 );
[ noisy ] = addnoise( x, pinkcorrelated, 15 );
audiowrite( [ folder '/37_modulation_noise.wav' ], noisy, fs );
clear x1 noisy
%%
% Noise gating
[ noisegating ] = gating( x, fs, 2 );
[ noisy ] = addnoise( x, noisegating, 10 );
audiowrite( [ folder '/38_noisegating.wav' ], noisy, fs )
clear x1 noisy
%%
% Musical Tones
[ x1,fs1 ] = audioread('noise-wav/musicaltones.wav');
[ shiftedtones ] = timbre_shift( x1, fs1, 0.5, 150 );
[ musicaltones ] = fluctuation( shiftedtones, fs1, 0.5, 0.5 );
[ noisy ] = addnoise( x, musicaltones, 10 );
audiowrite( [ folder '/39_musicaltones.wav' ], noisy, fs )
clear x1 fs1 noisy
%%
% Distorted backround noise
[ x1 ] = audioread('noise-wav/whitenoise_distorted.wav');
[ noisy ] = addnoise( x, x1, 10 );
audiowrite( [ folder '/40_distortedbackgroundnoise.wav' ], noisy, fs )
clear x1 noisy
%%
% Static noise
[ x1 ] = audioread('noise-wav/staticnoise.wav');
[ noisy ] = addnoise( x, x1, 10 );
audiowrite( [ folder '/41_static.wav' ], noisy, fs )
clear x1 noisy
%%
% Crackling noise
[ x1 ] = audioread('noise-wav/crackling_v1.wav');
[ noisy ] = addnoise( x, x1, 10 );
audiowrite( [ folder '/42_cracklingnoise.wav' ], noisy, fs )
clear x1 fs1 noisy noise
%%
% wind buffeting
[ x1 ] = audioread('noise-wav/windnoise.wav');
[ noisy ] = addnoise( x, x1, 10 );
audiowrite( [ folder '/43_wind_buffeting.wav' ], noisy, fs )
clear x1 noisy
%%
% GSM buzz
[ x1 ] = audioread('noise-wav/gsm.wav');
[ noisy ] = addnoise( x, x1, 10 );
audiowrite( [ folder '/44_gsmbuzz.wav' ], noisy, fs )
clear x1 noisy
%%
% Pops
[ x1 ] = audioread('noise-wav/pops_v1.wav');
[ noisy ] = addnoise( x, x1, 10 );
audiowrite( [ folder '/45_pops.wav' ], noisy, fs )
clear x1 noisy
%%
% Clicks
[ x1 ] = audioread('noise-wav/clicks_v2.wav');
[ noisy ] = addnoise( x, x1, 10 );
audiowrite( [ folder '/46_clicks.wav' ], noisy, fs )
clear x1 noisy
%%
% Pre-echo
[ preecho ] = onset( x, fs, T, 0.3 );
[ noisy ] = addnoise( x, preecho, 30 );
audiowrite( [ folder '/47_pre-echo.wav' ], noisy, fs )
clear x1 noisy
