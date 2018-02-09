function DecimatePoly_demo1
% Use DecimatePoly to simplify a contour extracted from a segmented image. 

% Demo image files
FileNames={'beetle-4.gif','camel-4.gif','device2-6.gif'};
   
% Select of the 3 images at random       
i=ceil(numel(FileNames)*rand(1));

% Read in the demo image
try
    im=imread(FileNames{i});
catch err %#ok<*NASGU>
    msg={sprintf('Unable to locate demo image titled %s.',FileNames{i})};
    msg{2}='1) Make sure you unpacked the contents of the DecimatePoly.zip into your current work directory.';
    msg{3}='2) Also make sure you have an Image Processing Toolbox before running this demo.';
    for i=1:3, disp(msg{i}); end
    return
end

% Get the countour
try
    im=imfill(im>0,4,'holes');
catch err
    msg='Image Processing Toolbox required by the demo not found';
    disp(msg)
    return
end
C=bwboundaries(im);
C=C{1};


% Visualize the binary image and the contour
hf=figure('color','w');
set(hf,'units','normalized')
set(hf,'position',[0.1 0.1 0.8 0.6])
h1=subplot(1,3,1); hold on
imshow(im)
plot(C(:,2),C(:,1),'.-g'), axis equal
axis('tight')

XLim=get(h1,'XLim'); YLim=get(h1,'YLim');

h1=get(h1,'Title');
msg=sprintf('Original: %u verts',size(C,1));
set(h1,'String',msg,'FontWeight','bold','FontSize',16);
drawnow

% Simplify
fprintf('================= %s =================\n',FileNames{i})
fprintf('Decimate by a factor of 10\n')
C1=DecimatePoly(C,[0.1 2]);

fprintf('Decimate by a factor of 20\n')
C2=DecimatePoly(C,[0.05 2]);

% Show the results
h2=subplot(1,3,2);
plot(C1(:,2),C1(:,1),'.-b'), axis equal
set(h2,'Ydir','reverse','XLim',XLim,'YLim',YLim)
h2=get(h2,'Title');
msg=sprintf('Decimated by x10: %u verts',size(C1,1)-1);
set(h2,'String',msg,'FontWeight','bold','FontSize',16);
drawnow

h3=subplot(1,3,3);
plot(C2(:,2),C2(:,1),'.-r'), axis equal
set(h3,'Ydir','reverse','XLim',XLim,'YLim',YLim)
h3=get(h3,'Title');
msg=sprintf('Decimated by x20: %u verts',size(C2,1)-1);
set(h3,'String',msg,'FontWeight','bold','FontSize',16);
drawnow


