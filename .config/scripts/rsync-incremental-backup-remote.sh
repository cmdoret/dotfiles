#!/bin/bash

# Configuration variables (change as you wish)
src="${HOME}"
dst="/run/media/cyril/storage/"
remote="desktop"
backupDepth=7
timeout=1800
pathBak0="laptop.0"
partialFolderName=".rsync-partial"
rotationLockFileName=".rsync-rotation-lock"
pathBakN="backup"
nameBakN="backup"
logName="rsync-incremental-backup_$(date +%Y-%m-%d)_$(date +%H-%M-%S).log"
ownFolderName=".rsync-incremental-backup"
logFolderName="log"
powerOff=0

# Combinate previously defined variables for use (don't touch this)
ownFolderPath="${HOME}/${ownFolderName}"
tempLogPath="${ownFolderPath}/${remote}_${dst//[\/]/\\}"
remoteDst="${remote}:${dst}"
bak0="${dst}/${pathBak0}"
remoteBak0="${remoteDst}/${pathBak0}"
partialFolderPath="${dst}/${partialFolderName}"
rotationLockFilePath="${dst}/${rotationLockFileName}"
logPath="${dst}/${pathBakN}/${logFolderName}"
remoteLogPath="${remote}:${logPath}"
logFile="${tempLogPath}/${logName}"

# Prepare log file
mkdir -p ${tempLogPath}
touch ${logFile}

writeToLog() {
	echo -e "$1" | tee -a ${logFile}
}

writeToLog "********************************"
writeToLog "*                              *"
writeToLog "*   rsync-incremental-backup   *"
writeToLog "*                              *"
writeToLog "********************************"

# Prepare backup paths
i=1
while [ $i -le $backupDepth ]
do
	export bak$i="${dst}/${pathBakN}/${nameBakN}.$i"
	true $((i = i + 1))
done

# Prepare main rsync configuration
rsyncFlags="-acChvz --timeout=${timeout} --delete --no-W --partial-dir=${partialFolderName} \
--link-dest=${bak1}/ --log-file=${logFile} --exclude=${ownFolderPath} --exclude='.mozilla/firefox/*/Cache' --exclude='.cache/chromium' --exclude='.thumbnails' --exclude='.local/share/Trash' --chmod=+r"

# Prepare log rsync configuration
logRsyncFlags="-rhvz --remove-source-files --exclude=${logName} --log-file=${logFile}"

writeToLog "\n[$(date +%Y-%m-%dT%H:%M:%S%z)] You are going to backup"
writeToLog "\tfrom:  ${src}"
writeToLog "\tto:    ${remoteBak0}"
writeToLog "\tflags: ${rsyncFlags}"

# Check remote connection if PC was off, it'll be turned on by WoL
ssh -q -o BatchMode=yes -o ConnectTimeout=10 ${remote} exit
if [ "$?" -ne "0" ]
then
    writeToLog "\nWaiting 2 minutes for PC to start.."
    sleep 120
    ssh -q -o BatchMode=yes -o ConnectTimeout=10 ${remote} exit
    if [ "$?" -ne "0" ]
    then
	    writeToLog "\n[$(date +%Y-%m-%dT%H:%M:%S%z)] Remote destination is not reachable"
	    exit 1
    else
        # Remember PC was turned off before backup
        powerOff=1
    fi
fi

# Prepare paths at destination
ssh ${remote} "mkdir -p ${dst} ${logPath}"

writeToLog "\n[$(date +%Y-%m-%dT%H:%M:%S%z)] Old logs sending begins\n"

# Send old pending logs to destination
rsync ${logRsyncFlags} ${tempLogPath}/ ${remoteLogPath}/

writeToLog "\n[$(date +%Y-%m-%dT%H:%M:%S%z)] Old logs sending finished"

# Rotate backups if last rsync succeeded ..
if (ssh ${remote} "[ ! -d ${partialFolderPath} ] && [ ! -e ${rotationLockFilePath} ]")
then
	# .. and there is previous data
	if (ssh ${remote} "[ -d ${bak0} ]")
	then
		writeToLog "\n[$(date +%Y-%m-%dT%H:%M:%S%z)] Backups rotation begins"

		true $((i = i - 1))

		# Remove the oldest backup if exists
		bak="bak$i"
		ssh ${remote} "rm -rf ${!bak}"

		# Rotate the previous backups
		while [ $i -gt 0 ]
		do
			bakNewPath="bak$i"
			true $((i = i - 1))
			bakOldPath="bak$i"
			if (ssh ${remote} "[ -d ${!bakOldPath} ]")
			then
				ssh ${remote} "mv ${!bakOldPath} ${!bakNewPath}"
			fi
		done

		writeToLog "[$(date +%Y-%m-%dT%H:%M:%S%z)] Backups rotation finished\n"
	else
		writeToLog "\n[$(date +%Y-%m-%dT%H:%M:%S%z)] No previous data found, there is no backups to be rotated\n"
	fi
else
	writeToLog "\n[$(date +%Y-%m-%dT%H:%M:%S%z)] Last backup failed, backups will not be rotated\n"
fi

# Set rotation lock file to detect in next run when backup fails
ssh ${remote} "touch ${rotationLockFilePath}"

writeToLog "[$(date +%Y-%m-%dT%H:%M:%S%z)] Backup begins\n"

# Do the backup
rsync ${rsyncFlags} ${src}/ ${remoteBak0}/

# Check rsync success
# Note: Ignoring exit code 24 (files vanished during transfer)
RET="$?"
if [ "$RET" -eq "0" ] || [ "$RET" -eq "24" ]
then
	writeToLog "\n[$(date +%Y-%m-%dT%H:%M:%S%z)] Backup completed successfully\n"

	# Clear unneeded partials and lock file
	ssh ${remote} "rm -rf ${partialFolderPath} ${rotationLockFilePath}"
	rsyncFail=0
else
	writeToLog "\n[$(date +%Y-%m-%dT%H:%M:%S%z)] Backup failed, try again later\n"
	rsyncFail=1
fi

# Send the complete log file to destination
scp ${logFile} ${remoteLogPath}
if [ "$?" -eq "0" ]
then
	rm ${logFile}
fi

if [ $powerOff -eq 1 ]
then
    # Turn PC back off if needed
	ssh -t ${remote} bash -ic "poweroff"
fi

exit ${rsyncFail}
