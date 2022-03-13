! A fortran95 program for G95
! By 航空学院 冯铮浩（2017300281）
! 习题10-4 用语句函数编程序，用牛顿法求：x^3-2*x^2+x-1=0在x=1.5附近的实根。

program Prog_10_4

    implicit none
    real(kind=8):: f,f1,x,x1,de
    integer n
    f(x)=(x**3)-2*(x**2)+x-1 ! 设置语句函数f(x)
    f1(x)=3*(x**2)-(4*x)+1 ! 设置语句函数f'(x)
    write(*,'(1X,"请输入搜索方程根的初始值：x1 = ",$)')
    read(*,*) x
    write(*,'(1X)')
    write(*,*) "利用牛顿法迭代求解结果如下："
    write(*,'(1X)')
    n=1
    de=1e-6 ! 设置迭代退出误差
10  continue
    x1=x
    x=x1-((f(x1))/(f1(x))) ! 利用牛顿迭代法逼近真实解
    write(*,100) n,x1,x
    n=n+1
    if (abs(x-x1).GT.de) goto 10
100 format(1X,'N=',I3,3X,'X1=',F15.7,3X,'X=',F15.7)
    write(*,'(1X)')
    write(*,200) x
200 format(1X,"方程的近似根为 x = ",F16.8)

end
