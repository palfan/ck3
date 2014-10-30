#!/usr/bin/env bash

NAME=test
echo $NAME >> test.txt
echo "fagfewagewa$NAME"



foo="abc
def
syz"

echo "$foo" >> teee.txt

pp=/home/zhuleis/moni/teee.txt

p2=$(dirname $pp)/test.txt
echo $p2


