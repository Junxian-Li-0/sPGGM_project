clear;
clc;
close all;

fid=fopen('Gene_network.txt');
adjacent_network={};
j=0;
while ~feof(fid)
    tline=fgetl(fid);
    j=j+1;
    adjacent_network{j}=regexp(tline, '\t', 'split');
end
fclose(fid);
total_node_num=j;

profile = readtable('UCEC_tumor.txt');
profile=table2array(profile(:,2:end));
C0=readtable('UCEC_normal.txt');
C0=table2array(C0(:,2:end));
psize=size(profile);

patients_num=[167 148 25 6 13 40 6 29];
tempcase=zeros(psize(1),length(patients_num),max(patients_num)+1);
end_index=patients_num(1);
for l=1:length(patients_num)
    if l==1
        tempcase(:,l,1:patients_num(l))=profile(:,1:end_index);
    else
        start_index=end_index+1;
        end_index=sum(patients_num(1:l));
        tempcase(:,l,1:patients_num(l))=profile(:,start_index:end_index);
    end
end

psize=size(tempcase);  % gene stage sample
ppi_network=zeros(psize(1),psize(1));
for i=1:total_node_num
    gene1=str2num(adjacent_network{i}{1});
    for j=1:length(adjacent_network{i})
       gene2=str2num(adjacent_network{i}{j});
       ppi_network(gene1,gene2)=1;
       ppi_network(gene2,gene1)=1;
    end
end
for i=1:psize(1)
    ppi_network(i,i)=1;
end

L_sPGGM2=zeros(total_node_num,psize(2),psize(3));
L_sPGGM=zeros(total_node_num,psize(2),psize(3));

mean_0=mean(C0,2);
Sigm_0 = cov(C0').*ppi_network;
for l=1:psize(2)
    for s=1:patients_num(l)
        TC=reshape(tempcase(:,l,s),psize(1),1);
        add_onecase=[C0 TC];
        mean_at=mean(add_onecase,2);
        Sigm_at = cov(add_onecase').*ppi_network;
        for na=1:total_node_num
            gene_list=str2double(adjacent_network{na});
            gene_num=length(gene_list);
            sigma_at=Sigm_at(gene_list,gene_list);
            sigma_0=Sigm_0(gene_list,gene_list);
            mu_at=mean_at(gene_list);
            mu_0=mean_0(gene_list);
            sigma0_sqrt = matrixsqrt(sigma_0);
            mix_sigma = sigma0_sqrt*sigma_at*sigma0_sqrt;
            mix_sigma_sqrt=matrixsqrt(mix_sigma);
            L_sPGGM(na,l,s)=sum((mu_0-mu_at).^2)/gene_num + trace(sigma_0+sigma_at-2*mix_sigma_sqrt)/gene_num;
        end
        [l,s]
    end 
end

save("L_sPGGM","L_sPGGM","psize","patients_num")
load L_sPGGM

stagelabel={'IA','IB','IC','IIA','IIB','IIIA','IIIB','IV'};
count=ceil(0.05*psize(1));
G_sPGGM=zeros(psize(2),psize(3));
for l=1:psize(2)
    for s=1:patients_num(l)
        tmp_lwd=L_sPGGM(:,l,s);
        [sorted_lwd,idx]=sort(tmp_lwd,'descend');
        G_sPGGM(l,s)=sum(sorted_lwd(1:count))/count;
    end
end

sPGGM=zeros(1,psize(2));
for l=1:psize(2)
    sPGGM(l)=mean(G_sPGGM(l,1:patients_num(l)));
end

plot(1:psize(2),sPGGM,'r-','LineWidth',2,'Marker','p')
xticks(1:psize(2))
xticklabels(stagelabel)
xlabel('stage')
ylabel('sPGGM');
title('UCEC')
