! A fortran95 program for G95
! By 航空学院 冯铮浩（2017300281）
! 考核题1_2（例题11-21） 用龙格库塔法编写一个解微分方程的通用程序，步长分别取h=0.01,h=0.001和h=0.0001

function func(y,x) ! 函数func功能：设置微分方程右侧函数f(y,x)形式

    func=(y**3)-(x*x)+1

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

function RungKt(xa,ya,xb,f,h) ! 函数RungKt功能：龙格库塔程序核心算法实现（输入变量：初始值，待求变量，误差要求，设置函数f）

    external f
    real :: k0,k1,k2,k3
    real :: RungKt
    call init(x0,xa,y0,ya,x1,xb)
!    h=0.01 ! 输入步长h
    call coeffi(k0,k1,k2,k3,x0,y0,h,f)
    y1=y0+(k0+(2*k1)+(2*k2)+k3)/6.0
    call init(x0,xa,y0,ya,x1,xb)
    do i=1,int((x1-x0)/(1.0*h)) ! 注意：此处调用int函数计算i需要循环的次数
        call coeffi(k0,k1,k2,k3,x0,y0,h,f)
        y1=y0+(k0+(2*k1)+(2*k2)+k3)/6.0
        x0=x0+h
        y0=y1
    end do
    RungKt=y1

end function

subroutine asterisk ! 子例行程序asterisk功能：每调用一次打印一行星号*

    write(*,10)
10  format(1X,70('*'))

end subroutine

program Problem_1_2

    external func
    integer i,ntot
    real :: xa,ya,xb,yb,xb_min,xb_max,nf,n,step,h
    call asterisk !打印一行星号
    write(*,'(1X)')
    write(*,100)
100 format(1X,"利用四阶龙格库塔公式求解一阶常微分方程如下:" &
          /1X/1X,"方程形式：dy/dx=y*y*y-x*x+1")
    write(*,'(1X)')
    write(*,'(1X,"请输入微分方程初始条件 x0,y0（以空格隔开）: ",$)')
    read(*,*) xa,ya
    write(*,'(1X)')
    write(*,'(1X,"请输入自变量x的起始值与结束值 x1_min,x1_max（以空格隔开）: ",$)')
    read(*,*) xb_min,xb_max
    write(*,'(1X)')
    write(*,'(1X,"请输入求解使用步长: h = ",$)')
    read(*,*) h
    write(*,'(1X)')
    write(*,'(1X,"请输入自变量x变化增量: step = ",$)')
10  continue
    read(*,*) step
    nf=(xb_max-xb_min)/(1.0*step)
    n=anint(nf)
    ntot=int(n)
    if ((abs(n-nf)<=1e-5).and.(xb_min<=xb_max)) then
        write(*,'(1X)')
        call asterisk
        write(*,'(1X)')
        write(*,200) ntot+1
200     format(1X,"输入的自变量区间与步长可匹配，共有",I2,"个待求变量值")
        write(*,'(1X)')
        write(*,300) xa,ya
300     format(1X,"求解微分方程结果如下：" &
              /1X/1X,"方程形式：dy/dx=y*y-x*x" &
              /1X/1X,"初始条件：x0 = ",F3.1,"   y0 = ",F3.1)
        write(*,'(1X)')
        write(*,400) h
400     format(1X,"求解所取步长为: h = ",F8.6,$)
        write(*,'(1X)')
        write(*,'(1X)')
        call asterisk
        do i=0,ntot
            xb=xb_min+(i*step)
            yb=RungKt(xa,ya,xb,func,h)
            write(*,500) xb,yb
        end do
500     format(/1X,"x1 = ",F16.6,"   y1 = ",F16.6)
    else
        write(*,'(1X)')
        write(*,'(1X,"输入的自变量区间与步长不匹配，所分段数非整数！请重新输入自变量x变化步长： step = ",$)')
        goto 10
    end if
    write(*,'(1X)')
    call asterisk
    write(*,'(1X)')
end
