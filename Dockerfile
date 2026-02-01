# Used for GitHub Action

FROM ghcr.io/purdue-socet/risc-v-ci:main

COPY entrypoint.sh /entrypoint.sh

COPY fusesoc.conf /fusesoc.conf

# RUN mkdir -p /fusesoc_libraries

# COPY fusesoc_libraries/. /fusesoc_libraries/.

ENTRYPOINT ["/entrypoint.sh"]