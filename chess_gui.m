function varargout = chess_gui(varargin)
% CHESS_GUI MATLAB code for chess_gui.fig
%      CHESS_GUI, by itself, creates a new CHESS_GUI or raises the existing
%      singleton*.
%
%      H = CHESS_GUI returns the handle to a new CHESS_GUI or the handle to
%      the existing singleton*.
%
%      CHESS_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CHESS_GUI.M with the given input arguments.
%
%      CHESS_GUI('Property','Value',...) creates a new CHESS_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before chess_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to chess_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help chess_gui

% Last Modified by GUIDE v2.5 30-Nov-2017 18:59:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @chess_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @chess_gui_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before chess_gui is made visible.
function chess_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to chess_gui (see VARARGIN)

% Choose default command line output for chess_gui
handles.output = hObject;
handles.A=imread('board.jpg');
%  set(handles.axes1,'xlim',[1 480]);
%  set(handles.axes1,'ylim',[1 480]);
%  axes(handles.axes1); 
colormap(gray)
handles.axes1 = imagesc(handles.A);

%  axis equal;
%  axis tight;
 axis off;
% Update handles structure
handles.knight_mask=[-1 -2;1 -2;-2 -1;2 -1;-2 1;2 1;-1 2;1 2];

white_rook_wb=rgb2gray(imread('white_rook_wb.jpg'));
white_rook_bb=rgb2gray(imread('white_rook_bb.jpg'));

white_knight_wb=rgb2gray(imread('white_knight_wb.jpg'));
white_knight_bb=rgb2gray(imread('white_knight_bb.jpg'));

white_bishop_wb=rgb2gray(imread('white_bishop_wb.jpg'));
white_bishop_bb=rgb2gray(imread('white_bishop_bb.jpg'));

white_queen_wb=rgb2gray(imread('white_queen_wb.jpg'));
white_queen_bb=rgb2gray(imread('white_queen_bb.jpg'));

white_king_wb=rgb2gray(imread('white_king_wb.jpg'));
white_king_bb=rgb2gray(imread('white_king_bb.jpg'));

white_pawn_wb=rgb2gray(imread('white_pawn_wb.jpg'));
white_pawn_bb=rgb2gray(imread('white_pawn_bb.jpg'));

black_rook_wb=rgb2gray(imread('black_rook_wb.jpg'));
black_rook_bb=rgb2gray(imread('black_rook_bb.jpg'));

black_knight_wb=rgb2gray(imread('black_knight_wb.jpg'));
black_knight_bb=rgb2gray(imread('black_knight_bb.jpg'));

black_bishop_wb=rgb2gray(imread('black_bishop_wb.jpg'));
black_bishop_bb=rgb2gray(imread('black_bishop_bb.jpg'));

black_queen_wb=rgb2gray(imread('black_queen_wb.jpg'));
black_queen_bb=rgb2gray(imread('black_queen_bb.jpg'));

black_king_wb=rgb2gray(imread('black_king_wb.jpg'));
black_king_bb=rgb2gray(imread('black_king_bb.jpg'));

black_pawn_wb=rgb2gray(imread('black_pawn_wb.jpg'));
black_pawn_bb=rgb2gray(imread('black_pawn_bb.jpg'));
handles.pionia=uint8(zeros(2,60,60,48));
handles.pionia(1,:,:,1:8)=repmat(white_pawn_wb,1,1,8);
handles.pionia(2,:,:,1:8)=repmat(white_pawn_bb,1,1,8);
handles.pionia(1,:,:,25:32)=repmat(black_pawn_wb,1,1,8);
handles.pionia(2,:,:,25:32)=repmat(black_pawn_bb,1,1,8);
handles.pionia(1,:,:,[12 17:24])=repmat(white_queen_wb,1,1,9);
handles.pionia(2,:,:,[12 17:24])=repmat(white_queen_bb,1,1,9);
handles.pionia(1,:,:,[36 41:48])=repmat(black_queen_wb,1,1,9);
handles.pionia(2,:,:,[36 41:48])=repmat(black_queen_bb,1,1,9);

