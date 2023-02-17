function [nanx_ALL,X]=interpNANs(signal, time, method)

if isempty(time)
    time=[1: length(signal)];
end

if isempty(method)
    method='linear'
end
[nSensors nSamples]=size(signal)

if nSensors>=nSamples
    signal=signal';
    [nSensors nSamples]=size(signal)
end

for i_sensor=1:nSensors
    temp_signal= signal(i_sensor,:);
    nanx = isnan(temp_signal);
    temp_signal(nanx) = interp1(time(~nanx), temp_signal(~nanx), time(nanx),method);
    X(i_sensor,:)=temp_signal;
    nanx_ALL(i_sensor,:)=nanx;
end

end