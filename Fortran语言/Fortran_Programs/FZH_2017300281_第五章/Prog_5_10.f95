! A fortran95 program for G95
! By 航空学院 冯铮浩
! 习题5-10 计算表达式Sn值

program Prog_5_10

    implicit none
    integer a,n,k,i,Sn,Sk
    write(*,'("请输入a的值：",$)')
    read(*,*) a
    write(*,'("请输入n的值：",$)')
    read(*,*) n
    Sn=0;
    Do k=1,n
        Sk=0
        Do i=1,k
            Sk=Sk+(a*(10**(i-1)))
        End Do
        Sn=Sn+Sk
    End Do
    write(*,*) "表达式 Sn = ",Sn

end