handles.pionia(1,:,:,[9 16])=repmat(white_rook_wb,1,1,2);
handles.pionia(2,:,:,[9 16])=repmat(white_rook_bb,1,1,2);
handles.pionia(1,:,:,[10 15])=repmat(white_knight_wb,1,1,2);
handles.pionia(2,:,:,[10 15])=repmat(white_knight_bb,1,1,2);
handles.pionia(1,:,:,[11 14])=repmat(white_bishop_wb,1,1,2);
handles.pionia(2,:,:,[11 14])=repmat(white_bishop_bb,1,1,2);
handles.pionia(1,:,:,13)=white_king_wb;
handles.pionia(2,:,:,13)=white_king_bb;
handles.pionia(1,:,:,[33 40])=repmat(black_rook_wb,1,1,2);
handles.pionia(2,:,:,[33 40])=repmat(black_rook_bb,1,1,2);
handles.pionia(1,:,:,[34 39])=repmat(black_knight_wb,1,1,2);
handles.pionia(2,:,:,[34 39])=repmat(black_knight_bb,1,1,2);
handles.pionia(1,:,:,[35 38])=repmat(black_bishop_wb,1,1,2);
handles.pionia(2,:,:,[35 38])=repmat(black_bishop_bb,1,1,2);
handles.pionia(1,:,:,37)=black_king_wb;
handles.pionia(2,:,:,37)=black_king_bb;
handles.flag=0;

axis off;
guidata(hObject, handles);

