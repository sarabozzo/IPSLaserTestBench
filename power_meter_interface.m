% ODS Medical Inc.  
% Sentry- Incoming & QC Inspection Matlab GUI, Power Meter Interface
% Sara Anne Bozzo

% % INITIALIZE PROGRAM
clc
clear all

%load library
libfile = 'PM100D_64.dll';
hfile = 'PM100D.h';
loadlibrary(libfile, hfile);

%initialize instrument
res = libpointer('int8Ptr', int8('USB0::0x1313::0x8072::P2005602::INSTR'));
hdl = libpointer('ulongPtr', 0);
calllib('PM100D_64', 'PM100D_init', res, 1, 1, hdl);



% % WAVELENGTH
% set wavelength
wave= 785;
calllib('PM100D_64','PM100D_setWavelength', hdl.value, wave);

%verify that wavelength is correct
wavept = libpointer('doublePtr',0);
calllib('PM100D_64', 'PM100D_getWavelength',hdl.value, 0, wavept);

%display wavelength value
%A=['Wavelength is ', wavept.value, 'nm.'];
disp(wavept.value);


% % POWER AUTO-RANGE SETTING
% set power auto-range setting
autoRange=0;
calllib('PM100D_64', 'PM100D_setPowerAutoRange',hdl.value, autoRange);

%verify that power auto-range setting is correct
autorpt = libpointer('uint16Ptr',0);
calllib('PM100D_64', 'PM100D_getPowerAutorange',hdl.value, autorpt);

%display power auto-range setting
%B=['Power auto-range setting is ',autorpt.value, '.'];
disp(autorpt.value);


% % POWER RANGE
% set power range
range=0.7;
calllib('PM100D_64', 'PM100D_setPowerRange',hdl.value, range);

%verify that power range is correct
rangept = libpointer('doublePtr',0);
calllib('PM100D_64', 'PM100D_getPowerRange',hdl.value,0, rangept);

%display power range
%C=['Power range is ', rangept.value, '.'];
disp(rangept.value);


% % AVG CNT
% set avg cnt
avgCnt=100;
calllib('PM100D_64', 'PM100D_setAvgCnt',hdl.value, avgCnt);

%verify that avg cnt is correct
avgCntVal = libpointer('int16Ptr',0);
calllib('PM100D_64', 'PM100D_getAvgCnt',hdl.value,avgCntVal);

%display power range
%D=['Avg CNT value is ', avgCntVal.value, '.'];
disp(avgCntVal.value);



% %POWER MEASUREMENT
%obtain power measurements
power = libpointer('doublePtr',0);
calllib('PM100D_64', 'PM100D_measPower', hdl.value, power);

%set range of values for power measurements 
calllib('PM100D_64', 'PM100D_setPowerRange', hdl.value, 1);

%display power value obtained
%E=['The power is ', power.value, '.'];
disp(power.value);


% %CLOSE PROGRAM
%close connection to the device
calllib('PM100D_64', 'PM100D_close', hdl.value);

%unload library
unloadlibrary PM100D_64;


