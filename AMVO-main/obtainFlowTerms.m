function [Fe, Fw, Fn, Fs] = obtainFlowTerms (U,V,h,i,j,type)
    switch type
        case 'u'
            Fs = h * avgField( V(i,j-1), V(i+1,j-1) );
            Fn = h * avgField( V(i,j)  , V(i+1,j)   );
            Fe = h * avgField( U(i+1,j), U(i,j)     );
            Fw = h * avgField( U(i-1,j), U(i,j)     );
        case 'v'

            Fs = h * avgField( U(i,j-1), U(i,j)     );
            Fn = h * avgField( U(i,j)  , U(i,j+1)   );
            Fe = h * avgField( V(i,j), V(i,j+1) );
            Fw = h * avgField( V(i-1,j+1), V(i-1,j)     );
    end


    
end