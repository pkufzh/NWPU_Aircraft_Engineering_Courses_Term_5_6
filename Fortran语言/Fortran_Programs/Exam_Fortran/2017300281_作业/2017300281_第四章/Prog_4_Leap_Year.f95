! A fortran95 program for G95
! By 航空学院 冯铮浩（2017300281）
! 补充习题：平年闰年的判定程序

program Prog_4_Leap_Year

    implicit none
    integer year,flag
    read(*,*) year
    flag=0
    if (((mod(year,4)==0) .AND. (mod(year,100)/=0)) .OR. &
       ((mod(year,400)==0) .AND. (mod(year,3200)/=0)) .OR. (mod(year,172800)==0)) then
        flag=1
    endif
    if (flag==1) then
        write(*,*) "输入的年份是闰年"
    else
        write(*,*) "输入的年份是平年"
    endif

end program

