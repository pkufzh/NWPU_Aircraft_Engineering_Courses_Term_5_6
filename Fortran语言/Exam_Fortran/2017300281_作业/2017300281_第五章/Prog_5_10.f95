! A fortran95 program for G95
! By ����ѧԺ ���
! ϰ��5-10 ������ʽSnֵ

program Prog_5_10

    implicit none
    integer a,n,k,i,Sn,Sk
    write(*,'("������a��ֵ��",$)')
    read(*,*) a
    write(*,'("������n��ֵ��",$)')
    read(*,*) n
    Sn=0;
    Do k=1,n
        Sk=0
        Do i=1,k
            Sk=Sk+(a*(10**(i-1)))
        End Do
        Sn=Sn+Sk
    End Do
    write(*,*) "���ʽ Sn = ",Sn

end
