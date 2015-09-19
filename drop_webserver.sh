#!/bin/sh -
#
#
# Header goes here, version .0.0.1, author: Sergey Paramonov
#
######################################################################################
######################################################################################
#
# Set ENV Variables 
#
######################################################################################


myname="drop_webserver.sh"
DEFAULT_SLEEP=60
GIT_REPO=github.com/serge-p/webserver
DOCUMENT_ROOT=/var/www/svp
WWW_USER=www


#
# export AWS_ACCESS_KEY=XXXXXXXXXXXXXXXXXXXX
# export AWS_SECRET_KEY=XXXXXXXXXXXXXXXXXXXX
#
# do_set_java_env() {
	# export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Versions/CurrentJDK/Home
	# export EC2_HOME=/usr/local/ec2/ec2-api-tools-1.7.5.0
	# export PATH=$PATH:$EC2_HOME/bin
# }


######################################################################################
#
#
# Set colors
#
#

_COLORS=${BS_COLORS:-$(tput colors 2>/dev/null || echo 0)}
detect_color_support() {
    if [ $? -eq 0 ] && [ "$_COLORS" -gt 2 ]; then
        RC="\033[1;31m"
        GC="\033[1;32m"
        BC="\033[1;34m"
        YC="\033[1;33m"
        EC="\033[0m"
    else
        RC=""
        GC=""
        BC=""
        YC=""
        EC=""
    fi
}


echoerror() {
    printf "${RC} * ERROR${EC}: %s\n" "$@" 1>&2;
}

echoinfo() {
    printf "${GC} *  INFO${EC}: %s\n" "$@";
}

echowarn() {
    printf "${YC} *  WARN${EC}: %s\n" "$@";
}

######################################################################################

usage() {
    cat << EOT
 Usage :  ${myname} instance-ID 

  Example instance-ID:	i-e696e145
EOT
} 

if [ "$#" -ne 1 ]; then
    usage
    exit 1
fi

export ID=$1

# Functions lib
######################################################################################
######################################################################################

do_update_ec2_sec_group() { 

    ec2-revoke default -p -1 || echowarn "Unable to delete rule in default security group" 
    
}

do_drop_ec2_instance() { 

	echoinfo "Terminating EC2 instance"
	ec2-terminate-instances ${ID} || return 1 
	echoinfo "Allow some time for VM to terminate"
	ec2-describe-instances ${ID}
}

######################################################################################
######################################################################################
#
# Main script logic starts here
#
######################################################################################
######################################################################################

detect_color_support
# do_set_java_env
do_update_ec2_sec_group
do_drop_ec2_instance