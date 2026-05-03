function [ERCP, ELCP,k] = circularPlanewave(k)
%%Helper script that provides LCP and RCP planar waves when given incidence directions
    % Input: k - 3x1 or 1x3 propagation vector
    % Output: ERCP - 3x1 RCP electric field
    %         ELCP - 3x1 LCP electric field

    % Ensure k is a column vector
    k = k(:);
    k = k / norm(k);   % normalize

    % Choose a vector not parallel to k
    if abs(k(3)) < 0.9
        n = [0; 0; 1];  % prefer z-axis
    else
        n = [-1; 0; 0];  % if k ~ z, use x-axis
    end

    % First transverse vector
    e1 = cross(n, k);
    e1 = e1 / norm(e1);
    if round(dot(e1,k),10) ~= 0
        Errormessage = "Ohoh";
    end
    % Second transverse vector
    e2 = cross(k, e1);
    e2 = e2 / norm(e2);
    if round(dot(e2,k),10) ~= 0
        Errormessage = "Ohoh";
    end
    % Left Circularly Polarized field
    ELCP = (1/sqrt(2)) * ( e1 - 1i * e2 );
    ELCP = ELCP';
    % Right Circularly Polarized field
    ERCP = (1/sqrt(2)) * ( e1 + 1i * e2 );
    ERCP = ERCP';

    k = k';
end





