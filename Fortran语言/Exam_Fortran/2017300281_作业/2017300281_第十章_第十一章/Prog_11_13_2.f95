! A fortran95 program for G95
! By ����ѧԺ ��ƣ�2017300281��
! ϰ��11-13 ��д�������η�����ֵ�ͨ�ó���
!           �������ָ������־��ȡ�n=2��ʼ����n=2*n�Ĺ�������n���������������ֵС��10^(-5)
!           ʱ��Ϊ�ﵽ����Ҫ�󡣰����Ļ���ֵ��Ϊ����ֵ

function trapezoid_method(a,b,n)

    real :: a,b,h,sum_ig,sum_tot,f
    real :: trapezoid_method
    integer n,i
    f(x)=sqrt(1+sin(x)) ! ���󶨻��ֺ���1
!    f(x)=x*x+x+1 ! ���󶨻��ֺ���2
!    f(x)=exp((-1)*((x*x)/2.0)) ! ���󶨻��ֺ���3
    h=abs((a-b)/(1.0*n))
    sum_ig=0
    do i=1,n-1
        sum_ig=sum_ig+f(a+(i*h))
    end do
    sum_tot=h*(((f(a)+f(b))/2.0)+sum_ig)
    trapezoid_method=sum_tot

end function

program Prog_11_13_2

    implicit none
    real :: trapezoid_method
    real :: a,b,ans,temp,e
    integer n,flag
    write(*,'(1X,"���������������� a = ",$)')
    read(*,*) a
    write(*,'(1X)')
    write(*,'(1X,"���������������� b = ",$)')
    read(*,*) b
    write(*,'(1X)')
    n=2 ! �趨n��ʼֵ
    ans=trapezoid_method(a,b,n) ! ����n=2ʱ�Ķ����ֳ�ʼֵ
    e=1e-5 ! �趨�˳���ﵽ�ľ���
    flag=0 ! �趨���ȴ��ı�ʶ
10  continue
    n=n*2
    temp=ans
    ans=trapezoid_method(a,b,n)
    if (abs(ans-temp)<e) flag=1
    if (flag/=1) goto 10
    write(*,'(1X)')
    write(*,100) ans
100 format(1X,"�������η���û��ֵĽ���ֵΪ�� ans = ",F12.8)
    write(*,'(1X)')
    write(*,200) n
200 format(1X,"�ﵽԤ�ھ���ʱ�� n= ",I6)

end
