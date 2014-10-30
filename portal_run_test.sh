#!/usr/bin/env bash

################################################################################
# 
################################################################################

PYTHON_PATH=/usr/local/python2.7
VIRTUALENV_NAME=zlenv999

################################################################################
# 
################################################################################

SUPERVISOR_CONF=supervisord.conf
REQUIREFILE_NAME=requirements.new.txt
ENDLESS_FILE=endless.py
PERSISTENT_FILE=persistent.py

which python

#PORTAL_PATH=/ktsg/ktsg_portal/
#UWSGI_BIN=uwsgi
#cd ${PORTAL_PATH} && ${UWSGI_BIN} --ini ${UWSGI_INI} -H $DEPLOY_VIRTUALENV_PATH$VIRTUALENV_NAME

script_path=$(pwd)
echo $script_path

command_exists(){
    command -v $1 &> /dev/null;
}

function check_virtenv(){
	if (workon $VIRTUALENV_NAME);then
		echo >&2 "virtualenv exists"
	else
		mkvirtualenv $VIRTUALENV_NAME
	fi
	
	workon $VIRTUALENV_NAME
}

function check_wrapper(){
	if [ ! -f $PYTHON_PATH/bin/virtualenvwrapper.sh ]; then
			echo >&2 "virtualenvwrapper not found, gonna install virtualenvwrapper"
            pip install virtualenvwrapper
    fi	
    
    source $PYTHON_PATH/bin/virtualenvwrapper.sh						
}

# function check_path_exist(){
#     if [ ! -d $VIRTUALENV_PATH ]; then
#             mkdir $VIRTUALENV_PATH
#     fi
# }

function check_supervisor(){
    pip install supervisor
	\cp -f $script_path/$SUPERVISOR_CONF /etc					
}

function install_pkg(){
	pip install -r $script_path/$REQUIREFILE_NAME 			
}


function override_pyfile(){
	site_packages=$(cdsitepackages && pwd)
	\cp -f $script_path/$ENDLESS_FILE $site_packages/endless_pagination/templatetags && \cp -f $script_path/$ENDLESS_FILE $site_packages/endless_pagination/templatetags
}

check_wrapper && check_virtenv && install_pkg && override_pyfile && check_supervisor
which python


