#!/bin/bash

# Installion script
cmd=$1
user=`grep user: input/mysql_conn.conf | cut -f2 -d' '`
pswd=`grep password: input/mysql_conn.conf | cut -f2 -d' '`

#target_dir='/var/www/html'
target_dir=$HOME/Desktop/pub_html

case $cmd in

install)
  # Run R scripts
  echo "Installing... "
  RScript syntax/00_start.R pwd install force
  
  # Run MySQL scripts
  if [ $pswd=='' ]
  then
    /usr/local/mysql/bin/mysql -u $user < syntax/data_structure.sql
    /usr/local/mysql/bin/mysql -u $user < syntax/results_framework.sql
  else
    /usr/local/mysql/bin/mysql -u $user -p$pswd < syntax/data_structure.sql
    /usr/local/mysql/bin/mysql -u $user -p$pswd < syntax/results_framework.sql
  fi
  
  # Create the App folder
  mkdir -p "$target_dir/app"
  cp -rf web/* "$target_dir/app"
  echo "Done!"
  ;;

uninstall)
  # Erase database from mysql
  echo "Uninstalling... "
  if [ $pswd=='' ]
  then
    /usr/local/mysql/bin/mysql -u $user -e "DROP DATABASE omsong;" 
  else
    /usr/local/mysql/bin/mysql -u $user -p$pswd -e "DROP DATABASE omsong;" 
  fi

  # Erase thins on App
  rm -rf "target_dir/app"
  echo "Done!"
  ;;

run)
  # Run R scripts
  echo "Running..."
  RScript /syntax/00_start.R pwd analysis
  RScript /syntax/00_start.R pwd run

  # Web plots
  cp web/categories_network.png "$target_dir/app"
  ;;

*)
  echo "Unknown Command!"

esac
