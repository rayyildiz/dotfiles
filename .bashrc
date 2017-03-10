#!/bin/bash
#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!

ERL_PATH=/usr/local/Cellar/erlang/19.1/bin/erl

export SDKMAN_DIR="/Users/rayyildiz/.sdkman"
[[ -s "/Users/rayyildiz/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/rayyildiz/.sdkman/bin/sdkman-init.sh"

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
