#!/bin/bash

echo 'Starting TomEE ...'

# todo configure properly with ENV variables so when we have more than one server we can reuse the same image
if [[ -n "${ENV_STICKY}" ]];
then
	export CATALINA_OPTS="${CATALINA_OPTS} -Dsticky=${ENV_STICKY}"
else
	export CATALINA_OPTS="${CATALINA_OPTS} -Dsticky=true"
fi

if [[ -n "${ENV_MEMCACHED_NODES}" ]];
then
	export CATALINA_OPTS="${CATALINA_OPTS} -DmemcachedNodes=${ENV_MEMCACHED_NODES}"
else
	export CATALINA_OPTS="${CATALINA_OPTS} -DmemcachedNodes=n1:localhost:11211"
fi

if [[ -n "${ENV_FAILOVER_NODES}" ]];
then
	export CATALINA_OPTS="${CATALINA_OPTS} -DfailoverNodes=${ENV_FAILOVER_NODES}"
else
	export CATALINA_OPTS="${CATALINA_OPTS} -DfailoverNodes= "
fi

if [[ -n "${ENV_JVM_ROUTE}" ]];
then
	export CATALINA_OPTS="${CATALINA_OPTS} -DjvmRoute=${ENV_JVM_ROUTE}"
else
	export CATALINA_OPTS="${CATALINA_OPTS} -DjvmRoute= "
fi

CATALINA_OPTS="${CATALINA_OPTS} -DmemcachedSessionManager=de.javakaffee.web.msm.MemcachedBackupSessionManager"


# starts memcached just before
/bin/su -c "memcached &" - memcache

${CATALINA_HOME}/bin/catalina.sh run