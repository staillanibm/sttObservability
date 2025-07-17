FROM iwhicr.azurecr.io/webmethods-edge-runtime:11.2.0 

USER 1724

ADD --chown=1724 . /opt/softwareag/IntegrationServer/packages/sttObservability

