# hostlos.sh

## how to use
bash hostloc.sh username password times

### ex
bash hostloc.sh fdasv fdsdfsa 20

### cron
bash /opt/hostloc/hostloc.sh fdasv fdsdfsa 20 >/dev/null 2>&1 &


# tp
1. Random user from  1 to 10000 
1. 结构做了优化,只要稍作修改就可以适配任何dz站点
   1. 你们自己搞吧
1. 脚本里留了接口 默认输出到shell，可以自己改一下输出到tel之类的地方
1. 如果上次生成的cookie没有被删除的话优先使用使用上次生成 的cookie

![ex2tel](https://raw.githubusercontent.com/imazes/hostlos.sh/master/ex2tel.png)
