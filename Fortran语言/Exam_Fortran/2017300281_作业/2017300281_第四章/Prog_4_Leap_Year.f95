! A fortran95 program for G95
! By ����ѧԺ ��ƣ�2017300281��
! ����ϰ�⣺ƽ��������ж�����

program Prog_4_Leap_Year

    implicit none
    integer year,flag
    read(*,*) year
    flag=0
    if (((mod(year,4)==0) .AND. (mod(year,100)/=0)) .OR. &
       ((mod(year,400)==0) .AND. (mod(year,3200)/=0)) .OR. (mod(year,172800)==0)) then
        flag=1
    endif
    if (flag==1) then
        write(*,*) "��������������"
    else
        write(*,*) "����������ƽ��"
    endif

end program

