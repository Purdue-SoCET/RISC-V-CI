# Used for GitHub Action

FROM ghcr.io/purdue-socet/risc-v-ci:main

COPY entrypoint.sh /entrypoint.sh

COPY fusesoc.conf /fusesoc.conf

COPY fusesoc_libraries/ /fusesoc_libraries/

ENTRYPOINT ["/entrypoint.sh"]