function [rms] = rmswavelet(f,a)
[C,L]=wavedec(f,2,a);
coef=sqrt(2*log(100));
cD1=detcoef(C,L,1);
des_tip=std(cD1);
thr=coef*des_tip;
Cthr=wthresh(C,'h',thr);
ibex_anual_reconstruida=waverec(Cthr,L,a);
rms=sqrt(norm(ibex_anual_reconstruida-f)^2/length(ibex_anual_reconstruida));
end