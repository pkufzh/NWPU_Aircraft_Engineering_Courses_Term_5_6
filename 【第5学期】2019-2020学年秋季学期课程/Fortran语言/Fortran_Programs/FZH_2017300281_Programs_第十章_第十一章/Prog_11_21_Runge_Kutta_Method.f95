! A fortran95 program for G95
! By 航空学院 冯铮浩（2017300281）
! 例题11-21 用龙格库塔法编写一个解微分方程的通用程序

function func(y,x) ! 函数func功能：设置微分方程右侧函数f(y,x)形式

    func=y*y-x*x

end function

subroutine init(x0,xa,y0,ya,x1,xb) ! 子例行程序init功能：集成将xa,ya,xb的值赋给x0,y0,x1的操作

    real :: x0,xa,y0,ya,x1,xb
    x0=xa
    y0=ya
    x1=xb

end subroutine

subroutine coeffi(k0,k1,k2,k3,x0,y0,h,f) ! 子例行程序coeffi功能：计算每次求解中k0,k1,k2,k3的值

    real :: k0,k1,k2,k3,x0,y0,h
    k0=h*f(y0,x0)
    k1=h*f((y0+(k0/2.0)),(x0+(h/2.0)))
    k2=h*f((y0+(k1/2.0)),(x0+(h/2.0)))
    k3=h*f((y0+k2),(x0+h))

end subroutine

function RungKt(xa,ya,xb,delta,f) ! 函数RungKt功能：龙格库塔程序核心算法实现（输入变量：初始值，待求变量，误差要求，设置函数f）

    external f
    integer nn,m,i
    real :: k0,k1,k2,k3
    real :: RungKt
    call init(x0,xa,y0,ya,x1,xb)
    nn=1
    h=(x1-x0)/(1.0*nn)
    call coeffi(k0,k1,k2,k3,x0,y0,h,f)
    y1=y0+(k0+(2*k1)+(2*k2)+k3)/6.0
    m=0
10  continue
    m=m+1
    call init(x0,xa,y0,ya,x1,xb)
    nn=nn*2
    h=(x1-x0)/(1.0*nn)
    RungKt=y1
    do i=1,nn
        call coeffi(k0,k1,k2,k3,x0,y0,h,f)
        y1=y0+(k0+(2*k1)+(2*k2)+k3)/6.0
        x0=x0+h
        y0=y1
    end do
    ! 如果达到误差要求或者迭代次数超过5000次，可认为达到精度，退出求解
    if ((abs(RungKt-y1)<=(abs(y1)*delta)).OR.(m>5000)) then
    else
    ! 否则区间数量nn=nn*2，再次求解yb
        goto 10
    end if
    if (m>5000) then
        write(*,*) "迭代次数已经大于5000!!"
    end if
    ! 返回RungKt求解值为迭代退出后的y1
    RungKt=y1

end function

program Prog_11_21_Runge_Kutta_Method

    external func
    integer i,ntot
    real :: xa,ya,xb,yb,delta,xb_min,xb_max,nf,n,step
    write(*,'(1X)')
    write(*,100)
100 format(1X,"求解一阶常微分方程如下:" &
          /1X/1X,"方程形式：dy/dx=y*y-x*x")
    write(*,'(1X)')
    write(*,'(1X,"请输入微分方程初始条件 xa,ya（以空格隔开）: ",$)')
    read(*,*) xa,ya
    write(*,'(1X)')
    write(*,'(1X,"请输入自变量x的起始值与结束值 xb_min,xb_max（以空格隔开）: ",$)')
    read(*,*) xb_min,xb_max
    write(*,'(1X)')
    write(*,'(1X,"请输入自变量x变化步长: step = ",$)')
10  continue
    read(*,*) step
!    write(*,'(1X,"请设置求解精度要求 delta = ",$)')
!    read(*,*) delta
    delta=1e-5 ! 默认设置求解精度要求
    nf=(xb_max-xb_min)/(1.0*step)
    n=anint(nf)
    ntot=int(n)
    if ((abs(n-nf)<=1e-6).and.(xb_min<=xb_max)) then !
        write(*,'(1X)')
        write(*,200) ntot+1
200     format(1X,"输入的自变量区间与步长可匹配，共有",I2,"个待求变量值")
        write(*,'(1X)')
        write(*,300) xa,ya
300     format(1X,"求解微分方程结果如下：" &
              /1X/1X,"方程形式：dy/dx=y*y-x*x" &
              /1X/1X,"初始条件：x0 = ",F3.1,"   y0 = ",F3.1)
        write(*,'(1X)')
        do i=0,ntot
            xb=xb_min+(i*step)
            yb=RungKt(xa,ya,xb,delta,func)
            write(*,400) xb,yb
        end do
400     format(/1X,"xb = ",F16.6,"   yb = ",F16.6)
    else
        write(*,'(1X)')
        write(*,'(1X,"输入的自变量区间与步长不匹配，所分段数非整数！请重新输入自变量x变化步长： step = ",$)')
        goto 10
    end if

end
