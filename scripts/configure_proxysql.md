# Configure ProxySQL

UPDATE global_variables SET variable_value='2CZGRJGGHyGjUV5.proxymonitor' WHERE variable_name='mysql-monitor_username';

UPDATE global_variables SET variable_value='monitor' WHERE variable_name='mysql-monitor_password';

INSERT INTO mysql_replication_hostgroups (writer_hostgroup,reader_hostgroup,comment) VALUES (1,2,'hostgroups');

INSERT INTO mysql_servers(hostgroup_id,hostname,port,comment, use_ssl) VALUES (1,'my-database.ccxt2rwryns5.eu-west-1.rds.amazonaws.com',3306,'mariadb',0);

INSERT INTO mysql_servers(hostgroup_id,hostname,port,comment, use_ssl) VALUES (2,'gateway01.us-east-1.prod.aws.tidbcloud.com',4000,'tidb',1 );

SET mysql-have_ssl=true;

SET mysql-ssl_p2s_ca="/var/lib/proxysql/proxysql-ca.pem";

SET mysql-ssl_p2s_cert="/var/lib/proxysql/proxysql-cert.pem";

SET mysql-ssl_p2s_key="/var/lib/proxysql/proxysql-key.pem";

INSERT INTO mysql_users(username,password,default_hostgroup,default_schema) VALUES ('user1','password1',1,'database1');

UPDATE global_variables SET variable_value='0.0.0.0:3306;/var/lib/proxysql/proxysql.sock' WHERE variable_name='mysql-interfaces';

LOAD MYSQL SERVERS TO RUNTIME;
LOAD MYSQL VARIABLES TO RUNTIME;
SAVE MYSQL VARIABLES TO DISK;
LOAD MYSQL USERS TO RUNTIME;
SAVE MYSQL USERS TO DISK;
SAVE MYSQL VARIABLES TO DISK;


