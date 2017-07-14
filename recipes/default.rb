#
# Cookbook:: installjensinks
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.
execute 'yum_update' do
  command 'sudo yum -y update'
end

yum_package 'java-1.8.0-openjdk-devel.x86_64' do
  action :install
end

yum_package 'wget' do
  action :install
end

yum_package 'git' do
  action :install
end

execute 'download_jenkins' do
  command 'sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo'
end

execute 'import_jenkins' do
  command 'sudo rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key'
end

execute 'install_jenkins' do
  command 'sudo yum -y install jenkins'
end

execute 'maven' do
command 'sudo mkdir -p /opt/maven
         cd /opt/maven
         sudo wget http://mirrors.advancedhosters.com/apache/maven/maven-3/3.5.0/binaries/apache-maven-3.5.0-bin.tar.gz
         sudo tar xvf apache-maven-3.5.0-bin.tar.gz
         sudo chown -R jenkins:jenkins /opt/maven'
end

execute 'path_profile' do
 command '{
          echo "export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.131-2.b11.el7_3.x86_64"
          echo "export MVN_HOME=/opt/maven/apache-maven-3.5.0/bin"
          echo "export PATH=$PATH:/opt/maven/apache-maven-3.5.0/bin"
          } >> /etc/profile'
end


execute 'path_batchrc' do
 command '{
          echo "export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.131-2.b11.el7_3.x86_64"
          echo "export MVN_HOME=/opt/maven/apache-maven-3.5.0/bin"
          echo "export PATH=$PATH:/opt/maven/apache-maven-3.5.0/bin"
} >> ~/.bashrc'
end

execute 'start_service' do
 command 'sudo systemctl start jenkins.service'
end



execute 'pem' do
  command 'echo "-----BEGIN RSA PRIVATE KEY-----
           MIIEowIBAAKCAQEAhFf+AH7Exgs+vKNPgLbGGg5kVnsfTbX5v3rkovPhLXY9C9xWPRfkPGQs3BvA
           0Kfl1QU18j/s+nMiZCQE5bL7Hufp83jwFs7qmJ+OmNTMJskFLtP0NIik+jE1T2wJIqlP3I8Dw6VZ
           ZCLfOanMPPQZjhjGuuc6khjCXWBfKYWoNqGX8iUOXMVnP7/rwL9eOQKQ3Vzm0iGQcbWj/WJIXyqv
           hPNdbi2QJ07CPtgys4jq3ylwZtX8Ri46ssr14n3BLrxEj1excVSYSDL+9CrdEFr3d0dFDGqoS5lN
           Kfr7pj8x3J1B9Q1FltziMvaRILi2sb1ekkHdjS8tAhBC2FP3sfkbhwIDAQABAoIBAAwIkDDtVekI
           BrlSRB1ZASRHYLo4Ub1YKZBOlVF3yWa/1IcqjrDZZkhTd3zADUUrrwsygRg41cxkAaGHYOad4pWJ
           0szvly0LvWsJPwcIelOgfZcncJICRrX1GXrSQPZk3L0aR+ZXN4ySWye8F7UHIPe5qwA9nCbCl5Gz
           /JMi8wucflDgtwbhmz02e8lb1uSczC7YeqaFnlvc0OTHESaKU4eCKhh/jK43jbOc3irCp0XTme9o
           tyRqjnqzrqhhn79XO9Hg33qPGW4wI8xP3rWvZirSzw6PpBZqsekDdhYsqn2q486r+pl6nI999gR6
           o3p7ZSJ80Xujn0Pfw6WsV0ind1kCgYEAxC9SWINuKE7VZICI+sTovGZgiMcKr60mEnBw245JlYNK
           JBhE1OasgFbgCInixNTrHlrBESSt9Jkn+sElgu+0/xZbZhpgzFXRrLg0baf0jD4ElsFgZPWWXlH/
           u+4M63po69PPwXs3WxKxogniWN+4QoT+HqSetlDiRHQt/YeD9UUCgYEArLG5PTDo1TlF554NvL+Y
           ZkmBZNS7rbXcZFS1tqNzKdKs+n/PgZEhmFXAU2ukxb7aiLww0aZY10BsO/RabbgBVgHpuFqqP8xV
           +vZsnirrWBjIl88c4UFbX8F0Tnh0O7cT1o6KUTkxtJLSYU0yY51mLFa6iDNPgwsYGsTlMe2t/FsC
           gYEAql5yA133vtdfJ00cJ7HybxH1CTLZC+Cw7FhrGa/CJS4Dp77Pn5fG/Bj1q1Sa8tX4bL7hZRLW
           YlDS0EcFXWTvaIqwysVjhG+Oi5DYLtYpX9THxWefX22KrNRG4pwC6ke+b/XcOKjZVKSyUAaHYyi9
           aj72NAQ/tBIfvNSrz7zskoUCgYBcdN4Wu6u8FGivo3f5WJ5wDOSApkBAtT/kW1HaEVIjzw4bIvhm
           htv0odxRDS1vTUnUsOR2KdggjfYkdyM+4Keec3G86JWDiJNzxCDM4W+Uf9hNJm5wzrvr3Te2l1ir
           a83sLe4xpCxPX9fQjjLvECLWlCxTpRzprLPgCRAoFfbzRwKBgGrX+6Hu2dgI64RcRMh5H70ylpl+
           2xNNJVjWWIoJVF7bxebxMaGvKssgiv5Warji0Sdlv2RhGL1Wdb7LvcB5OYfHdi8Os5CHarlo0kwj
           W4kciiKmA4S7arBR+LtqKdcbEqokmLIomM0J7b4nk4WQC0UQ7fNNpWVmI0w/uo2XaGpb
           -----END RSA PRIVATE KEY-----" > /var/lib/jenkins/git.private'
end

execute 'change_permisions' do
 command 'sudo chown jenkins:jenkins /var/lib/jenkins/git.private
          sudo chmod 600 /var/lib/jenkins/git.private'
end

