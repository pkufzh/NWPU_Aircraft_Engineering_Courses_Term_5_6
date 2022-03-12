! A fortran95 program for G95
! By 航空学院 冯铮浩（2017300281）
! 习题4-3 求下列逻辑表达式的值

program Prog_4_3
    implicit none
    real :: A=2.5,B=7.5,C=5.0,D=6.0
    logical L,M
    logical D1,D2
    L=.TRUE.
    M=.FALSE.
    D1=(.NOT. L .OR. C .EQ. D .AND. M)
    D2=((A .LT. B) .AND. (B .LT. A))
    write(*,*) '逻辑表达式3的值为：',D1
    write(*,*) '逻辑表达式6的值为：',D2
end
