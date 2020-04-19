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
Linux 是很多人走进计算机行业的敲门砖，同时也是面试官最喜欢问的知识点。但 Linux 中的命令较多，且单个命令的参数和格式又眼花缭乱，真正掌握还是有很大难度的。  
