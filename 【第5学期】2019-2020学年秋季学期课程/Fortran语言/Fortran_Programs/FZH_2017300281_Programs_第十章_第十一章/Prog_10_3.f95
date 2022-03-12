! A fortran95 program for G95
! By 航空学院 冯铮浩（2017300281）
! 习题10-3 用语句函数编程序，用辛普生法求定积分

program Prog_10_3

    implicit none
    real(kind=8):: x,a,b,h,s,t,f,f_2,f_4
    integer n,i
    f(X)=sin(X)+cos(X) ! 定义被积函数
    write(*,'(1X,"请输入被积区间下界：a = ",$)')
    read(*,*) a
    write(*,'(1X)')
    write(*,'(1X,"请输入被积区间上界：b = ",$)')
    read(*,*) b
    n=16 ! 定义积分微段个数
    h=(b-a)/(2.0*n)
    s=0.0 ! 结果累加变量
    t=a+h !
    f_2=0.0  ! 系数为2的累加项之和
    f_4=f(t) ! 系数为4的累加项之和
    do i=1,n-1
        t=t+h
        f_2=f_2+f(t)
        t=t+h
        f_4=f_4+f(t)
    end do
    s=(h/3.0)*(f(a)+f(b)+(4.0*f_4)+(2.0*f_2))
    write(*,'(1X)')
    write(*,100) s
100 format(1X,"表达式积分的结果为 s = ",F16.8)

end
