%DADES MENSUALS.
% serieTemporal=ibex_mensual;
% reconstruida=smooth_data_final;

%DADES DIÀRIES.
serieTemporal=ibex_diari;
reconstruida=smooth_data_final
numRemuestreos=100;

    % Calcular residus.
    residuos=serieTemporal-reconstruida;
    plot(residuos,'o');
    
    figure;
    hold on;  
    
    % Graficar la sèrie temporal original .
    plot(serieTemporal, 'Color', [0.2 0.2 1], 'LineWidth', 1.2); % Serie temporal original en azul
    
    % Inicializar una matriu per a guardar ttots els remostrejos.
    remuestreos = zeros(length(serieTemporal), numRemuestreos);
    
    % Realizar remostreig.
    for i = 1:numRemuestreos
        % Remostreig.
        remuestroAditivo = randn(size(serieTemporal)); % Generar ruido gaussiano
        serieRemuestreada = serieTemporal + residuos + remuestroAditivo; % Aplicar remuestro aditivo
        
        % Guardar remostrejos en la matriu.
        remuestreos(:, i) = serieRemuestreada;
        
        % Graficar remostrejos.
        plot(serieRemuestreada, 'Color', [1 0.7 0], 'LineWidth', 0.5); % Remuestreos aditivos en morado y amarillo con línea continua
    end
    
    %Llegenda.
    legend({'Sèrie temporal original', 'Remostrejos'}, 'Location', 'best');
    
    % Ajustar límits.
    xlim([1 length(serieTemporal)]);
    grid on;
    hold off; 
    
    
  