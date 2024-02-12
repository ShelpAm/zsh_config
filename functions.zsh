function proxy {
  local proxy_ip='127.0.0.1'
  local proxy_port='7890'

  local proxy_address=${proxy_ip}:${proxy_port}
  local proxy_url=http://${proxy_address}
  export HTTP_PROXY=$proxy_url
  export HTTPS_PROXY=$proxy_url
  export FTP_PROXY=$proxy_url
  git config --global http.proxy $proxy_address
  git config --global https.proxy ${proxy_address}
  # We have no access to the apt configuration file.
  # sudo echo "Acquire::http::Proxy \"${proxy_url}\"" > /etc/apt/apt.conf.d/proxy.conf
}

function unproxy {
  unset HTTP_PROXY
  unset HTTPS_PROXY
  unset FTP_PROXY
  git config --global --unset http.proxy
  git config --global --unset https.proxy
  # sudo echo '' > /etc/apt/apt.conf.d/proxy.conf
}

function reload {
  exec zsh
}

function config {
  nvim $ZDOTDIR/.zshrc && reload
}

function ensure_filedir() {
  [ ! -d $1 ] && mkdir -p "$(dirname $1)"
}
