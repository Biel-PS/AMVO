function tau = evalRe(U,V,L,Re)
    u = max(max(max(V)),max(max(U)));
    tau = u*L/Re;
end
