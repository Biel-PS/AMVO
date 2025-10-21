function [ue, uw, un, us] = obtainFaceValues (U,i,j)
    ue = avgField(U(i+1,j),U(i,j));
    uw = avgField(U(i-1,j),U(i,j));
    un = avgField(U(i,j+1),U(i,j));
    us = avgField(U(i,j-1),U(i,j));
end