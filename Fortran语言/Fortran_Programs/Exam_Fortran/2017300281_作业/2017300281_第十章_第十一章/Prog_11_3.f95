! A fortran95 program for G95
! By ����ѧԺ ��ƣ�2017300281��
! ϰ��11-3 ��д�����ӳ���GDC�������������Լ����

integer function gcd(x1,y1)
    integer q,x1,y1,x,y
    x=max(x1,y1)
    y=min(x1,y1)
10  continue
    q=mod(x,y)
    x=y
    y=q
    if (q/=0) goto 10
    gcd=x
end function

program Prog_11_3

    implicit none
    integer a(1000)
    integer i,n,ans
    integer gcd
    write(*,100)
100 format(1X,"��������Ҫ�����Լ�������ָ���: n = ",$)
    read(*,*) n
    write(*,'(1X)')
    write(*,200) n
200 format(1X,"������",I2,"���������Լ�������֣��Կո��������",$)
    read(*,*) a(1:n) ! �������������Լ��������
    write(*,'(1X)')
    ! ����gcd�����ӳ���������Լ��
    ans=gcd(a(1),a(n))
    do i=2,n-1
        ans=gcd(ans,a(i))
    end do
    write(*,300) ans
300 format(1X,"�����������ֵ����Լ��Ϊ gcd = ",I5)

end
