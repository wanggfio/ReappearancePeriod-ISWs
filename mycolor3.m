function c = mycolor3(n,m,step)
%c=mycolor(m,step)
% Input: 
% n
%    is the index of color set, now only 1 is supported.
%      [230 114]  %196 184 161  98 367 293]
% m  为层数必须为偶数
%    is the level of colormap, must be even.
% step 为间隔[-15 0 26]
%    is one-dimensional array with 3 numbers, which are the value of data
%    whose colormap is corresponding to -1, 0, and 1, respectively. With
%    step, the different negative and positive colorbar is allowed.
%    If step is one-dimensional array with 4 numbers, which means the
%    values between the second and the third are all zero, and the first
%    one is corresponding to -1, and the last one to 1.
% n = 1;
c = [];
if mod(m,2) ~= 0
    error('m number must be even.');
    return;
end
cc = colorset(n);
ncc = size(cc,1);
ncc2 = ncc/2;

if nargin < 3   % same function as mycolor
    c1 = interp1(linspace(-1,0,ncc2),cc(1:ncc2,:)    ,linspace(-1,0,m/2),'PCHIP');
    c2 = interp1(linspace( 0,1,ncc2),cc(ncc2+1:ncc,:),linspace( 0,1,m/2),'PCHIP');

    clear c
    c = [c1;c2];
    c(c<0) = 0;
    c(c>1) = 1;
    return
end
if numel(step) == 3
    % step is available
    % algorithm:    
    %      (xzero-xmin)/(xmax-xzero) = m1/m2;  and m1+m2 = m;
    %
    xmin = step(1); xzero = step(2); xmax = step(3);
    m1 = fix(((xzero-xmin)/(xmax-xmin))*m);
    m2 = fix(((xmax-xzero)/(xmax-xmin))*m);
    c1 = interp1(linspace(xmin,xzero,ncc2),cc(1:ncc2,:)    ,linspace(xmin,xzero,m1),'PCHIP');
    c2 = interp1(linspace(xzero,xmax,ncc2),cc(ncc2+1:ncc,:),linspace(xzero,xmax,m2),'PCHIP');

    clear c
    c = [c1;c2];
    c(c<0) = 0;
    c(c>1) = 1;
    return
end

if numel(step) == 4
    % step is available
    % algorithm:    
    %      (xzero1-xmin)/(0-xzero1) = n1/n2;  and n1+n2 = m/2;
    %      
    xmin = step(1); xzero1 = step(2); xzero2 = step(3); xmax = step(4);
    
    if xmin == 0 || xmax == 0
        error('Valid input of min or max value');
        return
    end
    
    n1 = fix(-xmin/(xmax-xmin)*m);
    n2 = fix(xmax/(xmax-xmin)*m);
    
    m1 = fix(((xmin-xzero1)/xmin)*n1);
    m2 = fix((xzero1/xmin)*n1);
    
    m3 = fix((xzero2/xmax)*n2);
    m4 = fix(((xmax-xzero2)/xmax)*n2);
    
    c1 = interp1(linspace(xmin,xzero1,ncc2),cc(1:ncc2,:)    ,linspace(xmin,xzero1,m1),'PCHIP');
    c12 = repmat([1 1 1],[m2+m3, 1]); 
    c2 = interp1(linspace(xzero2,xmax,ncc2),cc(ncc2+1:ncc,:),linspace(xzero2,xmax,m4),'PCHIP');

    clear c
    c = [c1;c12;c2];
    c(c<0) = 0;
    c(c>1) = 1;
    return
end

function cc = colorset(n)
switch n
    case 1
    cc = [ 10  50 120;  ...
           15  75 165;  ...
           30 110 200;  ...
           60 160 240;  ...
           90 180 250;  ...
          130 210 255;  ...
          160 240 255;  ...
          200 250 255;  ...
          215 250 255;  ...
          255 250 220;  ...
          255 232 120;  ...
          255 192  60;  ...
          255 160   0;  ...
          255  96   0;  ...
          255  50   0;  ...
          255  20   0;  ...
          192   0   0;  ...
          165   0   0]/255;
    otherwise 
          cc=othercolor(n);
end