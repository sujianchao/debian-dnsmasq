# debian-dnsmasq
在debian上搭建dnsmasq应用的docker镜像

#自定义配置文件
	dnsmasq.conf


#默认开放端口
    EXPOSE 22 53



#root登录密码可查看docker的log输出
	========================================================================
	You can now connect to this Ubuntu container via SSH using:

	    ssh -p 		<port> root@<host>
	and enter the root password 'U0iSGVUCr7W3' when prompted

	Please remember to change the above password as soon as possible!
	========================================================================


In this case, `U0iSGVUCr7W3` is the password allocated to the `root` user.

Done!

#为root设置固定密码
	ENV ROOT_PASS        mypass

#导入授权key登录ssh
	ENV AUTHORIZED_KEYS		`cat ~/.ssh/id_rsa.pub`