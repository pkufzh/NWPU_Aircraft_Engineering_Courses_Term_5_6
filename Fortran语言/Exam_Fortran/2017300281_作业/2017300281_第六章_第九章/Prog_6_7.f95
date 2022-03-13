! A fortran95 program for G95
! By 航空学院 冯铮浩（2017300281）
! 习题6-7 找出一篇文章中包含多少个单词

! 注：处理文章最多为100行，每行最多有100个字符
!     每个单词最长为16个字母

program Prog_6_7

    implicit none
    character(len=100)::line
    character c
    integer k,i,j,kl,nc,flag,cnt
    write(*,100)
100 format("请输入文章的行数 k = ",$)
    read(*,*) k
    write(*,'(1X)')
    write(*,200) k
200 format("请输入文章内容，共",I2," 行：")
    write(*,'(1X)')
    cnt=0
!   外层循环i：文章行数
    Do i=1,k
        read(*,'(a100)') line
        kl=len(line)
!       内层循环j：当前行字符位置
        j=1
        flag=0
        Do while (j<kl)
            c=line(j:j)
            nc=ichar(c)
            ! 若当前字符为字母，则单词数量加1
            if ((flag==0).AND.(((nc>=ichar('A')).AND.(nc<=ichar('Z'))) &
               .OR.((nc>=ichar('a')).AND.(nc<=ichar('z'))))) then
                cnt=cnt+1
                flag=1
            end if
            j=j+1
            Do while (flag==1)
                j=j+1
                c=line(j:j)
                nc=ichar(c)
                if ((nc>=ichar(' ')).AND.(nc<=ichar('/'))) then
                    flag=0
                end if
            End Do
        End Do
    END Do
    write(*,'(1X)')
    write(*,300) cnt
300 format("该文章中包含单词数为 ",I2," 个")

end
