! A fortran95 program for G95
! By ����ѧԺ ��ƣ�2017300281��
! ������1_1 ��д��ӡ�žų˷���

program Problem_1_1

    implicit none
    integer i,j,a
    write(*,*) "����ľžų˷���չʾ���£�"
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
