! A fortran95 program for G95
! By ����ѧԺ ��ƣ�2017300281��
! ϰ��10-3 ����亯������������������󶨻���

program Prog_10_3

    implicit none
    real(kind=8):: x,a,b,h,s,t,f,f_2,f_4
    integer n,i
    f(X)=sin(X)+cos(X) ! ���屻������
    write(*,'(1X,"�����뱻�������½磺a = ",$)')
    read(*,*) a
    write(*,'(1X)')
    write(*,'(1X,"�����뱻�������Ͻ磺b = ",$)')
    read(*,*) b
    n=16 ! �������΢�θ���
    h=(b-a)/(2.0*n)
    s=0.0 ! ����ۼӱ���
    t=a+h !
    f_2=0.0  ! ϵ��Ϊ2���ۼ���֮��
    f_4=f(t) ! ϵ��Ϊ4���ۼ���֮��
    do i=1,n-1
        t=t+h
        f_2=f_2+f(t)
        t=t+h
        f_4=f_4+f(t)
    end do
    s=(h/3.0)*(f(a)+f(b)+(4.0*f_4)+(2.0*f_2))
    write(*,'(1X)')
    write(*,100) s
100 format(1X,"���ʽ���ֵĽ��Ϊ s = ",F16.8)

end
