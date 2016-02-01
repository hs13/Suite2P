function um2pix=infoPixUm(totPixels,zoomMicro,microID)

% infoPixUm computes the number of pixels per um along the horizontal
% direction (xPU) vertical direction (yPU) approximately any direction
% (rPU)
%
% The inputs are:

% totPixels (number of pixels along the horizontal or vertical directions
% in the pre-registered movie)
% zoomMicro (zoom of the microscope)
% microID 'b'=b-scope, 'b2'=bergamo2 (in 3/3), 'm'=MOM
%
% 2015.12.16 Mario Dipoppa - Created
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if ~any(strcmp(microID, {'b', 'b2', 'm'}))
    display('WARNING: unknown type of microscope.')
    microID = 'b';
end

switch microID
    case 'b'
        zoom = [1.5 1.6 1.7 2 2.2 2.3 2.5 3];
        measuredHoriz = [680 635 615.5 524 491 460 431.5 371];
        measuredVert = [664.5 615 593 503.5 452.5 430 401 337.5];
    case 'b2'
        zoom = [1.6 1.9 2 2.2];
        measuredHoriz = [772 653 619.5 565.5];
        measuredVert = [755 640 605.5 547];
    case 'm'
        zoom = [3 4];
        measuredHoriz = [155 117];
        measuredVert = [155 117];
end

ind = find(zoom == zoomMicro);
if ~isempty(ind)
    sizeHoriz = measuredHoriz(ind);
    sizeVert = measuredVert(ind);
else
    curve = fit(zoom, measuredHoriz, 'poly2');
    sizeHoriz = curve(zoomFactor);
    curve = fit(zoom, measuredVert, 'poly2');
    sizeVert = curve(zoomFactor);
end

xPU = totPixels / sizeHoriz;
yPU = totPixels / sizeVert;

rPU=sqrt(yPU^2+xPU^2)/sqrt(2);

um2pix.xPU=xPU;
um2pix.yPU=yPU;
um2pix.rPU=rPU;

end
