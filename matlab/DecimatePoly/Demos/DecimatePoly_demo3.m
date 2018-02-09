function DecimatePoly_demo3
% Last demo showing how DecimatePoly can be used to improve the time 
% perfomance of in-polygon test. In fact, this application is the primary
% reason justifying the utility of DecimatePoly.

% Read in the beetle contour
try
    C=load('DemoContours.mat','C1');
    C=C.C1;
catch err %#ok<*NASGU>
    msg={'Unable to locate demo file titled DemoContours.mat'};
    msg{2}='Make sure you unpacked the contents of the DecimatePoly.zip into your current work directory.';
    for i=1:2, disp(msg{i}); end
    return
end

% Center the contour
C=[C(:,2) C(:,1)];
C=bsxfun(@minus,C,mean(C,1));
C(:,2)=-C(:,2);

% Generate a sample of uniformly distributed points
x=2*rand(2E4,2)-1;
x=bsxfun(@times,x,[150 240]);

% Initialize the waitbar
hw = waitbar(0,'Please be patient for 10 sec','Name','DecimatePoly demo','Color','w');
set(hw,'units','normalized')
p=get(hw,'position');
set(hw,'position',[0.5-p(3)/2 0.72+p(4) p(3:4)])

% Perform in-polygon test using the original contour
tic
%chk0=inpoly(x,C);
chk0=inpolygon(x(:,1),x(:,2),C(:,1),C(:,2));
t0=toc;


% Visualize the original contour and the points
hf=figure('color','w');
set(hf,'units','normalized')
set(hf,'position',[0.2 0.1 0.6 0.6])
h1=subplot(1,3,1);
plot(x(chk0,1),x(chk0,2),'+g','MarkerSize',6), hold on
plot(x(~chk0,1),x(~chk0,2),'+r','MarkerSize',6)
plot(C(:,1),C(:,2),'-k','LineWidth',2), axis equal
set(h1,'XLim',[-155 155],'YLim',[-245 245])
l=legend(h1,'inside','outside','boundary');
set(l,'Orientation','horizontal','Location','North','FontWeight','bold')

h1=get(h1,'Title');
msg=sprintf('Orgnl. Contr. = %u verts',size(C,1)-1);
set(h1,'String',msg,'FontWeight','bold','FontSize',20);
drawnow


% Initialize the axes comparing the orignal and simplified contours
h2=subplot(1,3,2);
plot(C(:,1),C(:,2),'-k'), axis equal, hold on
set(h2,'XLim',[-155 155],'YLim',[-245 245])
ledg={'100%'};
drawnow

waitbar(1/16,hw,sprintf('%3.0f%% complete ...',1/16*100))


% Perform the test using simpler versions of the contour and measure the 
% misclassification rate
n=15; j=1;
t=zeros(n,1); Err=zeros(n,1); r=zeros(n,1);
for i=1:n
    
    % Decimate the contour
    r(i)=i+2;
    Ci=DecimatePoly(C,[r(i)/100 2]);
        
    if mod(r(i),3)==0
        j=j+1;
        plot(h2,Ci(:,1),Ci(:,2),'-','Color',rand(1,3)*0.8)
        ledg{j}=sprintf('%u%%',r(i));
    end
    
    % Perform the test
    tic
    %chk=inpoly(x,Ci);
    chk=inpolygon(x(:,1),x(:,2),Ci(:,1),Ci(:,2));
    t(i)=toc;
    waitbar((i+1)/16,hw,sprintf('%3.0f%% complete ...',(i+1)/16*100))
    figure(hw)
    
    % Quantify the error using Dice coeff
    Err(i)=2*sum(chk&chk0)/(sum(chk)+sum(chk0));
        
end

legend(h2,ledg)
if ishandle(hw), delete(hw); end


% Plot the results
subplot(1,3,3);
[h3,H1,H2]=plotyy(r,Err,r,t0./t);
set(get(h3(1),'Ylabel'),'String','Dice Coeff','FontSize',20,'FontWeight','bold') 
set(get(h3(2),'Ylabel'),'String','Speed-up X','FontSize',20,'FontWeight','bold') 
set(h3,'FontSize',15)
%set(h3(1),'YLim',[0.93 1],'YTick',0.93:0.01:1)
xlabel('Percent Simplification','FontSize',20)

set(H1,'Marker','.','MarkerSize',20,'LineWidth',2)
set(H2,'Marker','.','MarkerSize',20,'LineWidth',2)

set(h3,'XLim',[0 n+5])
drawnow


