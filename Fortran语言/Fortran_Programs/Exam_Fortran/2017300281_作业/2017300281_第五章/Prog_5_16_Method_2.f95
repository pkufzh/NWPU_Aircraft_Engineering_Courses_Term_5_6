! A fortran95 program for G95
! By 航空学院 冯铮浩
! 习题5-16 Method ②用块IF 语句和GOTO 语句, 写程序, 求Σ

program Prog_5_16_Method_2

    implicit none
    integer n,i,k,sn,sk
    write(*,'("请输入n的值：",$)')
    read(*,*) n
    sn=0
    i=0
10  continue
    if (i<n) then
        i=i+1
        sk=1
        k=0
20      continue
        if (k<i)then
            k=k+1
            sk=sk*k
            goto 20 ! 跳转至k——内循环
        end if
        sn=sn+sk
        goto 10 ! 跳转至i——外循环
    end if
    write(*,*) "表达式的结果 Σ = ",sn

end
