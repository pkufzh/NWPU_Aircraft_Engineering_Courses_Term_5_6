! A fortran95 program for G95
! By ����ѧԺ ��ƣ�2017300281��
! ϰ��4-3 �������߼����ʽ��ֵ

program Prog_4_3
    implicit none
    real :: A=2.5,B=7.5,C=5.0,D=6.0
    logical L,M
    logical D1,D2
    L=.TRUE.
    M=.FALSE.
    D1=(.NOT. L .OR. C .EQ. D .AND. M)
    D2=((A .LT. B) .AND. (B .LT. A))
    write(*,*) '�߼����ʽ3��ֵΪ��',D1
    write(*,*) '�߼����ʽ6��ֵΪ��',D2
end
