! A fortran95 program for G95
! By 航空学院 冯铮浩
! 习题5-18 将 [例5.12] 改用直到型循环编写程序

program Prog_5_18

    implicit none
    integer N,i,flag
    write(*,'("请输入N的值：",$)')
    read(*,*) N
    flag=1;
    i=2
    ! 素数判定（只需从2循环到N的开方+1的取整即可）
10  continue
        if (mod(N,i)==0) then
            flag=0
        end if
        i=i+1
    if (i<=(int(sqrt(1.0*N)+1))) goto 10
    if ((flag==0) .and. (N/=2)) then
        write(*,*) "输入的数N为合数"
    else
        write(*,*) "输入的数N为素数"
    end if
end
