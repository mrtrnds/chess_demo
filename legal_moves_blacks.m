function [ v_final ] = legal_moves_blacks( A,knight_mask,level)
     [comp(:,1),comp(:,2),comp(:,3)]=find(A.*uint8((A>24)));
     v_final=[];
     v=[];
     %legal moves for black king
     index= find(comp(:,3)==37);
     poss=comp(index,1:2);
     if(~isempty(index))
             a=poss(1)-1:poss(1)+1;
             b=poss(2)-1:poss(2)+1;
             a=a(a>0 & a<9);
             b=b(b>0 & b<9);
             for i=1:length(a)
                 for j=1:length(b)
                    if(A(a(i),b(j))==0)
                        v=[v; a(i) b(j) 37 0];
                    elseif(A(a(i),b(j))<25)
                        v=[v; a(i) b(j) 37 A(a(i),b(j))];
                    end
                 end
             end
    %          [v(:,1) v(:,2) v(:,3)]=find(A(a,b).*uint8(A(a,b)>0 & A(a,b)<25));
    %          v(:,1:2)=v(:,1:2)-2;
    %          v(:,1:2)=v(:,1:2)+ones(size(v(:,1:2),1),1)*poss;
    %          v(:,4)=v(:,3);
    %          v(:,3)=37;
    %          [temp_v(:,1) temp_v(:,2)]=find(A(a,b)==0);
    %          temp_v=temp_v-2;
    %          temp_v=temp_v+ones(size(temp_v,1),1)*poss;


         %legal moves for black knight
         vec=[34 39];
         for j=1:length(vec)
             index=find(comp(:,3)==vec(j));
            %for i=1:length(index)
             if(isempty(index))
                 continue;
             end
                 poss=comp(index,1:2);
                 temp_v=knight_mask+ones(size(knight_mask,1),1)*poss;
                 temp_ind=find(temp_v(:,1)<1 | temp_v(:,1)>8 | temp_v(:,2)<1 | temp_v(:,2)>8);
                 temp_v(temp_ind,:)=[];
                 temp_a=temp_v(:,1)+8*(temp_v(:,2)-1);
                 temp_a=find(A(temp_a)>24);
                 temp_v(temp_a,:)=[];
                 temp_a=temp_v(:,1)+8*(temp_v(:,2)-1);
                 temp_b=find(A(temp_a));
                 [~,~,res]=find(A(temp_a));
                 temp_v(temp_b,4)=res;
                 temp_v(:,3)=vec(j);
                 v=[v;temp_v];
         end

         %legal moves for black pawns
         for i=25:32
             temp_poss=[];
             index=find(comp(:,3)==i);
             if(isempty(index))
                 continue;
             end
             poss=comp(index,1:2);
             if (poss(1)==7 && poss(2)==i-24)
                 temp_poss(1,:)=[5 i-24 i 0];
             end
             temp_poss=[temp_poss;poss(1)-1 poss(2) i 0];
             temp_a=temp_poss(:,1)+8*(temp_poss(:,2)-1);
             if(A(max(temp_a))~=0)
                 temp_poss=[];
             elseif(A(min(temp_a))~=0)
                 temp_poss(1,:)=[];

             end
             v=[v;temp_poss];

             if(poss(2)-1>0 && A(poss(1)-1,poss(2)-1)<25 && A(poss(1)-1,poss(2)-1)>0)
                 v=[v;poss-1 i A(poss(1)-1,poss(2)-1)];
             end
             if(poss(2)+1<9 && A(poss(1)-1,poss(2)+1)<25 && A(poss(1)-1,poss(2)+1)>0)
                 v=[v;poss(1)-1 poss(2)+1 i A(poss(1)-1,poss(2)+1)];
             end
         end
         %legal moves for  black rook
         vec=[33 40];
         for j=1:length(vec)
             index=find(comp(:,3)==vec(j));
             if(isempty(index))
                 continue;
             end
             poss=comp(index,1:2);
    %          temp_v_row=[poss(1)*ones(length((1:poss(2)-1)'),1) (1:poss(2)-1)';poss(1)*ones(length((poss(2)+1:8)'),1) (poss(2)+1:8)'];
    %          temp_v_col=[(1:poss(1)-1)' poss(2)*ones(length((1:poss(1)-1)'),1);(poss(1)+1:8)' poss(2)*ones(length((poss(1)+1:8)'),1)];
    %          A(poss(1),temp_v_row(:,2));
    %          A(temp_v_col(:,1),poss(2));
              for i=poss(1)+1:8;
                  if(A(i,poss(2))==0)
                      v=[v;i poss(2) vec(j) 0];
                  elseif(A(i,poss(2))<25)
                       v=[v;i poss(2) vec(j) A(i,poss(2))];
                       break;
                  else
                      break;
                  end
              end
              for i=poss(1)-1:-1:1;
                  if(A(i,poss(2))==0)
                      v=[v;i poss(2) vec(j) 0];
                  elseif(A(i,poss(2))<25)
                       v=[v;i poss(2) vec(j) A(i,poss(2))];
                       break;
                  else
                      break;
                  end
              end
              for i=poss(2)+1:8;
                  if(A(poss(1),i)==0)
                      v=[v;poss(1) i vec(j) 0];
                  elseif(A(poss(1),i)<25)
                       v=[v;poss(1) i vec(j) A(poss(1),i)];
                       break;
                  else
                      break;
                  end
              end
              for i=poss(2)-1:-1:1;
                  if(A(poss(1),i)==0)
                      v=[v;poss(1) i vec(j) 0];
                  elseif(A(poss(1),i)<25)
                       v=[v;poss(1) i vec(j) A(poss(1),i)];
                       break;
                  else
                      break;
                  end
              end
         end
         %legal moves for  black bishops
         vec=[35 38];
         for j=1:length(vec)
             index=find(comp(:,3)==vec(j));
             if(isempty(index))
                 continue;
             end
             poss=comp(index,1:2);
             i=poss+1;
             while(sum(i>0 & i<9)==2)
                 if(A(i(1),i(2))==0)
                      v=[v;i(1) i(2) vec(j) 0];
                  elseif(A(i(1),i(2))<25)
                       v=[v;i(1) i(2) vec(j) A(i(1),i(2))];
                       break;
                 else
                     break;
                 end
                  i=i+1;
             end
             i=poss-1;
             while(sum(i>0 & i<9)==2)
                 if(A(i(1),i(2))==0)
                      v=[v;i(1) i(2) vec(j) 0];
                  elseif(A(i(1),i(2))<25)
                      v=[v;i(1) i(2) vec(j) A(i(1),i(2))];
                       break;
                 else
                     break;
                 end
                  i=i-1;
             end
              i=[poss(1)-1 poss(2)+1];
              while(sum(i>0 & i<9)==2)
                   if(A(i(1),i(2))==0)
                      v=[v;i(1) i(2) vec(j) 0];
                  elseif(A(i(1),i(2))<25)
                      v=[v;i(1) i(2) vec(j) A(i(1),i(2))];
                       break;
                 else
                     break;
                   end
                  i=[i(1)-1 i(2)+1];
              end
              i=[poss(1)+1 poss(2)-1];
              while(sum(i>0 & i<9)==2)
                   if(A(i(1),i(2))==0)
                      v=[v;i(1) i(2) vec(j) 0];
                  elseif(A(i(1),i(2))<25)
                      v=[v;i(1) i(2) vec(j) A(i(1),i(2))];
                       break;
                 else
                     break;
                   end
                  i=[i(1)+1 i(2)-1];
              end
         end
         %legal moves for  black queen
         vec=[36 41:48];
         for j=1:length(vec)
         index=find(comp(:,3)==vec(j));
             if(~isempty(index))
                  poss=comp(index,1:2);
                  for i=poss(1)+1:8;
                      if(A(i,poss(2))==0)
                          v=[v;i poss(2) vec(j) 0];
                      elseif(A(i,poss(2))<25)
                           v=[v;i poss(2) vec(j) A(i,poss(2))];
                           break;
                      else
                          break;
                      end
                  end
                  for i=poss(1)-1:-1:1;
                      if(A(i,poss(2))==0)
                          v=[v;i poss(2) vec(j) 0];
                      elseif(A(i,poss(2))<25)
                           v=[v;i poss(2) vec(j) A(i,poss(2))];
                           break;
                      else
                          break;
                      end
                  end
                  for i=poss(2)+1:8;
                      if(A(poss(1),i)==0)
                          v=[v;poss(1) i vec(j) 0];
                      elseif(A(poss(1),i)<25)
                           v=[v;poss(1) i vec(j) A(poss(1),i)];
                           break;
                      else
                          break;
                      end
                  end
                  for i=poss(2)-1:-1:1;
                      if(A(poss(1),i)==0)
                          v=[v;poss(1) i vec(j) 0];
                      elseif(A(poss(1),i)<25)
                           v=[v;poss(1) i vec(j) A(poss(1),i)];
                           break;
                      else
                          break;
                      end
                  end

              i=poss+1;
                 while(sum(i>0 & i<9)==2)
                     if(A(i(1),i(2))==0)
                          v=[v;i(1) i(2) vec(j) 0];
                      elseif(A(i(1),i(2))<25)
                           v=[v;i(1) i(2) vec(j) A(i(1),i(2))];
                           break;
                     else
                         break;
                     end
                      i=i+1;
                 end
                 i=poss-1;
                 while(sum(i>0 & i<9)==2)
                     if(A(i(1),i(2))==0)
                          v=[v;i(1) i(2) vec(j) 0];
                      elseif(A(i(1),i(2))<25)
                          v=[v;i(1) i(2) vec(j) A(i(1),i(2))];
                           break;
                     else
                         break;
                     end
                      i=i-1;
                 end
                  i=[poss(1)-1 poss(2)+1];
                  while(sum(i>0 & i<9)==2)
                       if(A(i(1),i(2))==0)
                          v=[v;i(1) i(2) vec(j) 0];
                      elseif(A(i(1),i(2))<25)
                          v=[v;i(1) i(2) vec(j) A(i(1),i(2))];
                           break;
                     else
                         break;
                       end
                      i=[i(1)-1 i(2)+1];
                  end
                  i=[poss(1)+1 poss(2)-1];
                  while(sum(i>0 & i<9)==2)
                       if(A(i(1),i(2))==0)
                          v=[v;i(1) i(2) vec(j) 0];
                      elseif(A(i(1),i(2))<25)
                          v=[v;i(1) i(2) vec(j) A(i(1),i(2))];
                           break;
                       else
                         break;
                       end
                      i=[i(1)+1 i(2)-1];
                  end
             end
         end
         if(level==1)
             for i=1:size(v,1)
                 B=A;
                 B(B==v(i,3))=0;
                 if(v(i,3)>24 && v(i,3)<33 && v(i,1)==1)
                     B(v(i,1),v(i,2))=v(i,3)+16;
                 else
                     B(v(i,1),v(i,2))=v(i,3);
                 end
                 opp_v=legal_moves_whites( B, knight_mask,0);
                 if(~isempty(opp_v))
                     if(sum(opp_v(:,4)==37)==0)
                         v_final=[v_final;v(i,:)];
                     end
                 end
             end
         else
             v_final=v;
         end
     end
end