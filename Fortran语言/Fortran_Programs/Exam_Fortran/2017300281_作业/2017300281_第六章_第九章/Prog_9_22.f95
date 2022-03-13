! A fortran95 program for G95
! By 航空学院 冯铮浩（2017300281）
! 习题9-22 编写程序打印出任意阶奇数幻方

program Prog_9_22

    implicit none
    integer n,nmax,i,j,k
    integer a(1000,1000)
    write(*,100)
100 format('请输入幻方阶数（为奇数） n = ',$)
    read(*,*) n
    nmax=n*n
    ! 数组初始化（n-1*n-1矩阵置0操作）
    Do i=1,n+1
        Do j=1,n+1
            a(i,j)=0
        End Do
    End Do
    ! 按照规律(a)~(f)从1到n*n依次放数
    ! 规律(a)：连续的数从左下向右上的方向顺序放置
    ! 规律(f)：第一个数1放在第一行的中间
    i=1
    j=(n+1)/2
    a(i,j)=1
    k=1
    ! 开始放置下一个数k
    do while(k<nmax)
        !需要放置的下一个数
        k=k+1
        ! 行列号变化
        i=i-1
        j=j+1
        if (i==0) then
            ! 规律(b):当按(a)的规律放数时，下一个数的位置的行号变成小于1时，
            ! 则把该数放在该列中的最后一行上
            if ((j>=1).AND.(j<=n)) then
                a(n,j)=k
                i=n
            ! 规律(e):当按(a)的规律放数时，下一个数的位置的行号和列号都超过规定的行数和列数时，
            ! 则按(d)中的规则放数
            else
                a(i+2,j-1)=k
                i=i+2
                j=j-1
            end if
        else
            ! 规律(c):当按(a)的规律放数时，下一个数的位置的列号超过5时，
            ! 则把该数放在该行中第一列的位置中
            if (j>n) then
                a(i,1)=k
                j=1
            else
            ! 规律(d):当按(a)的规律放数时，下一个数的位置已经有数时，
            ! 则该数所放位置与上一个数在同一列上，只是行号加1
                if (a(i,j)/=0) then
                    a(i+2,j-1)=k
                    i=i+2
                    j=j-1
                else
                    a(i,j)=k
                end if
            end if
        end if
    end do
    write(*,'(1X)')
    write(*,*)"构造幻方如下："
    write(*,'(1X)')
    do i=1,n
        do j=1,n
            write(*,200) a(i,j)
        end do
        write(*,*)
    end do
200 format(I5,$)

end
