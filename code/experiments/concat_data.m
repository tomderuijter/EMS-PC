names = 10:10:60;
filename = '../../data/multi-subject/mult_subjects_expl_p';

new_PDAGs = [];
new_Gs = [];

for i = 1:length(names)
    name = strcat(filename,int2str(names(i)))
    load(name);
    
    new_Gs = cat(4, new_Gs, Gs);
    new_PDAGs = cat(4,new_PDAGs,PDAGs);
    
end

Gs = new_Gs;
PDAGs = new_PDAGs;
save('../../data/multi-subject/mult_subjects_expl.mat', 'Cs', 'Gs', 'PDAGs');
clear;