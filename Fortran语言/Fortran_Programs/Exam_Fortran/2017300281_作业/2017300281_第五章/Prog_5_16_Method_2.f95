! A fortran95 program for G95
! By ����ѧԺ ���
! ϰ��5-16 Method ���ÿ�IF ����GOTO ���, д����, ��

program Prog_5_16_Method_2

    implicit none
    integer n,i,k,sn,sk
    write(*,'("������n��ֵ��",$)')
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
            goto 20 ! ��ת��k������ѭ��
        end if
        sn=sn+sk
        goto 10 ! ��ת��i������ѭ��
    end if
    write(*,*) "���ʽ�Ľ�� �� = ",sn

end
