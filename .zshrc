# Path to your oh-my-zsh installation.
export ZSH=/Users/rayyildiz/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="spaceship"

DEFAULT_USER="rayyildiz"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=3

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="dd.mm.yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(sublime git golang adb battery cabal colorize docker emacs heroku nvm pip python sudo svn)

# User configuration

# export PATH="/usr/bin:/bin:/usr/sbin:/sbin:$PATH"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"



export GOPATH="/Users/rayyildiz/workspace/gopath"
export GOBIN=$GOPATH/bin
export GOAPP_ENGINE=/Developer/google-cloud-sdk/platform/google_appengine
export MAVEN_HOME=/Developer/apache-maven-3.3.9
export PYTHON2_HOME=/Users/rayyildiz/Library/Python/2.7
export GRADLE_HOME=/Developer/gradle-3.1
export ERL_PATH=/usr/local/Cellar/erlang/19.3/bin/erl

export NVM_DIR="/Users/rayyildiz/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

export ACTIVATOR_HOME=/Developer/activator-dist-1.3.12
export ANDROID_NDK=/Developer/android-ndk-r14b
export ANDROID_HOME=/Users/rayyildiz/Library/Android/sdk

export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_121.jdk/Contents/Home

export PATH=$PATH:$GOBIN:$MAVEN_HOME/bin:$PYTHON2_HOME/bin
export PATH=$PATH:$GRADLE_HOME/bin:$ERL_PATH
export PATH=$PATH:$ACTIVATOR_HOME/bin:$ANDROID_NDK:$ANDROID_HOME/tools
export PATH=$PATH:$GOAPP_ENGINE/goroot/bin

# NixOS
if [ -f ~/.nix-profile/etc/profile.d/nix.sh ]; then
    source ~/.nix-profile/etc/profile.d/nix.sh
fi

# Rustlang
if [ -f ~/.cargo/env ]; then
   source ~/.cargo/env
fi


# The next line updates PATH for the Google Cloud SDK.
if [ -f /Developer/google-cloud-sdk/path.zsh.inc ]; then
  source '/Developer/google-cloud-sdk/path.zsh.inc'
fi

# The next line enables shell command completion for gcloud.
if [ -f /Developer/google-cloud-sdk/completion.zsh.inc ]; then
  source '/Developer/google-cloud-sdk/completion.zsh.inc'
fi
eval $(/usr/libexec/path_helper -s)

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/rayyildiz/.sdkman"
[[ -s "/Users/rayyildiz/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/rayyildiz/.sdkman/bin/sdkman-init.sh"
