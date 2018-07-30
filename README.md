# nzbget
NZBGet container

docker run -d --name nzbget -v /mnt/Plex:/mnt/Plex -v /mnt/movies:/mnt/movies -v /mnt/Plex3:/mnt/Plex3 -p 6789:6789 mine/nzbget

Main focus was supporting `docker logs -f ID`

If you want to retain logs and download history your nzbget.conf file should look like:

MainDir=/opt/nzbget
DestDir=/mnt/Plex/NZB/dst
InterDir=/mnt/Plex/NZB/inter
NzbDir=/mnt/Plex/NZB/nzb
QueueDir=/mnt/Plex/NZB/queue
TempDir=/mnt/Plex/NZB/tmp
WebDir=/opt/nzbget/webui
ScriptDir=/opt/nzbget/scripts
LockFile=${MainDir}/nzbget.lock
LogFile=/mnt/Plex/NZB/nzbget.log
ConfigTemplate=/opt/nzbget/nzbget.conf

Where /mnt/Plex is a docker volume mount
