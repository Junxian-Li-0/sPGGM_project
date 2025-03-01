function [adjacent_network,total_node_num,M] = get_adjacent_network(network_path,total_gene_num)
fid=fopen(network_path);
adjacent_network={};
j=0;
while ~feof(fid)
    tline=fgetl(fid);
    j=j+1;
    adjacent_network{j}=regexp(tline, '\t', 'split');
end
fclose(fid);
total_node_num=j;
M=zeros(total_gene_num,total_gene_num);
for i=1:total_node_num
    gene1=str2num(adjacent_network{i}{1});
    for j=1:length(adjacent_network{i})
       gene2=str2num(adjacent_network{i}{j});
       M(gene1,gene2)=1;
       M(gene2,gene1)=1;
    end
end
for i=1:total_gene_num
    M(i,i)=1;
end
fprintf("total gene num:%d; total center gene num(center node num):%d\n",total_gene_num,total_node_num)
end