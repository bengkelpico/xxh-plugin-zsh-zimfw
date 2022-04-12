#!/usr/bin/env bash

CDIR="$(cd "$(dirname "$0")" && pwd)"
build_dir=$CDIR/build

while getopts A:K:q option
do
  case "${option}"
  in
    q) QUIET=1;;
    A) ARCH=${OPTARG};;
    K) KERNEL=${OPTARG};;
  esac
done

rm -rf $build_dir
mkdir -p $build_dir

for f in pluginrc.zsh
do
    cp $CDIR/$f $build_dir/
done

for f in zimrc
do
    cp $CDIR/$f $build_dir/.zimrc
done

cd $build_dir

[ $QUIET ] && arg_q='-q' || arg_q=''
[ $QUIET ] && arg_s='-s' || arg_s=''
[ $QUIET ] && arg_progress='' || arg_progress='--show-progress'

zimfw_home=$build_dir/zimfw

if [[ ! -e ${zimfw_home}/zimfw.zsh ]]; then
  curl -fsSL --create-dirs -o ${zimfw_home}/zimfw.zsh \
      https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
fi
