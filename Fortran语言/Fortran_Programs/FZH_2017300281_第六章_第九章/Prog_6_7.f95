! A fortran95 program for G95
! By ����ѧԺ ��ƣ�2017300281��
! ϰ��6-7 �ҳ�һƪ�����а������ٸ�����

! ע�������������Ϊ100�У�ÿ�������100���ַ�
!     ÿ�������Ϊ16����ĸ

program Prog_6_7

    implicit none
    character(len=100)::line
    character c
    integer k,i,j,kl,nc,flag,cnt
    write(*,100)
100 format("���������µ����� k = ",$)
    read(*,*) k
    write(*,'(1X)')
    write(*,200) k
200 format("�������������ݣ���",I2," �У�")
    write(*,'(1X)')
    cnt=0
!   ���ѭ��i����������
    Do i=1,k
        read(*,'(a100)') line
        kl=len(line)
!       �ڲ�ѭ��j����ǰ���ַ�λ��
        j=1
        flag=0
        Do while (j<kl)
            c=line(j:j)
            nc=ichar(c)
            ! ����ǰ�ַ�Ϊ��ĸ���򵥴�������1
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
300 format("�������а���������Ϊ ",I2," ��")

end
