export JAVA_HOME=$(/usr/libexec/java_home)
export ANDROID_HOME=~/Library/Android/sdk
export NDK_HOME=$ANDROID_HOME/ndk-bundle
export ANDROID_SDK=$ANDROID_HOME
# react-native http://facebook.github.io/react-native/docs/building-from-source
export ANDROID_NDK=$ANDROID_HOME/android-ndk-r17b
export GRADLE_OPTS="-Dorg.gradle.daemon=true"
export MY_TOOLS_HOME=~/tools

export PATH=/usr/local/sbin:/usr/local/opt/ruby/bin:~/bin:$ANDROID_HOME/platform-tools:$ANDROID_HOME/tools/bin:$NDK_HOME:$MY_TOOLS_HOME:$MY_TOOLS_HOME/depot_tools:$MY_TOOLS_HOME/apktool:$MY_TOOLS_HOME/dex2jar:$MY_TOOLS_HOME/flutter/bin:$PATH
# https://www.rust-lang.org/tools/install
export PATH="$HOME/.cargo/bin:$PATH"

# php
# export PATH=/usr/local/opt/php@5.6/bin:/usr/local/opt/php@5.6/sbin:$PATH
# export PHP_HOME=$(brew --prefix php@5.6)
# https://superuser.com/questions/433746/is-there-a-fix-for-the-too-many-open-files-in-system-error-on-os-x-10-7-1
# ulimit -S -n 2048

export ELECTRON_MIRROR=https://npm.taobao.org/mirrors/electron/
# export NDK_MODULE_PATH=/Users/yinhf/work/source/react-native/ReactAndroid/src/main/jni:/Users/yinhf/work/source/react-native/ReactAndroid/src/main/jni/first-party:/Users/yinhf/work/source/react-native/ReactAndroid/src/main/jni/third-party:/Users/yinhf/work/source/react-native/ReactCommon

# https://flutter.io/community/china
export PUB_HOSTED_URL=https://pub.flutter-io.cn
export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn

# alias for cnpm
alias cnpm="npm --registry=https://registry.npm.taobao.org \
  --disturl=https://npm.taobao.org/dist"

alias npm-registry-taobao="npm config set registry https://registry.npm.taobao.org"
alias npm-registry-default="npm config delete registry"

# alias cnpm="npm --registry=https://registry.npm.taobao.org \
#   --disturl=https://npm.taobao.org/dist \
#   --cache=$HOME/.npm/.cache/cnpm \
#   --userconfig=$HOME/.cnpmrc"

# react native adb
alias adbrn="adb reverse tcp:8081 tcp:8081"

alias android-studio="open -a /Applications/Android\ Studio.app"

alias pod-update-repo="cd ~/.cocoapods/repos/master && git pull"

alias ios-open-simulator="open /Applications/Xcode.app/Contents/Developer/Applications/Simulator.app"

# cd android support dir
alias cd-android-supoort="cd $ANDROID_HOME/extras/android/m2repository/com/android/support"

# XX-Net
# alias xxnet-start="~/tools/XX-Net/start"

#
# proxy
#
alias proxy-enable="export http_proxy=socks5://127.0.0.1:1080 && export https_proxy=socks5://127.0.0.1:1080"
alias proxy-enable-git="git config --global http.proxy 'socks5://127.0.0.1:1080' && git config --global https.proxy 'socks5://127.0.0.1:1080'"
alias proxy-disable="unset http_proxy && unset https_proxy"
alias proxy-disable-git="git config --global http.proxy '' && git config --global https.proxy ''"

# socks5
alias proxy-socks-enable="proxy-enable"
alias proxy-socks-enable-git="proxy-disable-git"

# http
alias proxy-http-enable="export http_proxy=http://127.0.0.1:1081 && export https_proxy=http://127.0.0.1:1081"
alias proxy-http-enable-git="git config --global http.proxy 'http://127.0.0.1:1081' && git config --global https.proxy 'http://127.0.0.1:1081'"

# nvm
export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# 不检查 $NVM_DIR/nvm.sh 以节省时间
. "$NVM_DIR/nvm.sh"

# xcode nvm 注释掉了 为什么这个 alias 这么耗时
# alias xcode-nvm-sync="sudo ln -sf `nvm which node` /Applications/Xcode.app/Contents/Developer/usr/bin/node"

# https://github.com/pyenv/pyenv
# 不检查 pyenv 是否存在 以节省时间
# if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
# fi

# https://github.com/pyenv/pyenv-virtualenv
# eval "$(pyenv virtualenv-init -)"
