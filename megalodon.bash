#!/bin/bash
PHP_INI=/usr/local/etc/php5/php.ini


#while [ $# -gt 0 ]; do
  #opt="$1"
  #shift
  #case "$opt" in
    #-b) branch="$1"; shift ;;
    #--no-prefix) prefix= ;;
    #--) break ;;
    #*) die "Unexpected option: $opt" ;;
  #esac
#done

command="$1"

shift
case "$command" in
  php) $EDITOR $PHP_INI;;
  #split|push) default="--default HEAD" ;;
  *) die "Unknown command '$command'" ;;
esac
