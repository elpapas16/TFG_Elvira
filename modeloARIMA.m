%En aquest document de codi, anem a crear-se el model ARIMA de le sèrie
%temporal.

%DADES ORIGINALS.
% data = ibex_mensual;
% data=ibex_diari;

%DADES SUAVITZADES.
%data = smooth_data_final;

%DADES AMB REMOSTREIG.
data = remuestreos(:, end);

% Visualizació de ACF y PACF
figure;
subplot(2,1,1);
autocorr(data);
title('Funció Autocorrelació (ACF)');

subplot(2,1,2);
parcorr(data);
title('Funció Autocorrelació Parcial (PACF)');
%% 
% Seleccionar model ARIMA.
 
    % Verificar que 'data' es un vector columna y no conté NaN o infinits
    data = data(:);
    data = data(~isnan(data) & ~isinf(data));

    % Inicializar variables 
    bestModel = [];
    bestAIC = inf;

    % Definir langs
    pRange = 0:2; % Ajusta estos valores segons necessitas, per a DADES 1 canvia ja que p i q van de 0 a 1 també.
    dRange = 0:1;
    qRange = 0:2;

    % Provar diferents combinacions de p, d, q
    for p = pRange
        for d = dRange
            for q = qRange
                try
                    % Ajustar el model ARIMA
                    model = arima(p, d, q);
                    [fit, ~, logL] = estimate(model, data, 'Display', 'off');

                    % Calcular el número de parámetros
                    numParams = p + q + 1; % +1 para la constante

                    % Calcular el AIC
                    aic = 2*numParams - 2*logL;

                    % Verificar si eés el millor model
                    if aic < bestAIC
                        bestModel = fit;
                        bestAIC = aic;
                    end
                catch ME
                    % Si hi ha un error al ajustar el model, mostrar el missatge
                    disp(['Error con ARIMA(', num2str(p), ',', num2str(d), ',', num2str(q), '): ', ME.message]);
                    continue;
                end
            end
        end
    end

    % Mostrar el mejor modelo i el AIC
    if ~isempty(bestModel)
        disp('Mejor modelo ARIMA:');
        disp(bestModel);
        disp(['AIC del mejor modelo: ', num2str(bestAIC)]);
    else
        disp('No se encontró un modelo ARIMA adecuado.');
    end
 
%% 
% Prediccions. AQUESTA PART ESTÀ FET AL R, ja que les gràfiques es
% visualitzaven millor.

bestModel = arima(1, 0,0); %Ajustar segons necessitas.

[fit, ~, logL] = estimate(bestModel, data, 'Display', 'off');
numSteps = 100;  % Número de pasos de predicción
[yF, yMSE] = forecast(fit, numSteps);  % Predicciones y error estándar de predicció
figure;
hold on;

% Graficar dades originals
plot(data, 'b', 'LineWidth', 1.5);  % Datos originales en azul

% Graficar prediccions
plot(length(data)+1:length(data)+numSteps, yF, 'r', 'LineWidth', 1.5);  
% axis([0 450 min(ibex_mensula) max(ibex_mensual)]);

xlabel('Tiempo');
ylabel('Valor');
title('Predicciones ARIMA');
legend('Datos originales', 'Predicciones');

hold off;
%% Pasar a formato vector para extrarelo al R.
str = sprintf('%g, ', remuestreos(:, end));
str = [str(1:end-2) ')'];  % Elimina la última coma y añade paréntesis de cierre
disp(str);

