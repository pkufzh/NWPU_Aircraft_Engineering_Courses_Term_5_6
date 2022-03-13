! A fortran95 program for G95
! By 航空学院 冯铮浩（2017300281）
! 习题11-4 编写求γ值的函数

real function coeff_gamma(x,cnt)

    integer i,cnt
    real x(1000)
    real det,xb,sum_tot,sum1,sum2
    sum_tot=0.0
    sum1=0.0
    sum2=0.0
    do i=1,cnt
        sum_tot=sum_tot+x(i)
    end do
    xb=sum_tot/(1.0*cnt)
    do i=1,cnt
        sum1=sum1+((x(i)-xb)**3)
        sum2=sum2+((x(i)-xb)**2)
    end do
    det=sqrt((sum2/(1.0*(cnt-1))))
    coeff_gamma=sum1/(1.0*cnt*(det**3))

end function

program Prog_11_4

    implicit none
    integer n
    real a(1000)
    real ans,coeff_gamma
    write(*,100)
100 format(1X,"请输入实验数据个数: n = ",$)
    read(*,*) n
    write(*,'(1X)')
    write(*,200) n
200 format(1X,"请输入",I2,"个实验数据值（以空格隔开）：",$)
    read(*,*) a(1:n) ! 输入所需求γ值的实验数据数列
    write(*,'(1X)')
    ! 调用coeff_gamma函数子程序计算最大公约数
    ans=coeff_gamma(a,n)
    write(*,300) ans
300 format(1X,"实验数据的失真系数为 γ = ",F16.8)

end
