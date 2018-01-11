#!/bin/bash
 
[ "$EUID" -ne '0' ] && echo "Error,This script must be run as root! " && exit 1
[ $# -gt '1' ] && [ "$1" == '-f' ] && tmpKernelVer="$2" || tmpKernelVer='';
[ -z "$(dpkg -l |grep 'grub-')" ] && echo "Not found grub." && exit 1
which make >/dev/null 2>&1
[ $? -ne '0' ] && {
echo "Install make..."
DEBIAN_FRONTEND=noninteractive apt-get install -y -qq make >/dev/null 2>&1
which make >/dev/null 2>&1
[ $? -ne '0' ] && {
echo "Error! Install make. "
exit 1
}
}
which awk >/dev/null 2>&1
[ $? -ne '0' ] && {
echo "Install awk..."
DEBIAN_FRONTEND=noninteractive apt-get install -y -qq gawk >/dev/null 2>&1
which awk >/dev/null 2>&1
[ $? -ne '0' ] && {
echo "Error! Install awk. "
exit 1
}
}
which gcc >/dev/null 2>&1
[ $? -ne '0' ] && {
echo "Install gcc..."
DEBIAN_FRONTEND=noninteractive apt-get install -y -qq gcc >/dev/null 2>&1
which gcc >/dev/null 2>&1
[ $? -ne '0' ] && {
echo "Error! Install gcc. "
echo "Please 'apt-get update' and try again! "
exit 1
}
}
GCCVER="$(readlink `which gcc` |grep -o '[0-9].*')"
GCCVER1="$(echo $GCCVER |awk -F. '{print $1}')"
GCCVER2="$(echo $GCCVER |awk -F. '{print $2}')"
[ -n "$GCCVER1" ] && [ "$GCCVER1" -gt '4' ] && CheckGCC='0' || CheckGCC='1'
[ "$CheckGCC" == '1' ] && [ -n "$GCCVER2" ] && [ "$GCCVER2" -ge '9' ] && CheckGCC='0'
[ "$CheckGCC" == '1' ] && {
echo "The gcc version require gcc-4.9 or higher. "
echo "You can try apt-get install -y gcc-4.9 or apt-get install -y gcc-6"
echo "Please upgrade it manually! "
exit 1
}
KernelVer='';
KernelBitVer='';
MainURL='http://kernel.ubuntu.com/~kernel-ppa/mainline'
[ -n "$tmpKernelVer" ] && {
wget -qO /dev/null "$MainURL/$tmpKernelVer"
[ $? -ne '0' ] && echo 'Please input a vaild kernel version! exp: v4.11.9.' && exit 1
KernelVer="$tmpKernelVer"
}
[ -z "$tmpKernelVer" ] && {
KernelVerBIG="$(wget -qO- "$MainURL" |awk -F '/">|href="' '{print $2}' |sed '/rc/d;/^$/d' |tail -n1)"
[ -n "$KernelVerBIG" ] && KernelVer="$(wget -qO- "$MainURL" |awk -F '/">|href="' '{print $2}' |sed '/rc/d;/^$/d' |grep ''${KernelVerBIG}'' |sort -n |tail -n1)"
}
[ -z "$KernelVer" ] && echo 'Error,Get Kernel fail! ' && exit 1
ReleaseURL="$(echo -n "$MainURL/$KernelVer")"
KernelBit="$(getconf LONG_BIT)"
[ "$KernelBit" == '32' ] && KernelBitVer='i386'
[ "$KernelBit" == '64' ] && KernelBitVer='amd64'
[ -z "$KernelBitVer" ] && echo "Error! " && exit 1
HeadersFile="$(wget -qO- "$ReleaseURL" |awk -F '">|href="' '/generic.*.deb/{print $2}' |grep 'headers' |grep "$KernelBitVer" |head -n1)"
[ -n "$HeadersFile" ] && HeadersAll="$(echo "$HeadersFile" |sed 's/-generic//g;s/_'${KernelBitVer}'.deb/_all.deb/g')"
[ -z "$HeadersAll" ] && echo "Error! Get Linux Headers for All." && exit 1
echo "$HeadersFile" | grep -q "$(uname -r)"
[ $? -ne '0' ] && echo "Error! Header not be matched by Linux Kernel." && exit 1
echo -ne "Download Kernel Headers for All\n\t$HeadersAll\n"
wget -qO "$HeadersAll" "$ReleaseURL/$HeadersAll"
echo -ne "Install Kernel Headers for All\n\t$HeadersAll\n"
dpkg -i "$HeadersAll" >/dev/null 2>&1
echo -ne "Download Kernel Headers\n\t$HeadersFile\n"
wget -qO "$HeadersFile" "$ReleaseURL/$HeadersFile"
echo -ne "Install Kernel Headers\n\t$HeadersFile\n"
dpkg -i "$HeadersFile" >/dev/null 2>&1
echo -ne "Download BBR POWERED Source code\n"
[ -e ./tmp ] && rm -rf ./tmp
mkdir -p ./tmp && cd ./tmp
[ $? -eq '0' ] && {
wget --no-check-certificate -qO- 'https://moeclub.org/attachment/LinuxSoftware/bbr/tcp_bbr_powered.c.deb' >./tcp_bbr_powered.c
echo 'obj-m:=tcp_bbr_powered.o' >./Makefile
make -s -C /lib/modules/$(uname -r)/build M=`pwd` modules CC=`which gcc`
echo "Loading TCP BBR POWERED..."
[ -f ./tcp_bbr_powered.ko ] && [ -f /lib/modules/$(uname -r)/modules.dep ] && {
cp -rf ./tcp_bbr_powered.ko /lib/modules/$(uname -r)/kernel/net/ipv4
depmod -a >/dev/null 2>&1
}
modprobe tcp_bbr_powered
[ ! -f /etc/sysctl.conf ] && touch /etc/sysctl.conf
sed -i '/net.core.default_qdisc.*/d' /etc/sysctl.conf
sed -i '/net.ipv4.tcp_congestion_control.*/d' /etc/sysctl.conf
echo "net.core.default_qdisc = fq" >>/etc/sysctl.conf
echo "net.ipv4.tcp_congestion_control = bbr_powered" >>/etc/sysctl.conf
}
lsmod |grep -q 'bbr_powered'
[ $? -eq '0' ] && {
sysctl -p >/dev/null 2>&1
echo "Finish! "
exit 0
} || {
echo "Error, Loading BBR POWERED."
exit 1
}
