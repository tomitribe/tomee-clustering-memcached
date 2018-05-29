FROM memcached:1.5.8-alpine

# this is required because the memcached image sets the current user to memcached and it does not have root access
USER root

# create a dedicated user and group for the demo
RUN addgroup tomee && adduser -s /bin/bash -D -G tomee tomee

# update packages and install necessary stuff
RUN apk add --update --no-cache curl wget bash openjdk8

#Setting environment variables
ENV TOMEE_VERSION 1.7.5
ENV TOMEE_CLASSIFIER webprofile
ENV TOMEE_TGZ_URL http://repo.maven.apache.org/maven2/org/apache/openejb/apache-tomee/${TOMEE_VERSION}/apache-tomee-${TOMEE_VERSION}-${TOMEE_CLASSIFIER}.tar.gz

ENV CATALINA_BASE /opt/tomee-clustering-memcached
ENV CATALINA_HOME /opt/apache-tomee-${TOMEE_CLASSIFIER}-${TOMEE_VERSION}
ENV PATH /opt:$CATALINA_HOME/bin:$CATALINA_BASE/bin:$PATH

#Setting WORKDIR
RUN mkdir -p ${CATALINA_HOME}
WORKDIR ${CATALINA_HOME}

RUN set -x \
	&& curl -fSL "$TOMEE_TGZ_URL" -o tomee.tar.gz \
	&& tar -zxvf tomee.tar.gz --strip-components=1 \
	&& rm bin/*.bat \
	&& rm tomee.tar.gz* \
	&& rm -rf webapps/ROOT

RUN wget -P lib/ http://repo1.maven.org/maven2/de/javakaffee/msm/memcached-session-manager/2.3.0/memcached-session-manager-2.3.0.jar && \
    wget -P lib/ http://repo1.maven.org/maven2/de/javakaffee/msm/memcached-session-manager-tc7/2.3.0/memcached-session-manager-tc7-2.3.0.jar && \
    wget -P lib/ http://repo1.maven.org/maven2/net/spy/spymemcached/2.12.3/spymemcached-2.12.3.jar

# copy application and configuration
RUN mkdir -p ${CATALINA_BASE} && \
	mkdir -p ${CATALINA_BASE}/bin && \
	mkdir -p ${CATALINA_BASE}/conf && \
	mkdir -p ${CATALINA_BASE}/lib && \
	mkdir -p ${CATALINA_BASE}/webapps && \
	mkdir -p ${CATALINA_BASE}/temp && \
	mkdir -p ${CATALINA_BASE}/work

WORKDIR ${CATALINA_BASE}

# copy app config files
COPY assembly/tomee/ .

# copy the webapps
COPY assembly/webapps/jolokia.war webapps
COPY assembly/tomee-clustering-memcached-1.0-SNAPSHOT.war webapps

COPY ./entrypoint.sh bin/entrypoint.sh
RUN chmod +x bin/entrypoint.sh

# change owner for CATALINA_BASE
RUN chown tomee:tomee -R ${CATALINA_BASE}

# switch the user back to tomee
# USER tomee

#Expose port 8080
EXPOSE 8080

CMD ["entrypoint.sh"]