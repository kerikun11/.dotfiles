sshcode() {
  # check argument
  if [ $# -eq 0 ]; then
    echo "usage: $0 host[:path]"
    return -1
  fi
  # find host and dir
  destination="$1"
  host=${destination%%:*} # before ':'
  dir=${destination##*:} # after ':'
  # fix dir if no ':' exist
  [ "$host" = "$dir" ] && dir=""
  # find abs path if $dir does not start with '/'
  [ "${dir:0:1}" != "/" ] && dir="$(ssh $host pwd)/$dir"
  # open with code
  code --folder-uri "vscode-remote://ssh-remote+$host$dir"
}
# setup completion
_sshcode () {
  local expl suf ret=1
  typeset -A opt_args
  if compset -P 1 '[^./][^/]#:'; then
    _remote_files -- ssh ${(kv)~opt_args[(I)-[FP1246]]/-P/-p} && ret=0
  elif compset -P 1 '*@'; then
    suf=( -S '' )
    compset -S ':*' || suf=( -r: -S: )
    _wanted hosts expl 'remote host name' _ssh_hosts $suf && ret=0
  else
    _alternative 'hosts:remote host name:_ssh_hosts -r: -S:'
  fi
  return ret
}
compdef _sshcode sshcode
