! A fortran95 program for G95
! By ����ѧԺ ��ƣ�2017300281��
! ϰ��9-4 ����˳����ҵķ���, �����������в���ĳ����, Ҫ��һ���ҵ�������ֹͣ���ҡ�

program Prog_9_4

    implicit none
    integer n,k,i,flag,po
    integer a(100)
    write(*,'("���������а���Ԫ�ظ��� n = ",$)')
    read(*,*) n
    write(*,'("��������Ҫ�������� k = ",$)')
    read(*,*) k
    write(*,100)
100 format("��������Ҫ�����������У��Կո��������",$)
    read(*,*) a(1:n)
    flag=0
    Do i=1,n
        if (a(i)==k) then
            flag=1
            po=i
            exit
        end if
    End Do
    if (flag==1)then
        write(*,'(1X)')
        write(*,200) po
200     format("�����������У��ɹ����ҵ���k�����״γ���λ��Ϊ����",I2," λ")
    else
        write(*,'(1X)')
        write(*,*) "�����������У�δ�ܲ��ҵ���k"
    end if

end
