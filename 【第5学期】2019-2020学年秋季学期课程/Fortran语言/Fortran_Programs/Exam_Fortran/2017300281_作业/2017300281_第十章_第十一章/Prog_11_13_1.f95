! A fortran95 program for G95
! By 航空学院 冯铮浩（2017300281）
! 习题11-13 编写利用梯形法求积分的通用程序
!           问题一：指定n=1000，求积分

function trapezoid_method(a,b,n)

    real :: a,b,h,sum_ig,sum_tot,f
    real :: trapezoid_method
    integer n,i
    f(x)=sqrt(1+sin(x)) ! 待求定积分函数1
!    f(x)=x*x+x+1 ! 待求定积分函数2
!    f(x)=exp((-1)*((x*x)/2.0)) ! 待求定积分函数3
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
    write(*,'(1X,"请输入待求积分下限 a = ",$)')
    read(*,*) a
    write(*,'(1X)')
    write(*,'(1X,"请输入待求积分上限 b = ",$)')
    read(*,*) b
    write(*,'(1X)')
    write(*,'(1X,"请输入划分待求积分段的区间个数 n = ",$)')
    read(*,*) n
    ans=trapezoid_method(a,b,n)
    write(*,'(1X)')
    write(*,100) ans
100 format(1X,"利用梯形法求得积分的近似值为： ans = ",F15.8)

end
