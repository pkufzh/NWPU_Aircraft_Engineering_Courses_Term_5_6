! A fortran95 program for G95
! By ����ѧԺ ���
! ϰ��5-16 Method ����WHILE ���, д����, ��

program Prog_5_16_Method_1

    implicit none
    integer n,i,k,sn,sk
    write(*,'("������n��ֵ��",$)')
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
    write(*,*) "���ʽ�Ľ�� �� = ",sn

end
