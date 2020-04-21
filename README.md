工作闲暇之余光顾下,可能更新进度较慢,但是只要是更新的都是经验之谈哦,相互学习,共同成长,技术不分先后,只分深浅!  
tips：
  1.github分行每行最后需要多出两个空格，好玩！！！  
  2.本库的目的是和大家一起学习，如文档存在错误，请指正，大家一起交流学习，共同成长。

前言概览  
shell 脚本仓库，主要用于加强shell脚本开发规范和学习提高shell编写效率  
后续将会持续性的进行更新，敬请期待。  

脚本开发需要具备：  
  1.开发语言的逻辑思维  
  2.目前脚本使用场景是在linux服务器上进行自动化运行，所以需要熟悉常用的linux指令  
  3.要有规范的开发脚本的习惯，例如：在脚本里附上：版本，作者，开发时间，优化记录，功能描述，使用示范  
  4.多多的学习他人脚本开发的好习惯，是十分有助于提高自己脚本开发能力  
#-----------------------------------------------------------------------------------------------#  
linux常用命令  
1.file  
使用file命令可以知道某个文件究竟是二进制（ELF格式）的可执行文件, 还是Shell Script文件，或者是其它的什么格式。file能识别的文件类型有目录、Shell脚本、英文文本、二进制可执行文件、C语言源文件、文本文件、DOS的可执行文件。  
eg：  
[root@localhost ~]# file test_local.sh   
test_local.sh: Bourne-Again shell script, ASCII text executable  

2.mkdir 
mkdir命令的作用是建立名称为dirname的子目录，与MS DOS下的md命令类似，它的使用权限是所有用户。   
格式   
mkdir [options] 目录名 
  [options]主要参数   
    －m, －－mode=模式：设定权限<模式>;，与chmod类似。  
    －p, －－parents：需要时创建上层目录；如果目录早已存在，则不当作错误。   
    －v, －－verbose：每次创建新目录都显示信息。   
    －－version：显示版本信息后离开。  
eg：
在进行目录创建时可以设置目录的权限，此时使用的参数是“－m”。假设要创建的目录名是“test”，让所有用户都有rwx(即读、写、执行的权限)，那么可以使用以下命令：  
$ mkdir －m 777 test  
$ mkdir test
$ mkdir －p /opt/joke/test  #批量创建目录  
[root@localhost ~]# mkdir -p /opt/joke/test    
[root@localhost ~]# ll /opt/joke/test/  
total 0  
[root@localhost ~]# ll /opt/joke  
total 0  
drwxr-xr-x 2 root root 6 Apr 19 02:19 test  

运维使用命令list  
1. find 命令  
1.1 find -regex 与 find -name 的区别  
1.2 Linux 命令中的“permission denied问题  
1.3 find 命令忽略大小写  
1.4 和文件访问、修改以及对应时间相关的 find 命令  
1.5 -mindepth 和 -maxdepth 的使用  
1.6 find 其他命令  
2. grep 命令  
3. diff 命令   
4. mount 命令   
5. ps 命令   
6. free 命令   
7. ifconfig（interface configs）  
8. telnet 命令   
9. scp（secure copy）命令   
10. zip 和 unzip 命令  
11. gzip 命令   
12. ll 命令   
13. netstat 命令   
14. kill 命令   
15. set 命令   
16. su 命令  
17.top 命令   
18.ulimit命令  
用于控制shell程序的资源。   
ulimit为shell内建指令，可用来控制shell执行程序的资源。   

Linux 是很多人走进计算机行业的敲门砖，同时也是面试官最喜欢问的知识点。但 Linux 中的命令较多，且单个命令的参数和格式又眼花缭乱，真正掌握还是有很大难度的。   
掌握的知识点   
1.cache buffer swap 区别   
swap 即虚拟内存，把磁盘的部分空间当作虚拟内存来使用   
  /proc/sys/vm/swappiness，该值越大，内核会越积极使用交换空间。   
  当swappiness=0时，表示最大限度使用物理内存；  
  当swappiness=100时，表示积极的使用swap分区。   
  /proc/sys/vm/swappiness动态生效的，永久修改，需修改/etc/sysctel.conf文件。   
buffer是即将被写入磁盘的   
    当应用在内存中修改过数据后，因写入磁盘速度低，在有空闲内存的情况下，这些数据会存入buffer，在以后某个时间再写入磁盘，从而应用可以继续后面的操作，而不必等待这些数据写入磁盘的操作完成
cache是被从磁盘中读出来的  
    cache是位于CPU和主存之间的一种容量很小但速度高于主存的存储器。从磁盘读取到内存的数据在被应用读取后，如果有剩余内存，则这部分数据会存入cache，以备第2次读取时，避免重新读磁盘。   
    
    如果在某个时刻，系统需要更多的内存，则会把cache部分擦除，并把buffer中的内容写入磁盘，从而把这两部分内存释放。  

综上，空闲物理内存不多，不一定表示系统运行状态很差，因为内存的cache及buffer部分可以随时被重用，这两部分内存也可以看作是额外的空闲内存。   

只有当swap被频繁调用，长时间不为0，才是内存资源是否紧张的依据。   

free -m

              total      used    free  shared  buffers  cached

Mem:          310G        47G    263G      0      5G      6G

-/+ buffers/cache:        36G    274G 

swap:          105G        0      105G

1、total: 物理内存实际总量 310G
2、used：总计分配给缓存（buffer与cache）使用的数量，包含未被使用的缓存。47=36+5+6（5和6未被使用）
3、free：未被分配的内存
4、shared：共享内存
5、buffers：系统分配的，未被使用的buffer剩余量。
6、cached：系统分配的，未被使用的cache剩余量。
7、buffers/cache used：buffers和cache的使用量，也即实际的内存使用量。
8、buffers/cache free:未被使用的buffers与cache和未被分配的内存之和。274=263+5+6。当前系统实际的可用内存。


