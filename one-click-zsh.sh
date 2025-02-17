#!/bin/bash

zsh --version
status=$?

if [ $status -ne 0 ]; then
    echo "-- zsh 未安装，即将执行安装 --"

    # TODO: 其它平台安装方式
    sudo apt-get update && sudo apt-get install -y zsh
fi

chsh -s $(which zsh)

if [ "$(basename "$SHELL")" = "zsh" ]; then
    echo "1. zsh 正确安装且已设置为默认 shell."
fi

echo "2. 正在安装 oh-my-zsh 和插件..."

RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

export ZSH_CUSTOM=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}
git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"

NEW_THEME="ys"
NEW_PLUGINS=("git" "jsontools" "z" "vi-mode" "zsh-syntax-highlighting" "zsh-autosuggestions")
NEW_PLUGINS_STR="plugins=( ${NEW_PLUGINS[@]} )"

sed -i "s/^ZSH_THEME=.*/ZSH_THEME=\"$NEW_THEME\"/" $HOME/.zshrc
sed -i "/^plugins=/c\\${NEW_PLUGINS_STR}" $HOME/.zshrc

echo "3. ~/.zshrc 已更新"

zsh -c "source $HOME/.zshrc"

echo "4. om-my-zsh 和插件安装并配置成功！"
