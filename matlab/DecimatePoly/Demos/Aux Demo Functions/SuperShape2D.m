function C=SuperShape2D(N,p)
% Generate a 2D shape using the following parametric (super) formula:
% 
%   r=(abs(cos(m*t/4)/a).^n2 + abs(sin(m*t/4)/b).^n3).^(-1/n1)
%
%   - N     : number of points. By default N=100.
%   - p     : shape parameters, p=[a b m n1 n2 n3]. By default 
%             p=[1 1 0 1 1 1], which corresponds to a circle.
%

if nargin<1, N=100; end
if nargin<2, p=[1 1 0 1 1 1]; end

a=p(1); b=p(2); m=p(3); n1=p(4); n2=p(5); n3=p(6);

t=linspace(0,2*pi,N)';
r=(abs(cos(m*t/4)/a).^n2 + abs(sin(m*t/4)/b).^n3).^(-1/n1);
r=real(r);

C=bsxfun(@times,r,[cos(t) sin(t)]);

