#!/bin/sh

umask 002

LANG=ja_JP.UTF-8
GCLOG=~tomcat/logs/gc.log

# PermSizeはHEAPに含まれない
# XX:SurvivorRatio=Eden/Survivor(From or To)
# XX:MaxTenuringThreshold=OLDに移動するまでのマイナーGCの回数
# Tenured > Tenuredに残るサイズ+ Newサイズ

CATALINA_OPTS="-server -Xss256k \
-Xmx768M -Xms768M \
-XX:MaxPermSize=384m -XX:PermSize=384m \
-XX:NewSize=256m -XX:MaxNewSize=256m \
-XX:SurvivorRatio=2 -XX:MaxTenuringThreshold=31 \
-XX:+UseConcMarkSweepGC"

CATALINA_OPTS="${CATALINA_OPTS} -Djava.awt.headless=true"

CATALINA_OPTS="${CATALINA_OPTS} -Dcom.sun.management.jmxremote.port=10000 \
-Dcom.sun.management.jmxremote=true \
-Dcom.sun.management.jmxremote.ssl=false \
-Dcom.sun.management.jmxremote.authenticate=false"

#CATALINA_OPTS="${CATALINA_OPTS} -Xloggc:${GCLOG} -verbose:gc \
#-XX:+PrintGCTimeStamps -XX:+PrintClassHistogram"

CATALINA_OPTS="${CATALINA_OPTS} -Xloggc:${GCLOG} -verbose:gc \
-XX:+UseGCLogFileRotation -XX:NumberOfGCLogFiles=10 -XX:GCLogFileSize=10M \
-XX:+PrintGCDetails -XX:+PrintGCTimeStamps -XX:+PrintGCDetails"

export LANG
export CATALINA_OPTS
