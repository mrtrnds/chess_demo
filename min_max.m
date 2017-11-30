function [ move ] = min_max( A,knight_mask)
values=[0 -1*ones(1,8) -7 -4 -3.5 -13.5 -4 -4 -3.5 -7 -13.5*ones(1,8) 1*ones(1,8) 7 4 3.5 14 4 4 3.5 7 13.5*ones(1,8)];
%values=[0 -20*ones(1,8) -7 -4 -3.5 -13.5 -4 -4 -3.5 -7 -13.5*ones(1,8) 1*ones(1,8) 7 4 3.5 14 4 4 3.5 7 13.5*ones(1,8)];
score=sum(values(A(:)+1));
v_final=legal_moves_blacks( A, knight_mask,1);
move=[];
for i=1:size(v_final,1)
    B=A;
    B(B==v_final(i,3))=0;
    if(v_final(i,3)>24 && v_final(i,3)<33 && v_final(i,1)==1)
        B(v_final(i,1),v_final(i,2))=v_final(i,3)+16;
    else
        B(v_final(i,1),v_final(i,2))=v_final(i,3);
    end
    v2_final{i}=legal_moves_whites( B, knight_mask,1);
%     v2_final{i}=[v2_final{i} v_final(i,4)];
    temp_val=10000;
    for j=1:size(v2_final{i},1)
        C=B;
        C(C==v2_final{i}(j,3))=0;
        if(v2_final{i}(j,3)>0 && v2_final{i}(j,3)<9 && v2_final{i}(j,1)==8)
            C(v2_final{i}(j,1),v2_final{i}(j,2))=v2_final{i}(j,3)+16;
        else
            C(v2_final{i}(j,1),v2_final{i}(j,2))=v2_final{i}(j,3);
        end
        C(v2_final{i}(j,1),v2_final{i}(j,2))=v2_final{i}(j,3);
        v3{i,j}=legal_moves_blacks( C, knight_mask,0);
        v3{i,j}=score-sum(values([v3{i,j}(:,4) ones(size(v3{i,j},1),1)*double([v2_final{i}(j,4) v_final(i,4)])]+1),2); %wow
        v3{i,j}=max(v3{i,j});
        if(temp_val>v3{i,j})
            temp_val=v3{i,j};
        end
    end
    lea(i)=temp_val;
end

if(~isempty(v_final))
    [val,Idx]=max(lea);
    %evaluation
    select=find(lea==val);
    select=select(ceil(length(select)*rand()));
    move=v_final(select,:);
end
end