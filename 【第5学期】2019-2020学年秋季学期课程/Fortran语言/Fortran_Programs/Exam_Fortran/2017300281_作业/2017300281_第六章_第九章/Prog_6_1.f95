! A fortran95 program for G95
! By ����ѧԺ ��ƣ�2017300281��
! ϰ��6-1 ��˫���ȼ���sin(x)

program Prog_6_1

    implicit none
    real(kind=8) :: x,sn,sk
    integer flag,cnt
    write(*,'("������������Һ���ֵ��x = ",$)')
    read(*,*) x
    sk=x
    sn=x
    flag=1
    cnt=0
10  continue
    flag=flag*(-1)
    cnt=cnt+1
    sk=(sk*x*x)/((cnt*2)*((cnt*2)+1))
    sn=sn+(flag*sk)
    if (abs(sk)>=1.0D-15) goto 10
    write(*,'(1X)')
    write(*,*) "���ʽ�Ľ�� sin(x) = ",sn

end
