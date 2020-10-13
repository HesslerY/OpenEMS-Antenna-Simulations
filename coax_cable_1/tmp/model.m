addpath('C:/Users/H364387/Downloads/openEMS/matlab');
close all
clear
clc

Sim_Path = '.';
Sim_CSX = 'csxcad2.xml';
fc = 4000000000;

f0 = 0;
fc = 4000000000;
length = 1000;           %coax length
numTS = 15000;           %number of timesteps
unit = 1e-3;            %drawing unit used
mesh_res = [5 5 5];     %desired mesh resistance
physical_constants;

FDTD = InitFDTD(numTS,1e-5);
FDTD = SetGaussExcite(FDTD,f0,f0);
BC = {'PEC','PEC','PEC','PEC','MUR','MUR'};
FDTD = SetBoundaryCond(FDTD,BC);
CSX = InitCSX();

CSX = AddMetal(CSX,'copper');

CSX = ImportSTL(CSX, 'copper',10, ['antenna.stl          '],'Transform',{'Scale', 1});
CSX = ImportSTL(CSX, 'copper',10, ['gnd.stl              '],'Transform',{'Scale', 1});
mesh.x = [-117.5,-115.1263,-112.7525,-110.3788,-108.0051,-105.6313,-103.2576,-100.8838,-98.5101,-96.1364,-93.7626,-91.3889,-89.0152,-86.6414,-84.2677,-81.8939,-79.5202,-77.1465,-74.7727,-72.399,-70.0253,-67.6515,-65.2778,-62.904,-60.5303,-58.1566,-55.7828,-53.4091,-51.0354,-48.6616,-46.2879,-43.9141,-41.5404,-39.1667,-36.7929,-34.4192,-32.0455,-29.6717,-27.298,-24.9242,-22.5505,-20.1768,-17.803,-15.4293,-13.0556,-10.6818,-8.3081,-5.9343,-3.5606,-1.1869,1.1869,3.5606,5.9343,8.3081,10.6818,13.0556,15.4293,17.803,20.1768,22.5505,24.9242,27.298,29.6717,32.0455,34.4192,36.7929,39.1667,41.5404,43.9141,46.2879,48.6616,51.0354,53.4091,55.7828,58.1566,60.5303,62.904,65.2778,67.6515,70.0253,72.399,74.7727,77.1465,79.5202,81.8939,84.2677,86.6414,89.0152,91.3889,93.7626,96.1364,98.5101,100.8838,103.2576,105.6313,108.0051,110.3788,112.7525,115.1263,117.5,];
mesh.y = [-117.5,-115.1263,-112.7525,-110.3788,-108.0051,-105.6313,-103.2576,-100.8838,-98.5101,-96.1364,-93.7626,-91.3889,-89.0152,-86.6414,-84.2677,-81.8939,-79.5202,-77.1465,-74.7727,-72.399,-70.0253,-67.6515,-65.2778,-62.904,-60.5303,-58.1566,-55.7828,-53.4091,-51.0354,-48.6616,-46.2879,-43.9141,-41.5404,-39.1667,-36.7929,-34.4192,-32.0455,-29.6717,-27.298,-24.9242,-22.5505,-20.1768,-17.803,-15.4293,-13.0556,-10.6818,-8.3081,-5.9343,-3.5606,-1.1869,1.1869,3.5606,5.9343,8.3081,10.6818,13.0556,15.4293,17.803,20.1768,22.5505,24.9242,27.298,29.6717,32.0455,34.4192,36.7929,39.1667,41.5404,43.9141,46.2879,48.6616,51.0354,53.4091,55.7828,58.1566,60.5303,62.904,65.2778,67.6515,70.0253,72.399,74.7727,77.1465,79.5202,81.8939,84.2677,86.6414,89.0152,91.3889,93.7626,96.1364,98.5101,100.8838,103.2576,105.6313,108.0051,110.3788,112.7525,115.1263,117.5,];
mesh.z = [0,5.0251,10.0503,15.0754,20.1005,25.1256,30.1508,35.1759,40.201,45.2261,50.2513,55.2764,60.3015,65.3266,70.3518,75.3769,80.402,85.4271,90.4523,95.4774,100.5025,105.5276,110.5528,115.5779,120.603,125.6281,130.6533,135.6784,140.7035,145.7286,150.7538,155.7789,160.804,165.8291,170.8543,175.8794,180.9045,185.9296,190.9548,195.9799,201.005,206.0302,211.0553,216.0804,221.1055,226.1307,231.1558,236.1809,241.206,246.2312,247.5,248,248.5,250,250.5,251,251.2563,252.5,253,253.5,256.2814,261.3065,266.3317,271.3568,276.3819,281.407,286.4322,291.4573,296.4824,301.5075,306.5327,311.5578,316.5829,321.608,326.6332,331.6583,336.6834,341.7085,346.7337,351.7588,356.7839,361.809,366.8342,371.8593,376.8844,381.9095,386.9347,391.9598,396.9849,402.0101,407.0352,412.0603,417.0854,422.1106,427.1357,432.1608,437.1859,442.2111,447.2362,452.2613,457.2864,462.3116,467.3367,472.3618,477.3869,482.4121,487.4372,492.4623,497.4874,502.5126,507.5377,512.5628,517.5879,522.6131,527.6382,532.6633,537.6884,542.7136,547.7387,552.7638,557.7889,562.8141,567.8392,572.8643,577.8894,582.9146,587.9397,592.9648,597.9899,603.0151,608.0402,613.0653,618.0905,623.1156,628.1407,633.1658,638.191,643.2161,648.2412,653.2663,658.2915,663.3166,668.3417,673.3668,678.392,683.4171,688.4422,693.4673,698.4925,703.5176,708.5427,713.5678,718.593,723.6181,728.6432,733.6683,738.6935,743.7186,747.5,747.7,748,748.2,748.5,748.7,748.7437,750,750.5,751,752.5,753,753.5,753.7688,758.794,763.8191,768.8442,773.8693,778.8945,783.9196,788.9447,793.9698,798.995,804.0201,809.0452,814.0704,819.0955,824.1206,829.1457,834.1709,839.196,844.2211,849.2462,854.2714,859.2965,864.3216,869.3467,874.3719,879.397,884.4221,889.4472,894.4724,899.4975,904.5226,909.5477,914.5729,919.598,924.6231,929.6482,934.6734,939.6985,944.7236,949.7487,954.7739,959.799,964.8241,969.8492,974.8744,979.8995,984.9246,989.9497,994.9749,1000,];
CSX = DefineRectGrid(CSX, unit, mesh);
coax_rad_i = 50;
coax_rad_ai = 115;
coax_rad_aa = 65;
start = [0,0,0];
stop  = [0,0,length/2];
[CSX,port{1}] = AddCoaxialPort( CSX, 10, 1, 'copper', '', start, stop, 'z', coax_rad_i, coax_rad_ai, coax_rad_aa, 'ExciteAmp', 1,'FeedShift', 10*mesh_res(1) );
%% define dump boxes... %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
CSX = AddDump(CSX,'Et_','DumpMode',2);
start = [mesh.x(1) , 0 , mesh.z(1)];
stop = [mesh.x(end) , 0 , mesh.z(end)];
CSX = AddBox(CSX,'Et_',0 , start,stop);
CSX = AddDump(CSX,'Ht_','DumpType',1,'DumpMode',2);
CSX = AddBox(CSX,'Ht_',0,start,stop);

WriteOpenEMS([Sim_Path '/' Sim_CSX],FDTD,CSX);
CSXGeomPlot([Sim_Path '/' Sim_CSX]);
