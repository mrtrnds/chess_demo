function [ v_final ] = legal_moves_whites( A,knight_mask,level)
     [user(:,1),user(:,2),user(:,3)]=find(A.*uint8(A>0 & A<25));
     v_final=[];
     v=[];
     %legal moves for white king
     index= find(user(:,3)==13);
     poss=user(index,1:2);
     if(~isempty(index))
             a=poss(1)-1:poss(1)+1;
             b=poss(2)-1:poss(2)+1;
             a=a(a>0 & a<9);
             b=b(b>0 & b<9);
             for i=1:length(a)
                 for j=1:length(b)
                    if(A(a(i),b(j))==0)
                        v=[v; a(i) b(j) 13 0];
                    elseif(A(a(i),b(j))>24)
                        v=[v; a(i) b(j) 13 A(a(i),b(j))];
                    end
                 end
             end
    %          [v(:,1) v(:,2) v(:,3)]=find(A(a,b).*uint8(A(a,b)>24));
    %          v(:,1:2)=v(:,1:2)-2;
    %          v(:,1:2)=v(:,1:2)+ones(size(v(:,1:2),1),1)*poss;
    %          v(:,4)=v(:,3);
    %          v(:,3)=13;
    %          [temp_v(:,1) temp_v(:,2)]=find(A(a,b)==0);
    %          temp_v=temp_v-2;
    %          temp_v=temp_v+ones(size(temp_v,1),1)*poss;
    %          v=[v;temp_v ones(size(temp_v,1),1)*[13 0]];


         %legal moves for white knight
         vec=[10 15];
         for j=1:length(vec)
             index=find(user(:,3)==vec(j));
            %for i=1:length(index)
             if(isempty(index))
                 continue;
             end
                 poss=user(index,1:2);
                 temp_v=knight_mask+ones(size(knight_mask,1),1)*poss;
                 temp_ind=find(temp_v(:,1)<1 | temp_v(:,1)>8 | temp_v(:,2)<1 | temp_v(:,2)>8);
                 temp_v(temp_ind,:)=[];
                 temp_a=temp_v(:,1)+8*(temp_v(:,2)-1);
                 temp_a=find(A(temp_a)<25 & A(temp_a)>0);
                 temp_v(temp_a,:)=[];
                 temp_a=temp_v(:,1)+8*(temp_v(:,2)-1);
                 temp_b=find(A(temp_a));
                 [~,~,res]=find(A(temp_a));
                 temp_v(temp_b,4)=res;
                 temp_v(:,3)=vec(j);
                 v=[v;temp_v];
         end

         %legal moves for white pawns
         for i=1:8
             temp_poss=[];
             index=find(user(:,3)==i);
             if(isempty(index))
                 continue;
             end
             poss=user(index,1:2);
             if (poss(1)==2 && poss(2)==i)
                 temp_poss(1,:)=[4 i i 0];
             end
             temp_poss=[temp_poss;poss(1)+1 poss(2) i 0];
             temp_a=temp_poss(:,1)+8*(temp_poss(:,2)-1);
             if(A(min(temp_a))~=0)
                 temp_poss=[];
             elseif(A(max(temp_a))~=0)
                 temp_poss(1,:)=[];

             end
             v=[v;temp_poss];

             if(poss(2)-1>0 && A(poss(1)+1,poss(2)-1)>24)
                 v=[v;poss(1)+1 poss(2)-1 i A(poss(1)+1,poss(2)-1)];
             end
             if(poss(2)+1<9 && A(poss(1)+1,poss(2)+1)>24)
                 v=[v;poss+1 i A(poss(1)+1,poss(2)+1)];
             end
         end
         %legal moves for  white rook
         vec=[9 16];
         for j=1:length(vec)
             index=find(user(:,3)==vec(j));
             if(isempty(index))
                 continue;
             end
             poss=user(index,1:2);
    %          temp_v_row=[poss(1)*ones(length((1:poss(2)-1)'),1) (1:poss(2)-1)';poss(1)*ones(length((poss(2)+1:8)'),1) (poss(2)+1:8)'];
    %          temp_v_col=[(1:poss(1)-1)' poss(2)*ones(length((1:poss(1)-1)'),1);(poss(1)+1:8)' poss(2)*ones(length((poss(1)+1:8)'),1)];
    %          A(poss(1),temp_v_row(:,2));
    %          A(temp_v_col(:,1),poss(2));
              for i=poss(1)+1:8;
                  if(A(i,poss(2))==0)
                      v=[v;i poss(2) vec(j) 0];
                  elseif(A(i,poss(2))>24)
                       v=[v;i poss(2) vec(j) A(i,poss(2))];
                       break;
                  else
                      break;
                  end
              end
              for i=poss(1)-1:-1:1;
                  if(A(i,poss(2))==0)
                      v=[v;i poss(2) vec(j) 0];
                  elseif(A(i,poss(2))>24)
                       v=[v;i poss(2) vec(j) A(i,poss(2))];
                       break;
                  else
                      break;
                  end
              end
              for i=poss(2)+1:8;
                  if(A(poss(1),i)==0)
                      v=[v;poss(1) i vec(j) 0];
                  elseif(A(poss(1),i)>24)
                       v=[v;poss(1) i vec(j) A(poss(1),i)];
                       break;
                  else
                      break;
                  end
              end
              for i=poss(2)-1:-1:1;
                  if(A(poss(1),i)==0)
                      v=[v;poss(1) i vec(j) 0];
                  elseif(A(poss(1),i)>24)
                       v=[v;poss(1) i vec(j) A(poss(1),i)];
                       break;
                  else
                      break;
                  end
              end
         end
         %legal moves for  white bishops
         vec=[11 14];
         for j=1:length(vec)
             index=find(user(:,3)==vec(j));
             if(isempty(index))
                 continue;
             end
             poss=user(index,1:2);
             i=poss+1;
             while(sum(i>0 & i<9)==2)
                 if(A(i(1),i(2))==0)
                      v=[v;i(1) i(2) vec(j) 0];
                  elseif(A(i(1),i(2))>24)
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
                  elseif(A(i(1),i(2))>24)
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
                  elseif(A(i(1),i(2))>24)
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
                  elseif(A(i(1),i(2))>24)
                      v=[v;i(1) i(2) vec(j) A(i(1),i(2))];
                       break;
                 else
                     break;
                   end
                  i=[i(1)+1 i(2)-1];
              end
         end
         %legal moves for  white queen
         vec=[12 17:24];
         for j=1:length(vec)
         index=find(user(:,3)==vec(j));
             if(~isempty(index))
                  poss=user(index,1:2);
                  for i=poss(1)+1:8;
                      if(A(i,poss(2))==0)
                          v=[v;i poss(2) vec(j) 0];
                      elseif(A(i,poss(2))>24)
                           v=[v;i poss(2) vec(j) A(i,poss(2))];
                           break;
                      else
                          break;
                      end
                  end
                  for i=poss(1)-1:-1:1;
                      if(A(i,poss(2))==0)
                          v=[v;i poss(2) vec(j) 0];
                      elseif(A(i,poss(2))>24)
                           v=[v;i poss(2) vec(j) A(i,poss(2))];
                           break;
                      else
                          break;
                      end
                  end
                  for i=poss(2)+1:8;
                      if(A(poss(1),i)==0)
                          v=[v;poss(1) i vec(j) 0];
                      elseif(A(poss(1),i)>24)
                           v=[v;poss(1) i vec(j) A(poss(1),i)];
                           break;
                      else
                          break;
                      end
                  end
                  for i=poss(2)-1:-1:1;
                      if(A(poss(1),i)==0)
                          v=[v;poss(1) i vec(j) 0];
                      elseif(A(poss(1),i)>24)
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
                      elseif(A(i(1),i(2))>24)
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
                      elseif(A(i(1),i(2))>24)
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
                      elseif(A(i(1),i(2))>24)
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
                      elseif(A(i(1),i(2))>24)
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
                 if(v(i,3)>0 && v(i,3)<9 && v(i,1)==8)
                     B(v(i,1),v(i,2))=v(i,3)+16;
                 else
                     B(v(i,1),v(i,2))=v(i,3);
                 end
                 opp_v=legal_moves_blacks( B, knight_mask,0);
                 if(~isempty(opp_v))
                     if(sum(opp_v(:,4)==13)==0)
                         v_final=[v_final;v(i,:)];
                     end
                 end
             end
         else
             v_final=v;
         end
     end
end