%% w文件输出测试
str='Acoustic_Field_Data_ceshi.dat'; % 创建Acoustic_Field_Data.dat写入声场计算结果
fid1=fopen(str,'w+'); % 以"w+"读写方式打开文件。先读后写。该文件已存在则更新；不存在则创建。
% 创建可导入Tecplot的数据云.dat文件
fprintf(fid1,'dddddd ...
            dddd');
fclose(fid1);