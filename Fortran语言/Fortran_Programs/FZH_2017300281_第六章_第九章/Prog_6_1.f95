! A fortran95 program for G95
! By 航空学院 冯铮浩（2017300281）
! 习题6-1 用双精度计算sin(x)

program Prog_6_1

    implicit none
    real(kind=8) :: x,sn,sk
    integer flag,cnt
    write(*,'("请输入待求正弦函数值：x = ",$)')
    read(*,*) x
    sk=x
    sn=x
    flag=1
    cnt=0
10  continue
    flag=flag*(-1)
    cnt=cnt+1
    sk=(sk*x*x)/((cnt*2)*((cnt*2)+1))
    sn=sn+(flag*sk)
    if (abs(sk)>=1.0D-15) goto 10
    write(*,'(1X)')
    write(*,*) "表达式的结果 sin(x) = ",sn

end
