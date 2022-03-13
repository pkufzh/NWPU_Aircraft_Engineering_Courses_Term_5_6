! A fortran95 program for G95
! By 航空学院 冯铮浩（2017300281）
! 习题6-3 交流电路各参数计算

program Prog_6_3

!   定义常量与名称统一变量
    parameter (omega = 314.15926)
    implicit complex(U,I,Z)
    real(kind=4) :: r1,c1,r2,c2,l2,r3,l3,r4,c4,p_I,p_I1,p_I2,p_I3
    U=(220.0,0.0)
!   各元器件参数输入
    write(*,'(1X)')
    write(*,'("请输入元器件1的参数 r1,c1：",$)')
    read(*,*) r1,c1
    write(*,'(1X)')
    write(*,'("请输入元器件2的参数 r2,c2,l2：",$)')
    read(*,*) r2,c2,l2
    write(*,'(1X)')
    write(*,'("请输入元器件3的参数 r3,l3：",$)')
    read(*,*) r3,l3
    write(*,'(1X)')
    write(*,'("请输入元器件4的参数 r4,c4：",$)')
    read(*,*) r4,c4
!   各元器件阻抗计算
    Z1=cmplx(r1,(-1.0)/(omega*c1))
    Z2=cmplx(r2,((-1.0)/(omega*c2)+(omega*l2)))
    Z3=cmplx(r3,(omega*l3))
    Z4=cmplx(r4,(-1.0)/(omega*c1))
    Z34=(Z3*Z4)/(Z3+Z4)
    Z234=Z2+Z34
!   问题1：总等效电阻计算
    Z=(Z1*Z234)/(Z1+Z234)
    write(*,'(1X)')
    write(*,*) "问题 1 的解答如下："
    write(*,'(1X)')
    write(*,*) "总等效电阻 Z = ",Z
    write(*,'(1X)')
!   问题2：电流I和相位计算
    I=U/Z
    p_I=57.29578*atan2(aimag(I),real(I))
    write(*,*) "问题 2 的解答如下："
    write(*,'(1X)')
    write(*,*) "电流 I = ",I
    write(*,*) "电流 I 的相位为 Phase_I = ",p_I
    write(*,'(1X)')
!   问题3：电流I1,I2,I3及其相位计算
!   问题3-1：电流I1及其相位计算
    I1=U/Z1
    p_I1=57.29578*atan2(aimag(I1),real(I1))
!   问题3-2：电流I2及其相位计算
    I23=I-I1
    U23=U-(I23*Z2)
    I2=U23/Z3
    p_I2=57.29578*atan2(aimag(I2),real(I2))
!   问题3-3：电流I3及其相位计算
    I3=U23/Z4
    p_I3=57.29578*atan2(aimag(I3),real(I3))
    write(*,*) "问题 3 的解答如下："
    write(*,'(1X)')
    write(*,*) "电流 I1 = ",I1
    write(*,*) "电流 I1 的相位 Phase_I1 = ",p_I1
    write(*,'(1X)')
    write(*,*) "电流 I2 = ",I2
    write(*,*) "电流 I2 的相位 Phase_I2 = ",p_I2
    write(*,'(1X)')
    write(*,*) "电流 I3 = ",I2
    write(*,*) "电流 I3 的相位 Phase_I3 = ",p_I3

end
