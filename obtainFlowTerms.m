function [Fe, Fw, Fn, Fs] = obtainFlowTerms (V,h,i,j)
    Fs = (V(i,j-1)*h + V(i+1,j-1)*h)/2;
    Fn = (V(i,j)*h + V(i+1,j)*h)/2;
    Fe = (V(i+1,j)*h + V(i,j)*h)/2;
    Fw = (V(i-1,j)*h + V(i,j)*h)/2;
end