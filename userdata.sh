#!/bin/bash
LOGDIR=/tmp/ec2_userdata.log
rm $LOGDIR

echo "Start System Admin Userdata ..."  | tee -a $LOGDIR
/bin/timedatectl set-timezone America/Los_Angeles  | tee -a $LOGDIR 2>&1
/bin/hostnamectl set-hostname --static "${host_name}"  | tee -a $LOGDIR 2>&1
/bin/hostname "${host_name}"  | tee -a $LOGDIR 2>&1

echo "Downloading content from s3"  | tee -a $LOGDIR 
mkdir -p /scripts/sysinit/ /scripts/sys/ /scripts/app/data/
rm /scripts/sysinit/* /scripts/sys/* /scripts/app/*
/root/.local/bin/aws s3 sync s3://${s3_sys_bucket}/aws_ec2_create_scripts/sysinit/bin /scripts/sysinit/  | tee -a $LOGDIR 2>&1
/root/.local/bin/aws s3 sync s3://${s3_sys_bucket}/aws_ec2_create_scripts/sysinit/data/ /scripts/sys/data/  | tee -a $LOGDIR 2&1
/root/.local/bin/aws s3 sync s3://${s3_sys_bucket}/ec2_sys_userdata/${host_name}/sys/bin/ /scripts/sys/bin/  | tee -a $LOGDIR 2>&1
/root/.local/bin/aws s3 cp s3://${s3_sys_bucket}/ec2_sys_userdata/${host_name}/sys/data/sudo.lst /scripts/app/data/  | tee -a $LOGDIR 2>&1
/root/.local/bin/aws s3 sync ${s3_app_location}/app/ /scripts/app/  | tee -a $LOGDIR 2>&1
chmod -R 755 /scripts/sysinit/* /scripts/sys/bin/* /scripts/app/bin/*   | tee -a $LOGDIR 2>&1

echo "Calling SysAdmin UserData ..."  | tee -a $LOGDIR
/bin/echo "${my_eip_id}" | tee -a /tmp/eip.txt
/bin/echo "efs /app oracle dba ${app_vol}" | tee -a /tmp/mount_files.txt
/bin/echo "efs /u01 oracle dba ${u01_vol}" | tee -a /tmp/mount_files.txt
/bin/echo "ebs asm1 oracle dba ${asm1_vol}" | tee -a /tmp/mount_files.txt
/bin/echo "ebs /db/lrprd oracle dba ${db_lrprd_vol}" | tee -a /tmp/mount_files.txt
/bin/echo "ebs /backup oracle dba ${backup_vol}" | tee -a /tmp/mount_files.txt
/bin/echo "ebs /u02 oracle dba ${u02_vol}" | tee -a /tmp/mount_files.txt
${rundir}/sysinit/runcmd 2>&1 | tee /tmp/runcmd_${host_name}.log
${rundir}/sys/bin/post_sys.sh | tee /tmp/post_${host_name}.log
sudo -u oracle ${rundir}/app/bin/post_oracle.sh  | tee /tmp/post_app_userdata.log
