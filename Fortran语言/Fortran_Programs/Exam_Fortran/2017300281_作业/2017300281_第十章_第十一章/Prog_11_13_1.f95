! A fortran95 program for G95
! By ����ѧԺ ��ƣ�2017300281��
! ϰ��11-13 ��д�������η�����ֵ�ͨ�ó���
!           ����һ��ָ��n=1000�������

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

program Prog_11_13_1

    implicit none
    real :: trapezoid_method
    real :: a,b,ans
    integer n
    write(*,'(1X,"���������������� a = ",$)')
    read(*,*) a
    write(*,'(1X)')
    write(*,'(1X,"���������������� b = ",$)')
    read(*,*) b
    write(*,'(1X)')
    write(*,'(1X,"�����뻮�ִ�����ֶε�������� n = ",$)')
    read(*,*) n
    ans=trapezoid_method(a,b,n)
    write(*,'(1X)')
    write(*,100) ans
100 format(1X,"�������η���û��ֵĽ���ֵΪ�� ans = ",F15.8)

end