% UIWAIT makes chess_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = chess_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Game_Callback(hObject, eventdata, handles)
% hObject    handle to Game (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --------------------------------------------------------------------
function About_Callback(hObject, eventdata, handles)

% hObject    handle to About (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Info_Callback(hObject, eventdata, handles)
openfig('Info.fig');
% hObject    handle to Info (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function New_Callback(hObject, eventdata, handles)
handles.undo=1;
handles.lose=0;
handles.history=[];
handles.win=0;
handles.A=imread('board.jpg');
colormap(gray)
handles.axes1 = imagesc(handles.A);
axis off;
handles.board=(zeros(8,8));
handles.flag=0;
handles.board(1,1:8)=9:16;  %whites 9=left_rook, 10=left_knight , 11=left_bishops, 12=white_queen, 13=white_king, 14=right_bishops, 15=right_knight, 16=right_rook
handles.board(8,1:8)=33:40; %blacks 33=left_rook, 34=left_knight, 35=left_bishops, 36=black_queen, 37=black_king, 38=right_bishops, 39=right_knight, 40=right_rook
                            %additional white queens will be
                            %17-24
                            %additional black queens will be
                            %41-42-43-44-45-46-47-48
handles.board(2,1:8)=1:8;   %white pawn
handles.board(7,1:8)=25:32; %black pawn
%pernaw sto tablo tis eikones me ta pionia
handles.A(1:60,1:60)=handles.pionia(1,:,:,33);
handles.A(1:60,61:120)=handles.pionia(2,:,:,34);
handles.A(1:60,121:180)=handles.pionia(1,:,:,35);
handles.A(1:60,181:240)=handles.pionia(2,:,:,36);
handles.A(1:60,241:300)=handles.pionia(1,:,:,37);
handles.A(1:60,301:360)=handles.pionia(2,:,:,38);
handles.A(1:60,361:420)=handles.pionia(1,:,:,39);
handles.A(1:60,421:480)=handles.pionia(2,:,:,40);

handles.A(421:480,1:60)=handles.pionia(2,:,:,9);
handles.A(421:480,61:120)=handles.pionia(1,:,:,10);
handles.A(421:480,121:180)=handles.pionia(2,:,:,11);
handles.A(421:480,181:240)=handles.pionia(1,:,:,12);
handles.A(421:480,241:300)=handles.pionia(2,:,:,13);
handles.A(421:480,301:360)=handles.pionia(1,:,:,14);
handles.A(421:480,361:420)=handles.pionia(2,:,:,15);
handles.A(421:480,421:480)=handles.pionia(1,:,:,16);

for i=0:3
    handles.A(61:120,1+i*120:60+i*120)=handles.pionia(2,:,:,25);
    handles.A(61:120,61+i*120:120+i*120)=handles.pionia(1,:,:,25);
    handles.A(361:420,1+i*120:60+i*120)=handles.pionia(1,:,:,1);
    handles.A(361:420,61+i*120:120+i*120)=handles.pionia(2,:,:,1);
end
handles.axes1 = imagesc(handles.A); 
set(handles.axes1,'ButtonDownFcn',{@draw,handles})
axis off;

guidata(hObject, handles);
% hObject    handle to New (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on mouse press over axes background.
function draw(hObject,eventdata,handles)
% button=get(figure(chess_gui),'SelectionType');
if(handles.flag==0)
    button=get(gcf,'SelectionType');
    coords=round(get(gca,'Currentpoint'));
    x = coords(1,1);
    y = coords(1,2);
    if (x<480 && y<480)
        if strcmp(button,'normal')
            handles.sel=[ceil((480-y)/60) ceil(x/60) handles.board(ceil((480-y)/60),ceil(x/60))];
            if(handles.sel(3)<25 && handles.sel(3)>0)
               handles.flag=1;
               handles.v=user_legal_moves_whites( uint8(handles.board), handles.knight_mask, handles.sel(3));
            end
        elseif strcmp(button,'alt')
            handles.flag=0;
        end
        %imshow(handles.im,'Parent',handles.axes1);
         handles.axes1 = imagesc(handles.A);
         axis off;
    end
    set(handles.axes1,'ButtonDownFcn',{@draw,handles}) 
elseif(handles.flag==1)
    move=0;
    button=get(gcf,'SelectionType');
    coords=round(get(gca,'Currentpoint'));
    x = coords(1,1);
    y = coords(1,2);
    if (x<480 && y<480)
        if strcmp(button,'normal')
            handles.sel2=[ceil((480-y)/60) ceil(x/60) handles.board(ceil((480-y)/60),ceil(x/60))];
            for j=1:size(handles.v,1)
                if(handles.v(j,1)==handles.sel2(1) && handles.v(j,2)==handles.sel2(2))
                    move=1;
                end
            end
            if(move)
                handles.flag=0;
                handles.board(handles.sel(1),handles.sel(2))=0;
                handles.history=[handles.history; handles.sel handles.sel2];
                if(handles.sel(3)>1 && handles.sel(3)<9 && handles.sel2(1)==8)
                    handles.board(handles.sel2(1),handles.sel2(2))=handles.sel(3)+16;
                    handles.sel(3)=handles.sel(3)+16;
                else
                    handles.board(handles.sel2(1),handles.sel2(2))=handles.sel(3);
                end
                if((mod(handles.sel(1),2)==1 && mod(handles.sel(2),2)==1) || (mod(handles.sel(1),2)==0 && mod(handles.sel(2),2)==0))
                    handles.A(480-(handles.sel(1)-1)*60:-1:480-handles.sel(1)*60+1,(handles.sel(2)-1)*60+1:handles.sel(2)*60)=0;
                else
                    handles.A(480-(handles.sel(1)-1)*60:-1:480-handles.sel(1)*60+1,(handles.sel(2)-1)*60+1:handles.sel(2)*60)=255;
                end
                if((mod(handles.sel2(1),2)==1 && mod(handles.sel2(2),2)==1) || (mod(handles.sel2(1),2)==0 && mod(handles.sel2(2),2)==0))
                    handles.A(480-handles.sel2(1)*60+1:480-(handles.sel2(1)-1)*60,(handles.sel2(2)-1)*60+1:handles.sel2(2)*60)=handles.pionia(2,:,:,handles.sel(3));
                else
                    handles.A(480-handles.sel2(1)*60+1:480-(handles.sel2(1)-1)*60,(handles.sel2(2)-1)*60+1:handles.sel2(2)*60)=handles.pionia(1,:,:,handles.sel(3));
                end
                handles.axes1 = imagesc(handles.A);
                axis off;
                drawnow;
                set(handles.Undo,'Enable','off');
                AImove=double(min_max(uint8(handles.board),handles.knight_mask)); %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                if(isempty(AImove))
                    patt=legal_moves_whites(uint8(handles.board), handles.knight_mask,0);
                    if(sum(patt(:,4)==37)>0)
                        handles.axes1 = imagesc(handles.A);
                        axis off;
                        handles.lose=1;
                        openfig('youwin.fig');
                        set(handles.Undo,'Enable','on');
                    else
                        handles.axes1 = imagesc(handles.A);
                        axis off;
                        handles.lose=1;
                        openfig('patt.fig');
                        set(handles.Undo,'Enable','on');
                    end
                else 
                    [prev_pos(:,1) prev_pos(:,2)]=find(handles.board==AImove(3));
                    handles.history=[handles.history; prev_pos AImove([3 1 2 4])];
                    handles.board(handles.board==AImove(3))=0;
                    if(AImove(3)>24 && AImove(3)<33 && AImove(1)==1)
                        handles.board(AImove(1),AImove(2))=AImove(3)+16;
                        temp=AImove(3)+16;
                    else
                        handles.board(AImove(1),AImove(2))=AImove(3);
                        temp=AImove(3);
                    end
                    if((mod(prev_pos(1),2)==1 && mod(prev_pos(2),2)==1) || (mod(prev_pos(1),2)==0 && mod(prev_pos(2),2)==0))
                        handles.A(480-(prev_pos(1)-1)*60:-1:480-prev_pos(1)*60+1,(prev_pos(2)-1)*60+1:prev_pos(2)*60)=0;
                    else
                        handles.A(480-(prev_pos(1)-1)*60:-1:480-prev_pos(1)*60+1,(prev_pos(2)-1)*60+1:prev_pos(2)*60)=255;
                    end
                    if((mod(AImove(1),2)==1 && mod(AImove(2),2)==1) || (mod(AImove(1),2)==0 && mod(AImove(2),2)==0))
                        handles.A(480-AImove(1)*60+1:480-(AImove(1)-1)*60,(AImove(2)-1)*60+1:AImove(2)*60)=handles.pionia(2,:,:,temp);
                    else
                        handles.A(480-AImove(1)*60+1:480-(AImove(1)-1)*60,(AImove(2)-1)*60+1:AImove(2)*60)=handles.pionia(1,:,:,temp);
                    end
                    handles.axes1 = imagesc(handles.A);
                    axis off;
                    drawnow;
                    set(handles.Undo,'Enable','on');
                    v_final=legal_moves_whites(uint8(handles.board), handles.knight_mask,1);
                    if(isempty(v_final))
                        patt=legal_moves_blacks(uint8(handles.board), handles.knight_mask,0);
                        if(sum(patt(:,4)==13)>0)
                            handles.axes1 = imagesc(handles.A);
                            axis off;
                            handles.lose=1;
                            openfig('youlose.fig');
                            set(handles.Undo,'Enable','on');
                        else
                            handles.axes1 = imagesc(handles.A);
                            axis off;
                            handles.lose=1;
                            openfig('patt.fig');
                            set(handles.Undo,'Enable','on');
                        end
                    end
                end
            end            
        elseif strcmp(button,'alt')  
            handles.flag=0;
        end
        %imshow(handles.im,'Parent',handles.axes1);
        if(handles.lose==0)
         handles.axes1 = imagesc(handles.A);
         axis off;
        end
    end
    set(handles.axes1,'ButtonDownFcn',{@draw,handles})
end
     guidata(gcf, handles);

% --------------------------------------------------------------------
function Undo_Callback(hObject, eventdata, handles)
% hObject    handle to Undo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    if (~isempty(handles.history))
        mymove=handles.history(end-1,:);
        aimove=handles.history(end,:);
        handles.history(end-1:end,:)=[];
        handles.board(aimove(1),aimove(2))=aimove(3);
        handles.board(aimove(4),aimove(5))=aimove(6);
        handles.board(mymove(1),mymove(2))=mymove(3);
        handles.board(mymove(4),mymove(5))=mymove(6);
        if((mod(aimove(1),2)==1 && mod(aimove(2),2)==1) || (mod(aimove(1),2)==0 && mod(aimove(2),2)==0))
            if(aimove(3)==0)
                handles.A(480-(aimove(1)-1)*60:-1:480-aimove(1)*60+1,(aimove(2)-1)*60+1:aimove(2)*60)=0;
            else
                handles.A(480-aimove(1)*60+1:480-(aimove(1)-1)*60,(aimove(2)-1)*60+1:aimove(2)*60)=handles.pionia(2,:,:,aimove(3));
            end
        else
            if(aimove(3)==0)
                handles.A(480-(aimove(1)-1)*60:-1:480-aimove(1)*60+1,(aimove(2)-1)*60+1:aimove(2)*60)=255;
            else
                handles.A(480-aimove(1)*60+1:480-(aimove(1)-1)*60,(aimove(2)-1)*60+1:aimove(2)*60)=handles.pionia(1,:,:,aimove(3));
            end
        end
        if((mod(aimove(4),2)==1 && mod(aimove(5),2)==1) || (mod(aimove(4),2)==0 && mod(aimove(5),2)==0))
            if(aimove(6)==0)
                 handles.A(480-aimove(4)*60+1:480-(aimove(4)-1)*60,(aimove(5)-1)*60+1:aimove(5)*60)=0;
            else
                handles.A(480-aimove(4)*60+1:480-(aimove(4)-1)*60,(aimove(5)-1)*60+1:aimove(5)*60)=handles.pionia(2,:,:,aimove(6));
            end
        else
            if(aimove(6)==0)
                handles.A(480-aimove(4)*60+1:480-(aimove(4)-1)*60,(aimove(5)-1)*60+1:aimove(5)*60)=255;
            else
                handles.A(480-aimove(4)*60+1:480-(aimove(4)-1)*60,(aimove(5)-1)*60+1:aimove(5)*60)=handles.pionia(1,:,:,aimove(6));
            end
        end
        if((mod(mymove(1),2)==1 && mod(mymove(2),2)==1) || (mod(mymove(1),2)==0 && mod(mymove(2),2)==0))
            if(mymove(3)==0)
                handles.A(480-(mymove(1)-1)*60:-1:480-mymove(1)*60+1,(mymove(2)-1)*60+1:mymove(2)*60)=0;
            else
                handles.A(480-mymove(1)*60+1:480-(mymove(1)-1)*60,(mymove(2)-1)*60+1:mymove(2)*60)=handles.pionia(2,:,:,mymove(3));
            end
        else
            if(mymove(3)==0)
                handles.A(480-(mymove(1)-1)*60:-1:480-mymove(1)*60+1,(mymove(2)-1)*60+1:mymove(2)*60)=255;
            else
                handles.A(480-mymove(1)*60+1:480-(mymove(1)-1)*60,(mymove(2)-1)*60+1:mymove(2)*60)=handles.pionia(1,:,:,mymove(3));
            end
        end
        if((mod(mymove(4),2)==1 && mod(mymove(5),2)==1) || (mod(mymove(4),2)==0 && mod(mymove(5),2)==0))
            if(mymove(6)==0)
                 handles.A(480-mymove(4)*60+1:480-(mymove(4)-1)*60,(mymove(5)-1)*60+1:mymove(5)*60)=0;
            else
                handles.A(480-mymove(4)*60+1:480-(mymove(4)-1)*60,(mymove(5)-1)*60+1:mymove(5)*60)=handles.pionia(2,:,:,mymove(6));
            end
        else
            if(mymove(6)==0)
                handles.A(480-mymove(4)*60+1:480-(mymove(4)-1)*60,(mymove(5)-1)*60+1:mymove(5)*60)=255;
            else
                handles.A(480-mymove(4)*60+1:480-(mymove(4)-1)*60,(mymove(5)-1)*60+1:mymove(5)*60)=handles.pionia(1,:,:,mymove(6));
            end
        end
        handles.axes1 = imagesc(handles.A);
        axis off;
        drawnow;
    end
    handles.flag=0;
    set(handles.axes1,'ButtonDownFcn',{@draw,handles})

guidata(hObject, handles);


% --------------------------------------------------------------------
function Exit_Callback(hObject, eventdata, handles)
close all;
% hObject    handle to Exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
