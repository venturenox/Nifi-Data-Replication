# #import base image for docker container
# FROM apache/nifi
# # Set the working directory to the NiFi installation directory
# # Any subsequent commands like COPY or RUN will use this directory as the current location.
# # /opt/nifi/nifi-current is the path where NiFi is installed within the container.
# WORKDIR /opt/nifi/nifi-current

# # it would copy the flow.xml.gz file from the local ./conf directory to the current working directory in the container (which is /opt/nifi/nifi-current as set by WORKDIR).
# # flow.xml.gz is typically the NiFi flow configuration file that defines the workflows and components in NiFi.
# # ->
# COPY ./conf/flow.xml.gz .

# # This command copies the entire ./conf directory from the local machine to the /opt/nifi/nifi-current/conf directory inside the container.
# COPY --chown=nifi:nifi --chmod=644 ./conf /opt/nifi/nifi-current/conf:

# # --chown=nifi:nifi: This ensures that the copied files and directories are owned by the nifi user and group inside the container.
# # --chmod=644: This sets the file permissions to 644, meaning the owner (nifi) has read and write permissions, and everyone else has only read permissions.
# # COPY --chown=nifi:nifi --chmod=644 ./conf /opt/nifi/nifi-current/


# # COPY ./extensions /opt/nifi/nifi-current/extensions 
# # RUN mkdir -p /usr/local/nifi/jdbc
# # COPY --chown=nifi:nifi --chmod=644 ./jdbc_drivers/ /usr/local/nifi/jdbc



# ------Permissions------

    # Use the base NiFi image
FROM apache/nifi

# Set the working directory to the NiFi installation directory
WORKDIR /opt/nifi/nifi-current

# Copy the flow.xml.gz file to the conf directory with correct ownership and permissions
COPY --chown=nifi:nifi --chmod=644 ./conf/flow.xml.gz /opt/nifi/nifi-current/conf/flow.xml.gz

# Copy the entire conf directory and set correct ownership and permissions
COPY --chown=nifi:nifi ./conf /opt/nifi/nifi-current/conf

# Ensure permissions on the conf directory are properly set
RUN chmod -R 755 /opt/nifi/nifi-current/conf && \
    chown -R nifi:nifi /opt/nifi/nifi-current/conf

# Create a directory for JDBC drivers if needed and set permissions
RUN mkdir -p /usr/local/nifi/jdbc && \
    chown -R nifi:nifi /usr/local/nifi/jdbc && \
    chmod -R 755 /usr/local/nifi/jdbc

# Optionally, copy JDBC drivers to the appropriate location
COPY --chown=nifi:nifi ./jdbc_drivers/ /usr/local/nifi/jdbc/
