! A fortran95 program for G95
! By ����ѧԺ ��ƣ�2017300281��
! ϰ��6-3 ������·����������

program Prog_6_3

!   ���峣��������ͳһ����
    parameter (omega = 314.15926)
    implicit complex(U,I,Z)
    real(kind=4) :: r1,c1,r2,c2,l2,r3,l3,r4,c4,p_I,p_I1,p_I2,p_I3
    U=(220.0,0.0)
!   ��Ԫ������������
    write(*,'(1X)')
    write(*,'("������Ԫ����1�Ĳ��� r1,c1��",$)')
    read(*,*) r1,c1
    write(*,'(1X)')
    write(*,'("������Ԫ����2�Ĳ��� r2,c2,l2��",$)')
    read(*,*) r2,c2,l2
    write(*,'(1X)')
    write(*,'("������Ԫ����3�Ĳ��� r3,l3��",$)')
    read(*,*) r3,l3
    write(*,'(1X)')
    write(*,'("������Ԫ����4�Ĳ��� r4,c4��",$)')
    read(*,*) r4,c4
!   ��Ԫ�����迹����
    Z1=cmplx(r1,(-1.0)/(omega*c1))
    Z2=cmplx(r2,((-1.0)/(omega*c2)+(omega*l2)))
    Z3=cmplx(r3,(omega*l3))
    Z4=cmplx(r4,(-1.0)/(omega*c1))
    Z34=(Z3*Z4)/(Z3+Z4)
    Z234=Z2+Z34
!   ����1���ܵ�Ч�������
    Z=(Z1*Z234)/(Z1+Z234)
    write(*,'(1X)')
    write(*,*) "���� 1 �Ľ�����£�"
    write(*,'(1X)')
    write(*,*) "�ܵ�Ч���� Z = ",Z
    write(*,'(1X)')
!   ����2������I����λ����
    I=U/Z
    p_I=57.29578*atan2(aimag(I),real(I))
    write(*,*) "���� 2 �Ľ�����£�"
    write(*,'(1X)')
    write(*,*) "���� I = ",I
    write(*,*) "���� I ����λΪ Phase_I = ",p_I
    write(*,'(1X)')
!   ����3������I1,I2,I3������λ����
!   ����3-1������I1������λ����
    I1=U/Z1
    p_I1=57.29578*atan2(aimag(I1),real(I1))
!   ����3-2������I2������λ����
    I23=I-I1
    U23=U-(I23*Z2)
    I2=U23/Z3
    p_I2=57.29578*atan2(aimag(I2),real(I2))
!   ����3-3������I3������λ����
    I3=U23/Z4
    p_I3=57.29578*atan2(aimag(I3),real(I3))
    write(*,*) "���� 3 �Ľ�����£�"
    write(*,'(1X)')
    write(*,*) "���� I1 = ",I1
    write(*,*) "���� I1 ����λ Phase_I1 = ",p_I1
    write(*,'(1X)')
    write(*,*) "���� I2 = ",I2
    write(*,*) "���� I2 ����λ Phase_I2 = ",p_I2
    write(*,'(1X)')
    write(*,*) "���� I3 = ",I2
    write(*,*) "���� I3 ����λ Phase_I3 = ",p_I3

end
