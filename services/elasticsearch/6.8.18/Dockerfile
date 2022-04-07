# for x86
FROM elasticsearch:6.8.18
# for arm
#FROM webhippie/elasticsearch:6.4

# install plugins here
RUN /usr/share/elasticsearch/bin/elasticsearch-plugin install analysis-phonetic && \
    /usr/share/elasticsearch/bin/elasticsearch-plugin install analysis-icu;
