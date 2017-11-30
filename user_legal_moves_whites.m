function [ v_final ] = user_legal_moves_whites( A,knight_mask,sel)
     [user(:,1),user(:,2),user(:,3)]=find(A.*uint8(A>0 & A<25));
     v_final=[];
     v=[];
     %legal moves for white king
     if(sel==13)
         index= find(user(:,3)==13);
         poss=user(index,1:2);
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
%          [temp_v(:,1) temp_v(:,2) temp_v(:,3)]=find(A(a,b).*uint8(A(a,b)>24));
%          temp_v(:,1:2)=temp_v(:,1:2)-2;
%          temp_v(:,1:2)=temp_v(:,1:2)+ones(size(temp_v(:,1:2),1),1)*poss;
%          temp_v(:,4)=temp_v(:,3);
%          temp_v(:,3)=13;
%          [temp_v2(:,1) temp_v2(:,2)]=find(A(a,b)==0);
%          temp_v2(:,1)=temp_v2(:,1)-size(A(a,b),1)+1;
%          temp_v2(:,2)=temp_v2(:,2)-size(A(a,b),2)+1;
%          temp_v2=temp_v2+ones(size(temp_v2,1),1)*poss;
%          temp_v=[temp_v;temp_v2 ones(size(temp_v2,1),1)*[13 0]];
     end

     
     %legal moves for white knight
     if(sel==10 || sel==15)
         index=find(user(:,3)==sel);
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
         temp_v(:,3)=sel;
         v=[v;temp_v];
     end
     
     %legal moves for white pawns
     if(sel>0 && sel<9)
         temp_poss=[];
         index=find(user(:,3)==sel);
         poss=user(index,1:2);
         if (poss(1)==2 && poss(2)==sel)
             temp_poss(1,:)=[4 sel sel 0];
         end
         temp_poss=[temp_poss;poss(1)+1 poss(2) sel 0];
         temp_a=temp_poss(:,1)+8*(temp_poss(:,2)-1);
         if(A(min(temp_a))~=0)
             temp_poss=[];
         elseif(A(max(temp_a))~=0)
             temp_poss(1,:)=[];
            
         end
         v=[v;temp_poss];
         
         if(poss(2)-1>0 && A(poss(1)+1,poss(2)-1)>24)
             v=[v;poss(1)+1 poss(2)-1 sel A(poss(1)+1,poss(2)-1)];
         end
         if(poss(2)+1<9 && A(poss(1)+1,poss(2)+1)>24)
             v=[v;poss+1 sel A(poss(1)+1,poss(2)+1)];
         end
     end
     %legal moves for  white rook
     if(sel==9 || sel==16)
         index=find(user(:,3)==sel);
         poss=user(index,1:2);
          for i=poss(1)+1:8;
              if(A(i,poss(2))==0)
                  v=[v;i poss(2) sel 0];
              elseif(A(i,poss(2))>24)
                   v=[v;i poss(2) sel A(i,poss(2))];
                   break;
              else
                  break;
              end
          end
          for i=poss(1)-1:-1:1;
              if(A(i,poss(2))==0)
                  v=[v;i poss(2) sel 0];
              elseif(A(i,poss(2))>24)
                   v=[v;i poss(2) sel A(i,poss(2))];
                   break;
              else
                  break;
              end
          end
          for i=poss(2)+1:8;
              if(A(poss(1),i)==0)
                  v=[v;poss(1) i sel 0];
              elseif(A(poss(1),i)>24)
                   v=[v;poss(1) i sel A(poss(1),i)];
                   break;
              else
                  break;
              end
          end
          for i=poss(2)-1:-1:1;
              if(A(poss(1),i)==0)
                  v=[v;poss(1) i sel 0];
              elseif(A(poss(1),i)>24)
                   v=[v;poss(1) i sel A(poss(1),i)];
                   break;
              else
                  break;
              end
          end
     end
     %legal moves for  white bishops
     if(sel==11 || sel==14)
         index=find(user(:,3)==sel);
         poss=user(index,1:2);
         i=poss+1;
         while(sum(i>0 & i<9)==2)
             if(A(i(1),i(2))==0)
                  v=[v;i(1) i(2) sel 0];
              elseif(A(i(1),i(2))>24)
                   v=[v;i(1) i(2) sel A(i(1),i(2))];
                   break;
             else
                 break;
             end
              i=i+1;
         end
         i=poss-1;
         while(sum(i>0 & i<9)==2)
             if(A(i(1),i(2))==0)
                  v=[v;i(1) i(2) sel 0];
              elseif(A(i(1),i(2))>24)
                  v=[v;i(1) i(2) sel A(i(1),i(2))];
                   break;
             else
                 break;
             end
              i=i-1;
         end
          i=[poss(1)-1 poss(2)+1];
          while(sum(i>0 & i<9)==2)
               if(A(i(1),i(2))==0)
                  v=[v;i(1) i(2) sel 0];
              elseif(A(i(1),i(2))>24)
                  v=[v;i(1) i(2) sel A(i(1),i(2))];
                   break;
             else
                 break;
               end
              i=[i(1)-1 i(2)+1];
          end
          i=[poss(1)+1 poss(2)-1];
          while(sum(i>0 & i<9)==2)
               if(A(i(1),i(2))==0)
                  v=[v;i(1) i(2) sel 0];
              elseif(A(i(1),i(2))>24)
                  v=[v;i(1) i(2) sel A(i(1),i(2))];
                   break;
             else
                 break;
               end
              i=[i(1)+1 i(2)-1];
          end
     end
     %legal moves for  white queen
     if(sel==12 || (sel>16 && sel<25))
     index=find(user(:,3)==sel);
         if(~isempty(index))
              poss=user(index,1:2);
              for i=poss(1)+1:8;
                  if(A(i,poss(2))==0)
                      v=[v;i poss(2) sel 0];
                  elseif(A(i,poss(2))>24)
                       v=[v;i poss(2) sel A(i,poss(2))];
                       break;
                  else
                      break;
                  end
              end
              for i=poss(1)-1:-1:1;
                  if(A(i,poss(2))==0)
                      v=[v;i poss(2) sel 0];
                  elseif(A(i,poss(2))>24)
                       v=[v;i poss(2) sel A(i,poss(2))];
                       break;
                  else
                      break;
                  end
              end
              for i=poss(2)+1:8;
                  if(A(poss(1),i)==0)
                      v=[v;poss(1) i sel 0];
                  elseif(A(poss(1),i)>24)
                       v=[v;poss(1) i sel A(poss(1),i)];
                       break;
                  else
                      break;
                  end
              end
              for i=poss(2)-1:-1:1;
                  if(A(poss(1),i)==0)
                      v=[v;poss(1) i sel 0];
                  elseif(A(poss(1),i)>24)
                       v=[v;poss(1) i sel A(poss(1),i)];
                       break;
                  else
                      break;
                  end
              end

          i=poss+1;
             while(sum(i>0 & i<9)==2)
                 if(A(i(1),i(2))==0)
                      v=[v;i(1) i(2) sel 0];
                  elseif(A(i(1),i(2))>24)
                       v=[v;i(1) i(2) sel A(i(1),i(2))];
                       break;
                 else
                     break;
                 end
                  i=i+1;
             end
             i=poss-1;
             while(sum(i>0 & i<9)==2)
                 if(A(i(1),i(2))==0)
                      v=[v;i(1) i(2) sel 0];
                  elseif(A(i(1),i(2))>24)
                      v=[v;i(1) i(2) sel A(i(1),i(2))];
                       break;
                 else
                     break;
                 end
                  i=i-1;
             end
              i=[poss(1)-1 poss(2)+1];
              while(sum(i>0 & i<9)==2)
                   if(A(i(1),i(2))==0)
                      v=[v;i(1) i(2) sel 0];
                  elseif(A(i(1),i(2))>24)
                      v=[v;i(1) i(2) sel A(i(1),i(2))];
                       break;
                 else
                     break;
                   end
                  i=[i(1)-1 i(2)+1];
              end
              i=[poss(1)+1 poss(2)-1];
              while(sum(i>0 & i<9)==2)
                   if(A(i(1),i(2))==0)
                      v=[v;i(1) i(2) sel 0];
                  elseif(A(i(1),i(2))>24)
                      v=[v;i(1) i(2) sel A(i(1),i(2))];
                       break;
                   else
                     break;
                   end
                  i=[i(1)+1 i(2)-1];
              end
         end
     end
     for i=1:size(v,1)
         B=A;
         B(poss(1),poss(2))=0;
         if(v(i,3)>0 && v(i,3)<9 && v(i,1)==8)
             B(v(i,1),v(i,2))=sel+16;
         else
             B(v(i,1),v(i,2))=sel;
         end
         opp_v=legal_moves_blacks( B, knight_mask,0 );
         if(~isempty(opp_v))
             if(sum(opp_v(:,4)==13)==0)
                 v_final=[v_final;v(i,:)];
             end
         end
     end
end