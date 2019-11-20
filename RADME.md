# Task-runner alias `rr`

Running tasks defined in `config.yml` file

## Usage

`-c` - edit configuration

`-s` - show configuration

`-f` - load default default configuration

`-d` - enable debugging mode

`-v` - all commands verbose

`-u` - self update

## Configuration

### Run `rr -c` to edit configuration __~/.config/task-runner/config.yml__

```yaml
LAST_UPDATE_DATE: 2019-11-18 # check for update one time everyday
AUTOUPDATE: true

# order of commands
 COMMANDS: git clear npm_install

 git: # name of command
   command: 'ls -la'
   description: "Tutorial"
   run_if_var_is_true: # if this variable is true run command
   exit_on_error: true|false
   verbose: true|false

# setting variable to value 'true' if fulfils the condition.
# if empty default variable name is UPPERCASE command name + GREP|SUCCESS|FAIL
   set_var_grep: # GIT_GREP
   set_var_success: # GIT_SUCCESS
   set_var_fail: # GIT_FAIL

   grep: # grep in output
   grep_message: # if grep is successful show this message
```

### Backup

Creates a backup automatically adding to the end of file `~` applies to configuration and script itself

## Instalation

**via curl**
```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/szunaj13pl/shell-task-runner/master/install.sh)"
```
**via wget**
```
sh -c "$(wget https://raw.githubusercontent.com/szunaj13pl/shell-task-runner/master/install.sh -O -)"
```
**or step by step**

```
    # Install requirements

        sudo apt install git


    # Create tempormaly folder for clean instalation

        temp_task-runner_folder=$(mktemp -d /tmp/task-runner.XXXXXX)


    # Download project

        git clone https://github.com/szunaj13pl/shell-task-runner.git "$temp_task-runner_folder"\
        && cd "$temp_task-runner_folder"


    # Create 'bin' folder and copy script to it

        mkdir -p $HOME/bin
        cp task-runner $HOME/bin


    # Add 'bin' folder to $PATH

        echo "$PATH"| grep --quiet "$HOME/bin" \
        && echo 'export PATH="$HOME/bin:$PATH"' >> $HOME/.profile


    # Create configuration folder and copy 'default_config' to it

        mkdir -p $HOME/.config/task-runner
        cp default_config $HOME/.config/task-runner/default_config
        cp --no-clobber default_config $HOME/.config/task-runner/config

    # Now you can use 'task-runner' or alias 'rr' like command


    # Clean-up

        rm  -rf "$temp_task-runner_folder"

    # DONE! Now you can use 'task-runner' like command

```
