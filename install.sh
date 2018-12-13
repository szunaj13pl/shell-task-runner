#!/bin/bash

# Janusz Ładecki <szunaj13pl@gmail.com>
# Created on 22.01.2018

install() {
    
    scriptName='task-runner'
    gitRepository='https://github.com/szunaj13pl/shell-task-runner.git'
    gitRepositoryRawVersionUrl='https://github.com/szunaj13pl/shell-task-runner/raw/master/install.sh'
    
    config_folder="$HOME/.config/${scriptName}"
    
    config_name="config.yml"
    config_file="${config_folder}/${config_name}"
    
    config_default_name="default_config.yml"
    config_default_file="${config_folder}/${config_default_name}"
    
    clear
    
    # Use colors, but only if connected to a terminal, and that terminal
    # supports them.
    if which tput >/dev/null 2>&1; then
        ncolors=$(tput colors)
    fi
    if [ -t 1 ] && [ -n "$ncolors" ] && [ "$ncolors" -ge 8 ]; then
        RED="$(tput setaf 1)"
        GREEN="$(tput setaf 2)"
        YELLOW="$(tput setaf 3)"
        BLUE="$(tput setaf 4)"
        BOLD="$(tput bold)"
        NORMAL="$(tput sgr0)"
    else
        RED=""
        GREEN=""
        YELLOW=""
        BLUE=""
        BOLD=""
        NORMAL=""
    fi
    
    # Check if can reach github.com
    printf "${NORMAL}Checking if can reach ${YELLOW} ${BOLD}Github.com${NORMAL}\n"
    ping -c 2 github.com >/dev/null 2>&1 || (printf "${NORMAL}Error: ${YELLOW}Github.com ${RED}is urechable${NORMAL}\n" && exit 1) || exit 1
    
    # Activate RAW version of install script
    hash curl >/dev/null 2>&1 || {
        wget "${gitRepositoryRawVersionUrl}"  2>>/dev/null 1>/dev/null
    } || \
    hash wget >/dev/null 2>&1 || {
        curl "${gitRepositoryRawVersionUrl}" 1>>/dev/null -s
    }
    
    
    # Only enable exit-on-error after the non-critical colorization stuff,
    # which may fail on systems lacking tput or terminfo
    set -e
    
    # Create tempormaly folder for clean instalation
    printf "${BLUE}Creating temporary folder${YELLOW} $temp_folder ${BLUE}...${NORMAL}\n"
    
    local temp_folder=$(mktemp -d /tmp/${scriptName}.XXXXXX)
    
    
    # Check if git is installed
    printf "${BLUE}Checking if ${YELLOW}git ${BLUE}is installed ...${NORMAL}\n"
    
    hash git >/dev/null 2>&1 || {
        printf "${NORMAL}Error:${YELLOW}git ${RED}is not installed${NORMAL}\n"
        exit 1
    }
    
    
    # Download project
    printf "${BLUE}Cloning ${BOLD}${scriptName} ${NORMAL}\n"
    
    git clone "${gitRepository}" "$temp_folder"\
    && cd "$temp_folder"
    
    
    # Create 'bin' folder and copy script to it
    
    printf "${BLUE}Checking if ${YELLOW}$HOME/bin${BLUE} exists ...${NORMAL}\n"
    mkdir -p $HOME/bin
    
    printf "${BLUE}Coping ${BOLD}${scriptName} ${NORMAL}${BLUE}to ${YELLOW}$HOME/bin ${NORMAL}\n"
    cp ${scriptName} $HOME/bin
    
    
    # Add 'bin' folder to $PATH
    printf "${BLUE}Checking if ${YELLOW}$HOME/bin${BLUE} is in PATH ...${NORMAL}\n"
    
    echo "$PATH"| grep --quiet "$HOME/bin" \
    || (echo 'export PATH="$HOME/bin:$PATH"' >> $HOME/.profile && printf "${GREEN} Adding ${YELLOW}$HOME/bin${GREEN} to PATH ...${NORMAL}\n")
    
    
    # Create configuration folder and copy 'default_config' to it
    printf "${BLUE}Creating ${scriptName} configuration if not found any...${NORMAL}\n"
    mkdir -p "${config_folder}"
    cp default_config.yml ${config_default_file}
    cp --no-clobber default_config.yml ${config_file}
    
    # Clean-up
    printf "${BLUE}Cleaning...${NORMAL}\n"
    
    rm -rf "$temp_folder"
}

install && printf "${BLUE}Now you can use ${YELLOW}${scriptName} ${BLUE}like command${NORMAL}\n"