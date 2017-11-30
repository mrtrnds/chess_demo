clear;
clc;
A=zeros(480,480);
B=255*ones(60,60);
for i=0:3
    for j=0:3
        A(1+i*120:60+i*120,1+j*120:60+j*120)=B;
         A(61+i*120:120+i*120,61+j*120:120+j*120)=B;
    end
end
imshow(A);
imwrite(A,'board.jpg');