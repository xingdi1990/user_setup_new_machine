# this script is for creating new user on a fresh machine

* Login your new server by the authorization file such as:
  ```
  chmod 600 id_rsa_hyperstack
  ssh -i id_rsa_hyperstack ubuntu@xx.xxx.xxx.xxx
  ```
* Get the script
  ```
  wget https://raw.githubusercontent.com/xingdi1990/user_setup_new_machine/refs/heads/main/script.sh
  ```
* Follow the instruction on screen for finishing setting up your new account $username
* relogin with your new account
  ```
  ssh -i id_rsa_hyperstack $username@xx.xxx.xxx.xxx 
  ```
