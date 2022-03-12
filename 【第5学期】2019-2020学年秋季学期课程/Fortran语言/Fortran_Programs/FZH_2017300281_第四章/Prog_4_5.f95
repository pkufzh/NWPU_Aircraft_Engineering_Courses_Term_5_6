! A fortran95 program for G95
! By 航空学院 冯铮浩（2017300281）
! 习题4-5 求Y值

program Prog_4_5
    implicit none
    integer flag
    real(kind=4) :: x,y
    read(*,*) x
    flag=1
    if ((x .LT. 30) .AND. (x .GE. 20)) then
        y=(x**3)+(x*x)+1
    elseif ((x .LT. 20) .AND. (x .GE. 10)) then
        y=x*x+1
    elseif ((x .LT. 10) .AND. (x .GE. 0)) then
        y=x
    else
        flag=0
    endif
    if (flag==1) then
        write(*,*) 'Y = ',y
    else
        write(*,*)"Error!请输入大于等于0且小于30的值！"
    endif
end program
