! A fortran95 program for G95
! By ����ѧԺ ��ƣ�2017300281��
! ϰ��4-4 ����˰��TAX

program Prog_4_4
    implicit none
    real(kind=4)::INCOME,TAX
    read(*,*) INCOME
    if (INCOME .LT. 400.0) then
        TAX = 0
    else
        TAX = (INCOME-400.0)*(0.01*20)
    end if
    write(*,*) 'TAX = ',TAX
end
