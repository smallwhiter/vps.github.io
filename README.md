# VPS
VPS使用密匙登录

###进入.ssh文件夹,如果没有就新建一个### `mkdir .ssh `
 
` cd .ssh/ `

###创建密匙文件
` ssh-keygen -b 2048 -t rsa `

	-b后面是指定加密后的字符串长度
	-t后面是指定加密算法，常用的加密算法有rsa,dsa等
	默认生成的文件如下：
	id_rsa.pub 公钥文件
	id_rsa 私钥文件
中途需要输入密码，可以不输入

	Enter passphrase
	
再次输入密码
	
	Enter same passphrase again:

###修改公钥的文件名为authorized_keys
`mv id_rsa.pub authorized_keys`

###修改公钥文件权限

` chmod 600 authorized_keys `
` chmod 700 ~/.ssh `

###修改ssh文件

	vim /etc/ssh/sshd_config

###31，32行去掉#

- RSAAuthentication yes
- PubkeyAuthentication yes

52行关闭密码登录
- PasswordAuthentication no

###重启 SSH 服务

	service ssh restart


