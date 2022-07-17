function P = sm_dwb_roadgen( u )
%SM_DWB_ROADGEN This block generates test road profiles for the left and 
% right tires. A road profile is comprised of the following 
% 1  - Low frequency sinusoid with the left and right road profiles in phase
% 2  - Low frequency sinusoid with the left and right road profiles out of phase
% 3  - Mid frequency sinusoid with the left and right road profiles in phase
% 4  - Mid frequency sinusoid with the left and right road profiles out of phase
% 5  - High frequency sinusoid with the left and right road profiles in phase
% 6  - High frequency sinusoid with the left and right road profiles out of phase
% 7  - Step with the left and right road profiles in phase
% 8  - Step with the left and right road profiles out of phase
% 9  - Pulse with the left and right road profiles in phase
% 10 - Pulse with the left and right road profiles out of phase
% 11 - Large step down (Dive)

persistent Ts Tb Fl Al Fm Am Fh Ah Ps As Pp Wp Ap Ad

t = u(1);
if t == 0
    params = u(2:end);
    Ts = params(1);
    Tb = params(2);
    Fl = params(3);
    Al = params(4);
    Fm = params(5);
    Am = params(6);
    Fh = params(7);
    Ah = params(8);
    Ps = params(9);
    As = params(10);
    Pp = params(11);
    Wp = params(12);
    Ap = params(13);
    Ad = params(14);
end

P = [0 0];
T = mod(t,Ts);
idx = floor(t/Ts);

if (T < Ts-Tb) || idx == 10
    if idx < 6
        th1 = 0; th2 = 0;
        switch idx
            case 0
                % Low Freq Sinusoid, In Phase
                A = Al; th1 = 2*pi*Fl*T; th2 = 2*pi*Fl*T;
            case 1
                % Low Freq Sinusoid, Out of Phase
                A = Al; th1 = 2*pi*Fl*T; th2 = 2*pi*Fl*T+pi;
            case 2
                % Mid Freq Sinusoid, In Phase
                A = Am; th1 = 2*pi*Fm*T; th2 = 2*pi*Fm*T;
            case 3
                % Mid Freq Sinusoid, Out of Phase
                A = Am; th1 = 2*pi*Fm*T; th2 = 2*pi*Fm*T+pi;
            case 4
                % High Freq Sinusoid, In Phase
                A = Ah; th1 = 2*pi*Fh*T; th2 = 2*pi*Fh*T;
            case 5
                % High Freq Sinusoid, Out of Phase
                A = Ah; th1 = 2*pi*Fh*T; th2 = 2*pi*Fh*T+pi;
        end
        P(1) = A*sin(th1);
        P(2) = A*sin(th2);
    else
        TT = mod(T,Ps);
        switch idx
            case 6
                % Step, In Phase
                if TT < Ps/2
                    P = [As As];
                end
            case 7
                % Step, Out of Phase
                if TT < Ps/2
                    P = [As 0];
                else
                    P = [0 As];
                end
            case 8
                % Pulse, In Phase
                if TT < Wp
                    P = [Ap Ap];
                end
            case 9
                % Pulse, Out of Phase
                if TT < Wp
                    P = [Ap 0];
                elseif (TT > Pp/2) && (TT-Pp/2 < Wp)
                    P = [0 Ap];
                end
            case {10,11}
                % Large Step (Dive)
                P = [-Ad -Ad];
        end
    end
end

end

