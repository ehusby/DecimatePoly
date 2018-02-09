function DecimatePoly_demo2
% Second demo showing the ability of DecimatePoly to retain visually 
% important features during simplification.

% Create a sample shape
n=2*ceil(4*rand(1))+5;
C=SuperShape2D(2E3,[1 1 n 0.5 0.5 0.5]);
C=[C;C(1,:)]; % make sure first and last points are the same

% Adaptively subsample the contour by specifying offset tolerance
fprintf('=================== %u star ===================\n',n)
fprintf('Boundary offset tolerance = 1E-4\n')
C1=DecimatePoly(C,[1E-4 1]);
fprintf('Boundary offset tolerance = 1E-3\n')
C2=DecimatePoly(C,[1E-3 1]);

% Visualize the original contour
hf=figure('color','w');
set(hf,'units','normalized')
set(hf,'position',[0.2 0.1 0.6 0.6])
h1=subplot(1,3,1); 
plot(C(:,1),C(:,2),'.-g'), axis equal
set(h1,'XLim',[-1.1 1.1],'YLim',[-1.1 1.1],'YTick',get(h1,'XTick'))

h1=get(h1,'Title');
msg=sprintf('Original: %u verts',size(C,1)-1);
set(h1,'String',msg,'FontWeight','bold','FontSize',16);

% Visualize the decimated contours
h2=subplot(1,3,2); 
plot(C1(:,1),C1(:,2),'.-b'), axis equal
set(h2,'XLim',[-1.1 1.1],'YLim',[-1.1 1.1],'YTick',get(h2,'XTick'))
h2=get(h2,'Title');
msg=sprintf('Btol = 1E-4: %u verts',size(C1,1)-1);
set(h2,'String',msg,'FontWeight','bold','FontSize',16);

h3=subplot(1,3,3); 
plot(C2(:,1),C2(:,2),'.-r'), axis equal
set(h3,'XLim',[-1.1 1.1],'YLim',[-1.1 1.1],'YTick',get(h3,'XTick'))
h3=get(h3,'Title');
msg=sprintf('Btol = 1E-3: %u verts',size(C2,1)-1);
set(h3,'String',msg,'FontWeight','bold','FontSize',16);

