#!/bin/bash
path='/home/vagrant/workspace/webProjects/github-dev-blog'
#/home/vagrant/workspace/webProjects/github-dev-blog
#/home/vagrant/workspace/webProjects/dev-blog
# path='/Users/zhangrongxiang/WorkSpace/webProjects/dev-blog'
md=$1
real=`realpath  $1`
md5=`md5sum $md`
listDir () {
    if [[ -d $1 ]];then
        cd $1
        for i in `ls`;do
            if [[ -d $i && $i != "lib" ]];then
                listDir $i               
            fi
        done
        if [[ -f $md ]];then
            thisMd5=`md5sum $md`
            if [[ $md5 != $thisMd5 ]];then
                cp $real -f .
                # rm -f $md
            fi
        else
            cp $real -f .
            # date > /dev/null
        fi
        cd ..
    fi
}
listDir $path
