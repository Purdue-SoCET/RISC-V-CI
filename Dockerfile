# Used for GitHub Action

FROM ghcr.io/purdue-socet/RISC_V_CI:main

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]