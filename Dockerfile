# Used for GitHub Action

FROM ghcr.io/purdue-socet/risc-v-ci:main

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]