
syms Em R0 R1 C1 R2 C2 R3 C3 I vmeasured t;
%vpredi=Em- I*R0 -(I*R1*(1-exp(-t/(R1*C1))))-(I*R2*(1-exp(-t/(R2*C2))))-(I*R3*(1-exp(-t/(R3*C3))));

vpredi=Em- I*R0 -(I*R1*(1-exp(-t/(R1*C1))));
J=((vpredi-vmeasured)^2); % ????
paramssym=transpose([Em R0 R1 C1]);
hess=hessian(J,paramssym);
grad=gradient(J,paramssym);
LR=0.001;
params_old=transpose([4.1 0.01 0.02 40000]);

for i=1:100
    ti=randi([1 3962],1,20);
    %ti=1:1:3962;

    ti=ti';
    ti=ti/1000;

    vmeasur=vmeas(floor(ti*1000));
    hessi=subs(hess,paramssym,params_old);
    hes=0;
    parfor j=1:length(ti)
        Ival=2.6;
        H=Ival;
        idx=H>0.36;
        H(idx)=-Ival(idx);
        hes=hes+round(subs(hessi,[t vmeasured I], [ti(j) vmeasur(j) Ival]),3);
    end
    hes=hes/length(ti);
    
    gradi=subs(grad,paramssym,params_old);
    gradie=0;
    parfor j=1:length(ti)
        Ival=2.6;
        H=Ival;
        idx=H>0.36;
        H(idx)=-Ival(idx);
        gradie=gradie+round(subs(gradi,[t vmeasured I],[ti(j) vmeasur(j) Ival]),4);
    end
    gradie=gradie/length(ti);
    if gradie==0
        break
    end
    %params=round((params_old-(LR*gradie)),4);
    params=round(params_old-((hes+(LR*(eye(length(paramssym)))))\gradie),4);
    
    if ((hes+(LR*(eye(length(paramssym)))))\gradie) == 0
        break
    end
    if params(2)<=0 || params(2)== (Inf | -Inf)
        params(2)=params_old(2);
    end
    if params(1)<=0 || params(1)== (Inf | -Inf)
        params(1)=params_old(1);
    end
    if params(3)<=0 || params(3)== (Inf | -Inf)
        params(3)=params_old(3);
    end
    %if params(7)<=0 || params(7)== (Inf | -Inf)
    %    params(7)=params_old(7);
    %end
    %if params(5)<=0 || params(5)== (Inf | -Inf)
    %    params(5)=params_old(5);
    %end
    if params(4)<=0 || params(4)== (Inf | -Inf)
        params(4)=params_old(4);
    end
    %if params(6)<=0 || params(6)== (Inf | -Inf)
    %    params(6)=params_old(6);
    %end
    %if params(8)<=0 || params(8)== (Inf | -Inf)
    %    params(8)=params_old(8);
    %end
    
    %params(params<0)=params_old;
    %params(params(1)>4.2)=4.2;
    params_old=params;
end

%% 

%params=transpose([4.0081 0.0039 0.0061 40000 0.0127 50000 0.0076 60000]);
%params=transpose([4.0376 0.022 40000 0.0327 50000 0.0045 60000]);
%params=transpose([4.0376 0.036 40000 0.02 50000 0.026 60000]);
%params=transpose([4.0376 0.0158 0.022 40000 0.0327 50000 0.0048 60000]);
%vpredi=subs(vpredi,paramssym,params);
J=0;
vpredic=1:1:3962;
vpredic=transpose(vpredic);
vpredic(1)=vmeas1(1);

%params=transpose([4.0 0.015 0.0128 40000]);
%disp(params)

syms Em R0 R1 C1 R2 C2 R3 C3 I vmeasured t;
vpredi=Em- I*R0 -(I*R1*(1-exp(-t/(R1*C1))));
paramssym=transpose([Em R0 R1 C1]);
params=transpose([4 0.02 0.0128 40000]);
vpredi=subs(vpredi,paramssym,params)

parfor i=2:3962
    Ival=2.6;
    B=Ival;
    id=i>361;
    B(id)=-Ival(id);
    
    vpredic(i)=subs(vpredi,[t I],[i B]);
    J= J + (((vpredic(i)-vmeas1(i))^2)/3962); 
end
plot(time,[vmeas1,vpredic]);


