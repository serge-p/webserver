#!/bin/sh -

# Set ENV Variables 
#
######################################################################################


myname="deploy_webserver.sh"
DEFAULT_SLEEP=3
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
__detect_color_support() {
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
 Usage :  ${myname} [type] [options] 

  Installation types:
    - shell
    - salt
    - chief

EOT
} 


# Functions lib
######################################################################################
######################################################################################



do_java_check() {

	which java || return 1  

	## To be continued, assuming, you've got JDK preinstalled 
	## and preset all required java vars

}


do_install_ec2_cli() {

	mkdir /tmp/svp && cd /tmp/svp || return 1
	wget http://s3.amazonaws.com/ec2-downloads/ec2-api-tools.zip
	mkdir /usr/local/ec2 && unzip ec2-api-tools.zip -d /usr/local/ec2 || return 1 
	do_set_java_env 

	## To be continued, assuming, you've got JDK pre-installed to this box
	## and preset all required java vars


}

do_create_ec2_key_pair() { 

	ec2-run-instances --key svp --instance-type t2.micro  ami-0d4cfd66 || echowarn "Unable to create keypair"

}

do_gen_init_script() { 

echoinfo "Generating initialization script"
cat << EOF >> ec2-init.sh
#!/bin/sh
yum -y install wget git 
mkdir -p /srv/salt # && cd /srv && git clone https://${GIT_REPO}.git
wget -O install_salt.sh https://bootstrap.saltstack.com || curl -L https://bootstrap.saltstack.com -o install_salt.sh
sh install_salt.sh
echo "file_client: local" >/etc/salt/minion.d/masterless.conf
echo  

EOF
	
}

do_start_ec2_instance() { 
	
	if [ -f ec2-init.sh ] ; then 
		echoinfo "Starting EC2 instance"
		ec2-run-instances --key svp --instance-type t2.micro --user-data ec2-init.sh ami-0d4cfd66 || return 1 
	else 
		echoerror "Init file is missing" 
		return 1  

	fi
}


######################################################################################
######################################################################################
#
# Main script logic starts here
#
######################################################################################
######################################################################################

__detect_color_support
do_gen_init_script || echoerror "unable to generate init script"
