! A fortran95 program for G95
! By 航空学院 冯铮浩
! 习题5-16 Method ①用WHILE 语句, 写程序, 求Σ

program Prog_5_16_Method_1

    implicit none
    integer n,i,k,sn,sk
    write(*,'("请输入n的值：",$)')
    read(*,*) n
    sn=0
    i=0
    Do while(i<n)
        i=i+1
        sk=1
        Do k=1,i
            sk=sk*k
        End Do
        sn=sn+sk
    End Do
    write(*,*) "表达式的结果 Σ = ",sn

end
