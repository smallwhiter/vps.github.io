### superbench.sh(vps 独服测试  [脚本来源：](https://www.oldking.net/350.html))

```
wget -qO- –no-check-certificate https://raw.githubusercontent.com/smallwhiter/vps.github.io/master/superbench.sh | bash
```



### SuperSpeed.sh(一键测试服务器到国内的速度 ，[脚本来源:](https://www.oldking.net/305.html))

```
wget –no-check-certificate https://raw.githubusercontent.com/smallwhiter/vps.github.io/master/SuperSpeed.sh 
chmod +x SuperSpeed.sh
bash SuperSpeed.sh
```



### BBR.sh(拥塞算法,[脚本来源：](https://moeclub.org/2017/06/06/249/))

```
wget -N --no-check-certificate https://raw.githubusercontent.com/smallwhiter/vps.github.io/master/BBR.sh && chmod +x BBR.sh && bash BBR.sh -f v4.11.9
```



### BBR_POWERED.sh(拥塞算法,[脚本来源：](https://moeclub.org/2017/06/24/278/))

```
wget -N --no-check-certificate https://raw.githubusercontent.com/smallwhiter/vps.github.io/master/BBR_POWERED.sh && chmod +x BBR_POWERED.sh && bash BBR_POWERED.sh -f v4.11.9
```

### DebianNET.sh（DD Windows，[脚本来源：](https://moeclub.org/2017/11/19/483/)）
需求
- Debian/Ubuntu:  
apt-get install -y gawk sed grep
 
- RedHat/CentOS:  
yum install -y gawk sed grep

-
```
#Windows
wget -N --no-check-certificate https://raw.githubusercontent.com/smallwhiter/vps.github.io/master/DebianNET.sh && chmod +x DebianNET.sh && bash DebianNET.sh -dd '[Windows dd包直连地址]'

#Ubuntu 14.04 x64位
wget -N --no-check-certificate https://raw.githubusercontent.com/smallwhiter/vps.github.io/master/DebianNET.sh && chmod +x DebianNET.sh && bash DebianNET.sh -u trusty -v 64

#Ubuntu 16.04 64位
wget -N --no-check-certificate https://raw.githubusercontent.com/smallwhiter/vps.github.io/master/DebianNET.sh && chmod +x DebianNET.sh && bash DebianNET.sh -u xenial -v 64 -a

#Ubuntu 17.04 x64位
wget -N --no-check-certificate https://raw.githubusercontent.com/smallwhiter/vps.github.io/master/DebianNET.sh && chmod +x DebianNET.sh && bash DebianNET.sh -u zesty -v 64

#Debian 8 x64位
wget -N --no-check-certificate https://raw.githubusercontent.com/smallwhiter/vps.github.io/master/DebianNET.sh && chmod +x DebianNET.sh && bash DebianNET.sh -d jessie -v amd64

#Debian 9 x64位
wget -N --no-check-certificate https://raw.githubusercontent.com/smallwhiter/vps.github.io/master/DebianNET.sh && chmod +x DebianNET.sh && bash DebianNET.sh -d stretch -v amd64
```



### transmission.sh (有修改，脚本来源：[ubuntu transmission一键安装](http://xiaofd.win/ubuntu-transmission-onekey-with-transmission-cli-and-rss.html))
```
wget -N --no-check-certificate https://raw.githubusercontent.com/smallwhiter/vps.github.io/master/transmission.sh && chmod +x transmission.sh && bash transmission.sh -u 用户名 -p 密码 --port 9091
#默认用户名和密码均为Baymin，默认端口为9091
```



