#!/usr/local/bin/bash

TAG="arq"
URL="https://www.arqbackup.com/download/arqbackup/arq7_release_notes.html"
NOTIFY="https://api.pushcut.io/xxxx/notifications/arq-release-notes"
$HOME/Code/page-monitor/page-monitor.sh "$TAG" "$URL" "$NOTIFY"
