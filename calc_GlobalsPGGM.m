function sPGGM = calc_GlobalsPGGM(local_sPGGM_matrix,count,patient_label,patient_num)
[total_node_num,sample_num]=size(local_sPGGM_matrix);
count=min(count,total_node_num);
global_sPGGM=zeros(sample_num,1);
for s=1:sample_num
    tmp_ld=local_sPGGM_matrix(:,s);
    [sorted_ld,~]=sort(tmp_ld,'descend');
    global_sPGGM(s)=sum(sorted_ld(1:count))/count;
end
stage_num=length(patient_num);
sPGGM=zeros(1,stage_num);
for t=1:stage_num
    tmp_patient=(patient_label==t);
    tmp_global_sPGGM=global_sPGGM(tmp_patient);
    sPGGM(t)=mean(tmp_global_sPGGM);
end
end