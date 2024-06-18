%Carreguem les dades de l'IBEX35 obtingudes de manera diaria.
ibex_diari=[8792.5,8906.1,8944.3,9070.7,9207.1,9232.5,9157.4,9183.2,9254.6,9312.3,9237.7,9278.7,9310,9362.9,9378.5,9421.9,9494.8,9450.9,9415.6,9406.4,9290.3,9293.7,9314.6,9241,9082,9076.7,9043.6,9147.3,9211.3,9183.2,9167.7,9182.8,9234.10,9201.5,9191.4,9211.6,9213.1,9251.5,9305,9267,9163.5,9116.1,9191.1,9180.1,9167.5,9050.2,9167.5,9317.3,9289.1,9310.8,9359.8,9338.3,9309.7,9344.4,9333.7,9432.8,9430.8,9495,9431.9,9439.8,9436.4,9364.7,9265.8,9274,9393,9481.3,9510.6,9593,9644.8,9588.4,9486.3,9285.00,9248.8,9252.9,9331.1,9453.7,9478.7,9438.3,9438,9455.7,9451.8,9519.6,9571.5,9543.5,9519.2,9600.5,9694.7,9685.1,9641.5,9502.9,9328.7,9307.1,9368.4,9358.6,9301.8,9354.4,9502.2,9434.3,9429.6,9347.5,9350.5,9278,9267.7,9262.8,9314,9315.6,9324.7,9338.9,9490.1,9581.2,9551.1,9505.9,9449.6,9416.3,9392,9314.4,9310,9364.6,9435.2,9455.4,9424.1,9549,9549.7,9482.1,9527.2,9645.8,9548.9,9502,9386,9366.9,9331.9,9426.8,9428,9319,9165.5,9102.9,9157.7,9235.8,9151.3,9352.1,9360.4,9336,9232.9,9287.1,9298.5,9212.7,9146.8,9029.1,8995.5,8975.8,8984.8,8962.8,8918.3,9013.9,9017.3,9075,9260.4,9293.9,9241.5,9235.9,9283.8,9405.2,9371.7,9461.7,9623.3,9640.7,9667.4,9761.4,9839,9827.5,9887.4,9905.5,9939,9936.1,10003.4,10062.6,10058.2,10140.8,10178.3,10238.4,10258.1,10146,10223.4,10198,10118.7,10096.1,10171.7,10095.6,10054.9,10106.7,10101,10104.3,10111.9,10121.8,10086.2,10102.1,10182.1,10053.4,10182.4,10164.5,10209,10060.3,10067.1,10004.9,10094.8,10076.9,9994.1,9867.8,9880.3,9858.3,9968.1,9859.2,9974,9916.6,9936.6,9890.3,10039.3,10077.7,10014,10062.5,9941.3,10003,9888.2,9905.4,9896.6,9984.7,9925.4,9916.6,9927.3,9886.4,9944.8,10038.2,10107.2,10138.9,10130.6,10138.4,10113.8,10068.6,10001.3,10064.7,10069.8,10117.1,10197.2,10319.6,10305.7,10325.7,10388.9,10560.5,10490.5]
%Ho dibuixem graficament.
plot(ibex_diari,"blue")
axis([0 length(ibex_diari) min(ibex_diari) max(ibex_diari)]);
title('IBEX-35 diari');
hold off
%% 
%TRIEM FAMILIA DE WAVELETS.
%Aquesta part la trobem en el document wavelet_anual.m.
%% 
%CORBA SUAVITZADA AMB LA FAMILIA DE WAVELETS TRIADA.
%Tot seguit, suavitzem la corba mitjançant wavelets.
%Descomponem la senyal en dos nivell fent ús de la familia de wavelets
%triada.
[C,L]=wavedec(ibex_diari,3,'bior3.5');
%Després de realitzar les descomposicions truncarem a partir d'un valor i recompondrem el senyal, obtenint així les dades ja suavitzades.
coef=sqrt(2*log(100));%Calculem la part que va dins de l'arrel de la formula mitjançant la qual calculem l'umbral.
cD1=detcoef(C,L,1);
des_tip=std(cD1);%Calculem la desviació tipíca de la part de detalls.

thr=coef*des_tip;%Calculem el valor de l'umral multiplicant els coeficients calculats anteriorment.

% Cthr=wthresh(C,'s',thr);%Trunquem amb funció suau.
Cthr=wthresh(C,'h',thr);%Trunquem amb funció forta.

%Reconstruim el senyal. Tornem a recomposar les dades, ja truncades amb la
%meteixa familia de wavelets triada.
ibex_diari_reconstruida1=waverec(Cthr,L,'bior3.5');

%Dibuixem els resultats per veure els resultats. Representam gràficamnet la
%curva suavizada en la curva no suavizada.
plot(ibex_diari_reconstruida1,'blue')
hold on
plot(ibex_diari,'r')
axis([0 length(ibex_diari) min(ibex_diari) max(ibex_diari)]);
legend('sèrie suavitzada IBEX-35', 'sèrie original IBEX-35','Location', 'northwest');

