function local_sPGGM = get_LocalsPGGM(case_sample,ref_sample,network_path)
[total_gene,sample_num]=size(case_sample); 
[adjacent_network,total_node_num,M]=get_adjacent_network(network_path,total_gene);
local_sPGGM=zeros(total_node_num,sample_num);
Mean_ref=mean(ref_sample,2);
Sigm_ref = cov(ref_sample').*M;
for s=1:sample_num
    TC=reshape(case_sample(:,s),total_gene,1);
    add_onecase=[ref_sample TC];
    Mean_per=mean(add_onecase,2);
    Sigm_per = cov(add_onecase').*M;
    for na=1:total_node_num
        gene_id=str2double(adjacent_network{na});
        gene_num=length(gene_id);
        sigma1=Sigm_ref(gene_id,gene_id);
        sigma2=Sigm_per(gene_id,gene_id);
        mu1=Mean_ref(gene_id);
        mu2=Mean_per(gene_id);
        local_sPGGM(na,s)=calc_distance(mu1,mu2,sigma1,sigma2)/gene_num;
    end
    fprintf("Sample %d is finished.\n",s)
end
end