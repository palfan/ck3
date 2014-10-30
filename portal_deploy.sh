#!/usr/bin/env bash

################################################################################
# need config
################################################################################

DEPLOY_PATH=/home/zhuleis/deploy5  #where to checkout svn portal_deploy
PYTHON_PATH=/usr/local/python  #real python path, not links
VIRTUALENV_NAME=portalenv5		 


SVN_PATH=https://192.168.1.254/svn/kryptanium_sg/server/src/ktsg_portal/env/portal_deploy
USER_NAME=maguoguang
PASSWORD=1qaz2wsx!  

################################################################################
# 
################################################################################
DEPLOY_DIR=portal_deploy
DEPLOY_SCRIPT=portal_env_setup.sh


 function prepare_deploy_path(){
     if [ ! -d $DEPLOY_PATH ]; then
             mkdir $DEPLOY_PATH
     fi
     
     cd $DEPLOY_PATH
     rm -rf ./$DEPLOY_DIR
 }

prepare_deploy_path && svn export $SVN_PATH --force --username=${USER_NAME} --password=${PASSWORD} && cd $DEPLOY_DIR 
chmod 755 $DEPLOY_SCRIPT  && source $DEPLOY_SCRIPT


