! A fortran95 program for G95
! By ����ѧԺ ���
! ϰ��5-18 �� [��5.12] ����ֱ����ѭ����д����

program Prog_5_18

    implicit none
    integer N,i,flag
    write(*,'("������N��ֵ��",$)')
    read(*,*) N
    flag=1;
    i=2
    ! �����ж���ֻ���2ѭ����N�Ŀ���+1��ȡ�����ɣ�
10  continue
        if (mod(N,i)==0) then
            flag=0
        end if
        i=i+1
    if (i<=(int(sqrt(1.0*N)+1))) goto 10
    if ((flag==0) .and. (N/=2)) then
        write(*,*) "�������NΪ����"
    else
        write(*,*) "�������NΪ����"
    end if
end
