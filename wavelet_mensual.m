%ELEGIM FAMILIA DE WAVELETS per suavitzar la corba.
%El primer porblema en el que ens trobem és quina familia de wavelets
%utilitzem.
%Families de wavelet: 'haar','db2',...,'db45'; 'coif1',...,'coif5'; 
%'bior1.1','bior1.3','bior1.5','bior2.2','bior2.4','bior2.6','bior2.8';
%'bior3.1','bior3.3','bior3.5','bior3.7','bior3.9',
%'bior4.4','bior5.5','bior6.8'.

%Mitjançant el càlcul del error entre la corba del IBEX35 i la corba
%suavitzada mitjançant la familia de wavelets elegida. Utilitzarem com a
%mesura de l'error el que denominarem com RMS, que computa l'error entre
%dos senyals com RMS=sqrt(norm()/N).
s=ibex_mensual;
%%%HAAR%%%
w1='haar';
rms1=rmswavelet(s,w1);

%%%DAUBECHIES%%%
w2='db2';
rms2=rmswavelet(s,w2);
w3='db3';
rms3=rmswavelet(s,w3);
w4='db4';
rms4=rmswavelet(s,w4);
w5='db5';
rms5=rmswavelet(s,w5);
w6='db6';
rms6=rmswavelet(s,w6);
w7='db7';
rms7=rmswavelet(s,w7);
w8='db8';
rms8=rmswavelet(s,w8);
w9='db9';
rms9=rmswavelet(s,w9);
w10='db10';
rms10=rmswavelet(s,w10);

%%%COIFLETS%%%
w11='coif1';
rms11=rmswavelet(s,w11);
w12='coif2';
rms12=rmswavelet(s,w12);
w13='coif3';
rms13=rmswavelet(s,w13);
w14='coif4';
rms14=rmswavelet(s,w14);
w15='coif5';
rms15=rmswavelet(s,w15);


%%%BIORTOGANALS%%
w16='bior1.1';
rms16=rmswavelet(s,w16);
w17='bior1.3';
rms17=rmswavelet(s,w17);
w18='bior1.5';
rms18=rmswavelet(s,w18);
w19='bior2.2';
rms19=rmswavelet(s,w19);
w20='bior2.4';
rms20=rmswavelet(s,w20);
w21='bior2.6';
rms21=rmswavelet(s,w21);
w22='bior2.8';
rms22=rmswavelet(s,w22);
w23='bior3.1';
rms23=rmswavelet(s,w23);
w24='bior3.3';
rms24=rmswavelet(s,w24);
w25='bior3.5';
rms25=rmswavelet(s,w25);
w26='bior3.7';
rms26=rmswavelet(s,w26);
w27='bior3.9';
rms27=rmswavelet(s,w27);
w28='bior4.4';
rms28=rmswavelet(s,w28);
w29='bior5.5';
rms29=rmswavelet(s,w29);
w30='bior6.8';
rms30=rmswavelet(s,w30);

%Ara, agafem els tres valors més xicotets.
datos=[rms1,rms2,rms3,rms4,rms5,rms6,rms7,rms8,rms9,rms10,rms11,rms12,rms13,rms14,rms15,rms16,rms17,rms18,rms19,rms20,rms21,rms22,rms23,rms24,rms25,rms26,rms27,rms28,rms29,rms30];
valores_mas_pequenos = sort(datos);
valores_mas_pequenos = valores_mas_pequenos(1:3);

% Mostrar los 43 valores más pequeños
disp('Los 3 valores más pequeños son:');
disp(valores_mas_pequenos);