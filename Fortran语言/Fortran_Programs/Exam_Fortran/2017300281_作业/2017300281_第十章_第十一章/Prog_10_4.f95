! A fortran95 program for G95
! By ����ѧԺ ��ƣ�2017300281��
! ϰ��10-4 ����亯���������ţ�ٷ���x^3-2*x^2+x-1=0��x=1.5������ʵ����

program Prog_10_4

    implicit none
    real(kind=8):: f,f1,x,x1,de
    integer n
    f(x)=(x**3)-2*(x**2)+x-1 ! ������亯��f(x)
    f1(x)=3*(x**2)-(4*x)+1 ! ������亯��f'(x)
    write(*,'(1X,"�������������̸��ĳ�ʼֵ��x1 = ",$)')
    read(*,*) x
    write(*,'(1X)')
    write(*,*) "����ţ�ٷ�������������£�"
    write(*,'(1X)')
    n=1
    de=1e-6 ! ���õ����˳����
10  continue
    x1=x
    x=x1-((f(x1))/(f1(x))) ! ����ţ�ٵ������ƽ���ʵ��
    write(*,100) n,x1,x
    n=n+1
    if (abs(x-x1).GT.de) goto 10
100 format(1X,'N=',I3,3X,'X1=',F15.7,3X,'X=',F15.7)
    write(*,'(1X)')
    write(*,200) x
200 format(1X,"���̵Ľ��Ƹ�Ϊ x = ",F16.8)

end
