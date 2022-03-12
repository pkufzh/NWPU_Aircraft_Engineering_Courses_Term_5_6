! A fortran95 program for G95
! By 航空学院 冯铮浩（2017300281）
! 习题11-3 编写函数子程序GDC求两个数的最大公约数。

integer function gcd(x1,y1)
    integer q,x1,y1,x,y
    x=max(x1,y1)
    y=min(x1,y1)
10  continue
    q=mod(x,y)
    x=y
    y=q
    if (q/=0) goto 10
    gcd=x
end function

program Prog_11_3

    implicit none
    integer a(1000)
    integer i,n,ans
    integer gcd
    write(*,100)
100 format(1X,"请输入所要求最大公约数的数字个数: n = ",$)
    read(*,*) n
    write(*,'(1X)')
    write(*,200) n
200 format(1X,"请输入",I2,"个待求最大公约数的数字（以空格隔开）：",$)
    read(*,*) a(1:n) ! 输入所需求最大公约数的数列
    write(*,'(1X)')
    ! 调用gcd函数子程序计算最大公约数
    ans=gcd(a(1),a(n))
    do i=2,n-1
        ans=gcd(ans,a(i))
    end do
    write(*,300) ans
300 format(1X,"输入数列数字的最大公约数为 gcd = ",I5)

end
