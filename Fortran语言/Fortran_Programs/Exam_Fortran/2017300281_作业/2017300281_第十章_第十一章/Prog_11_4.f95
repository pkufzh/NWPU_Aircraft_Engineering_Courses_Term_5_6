! A fortran95 program for G95
! By ����ѧԺ ��ƣ�2017300281��
! ϰ��11-4 ��д���ֵ�ĺ���

real function coeff_gamma(x,cnt)

    integer i,cnt
    real x(1000)
    real det,xb,sum_tot,sum1,sum2
    sum_tot=0.0
    sum1=0.0
    sum2=0.0
    do i=1,cnt
        sum_tot=sum_tot+x(i)
    end do
    xb=sum_tot/(1.0*cnt)
    do i=1,cnt
        sum1=sum1+((x(i)-xb)**3)
        sum2=sum2+((x(i)-xb)**2)
    end do
    det=sqrt((sum2/(1.0*(cnt-1))))
    coeff_gamma=sum1/(1.0*cnt*(det**3))

end function

program Prog_11_4

    implicit none
    integer n
    real a(1000)
    real ans,coeff_gamma
    write(*,100)
100 format(1X,"������ʵ�����ݸ���: n = ",$)
    read(*,*) n
    write(*,'(1X)')
    write(*,200) n
200 format(1X,"������",I2,"��ʵ������ֵ���Կո��������",$)
    read(*,*) a(1:n) ! �����������ֵ��ʵ����������
    write(*,'(1X)')
    ! ����coeff_gamma�����ӳ���������Լ��
    ans=coeff_gamma(a,n)
    write(*,300) ans
300 format(1X,"ʵ�����ݵ�ʧ��ϵ��Ϊ �� = ",F16.8)

end
