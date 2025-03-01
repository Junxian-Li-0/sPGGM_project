function [stage_lab,patient_label,patient_num] = get_stage(sample_stage_path)
sample_stage=readtable(sample_stage_path);
[stage_lab, ~, idx] = unique(sample_stage.stage);
patient_num = accumarray(idx, 1);
patient_label=idx;
result = table(stage_lab, patient_num, 'VariableNames', {'Stage', 'sample num'});
disp(result)
end