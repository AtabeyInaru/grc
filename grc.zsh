#!/usr/bin/env zsh

if [ "$TERM" = dumb ] || (( ! $+commands[grc] ))
then
    return
fi

# Supported commands
cmds=(
  as
  ant
  blkid
  cc
  configure
  cvs
  df
  diff
  dig
  dnf
  docker
  docker-compose
  docker-machine
  du
  env
  fdisk
  findmnt
  free
  g++
  gas
  gcc
  getfacl
  getsebool
  gmake
  id
  ifconfig
  iostat
  ip
  iptables
  iwconfig
  journalctl
  kubectl
  last
  ldap
  lolcat
  ld
  ls
  lsattr
  lsblk
  lsmod
  lsof
  lspci
  make
  mount
  mtr
  mvn
  netstat
  nmap
  ntpdate
  php
  ping
  ping6
  proftpd
  ps
  sar
  semanage
  sensors
  showmount
  sockstat
  ss
  stat
  sysctl
  systemctl
  tcpdump
  traceroute
  traceroute6
  tune2fs
  uptime
  vmstat
  wdiff
  whois
)

function setup_alias() {
  local name="$1"
  local path="$(which "$name")"
  $name() {
    grc --colour=auto $commands[$0] "$@"
  }
  compdef "_${name}" "$name"
}

# Set alias for available commands.
for cmd in $cmds ; do
  if (( $+commands[$cmd] )) ; then
    setup_alias $cmd
  fi
done

# Clean up variables
unset cmds cmd setup_alias
