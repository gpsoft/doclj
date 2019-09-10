FROM openjdk:8-jdk-stretch

WORKDIR /root

# utils
ENV DEBCONF_NOWARNINGS yes
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        vim \
        git \
        less \
        net-tools \
        rlwrap \
    && rm -rf /var/lib/apt/lists/*

# leiningen
ENV LEIN_ROOT=1
RUN wget -q https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein \
    && chmod 755 lein \
    && mv lein /usr/local/bin \
    && lein version

# boot
ENV BOOT_AS_ROOT=yes
RUN wget -q https://github.com/boot-clj/boot-bin/releases/download/latest/boot.sh \
    && chmod 755 boot.sh \
    && mv boot.sh /usr/local/bin/boot \
    && boot --update

# clojure cli tools
RUN wget -q -O install.sh https://download.clojure.org/install/linux-install-1.10.1.469.sh \
    && bash install.sh -p /usr/local \
    && rm install.sh

# port for web, figwheel, and nrepl
EXPOSE 8080
EXPOSE 3000
EXPOSE 3449
EXPOSE 9500
EXPOSE 3575

# for convenience
COPY ./.bashrc /root/

# startup script
COPY ./dev.sh /usr/local/bin/
RUN chmod 755 /usr/local/bin/dev.sh

# clojure tooling environment
COPY profiles.clj /root/.lein/
COPY profile.boot /root/.boot/
COPY deps.edn /root/.clojure/


RUN mkdir -p /root/.vim/autoload ~/.vim/bundle
RUN curl -LSso /root/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
WORKDIR /root/.vim/bundle
RUN git clone https://github.com/tpope/vim-fireplace
RUN git clone https://github.com/tpope/vim-sexp-mappings-for-regular-people.git
RUN git clone https://github.com/guns/vim-sexp.git
RUN git clone https://github.com/guns/vim-clojure-static
RUN git clone https://github.com/kien/rainbow_parentheses.vim.git
COPY .vimrc /root/.vimrc

