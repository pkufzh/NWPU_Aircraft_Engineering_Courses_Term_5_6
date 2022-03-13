! A fortran95 program for G95
! By 航空学院 冯铮浩（2017300281）
! 习题9-4 利用顺序查找的方法, 从有序数列中查找某个数, 要求一旦找到就立即停止查找。

program Prog_9_4

    implicit none
    integer n,k,i,flag,po
    integer a(100)
    write(*,'("请输入数列包含元素个数 n = ",$)')
    read(*,*) n
    write(*,'("请输入需要查找数字 k = ",$)')
    read(*,*) k
    write(*,100)
100 format("请输入需要查找数列数列（以空格隔开）：",$)
    read(*,*) a(1:n)
    flag=0
    Do i=1,n
        if (a(i)==k) then
            flag=1
            po=i
            exit
        end if
    End Do
    if (flag==1)then
        write(*,'(1X)')
        write(*,200) po
200     format("在有序数列中，成功查找到数k，其首次出现位置为：第",I2," 位")
    else
        write(*,'(1X)')
        write(*,*) "在有序数列中，未能查找到数k"
    end if

end
