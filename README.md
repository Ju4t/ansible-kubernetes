# Ansible-Playbook

## ansible 环境
```bash
yum install -y python3 unzip expect
pip3 install -U pip setuptools -i https://mirrors.aliyun.com/pypi/simple/
pip3 install -r ansible -i https://pypi.tuna.tsinghua.edu.cn/simple
```

## 机器环境

### CentOS 系统
要求：NODE > 2C 2G
```bash
# CentOS 7.9 最小化安装
https://mirrors.aliyun.com/centos/7.9.2009/isos/x86_64/CentOS-7-x86_64-Minimal-2009.iso
```

### 虚拟机环境参考设置
```bash
# 修改IP
export ethfile=/etc/sysconfig/network-scripts/ifcfg-eth0

sed -i 's/^IPADDR="192.168.8.10"/IPADDR="192.168.8.61"/g' /etc/sysconfig/network-scripts/ifcfg-eth0 && reboot
sed -i 's/^IPADDR="192.168.8.10"/IPADDR="192.168.8.62"/g' /etc/sysconfig/network-scripts/ifcfg-eth0 && reboot
sed -i 's/^IPADDR="192.168.8.10"/IPADDR="192.168.8.63"/g' /etc/sysconfig/network-scripts/ifcfg-eth0 && reboot

sed -i 's/^IPADDR="192.168.8.10"/IPADDR="192.168.8.71"/g' /etc/sysconfig/network-scripts/ifcfg-eth0 && reboot
sed -i 's/^IPADDR="192.168.8.10"/IPADDR="192.168.8.72"/g' /etc/sysconfig/network-scripts/ifcfg-eth0 && reboot
sed -i 's/^IPADDR="192.168.8.10"/IPADDR="192.168.8.73"/g' /etc/sysconfig/network-scripts/ifcfg-eth0 && reboot

# 重启网络服务
service network restart
```

### SSH免登陆
```bash
# 生成 rsa
ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa

chmod -R 777 ssh-copy.sh

# 修改 ssh-copy.sh 中的密码，执行
./ssh-copy.sh
```
### 设置 inventory
```bash
# 参考 inventory.ini 文件
```

### 运行任务
```bash
ansible-playbook -i inventory 1[tab].yml
# 选装
ansible-playbook -i inventory 2[tab].yml

ansible-playbook -i inventory 3[tab].yml

# 修改密钥，查看 master01 节点的 kubeadm-init.log
ansible-playbook -i inventory 4[tab].yml
ansible-playbook -i inventory 5[tab].yml

# 部署 flannel
ansible-playbook -i inventory 6[tab].yml
```

## ansible-playbook 安装 k8s 时可以继续完善的地方
- ha-proxy（本例中，用Master/Backup，若有SLB也就不需要了，生产环境：建议负载均衡到多个master中）
- etcd (本例中堆叠，可以玩玩 独立etcd)

> keepalived 对k8s的健康检查 参考 https://github.com/kubernetes/kubeadm/blob/main/docs/ha-considerations.md
> k8s 多 master 需要超过半数master节点存活
> 高可用方案：*堆叠 和 独立etcd


## Test
```shell
kubectl create deployment nginx --image=nginx
kubectl expose deployment nginx --port=80 --type=NodePort
kubectl get pod,svc
```