! A fortran95 program for G95
! By 航空学院 冯铮浩（2017300281）
! 习题6-4 求三角形面积和三角形重心

program Prog_6_4

    implicit none
    real(kind=4) :: x1,y1,x2,y2,x3,y3,a,b,c,p,S,gx,gy
    complex G
!   各点坐标输入
    x1=1.5
    y1=2.0
    x2=4.5
    y2=4.5
    x3=18.0
    y3=10.5
!   利用海伦-秦九韶三角形面积公式求解
    a=sqrt((x1-x2)*(x1-x2)+(y1-y2)*(y1-y2))
    b=sqrt((x2-x3)*(x2-x3)+(y2-y3)*(y2-y3))
    c=sqrt((x1-x3)*(x1-x3)+(y1-y3)*(y1-y3))
    p=(a+b+c)/2 ! 计算三角形周长的一半
!   问题1：三角形面积的计算
    S=sqrt(p*(p-a)*(p-b)*(p-c))
    write(*,'(1X)')
    write(*,*) "问题 1 ：三角形的面积 S = ",S
!   问题2：三角形重心坐标的计算
    gx=(x1+x2+x3)/3.0
    gy=(y1+y2+y3)/3.0
    G=cmplx(gx,gy)
    write(*,'(1X)')
    write(*,*) "问题 2 ：三角形的重心坐标 = ",G

end
