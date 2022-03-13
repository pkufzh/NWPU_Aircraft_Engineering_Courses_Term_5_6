! A fortran95 program for G95
! By 航空学院 冯铮浩（2017300281）
! 习题11-10 利用随机函数产生n（书上为20）个二位数整数，进行对两个满足要求区间进行对换操作

subroutine my_rand_array(l,r,s) ! 子程序功能：生成一个[l,r]范围内的随机整数

    implicit none
    integer l,r,length,s
    real :: rd
    length=r-l ! 计算区间长度
    call random_number(rd)
    s=floor(l+(1.0*(length*rd)))

end subroutine

subroutine init_random_seed() ! 子程序功能（参考网上文献）：改变默认随机数种子，避免每次生成随机数均为相同的

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

function check_flag(y,n) ! 函数功能：判断输入的p1~p4是否满足条件①不越界②从小到大顺序

    implicit none
    integer check_flag,i,n
    integer y(4)
    check_flag=1 ! 1代表输入值p1~p4满足两个条件

    if ((y(1)<=1).AND.(y(4)>=n)) then
        check_flag=0 ! 0代表输入值p1~p4不满足两个条件
    else
        do i=1,3
            if (y(i)>=y(i+1)) then
                check_flag=0
            end if
        end do
    end if

end function

subroutine swap(x,p1,p2,p3,p4,n) ! 子程序功能：对x数组中[p1,p2]和[p3,p4]两段之间的数字进行整体调换

    implicit none
    integer a,b,k,temp,lm,s1
    integer x(1000),p1,p2,p3,p4,n

    a=p2-p1+1 ! 计算[p1,p2]区间内的数字个数
    b=p4-p3+1 ! 计算[p3,p4]区间内的数字个数
    s1=min(a,b) ! 计算首次交换的数字个数
    lm=max(a,b)-s1 ! 需要移动格数
    ! 进行第一块区域交换操作
    if (a==s1) then ! 第一段区间内数字个数小于第二段区间内数字个数
        ! 将数组各个数字从下标p2+1开始向右移动lm个位置，以腾出交换空间
        do k=1,(n-p2)
            x(n-k+lm+1)=x(n-k+1)
        end do
        ! 将数组移开一段数后暴露的部分置零
        do k=1,lm
            x(p2+k)=0
        end do
        ! 将两个相同长度的数段进行对换
        do k=0,(a+lm-1)
            temp=x(p1+k)
            x(p1+k)=x(p3+lm+k)
            x(p3+lm+k)=temp
        end do
        ! 将数组移位的部分补充数组中剩余的“0”值项
        do k=1,(n-p4)
            x(p4+k)=x(p4+k+lm)
        end do
        ! 将数组多余部分置零
        do k=1,lm
            x(n+k)=0
        end do
    else
        ! 将数组各个数字从下标p4+1开始至下标n向右移动lm个位置，以腾出交换空间
        do k=1,(n-p4)
            x(n-k+lm+1)=x(n-k+1)
        end do
        ! 将数组移开一段数后暴露的部分置零
        do k=1,lm
            x(p4+k)=0
        end do
        ! 将两个相同长度的数段进行对换
        do k=0,(b+lm-1)
            temp=x(p1+k)
            x(p1+k)=x(p3+k)
            x(p3+k)=temp
        end do
        ! 将数组移位的部分补充数组中剩余的“0”值项
        do k=1,(n-p2)
            x(p2-lm+k)=x(p2+k)
        end do
        ! 将数组多余部分置零
        do k=1,lm
            x(n+k)=0
        end do
    end if

end subroutine

program Prog_11_10

    implicit none
    integer a(1000)
    integer p(4),n,i,flag,check_flag
    write(*,'(1X,"请输入数列包含元素个数 n = ",$)')
    read(*,*) n
    call init_random_seed() ! 子程序函数，生成随机数前调用，设置随机数种子
    do i=1,n
        call my_rand_array(10,99,a(i)) ! 调用函数my_rand_array生成一个二位数整数随机数组
    end do
    write(*,'(1X)')
    write(*,'(1X,"包含",I2,"个二位数整数的数列已成功生成！结果如下：")') n
    do i=1,n
        write(*,100) a(i)
    end do
100 format(I5,$)
    write(*,'(1X)')
    write(*,'(1X)')
    write(*,'(1X,"请输入需要对换的两个数段的左右区间值（以空格隔开）：",$)')
10  continue
    read(*,*) p(1:4)
    flag=check_flag(p,n)
    if (flag==1) then
        write(*,'(1X)')
        write(*,*) "输入的P1~P4符合条件"
        call swap(a,p(1),p(2),p(3),p(4),n)
    else
        write(*,'(1X)')
        write(*,'(1X,"输入的P1~P4不符合条件！请重新输入（以空格隔开）：",$)')
        goto 10
    end if
    write(*,'(1X)')
    write(*,*) "输出交换数段后的数列如下："
    do i=1,n
        write(*,200) a(i)
    end do
200 format(I5,$)
    write(*,'(1X)')

end
