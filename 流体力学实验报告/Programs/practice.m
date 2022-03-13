clear all
clf
clc
figure;
m=2;
n=2;
k=2;

for i=1:m+n+k
    if i<=m
        hi(i)=plot(10*log10(Ptotal(i,:)),'-b','linewidth',2);
        if i~=1
            set(hi(i),'handlevisibility','off');
        end
        hold on;
    else
        hi(i)=plot(10*log10(Ptotal(i,:)),'--r','linewidth',2);
        if i~=m+1
            set(hi(i),'handlevisibility','off');
        end
        hold on;
    end
end
xlabel('Iterations');
ylabel('The powers of MUE and FUEs (dB)');
legend('MUE','FUEs')