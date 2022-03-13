! A fortran95 program for G95
! By 航空学院 冯铮浩（2017300281）
! 考核题1_1 编写打印九九乘法表

program Problem_1_1

    implicit none
    integer i,j,a
    write(*,*) "输出的九九乘法表展示如下："
    write(*,'(1X)')
    do i=1,9
        do j=1,i
            a=i*j
            write(*,100) j,i,a
        end do
        write(*,'(1X)')
    end do
100 format(I2,"*",I2,"=",I2,$)

end
