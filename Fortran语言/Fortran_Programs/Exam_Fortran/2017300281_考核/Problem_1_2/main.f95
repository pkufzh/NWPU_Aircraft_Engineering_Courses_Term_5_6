! A fortran95 program for G95
! By ����ѧԺ ��ƣ�2017300281��
! ������1_2������11-21�� �������������дһ����΢�ַ��̵�ͨ�ó��򣬲����ֱ�ȡh=0.01,h=0.001��h=0.0001

function func(y,x) ! ����func���ܣ�����΢�ַ����Ҳຯ��f(y,x)��ʽ

    func=(y**3)-(x*x)+1

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

function RungKt(xa,ya,xb,f,h) ! ����RungKt���ܣ����������������㷨ʵ�֣������������ʼֵ��������������Ҫ�����ú���f��

    external f
    real :: k0,k1,k2,k3
    real :: RungKt
    call init(x0,xa,y0,ya,x1,xb)
!    h=0.01 ! ���벽��h
    call coeffi(k0,k1,k2,k3,x0,y0,h,f)
    y1=y0+(k0+(2*k1)+(2*k2)+k3)/6.0
    call init(x0,xa,y0,ya,x1,xb)
    do i=1,int((x1-x0)/(1.0*h)) ! ע�⣺�˴�����int��������i��Ҫѭ���Ĵ���
        call coeffi(k0,k1,k2,k3,x0,y0,h,f)
        y1=y0+(k0+(2*k1)+(2*k2)+k3)/6.0
        x0=x0+h
        y0=y1
    end do
    RungKt=y1

end function

subroutine asterisk ! �����г���asterisk���ܣ�ÿ����һ�δ�ӡһ���Ǻ�*

    write(*,10)
10  format(1X,70('*'))

end subroutine

program Problem_1_2

    external func
    integer i,ntot
    real :: xa,ya,xb,yb,xb_min,xb_max,nf,n,step,h
    call asterisk !��ӡһ���Ǻ�
    write(*,'(1X)')
    write(*,100)
100 format(1X,"�����Ľ����������ʽ���һ�׳�΢�ַ�������:" &
          /1X/1X,"������ʽ��dy/dx=y*y*y-x*x+1")
    write(*,'(1X)')
    write(*,'(1X,"������΢�ַ��̳�ʼ���� x0,y0���Կո������: ",$)')
    read(*,*) xa,ya
    write(*,'(1X)')
    write(*,'(1X,"�������Ա���x����ʼֵ�����ֵ x1_min,x1_max���Կո������: ",$)')
    read(*,*) xb_min,xb_max
    write(*,'(1X)')
    write(*,'(1X,"���������ʹ�ò���: h = ",$)')
    read(*,*) h
    write(*,'(1X)')
    write(*,'(1X,"�������Ա���x�仯����: step = ",$)')
10  continue
    read(*,*) step
    nf=(xb_max-xb_min)/(1.0*step)
    n=anint(nf)
    ntot=int(n)
    if ((abs(n-nf)<=1e-5).and.(xb_min<=xb_max)) then
        write(*,'(1X)')
        call asterisk
        write(*,'(1X)')
        write(*,200) ntot+1
200     format(1X,"������Ա��������벽����ƥ�䣬����",I2,"���������ֵ")
        write(*,'(1X)')
        write(*,300) xa,ya
300     format(1X,"���΢�ַ��̽�����£�" &
              /1X/1X,"������ʽ��dy/dx=y*y-x*x" &
              /1X/1X,"��ʼ������x0 = ",F3.1,"   y0 = ",F3.1)
        write(*,'(1X)')
        write(*,400) h
400     format(1X,"�����ȡ����Ϊ: h = ",F8.6,$)
        write(*,'(1X)')
        write(*,'(1X)')
        call asterisk
        do i=0,ntot
            xb=xb_min+(i*step)
            yb=RungKt(xa,ya,xb,func,h)
            write(*,500) xb,yb
        end do
500     format(/1X,"x1 = ",F16.6,"   y1 = ",F16.6)
    else
        write(*,'(1X)')
        write(*,'(1X,"������Ա��������벽����ƥ�䣬���ֶ����������������������Ա���x�仯������ step = ",$)')
        goto 10
    end if
    write(*,'(1X)')
    call asterisk
    write(*,'(1X)')
end
