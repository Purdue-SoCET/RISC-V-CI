# Used for GitHub Action

FROM ghcr.io/purdue-socet/risc-v-ci:main


#set up SSH
RUN mkdir -p ~/.ssh && \
    ssh-keyscan github.com >>~/.ssh/known_hosts

COPY install_digital_libs.sh /install_digital_libs.sh
RUN chmod +x /install_digital_libs.sh

RUN ./install_digital_libs.sh

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]