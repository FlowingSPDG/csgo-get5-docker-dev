#!/bin/bash
######################
#   get steamworks   #
######################

mkdir -p /downloads/steamworks
chown -R user:user /downloads

STEAMWORKS_HANDLED=FALSE

if  [[ $STEAMWORKS_VER == "" ]] ;
then
echo "missing STEAMWORKS_VER. Exiting"
exit 1
fi

if  [[ $STEAMWORKS_VER == http*.tgz ]] ;
then
    echo "found steamworks download url: " 
    echo $STEAMWORKS_VER
    echo "downloading..." 
    su user -c " wget -q -O /downloads/steamworks.tgz $STEAMWORKS_VER  && \
    tar xvzf /downloads/steamworks.tgz -C /downloads/steamworks && \
    rsync -aq /downloads/steamworks/package/addons/ $CSGO_DIR/csgo/addons && \
    rm -rf /downloads/steamworks /downloads/steamworks.tgz" 
    STEAMWORKS_HANDLED=TRUE
fi

if  [[ $STEAMWORKS_VER == LOCAL ]] ;
then
    echo "use local steamworks" 
    echo "copy files..." 
    rsync -aq /localmounts/steamworks/addons/ $CSGO_DIR/csgo/addons
    chown -R user:user $CSGO_DIR/csgo/addons
    STEAMWORKS_HANDLED=TRUE
fi

if  [[ $STEAMWORKS_HANDLED == FALSE ]] ;
then
    echo "found no url and no LOCAL setting for steamworks try to download version: " 
    echo $STEAMWORKS_VER
    echo "downloading..." 
    su user -c " wget -q -O /downloads/steamworks.tgz https://github.com/KyleSanderson/SteamWorks/releases/download/$STEAMWORKS_VER/package-lin.tgz"
    if [ ! -s "/downloads/steamworks.tgz" ]; then
        echo "steamworks.tgz does not exist. Do you entered a wrong version number?"
        exit 1
    else   
        su user -c " tar xvzf /downloads/steamworks.tgz -C /downloads/steamworks && \
        rsync -aq /downloads/steamworks/package/addons/ $CSGO_DIR/csgo/addons && \
        rm -rf /downloads/steamworks /downloads/steamworks.tgz" 
        STEAMWORKS_HANDLED=TRUE
    fi
fi

if  [[ $STEAMWORKS_HANDLED == FALSE ]] ;
then
    echo "steamworks installation was not successful. Please check your STEAMWORKS_VER env."
    exit 1
else
    echo "steamworks installation seems sucessful if no errors were reported."
fi

printf '%.s─' $(seq 1 $(tput cols))

######################
#     get metamod    #
######################

mkdir -p /downloads/metamod
chown -R user:user /downloads

METAMOD_HANDLED=FALSE

if  [[ $METAMOD_VER == "" ]] ;
then
echo "missing METAMOD_VER. Exiting"
exit 1
fi

if  [[ $METAMOD_VER == http*.tar.gz ]] ;
then
    echo "found metamod download url: " 
    echo $METAMOD_VER
    echo "downloading..." 
    su user -c " wget -q -O /downloads/metamod.tar.gz $METAMOD_VER  && \
    tar xvzf /downloads/metamod.tar.gz -C /downloads/metamod && \
    rsync -aq /downloads/metamod/ $CSGO_DIR/csgo && \
    rm -rf /downloads/metamod /downloads/metamod.tar.gz" 
    METAMOD_HANDLED=TRUE
fi

if  [[ $METAMOD_VER == LOCAL ]] ;
then
    echo "use local metamod" 
    echo "copy files..." 
    su user -c "rsync -aq /localmounts/metamod/ $CSGO_DIR/csgo" 
    chown -R user:user $CSGO_DIR/csgo
    METAMOD_HANDLED=TRUE
fi

