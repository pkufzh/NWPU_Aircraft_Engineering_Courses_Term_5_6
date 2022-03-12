! A fortran95 program for G95
! By ����ѧԺ ��ƣ�2017300281��
! ϰ��11-10 ���������������n������Ϊ20������λ�����������ж���������Ҫ��������жԻ�����

subroutine my_rand_array(l,r,s) ! �ӳ����ܣ�����һ��[l,r]��Χ�ڵ��������

    implicit none
    integer l,r,length,s
    real :: rd
    length=r-l ! �������䳤��
    call random_number(rd)
    s=floor(l+(1.0*(length*rd)))

end subroutine

subroutine init_random_seed() ! �ӳ����ܣ��ο��������ף����ı�Ĭ����������ӣ�����ÿ�������������Ϊ��ͬ��

    implicit none
    integer i,n,clock
    integer,dimension(:),allocatable::seed
    call random_seed(size=n)
    allocate(seed(n))
    call system_clock(count=clock)
    seed=clock+37*(/(i-1,i=1,n)/)
    call random_seed(put=seed)
    deallocate(seed)

end subroutine

function check_flag(y,n) ! �������ܣ��ж������p1~p4�Ƿ����������ٲ�Խ��ڴ�С����˳��

    implicit none
    integer check_flag,i,n
    integer y(4)
    check_flag=1 ! 1��������ֵp1~p4������������

    if ((y(1)<=1).AND.(y(4)>=n)) then
        check_flag=0 ! 0��������ֵp1~p4��������������
    else
        do i=1,3
            if (y(i)>=y(i+1)) then
                check_flag=0
            end if
        end do
    end if

end function

subroutine swap(x,p1,p2,p3,p4,n) ! �ӳ����ܣ���x������[p1,p2]��[p3,p4]����֮������ֽ����������

    implicit none
    integer a,b,k,temp,lm,s1
    integer x(1000),p1,p2,p3,p4,n

    a=p2-p1+1 ! ����[p1,p2]�����ڵ����ָ���
    b=p4-p3+1 ! ����[p3,p4]�����ڵ����ָ���
    s1=min(a,b) ! �����״ν��������ָ���
    lm=max(a,b)-s1 ! ��Ҫ�ƶ�����
    ! ���е�һ�����򽻻�����
    if (a==s1) then ! ��һ�����������ָ���С�ڵڶ������������ָ���
        ! ������������ִ��±�p2+1��ʼ�����ƶ�lm��λ�ã����ڳ������ռ�
        do k=1,(n-p2)
            x(n-k+lm+1)=x(n-k+1)
        end do
        ! �������ƿ�һ������¶�Ĳ�������
        do k=1,lm
            x(p2+k)=0
        end do
        ! ��������ͬ���ȵ����ν��жԻ�
        do k=0,(a+lm-1)
            temp=x(p1+k)
            x(p1+k)=x(p3+lm+k)
            x(p3+lm+k)=temp
        end do
        ! ��������λ�Ĳ��ֲ���������ʣ��ġ�0��ֵ��
        do k=1,(n-p4)
            x(p4+k)=x(p4+k+lm)
        end do
        ! ��������ಿ������
        do k=1,lm
            x(n+k)=0
        end do
    else
        ! ������������ִ��±�p4+1��ʼ���±�n�����ƶ�lm��λ�ã����ڳ������ռ�
        do k=1,(n-p4)
            x(n-k+lm+1)=x(n-k+1)
        end do
        ! �������ƿ�һ������¶�Ĳ�������
        do k=1,lm
            x(p4+k)=0
        end do
        ! ��������ͬ���ȵ����ν��жԻ�
        do k=0,(b+lm-1)
            temp=x(p1+k)
            x(p1+k)=x(p3+k)
            x(p3+k)=temp
        end do
        ! ��������λ�Ĳ��ֲ���������ʣ��ġ�0��ֵ��
        do k=1,(n-p2)
            x(p2-lm+k)=x(p2+k)
        end do
        ! ��������ಿ������
        do k=1,lm
            x(n+k)=0
        end do
    end if

end subroutine

program Prog_11_10

    implicit none
    integer a(1000)
    integer p(4),n,i,flag,check_flag
    write(*,'(1X,"���������а���Ԫ�ظ��� n = ",$)')
    read(*,*) n
    call init_random_seed() ! �ӳ����������������ǰ���ã��������������
    do i=1,n
        call my_rand_array(10,99,a(i)) ! ���ú���my_rand_array����һ����λ�������������
    end do
    write(*,'(1X)')
    write(*,'(1X,"����",I2,"����λ�������������ѳɹ����ɣ�������£�")') n
    do i=1,n
        write(*,100) a(i)
    end do
100 format(I5,$)
    write(*,'(1X)')
    write(*,'(1X)')
    write(*,'(1X,"��������Ҫ�Ի����������ε���������ֵ���Կո��������",$)')
10  continue
    read(*,*) p(1:4)
    flag=check_flag(p,n)
    if (flag==1) then
        write(*,'(1X)')
        write(*,*) "�����P1~P4��������"
        call swap(a,p(1),p(2),p(3),p(4),n)
    else
        write(*,'(1X)')
        write(*,'(1X,"�����P1~P4���������������������루�Կո��������",$)')
        goto 10
    end if
    write(*,'(1X)')
    write(*,*) "����������κ���������£�"
    do i=1,n
        write(*,200) a(i)
    end do
200 format(I5,$)
    write(*,'(1X)')

end
