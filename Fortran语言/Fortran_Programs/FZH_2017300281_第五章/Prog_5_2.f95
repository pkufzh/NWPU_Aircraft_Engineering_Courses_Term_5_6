! A fortran95 program for G95
! By 航空学院 冯铮浩
! 习题5-2 计算表达式值

program Prog_5_2

    implicit none
    integer i,n
    real(kind=8):: ans
    write(*,'("请输入n的值：",$)')
    read(*,*) n
    ans=0
    Do i=1,n
        ans=ans+(1.0/(i*(i+1)))
    End Do
    write(*,*) "表达式的结果 Σ= ",ans

end
