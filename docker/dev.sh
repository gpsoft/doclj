#!/bin/bash

# Input env vars:
#   SHARED_DIR(optional): the directory shared with the host
#
if [ -z $SHARED_DIR ]; then
    SHARED_DIR=$PWD
fi


# Retrieve user info.
HOST_GID=$(stat -c %g $SHARED_DIR)
HOST_UID=$(stat -c %u $SHARED_DIR)
DK_GROUP=$(stat -c %G $SHARED_DIR)
DK_USER=$(stat -c %U $SHARED_DIR)
if [ $DK_GROUP = UNKNOWN ]; then
    DK_GROUP=dk_group
    groupadd --gid $HOST_GID $DK_GROUP
fi
if [ $DK_USER = UNKNOWN ]; then
    DK_USER=dk_user
    useradd --home-dir /home/$DK_USER --gid $HOST_GID \
        --uid $HOST_UID --shell /bin/bash $DK_USER

    # Bring clojure tooling environment from root.
    cp -r /root/.bashrc /root/.lein /root/.boot /root/.clojure /root/.vim /root/.vimrc \
        /home/$DK_USER/
    chown -R $DK_USER:$DK_GROUP \
        /home/$DK_USER/.bashrc \
        /home/$DK_USER/.lein \
        /home/$DK_USER/.boot \
        /home/$DK_USER/.clojure \
        /home/$DK_USER/.vim \
        /home/$DK_USER/.vimrc \
        /home/$DK_USER
    chmod 644 /home/$DK_USER/.bashrc
fi

# Switch to the user
su $DK_USER
