# Used for GitHub Action

FROM ghcr.io/purdue-socet/risc-v-ci:main


#set up SSH
RUN mkdir -p ~/.ssh && \
    ssh-keyscan github.com >>~/.ssh/known_hosts

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]