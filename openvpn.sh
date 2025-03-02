#!/bin/bash

set -e
source .env

function menu() {
    echo "1) Initialize (required)"
    echo "2) Create client"
    echo "3) Revoke client"
    echo "4) List clients"
    echo "5) Exit"

    until [[ $OPTION =~ ^[1-5]$ ]]; do
        read -rp "Select an option [1-5]: " OPTION
    done

    case $OPTION in
    1)
        echo ""
        init
        ;;
    2)
        echo ""
        create_client
        ;;
    3)
        echo ""
        revoke_client
        ;;
    4)
        echo ""
        list_clients
        ;;
    5)
        exit 0
        ;;
    esac
}

function init() {
    until [[ $HOST =~ ^[a-zA-Z0-9\.:]+$ ]]; do
        read -rp "Server host or IP: " HOST
    done

    run ovpn_genconfig -u udp://$HOST
    run ovpn_initpki

    sudo chown -R $(whoami): $OPENVPN_DIR
    sed -i 's/\/tmp\/openvpn-status.log/\/var\/log\/openvpn-status.log/g' $OPENVPN_CONFIG/openvpn.conf
}

function create_client() {
    CLIENTNAME=$(request_client_name)

    mkdir -p $OPENVPN_CLIENTS

    run easyrsa build-client-full $CLIENTNAME nopass
    run ovpn_getclient $CLIENTNAME | sed "s/1194 udp/$OPENVPN_PORT udp/g" >$OPENVPN_CLIENTS/$CLIENTNAME.ovpn
}

function revoke_client() {
    list_clients

    echo ""

    CLIENTNAME=$(request_client_name)

    run ovpn_revokeclient $CLIENTNAME remove

    rm $OPENVPN_CLIENTS/$CLIENTNAME.ovpn
}

function list_clients() {
    run ovpn_listclients
}

function request_client_name() {
    until [[ $CLIENTNAME =~ ^[a-zA-Z0-9_\.]+$ ]]; do
        read -rp "Client name: " CLIENTNAME
    done

    echo $CLIENTNAME
}

function run() {
    docker compose run --rm openvpn $@
}

menu