if  [[ $METAMOD_HANDLED == FALSE ]] ;
then
    echo "found no url and no LOCAL setting for metamod try to download version: " 
    echo $METAMOD_VER
    echo "getting current version: " 
    LATESTMM=$(wget -qO- https://mms.alliedmods.net/mmsdrop/"$METAMOD_VER"/mmsource-latest-linux)
    echo $LATESTMM
    echo "downloading..." 
    su user -c " wget -q -O /downloads/metamod.tar.gz https://mms.alliedmods.net/mmsdrop/\"$METAMOD_VER\"/\"$LATESTMM\""
    if [ ! -s "/downloads/metamod.tar.gz" ]; then
        echo "metamod.tar.gz does not exist. Do you entered a wrong version number?"
        exit 1
    else   
        su user -c " tar xvzf /downloads/metamod.tar.gz -C /downloads/metamod && \
        rsync -aq /downloads/metamod/ $CSGO_DIR/csgo && \
        rm -rf /downloads/metamod /downloads/metamod.tar.gz" 
        METAMOD_HANDLED=TRUE
    fi
fi

if  [[ $METAMOD_HANDLED == FALSE ]] ;
then
    echo "metamod installation was not successful. Please check your METAMOD_VER env."
    exit 1
else
    echo "metamod installation seems sucessful if no errors were reported."
fi

printf '%.s─' $(seq 1 $(tput cols))

######################
#     get sourcemod  #
######################

mkdir -p /downloads/sourcemod
chown -R user:user /downloads

SOURCEMOD_HANDLED=FALSE

if  [[ $SOURCEMOD_VER == "" ]] ;
then
echo "missing SOURCEMOD_VER. Exiting"
exit 1
fi

if  [[ $SOURCEMOD_VER == http*.tar.gz ]] ;
then
    echo "found sourcemod download url: " 
    echo $SOURCEMOD_VER
    echo "downloading..." 
    su user -c " wget -q -O /downloads/sourcemod.tar.gz $SOURCEMOD_VER  && \
    tar xvzf /downloads/sourcemod.tar.gz -C /downloads/sourcemod && \
    rsync -aq /downloads/sourcemod/ $CSGO_DIR/csgo && \
    rm -rf /downloads/sourcemod /downloads/sourcemod.tar.gz" 
    SOURCEMOD_HANDLED=TRUE
fi

if  [[ $SOURCEMOD_VER == LOCAL ]] ;
then
    echo "use local sourcemod" 
    echo "copy files..." 
    rsync -aq /localmounts/sourcemod/ $CSGO_DIR/csgo
    chown -R user:user $CSGO_DIR/csgo
    SOURCEMOD_HANDLED=TRUE
fi

if  [[ $SOURCEMOD_HANDLED == FALSE ]] ;
then
    echo "found no url and no LOCAL setting for sourcemod try to download version: " 
    echo $SOURCEMOD_VER
    echo "getting current version: " 
    LATESTSM=$(wget -qO- https://sm.alliedmods.net/smdrop/"$SOURCEMOD_VER"/sourcemod-latest-linux)
    echo $LATESTSM
    echo "downloading..." 
    su user -c " wget -q -O /downloads/sourcemod.tar.gz https://sm.alliedmods.net/smdrop/\"$SOURCEMOD_VER\"/\"$LATESTSM\""
    if [ ! -s "/downloads/sourcemod.tar.gz" ]; then
        echo "sourcemod.tar.gz does not exist. Do you entered a wrong version number?"
        exit 1
    else   
        su user -c " tar xvzf /downloads/sourcemod.tar.gz -C /downloads/sourcemod && \
        rsync -aq /downloads/sourcemod/ $CSGO_DIR/csgo && \
        rm -rf /downloads/sourcemod /downloads/sourcemod.tar.gz" 
        SOURCEMOD_HANDLED=TRUE
    fi
fi

if  [[ $SOURCEMOD_HANDLED == FALSE ]] ;
then
    echo "sourcemod installation was not successful. Please check your SOURCEMOD_VER env."
    exit 1
else
    echo "sourcemod installation seems sucessful if no errors were reported."
fi

printf '%.s─' $(seq 1 $(tput cols))


######################
# copy configs       #
######################

if [ -d "/localmounts/servercfg" ]
then
	if [ "$(ls -A /localmounts/servercfg)" ]; then
        echo "Copy server configs..."
        cp -rf /localmounts/servercfg/* $CSGO_DIR/csgo/cfg/
        chown -R user:user $CSGO_DIR/csgo/cfg
	fi
fi


printf '%.s─' $(seq 1 $(tput cols))
echo starting csgo...

######################
# Set launch options #
######################
ARGS="-game csgo -console -usercon -steam_dir $STEAMCMD_DIR -steamcmd_script $STEAMCMD_DIR/steamcmd.sh -ip 0.0.0.0"

if [ -v SERVER_TOKEN ]
then
    ARGS="$ARGS +sv_setsteamaccount $SERVER_TOKEN"
fi
if [ -v PASSWORD ]
then
    ARGS="$ARGS +sv_password $PASSWORD"
fi
if [ -v RCON_PASSWORD ]
then
    ARGS="$ARGS +rcon_password $RCON_PASSWORD"
fi
if [ -v GOTV_ENABLE ]
then
    ARGS="$ARGS +tv_enable $GOTV_ENABLE"
fi
if [ -v GOTV_PASSWORD ]
then
    ARGS="$ARGS +tv_password $GOTV_PASSWORD"
fi
if [ -v GOTV_DELAY ]
then
    ARGS="$ARGS +tv_delay $GOTV_DELAY"
fi
if [ -v GOTV_SNAPSHOTRATE ]
then
    ARGS="$ARGS +tv_snapshotrate $GOTV_SNAPSHOTRATE"
fi
if [ -v  PUBLIC_ADDRESS ]
then
    ARGS="$ARGS +net_public_adr $PUBLIC_ADDRESS"
fi
if [ -v IP ]
then
    ARGS="$ARGS -ip $IP"
else
    ARGS="$ARGS -ip 0.0.0.0"
fi
if [ -v PORT ]
then
    ARGS="$ARGS -port $PORT"
fi
if [ -v GOTV_PORT ]
then
    ARGS="$ARGS +tv_port $GOTV_PORT"
fi
if [ -v CLIENT_PORT ]
then
    ARGS="$ARGS +clientport $CLIENT_PORT"
fi
if [ -v TICKRATE ]
then
    ARGS="$ARGS -tickrate $TICKRATE"
else
    ARGS="$ARGS -tickrate 128"
fi
if [ -v MAXPLAYERS ]
then
    ARGS="$ARGS -maxplayers_override $MAXPLAYERS"
else
    ARGS="$ARGS -maxplayers_override 20"
fi
if [ -v GAMETYPE ]
then
    ARGS="$ARGS +game_type $GAMETYPE"
else
    ARGS="$ARGS +game_type 6"
fi
if [ -v GAMEMODE ]
then
    ARGS="$ARGS +game_mode $GAMEMODE"
else
    ARGS="$ARGS +game_mode 0"
fi
if [ -v MAPGROUP ]
then
    ARGS="$ARGS +mapgroup $MAPGROUP"
else
    ARGS="$ARGS +mapgroup mg_active"
fi
if [ -v MAP ]
then
    ARGS="$ARGS +map $MAP"
else
    ARGS="$ARGS +map dz_blacksite"
fi
if [ -v HOST_WORKSHOP_COLLECTION ]
then
    ARGS="$ARGS +host_workshop_collection $HOST_WORKSHOP_COLLECTION"
fi
if [ -v WORKSHOP_START_MAP ]
then
    ARGS="$ARGS +workshop_start_map $WORKSHOP_START_MAP"
fi
if [ -v WORKSHOP_AUTHKEY ]
then
    ARGS="$ARGS -authkey $WORKSHOP_AUTHKEY"
fi
if [ -v AUTOEXEC ]
then
    ARGS="$ARGS +exec $AUTOEXEC"
fi
if [ $UPDATE_ON_LAUNCH -eq 1 ]
then
    ARGS="$ARGS -autoupdate"
fi
if [ -v CUSTOM_ARGS ]
then
    ARGS="$ARGS $CUSTOM_ARGS"
fi 'get5_autoload_config match_config.json' > $CSGO_DIR/csgo/cfg/sourcemod/get5.cfg
fi


#################
# Launch server #
#################
cd $CSGO_DIR
echo "./srcds_run $ARGS"
su user -c "./srcds_run $ARGS"