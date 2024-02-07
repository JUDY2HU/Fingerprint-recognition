function varargout = GUI(varargin)
% GUI MATLAB code for GUI.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)". 
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI

% Last Modified by GUIDE v2.5 19-Jan-2021 20:14:11

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_OutputFcn, ...
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


% --- Executes just before GUI is made visible.
function GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI (see VARARGIN)

% Choose default command line output for GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
set(handles.text1,'string',' ')
[filename,pathname]=uigetfile({'*.tif';'*.*'},'载入指纹');
if isequal(filename,0)|isequal(pathname,0)
    errordlg('没有选中文件','出错');
    return;
else
    file=[pathname,filename];
    x1=file;
    axes(handles.axes1);
    imshow(x1);
    save x1
end
set(handles.text1,'string','载入指纹1')
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
load txy1;
txy1=cut(thin1,txy1);
axes(handles.axes2);imshow(txy1);
set(handles.text1,'string','去伪处理');


% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
 set(handles.text1,'string','载入指纹图象Ⅱ')
[filename,pathname]=uigetfile({'*.tif';'*.*'},'载入指纹');
if isequal(filename,0)|isequal(pathname,0)
    errordlg('没有选中文件','出错');
    return;
else
    file=[pathname,filename];
    x2=file;
    axes(handles.axes6);
    imshow(x2);
    save x2
end
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
load txy2;
txy2=cut(thin2,txy2);
axes(handles.axes7);imshow(txy2);
set(handles.text1,'string','去伪')

% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
set(handles.text1,'string','比对识别中，请稍等...')
load thin1
load thin2
txy1=point(thin1);
txy2=point(thin2);
[w1,txy1]=guanghua(thin1,txy1);
[w2,txy2]=guanghua(thin2,txy2);
thin1=w1;
thin2=w2;
txy1=cut(thin1,txy1);
txy2=cut(thin2,txy2);
[pxy31,error2]=last1(thin1,8,txy1,60)
[pxy32,error2]=last1(thin2,8,txy2,60)
if isempty(pxy31) == 1 || isempty(pxy32) == 1 % 判断数组 pxy31 和 pxy32 是否为空
 error = 1;
 return;
end

num=20;
cxy1=pxy31;
cxy2=pxy32;
d1=distance(cxy1(1,1),cxy1(1,2),num,thin1);
d2=distance(cxy2(1,1),cxy2(1,2),num,thin2);
f=(sum(abs((d1./d2)-1)));
f=0;
if f<=0.5
    error=0;
else
    error=1;
end

c11=find_point(cxy1(1,1),cxy1(1,2),txy1,1);
c12=find_point(cxy1(1,1),cxy1(1,2),txy1,2);
c21=find_point(cxy2(1,1),cxy2(1,2),txy2,1);
c22=find_point(cxy2(1,1),cxy2(1,2),txy2,2);
cxy1(2,:)=c11;
cxy1(3,:)=c12(2,:);
cxy2(2,:)=c21;
cxy2(3,:)=c22(2,:);

x11=cxy1(1,1);  y11=cxy1(1,2);
x12=cxy1(2,1);  y12=cxy1(2,2);
x13=cxy1(3,1);  y13=cxy1(3,2);
x21=cxy2(1,1);  y21=cxy2(1,2);
x22=cxy2(2,1);  y22=cxy2(2,2);
x23=cxy2(3,1);  y23=cxy2(3,2);
dd1(1)=juli(x11,y11,x12,y12);
dd1(2)=juli(x12,y12,x13,y13);
dd1(3)=juli(x13,y13,x11,y11);
dd2(1)=juli(x21,y21,x22,y22);
dd2(2)=juli(x22,y22,x23,y23);
dd2(3)=juli(x23,y23,x21,y21);
ff=0;
ff=(sum(abs((dd1./dd2)-1)))
if ff<=1
    error=0;
else
    error=1;
end
cxy1(2:41,:)=find_point(pxy31(1,1),pxy31(1,2),txy1,40);
cxy2(2:41,:)=find_point(pxy32(1,1),pxy32(1,2),txy2,40);
f11=length(find(cxy1(:,3)==2));
f12=length(find(cxy1(:,3)==6));
f21=length(find(cxy2(:,3)==2));
f22=length(find(cxy2(:,3)==6));
fff=abs(f11-f21)/(f11+f12);
%set(handles.text4,'string',1-fff)
if f<0.5&&ff<1.5&&fff<0.2
    set(handles.text1,'string','识别成功')
else
    set(handles.text1,'string','识别失败')
end


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
load w;axes(handles.axes2);imshow(w);
set(handles.text1,'string','细化处理');

% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
load w;axes(handles.axes7);imshow(w);
set(handles.text1,'string','细化处理');
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
load thin1;
txy1=point(thin1);
axes(handles.axes2);imshow(txy1);
save txy1;
set(handles.text1,'string','提取特征点')
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
load thin2;
txy2=point(thin2);
axes(handles.axes7);imshow(txy2);
save txy2;
set(handles.text1,'string','提取特征点')
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
load Im;axes(handles.axes2);imshow(Im);
set(handles.text1,'string','二值化处理')

% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
load x2;
thin2=tuxiangyuchuli(x2);
load im;axes(handles.axes7);imshow(im);
save thin2
set(handles.text1,'string','灰度化处理')
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
load x1
thin1=tuxiangyuchuli(x1);
load im;axes(handles.axes2);imshow(im);
save thin1;
set(handles.text1,'string','灰度化处理')
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
load Im;axes(handles.axes7);imshow(Im);
set(handles.text1,'string','二值化处理')

% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
