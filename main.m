clear;
clc;
tic;
%initialization
knight_mask=[-1 -2;1 -2;-2 -1;2 -1;-2 1;2 1;-1 2;1 2];
A=uint8(zeros(8,8));
A(1,1:8)=9:16;  %whites 9=left_rook, 10=left_knight , 11=left_bishops, 12=white_queen, 13=white_king, 14=right_bishops, 15=right_knight, 16=right_rook
A(8,1:8)=33:40; %blacks 33=left_rook, 34=left_knight, 35=left_bishops, 36=black_queen, 37=black_king, 38=right_bishops, 39=right_knight, 40=right_rook
                %additional white queens will be
                %17-24
                %additional black queens will be
                %41-42-43-44-45-46-47-48
A(2,1:8)=1:8;   %white pawn
A(7,1:8)=25:32; %black pawn
v=legal_moves_blacks( A, knight_mask );



for i=1:size(v,1)
    B=A;
    B(B==v(i,3))=0;
    if(v(i,3)>24 && v(i,3)<33 && v(i,1)==1)
        B(v(i,1),v(i,2))=v(i,3)+16;
    else
        B(v(i,1),v(i,2))=v(i,3);
    end
    [v2{i}]=legal_moves_whites( B, knight_mask );
    for j=1:size(v2{i},1)
        C=B;
        C(C==v2{i}(j,3))=0;
        if(v2{i}(j,3)>0 && v2{i}(j,3)<9 && v2{i}(j,1)==8)
            C(v2{i}(j,1),v2{i}(j,2))=v2{i}(j,3)+16;
        else
            C(v2{i}(j,1),v2{i}(j,2))=v2{i}(j,3);
        end
        C(v2{i}(j,1),v2{i}(j,2))=v2{i}(j,3);
        [v3{i,j}]=legal_moves_blacks( C, knight_mask );
    end
end
toc