%GRÁFICS PROMEDIO Y TENDENCIA
%Descomposem la serie de dades mitjançant wavelets triats.
%% 
%OPCIÓ 1. Emprem els comandos appcoef, i detcoeff. I així obtenim
%subsenyal tendencia i subsenyal fluctuació.
[C,L]=wavedec(ibex_diari,3,'bior3.5'); %Decomposem el senyal.


%Extraem els valors de la tendencia i de les fluctuacions del vector C.
cA11=appcoef(C,L,'bior3.5',1); %Extraem coeficients tendencia de NIvell 1.
cD11=detcoef(C,L,1);%Extraem coeficients detalls de Nivell 1.
cA12=appcoef(C,L,'bior3.5',2); %Extraem coeficients tendencia de Nivell 2.
cD12=detcoef(C,L,2);%Extraem coeficints detalls de Nivell 2.
cA13=appcoef(C,L,'bior3.5',3); %Extraem coeficients tendencia de Nivell 3.
cD13=detcoef(C,L,3);%Extraem coeficints detalls de Nivell 3.

subplot(3,2,1);plot(cA11);axis([0 length(cA11) 0 35000]);title('Tendencia nivell 1');	% Representamos gráficamente la Tendencia de Nivell 1.
subplot(3,2,2);plot(cD11); axis([0 length(cD11) -4000 4000]);title('Detall nivell 1');	% Representamos gráficamente el Detall de Nivell 1.
subplot(3,2,3);plot(cA12);axis([0 length(cA12) 0 35000]);title('Tendencia nivell 2');	% Representamos gráficamente la Tendencia de Nivell 2.
subplot(3,2,4);plot(cD12);axis([0 length(cD12) -4000 4000]);title('Detall nivell 2');	% Representamos gráficamente el Detalle de Nivell 2.
subplot(3,2,5);plot(cA13);axis([0 length(cA13) 0 35000]);title('Tendencia nivell 3');	% Representamos gráficamente la Tendencia de Nivell 3.
subplot(3,2,6);plot(cD13);axis([0 length(cD13) -4000 4000]);title('Detall nivell 3');	% Representamos gráficamente el Detalle de Nivell 3.
%% 
%OPCIÓ 2. (Millor) Emprem els comandos wrcoef. I així  obtenim senyal
% promedio i senyal detall.
% Reconstruim a continuació les senyals promedio i detalls.
A1=wrcoef('a',C,L,'bior3.5',1);			% Traem les dades corresponents a la part de TENDENCIA del Nivell 1.
A2=wrcoef('a',C,L,'bior3.5',2);			% Traem les dades corresponents a la part de TENDENCIA del Nivell 2.
A3=wrcoef('a',C,L,'bior3.5',3);			% Traem les dades corresponents a la part de TENDENCIA del Nivell 3.
D1=wrcoef('d',C,L,'bior3.5',1);			% Traem les dades corresponents a la part de DETALL del Nivell 1.
D2=wrcoef('d',C,L,'bior3.5',2);			% Traem les dades corresponents a la part de DETALL del Nivell 2.
D3=wrcoef('d',C,L,'bior3.5',3);			% Traem les dades corresponents a la part de DETALL del Nivell 3.

subplot(3,2,1);plot(A1);axis([0 length(A1) 8000 11000]);title('TENDÈNCIA - Nivell 1');	% Representamos gráficamente la Promedio de Nivell 1.
subplot(3,2,2);plot(D1); axis([0 length(D1) -400 400]);title('DETALL + F.ALEATÒRIES - Nivell 1');	% Representamos gráficamente el Detall de Nivell 1.
subplot(3,2,3);plot(A2);axis([0 length(A2) 8000 11000]);title('TENDÈNCIA - Nivell 2');	% Representamos gráficamente la Promedio de Nivell 2.
subplot(3,2,4);plot(D2);axis([0 length(D2) -400 400]);title('DETALL + F.ALEATÒRIES - Nivell 2');	% Representamos gráficamente el Detalle de Nivell 2.
subplot(3,2,5);plot(A2);axis([0 length(A3) 8000 11000]);title('TENDÈNCIA - Nivell 3');	% Representamos gráficamente la Promedio de Nivell 3.
subplot(3,2,6);plot(D2);axis([0 length(D3) -400 400]);title('DETALL + F.ALEATÒRIES - Nivell 3');	% Representamos gráficamente el Detalle de Nivell 3.
%% 
%Per últim, fem una xicoteta comprovació.

HH=A1+D1;					% Comprovem que la suma de A1(Tendencia en Nivell 1) y D1(Detall en Nivell 1) resulta les dades originals (sin suavizar con Wavelets)

plot(HH)					% I ho representem gràficament
hold on
plot(ibex_diari,'r')

