! A fortran95 program for G95
! By ����ѧԺ ���
! ϰ��5-2 ������ʽֵ

program Prog_5_2

    implicit none
    integer i,n
    real(kind=8):: ans
    write(*,'("������n��ֵ��",$)')
    read(*,*) n
    ans=0
    Do i=1,n
        ans=ans+(1.0/(i*(i+1)))
    End Do
    write(*,*) "���ʽ�Ľ�� ��= ",ans

end
