! A fortran95 program for G95
! By 航空学院 冯铮浩（2017300281）
! 习题11-13 编写利用梯形法求积分的通用程序
!           问题二：指定求积分精度。n=2开始，按n=2*n的规律增加n，当两次所求积分值小于10^(-5)
!           时认为达到精度要求。把最后的积分值作为函数值

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

program Prog_11_13_2

    implicit none
    real :: trapezoid_method
    real :: a,b,ans,temp,e
    integer n,flag
    write(*,'(1X,"请输入待求积分下限 a = ",$)')
    read(*,*) a
    write(*,'(1X)')
    write(*,'(1X,"请输入待求积分上限 b = ",$)')
    read(*,*) b
    write(*,'(1X)')
    n=2 ! 设定n初始值
    ans=trapezoid_method(a,b,n) ! 计算n=2时的定积分初始值
    e=1e-5 ! 设定退出须达到的精度
    flag=0 ! 设定精度达标的标识
10  continue
    n=n*2
    temp=ans
    ans=trapezoid_method(a,b,n)
    if (abs(ans-temp)<e) flag=1
    if (flag/=1) goto 10
    write(*,'(1X)')
    write(*,100) ans
100 format(1X,"利用梯形法求得积分的近似值为： ans = ",F12.8)
    write(*,'(1X)')
    write(*,200) n
200 format(1X,"达到预期精度时， n= ",I6)

end
