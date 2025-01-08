FROM apache/nifi:1.28.0
WORKDIR /opt/nifi/nifi-current
# COPY ./conf/flow.xml.gz .
# COPY --chown=nifi:nifi --chmod=644 ./conf /opt/nifi/nifi-current/conf
# COPY ./extensions /opt/nifi/nifi-current/extensions 
# RUN mkdir -p /usr/local/nifi/jdbc
COPY --chown=nifi:nifi --chmod=644 ./jdbc_drivers/ /usr/local/nifi/jdbc 