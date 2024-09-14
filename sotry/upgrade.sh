#!/bin/bash
TARGET_BLOCK=626575
for (( ; ; )); do
    height=$(curl -s http://localhost:26657/status | jq -r '.result.sync_info.latest_block_height')
    if ((height >= TARGET_BLOCK)); then
    systemctl stop storyd
    cd $HOME
    mkdir story
    cd $HOME/story/
    wget https://story-geth-binaries.s3.us-west-1.amazonaws.com/story-public/story-linux-amd64-0.10.0-9603826.tar.gz
    tar xvzf story-linux-amd64-0.10.0-9603826.tar.gz 
    rm story-linux-amd64-0.10.0-9603826.tar.gz 
    mv story-linux-amd64-0.10.0-9603826/story /usr/local/bin/storyd
    rm -r story-linux-amd64-0.10.0-9603826
    storyd version
    systemctl restart storyd
      break
    else
      echo -e "Current block height: ${CYAN}$height${NC}"
    fi
    sleep 5
done
echo "------------------------------"
echo -e "Check logs : journalctl -u storyd -f --no-hostname | ccze -A"
