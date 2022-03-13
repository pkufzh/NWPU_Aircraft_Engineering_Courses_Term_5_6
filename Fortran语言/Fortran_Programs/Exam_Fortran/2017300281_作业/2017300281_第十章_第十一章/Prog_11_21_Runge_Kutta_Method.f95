! A fortran95 program for G95
! By ����ѧԺ ��ƣ�2017300281��
! ����11-21 �������������дһ����΢�ַ��̵�ͨ�ó���

function func(y,x) ! ����func���ܣ�����΢�ַ����Ҳຯ��f(y,x)��ʽ

    func=y*y-x*x

end function

subroutine init(x0,xa,y0,ya,x1,xb) ! �����г���init���ܣ����ɽ�xa,ya,xb��ֵ����x0,y0,x1�Ĳ���

    real :: x0,xa,y0,ya,x1,xb
    x0=xa
    y0=ya
    x1=xb

end subroutine

subroutine coeffi(k0,k1,k2,k3,x0,y0,h,f) ! �����г���coeffi���ܣ�����ÿ�������k0,k1,k2,k3��ֵ

    real :: k0,k1,k2,k3,x0,y0,h
    k0=h*f(y0,x0)
    k1=h*f((y0+(k0/2.0)),(x0+(h/2.0)))
    k2=h*f((y0+(k1/2.0)),(x0+(h/2.0)))
    k3=h*f((y0+k2),(x0+h))

end subroutine

function RungKt(xa,ya,xb,delta,f) ! ����RungKt���ܣ����������������㷨ʵ�֣������������ʼֵ��������������Ҫ�����ú���f��

    external f
    integer nn,m,i
    real :: k0,k1,k2,k3
    real :: RungKt
    call init(x0,xa,y0,ya,x1,xb)
    nn=1
    h=(x1-x0)/(1.0*nn)
    call coeffi(k0,k1,k2,k3,x0,y0,h,f)
    y1=y0+(k0+(2*k1)+(2*k2)+k3)/6.0
    m=0
10  continue
    m=m+1
    call init(x0,xa,y0,ya,x1,xb)
    nn=nn*2
    h=(x1-x0)/(1.0*nn)
    RungKt=y1
    do i=1,nn
        call coeffi(k0,k1,k2,k3,x0,y0,h,f)
        y1=y0+(k0+(2*k1)+(2*k2)+k3)/6.0
        x0=x0+h
        y0=y1
    end do
    ! ����ﵽ���Ҫ����ߵ�����������5000�Σ�����Ϊ�ﵽ���ȣ��˳����
    if ((abs(RungKt-y1)<=(abs(y1)*delta)).OR.(m>5000)) then
    else
    ! ������������nn=nn*2���ٴ����yb
        goto 10
    end if
    if (m>5000) then
        write(*,*) "���������Ѿ�����5000!!"
    end if
    ! ����RungKt���ֵΪ�����˳����y1
    RungKt=y1

end function

program Prog_11_21_Runge_Kutta_Method

    external func
    integer i,ntot
    real :: xa,ya,xb,yb,delta,xb_min,xb_max,nf,n,step
    write(*,'(1X)')
    write(*,100)
100 format(1X,"���һ�׳�΢�ַ�������:" &
          /1X/1X,"������ʽ��dy/dx=y*y-x*x")
    write(*,'(1X)')
    write(*,'(1X,"������΢�ַ��̳�ʼ���� xa,ya���Կո������: ",$)')
    read(*,*) xa,ya
    write(*,'(1X)')
    write(*,'(1X,"�������Ա���x����ʼֵ�����ֵ xb_min,xb_max���Կո������: ",$)')
    read(*,*) xb_min,xb_max
    write(*,'(1X)')
    write(*,'(1X,"�������Ա���x�仯����: step = ",$)')
10  continue
    read(*,*) step
!    write(*,'(1X,"��������⾫��Ҫ�� delta = ",$)')
!    read(*,*) delta
    delta=1e-5 ! Ĭ��������⾫��Ҫ��
    nf=(xb_max-xb_min)/(1.0*step)
    n=anint(nf)
    ntot=int(n)
    if ((abs(n-nf)<=1e-6).and.(xb_min<=xb_max)) then !
        write(*,'(1X)')
        write(*,200) ntot+1
200     format(1X,"������Ա��������벽����ƥ�䣬����",I2,"���������ֵ")
        write(*,'(1X)')
        write(*,300) xa,ya
300     format(1X,"���΢�ַ��̽�����£�" &
              /1X/1X,"������ʽ��dy/dx=y*y-x*x" &
              /1X/1X,"��ʼ������x0 = ",F3.1,"   y0 = ",F3.1)
        write(*,'(1X)')
        do i=0,ntot
            xb=xb_min+(i*step)
            yb=RungKt(xa,ya,xb,delta,func)
            write(*,400) xb,yb
        end do
400     format(/1X,"xb = ",F16.6,"   yb = ",F16.6)
    else
        write(*,'(1X)')
        write(*,'(1X,"������Ա��������벽����ƥ�䣬���ֶ����������������������Ա���x�仯������ step = ",$)')
        goto 10
    end if

end
