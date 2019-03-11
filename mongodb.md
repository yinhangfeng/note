```
red hat / centos 安装
https://docs.mongodb.com/manual/tutorial/install-mongodb-on-red-hat/

配置文件
https://docs.mongodb.com/manual/reference/configuration-options/

开启 auth
https://stackoverflow.com/questions/25325142/how-to-set-authorization-in-mongodb-config-file

备份
https://docs.mongodb.com/manual/reference/program/mongodump/
http://www.runoob.com/mongodb/mongodb-mongodump-mongorestore.html

用户管理
https://docs.mongodb.com/manual/tutorial/create-users/

db.createUser({user: "root", pwd: "root", roles: [{role: "root", db: "admin"}]})
db.createUser({user: "test", pwd: "test", roles: [{role: "readWrite", db: "testdb"}]})

db.auth(‘root’, ‘root’)

db.updateUser(“root”, {pwd: “root1”})

db.getUser(“root”)

修改用户
https://docs.mongodb.com/manual/tutorial/manage-users-and-roles/

roles
https://docs.mongodb.com/manual/reference/built-in-roles/

Connection String URI Format
https://docs.mongodb.com/manual/reference/connection-string/
使用 user pass 在admin db 验证 登录db1
mongodb://user:pass@127.0.0.1:27017/db1?authSource=admin
```
