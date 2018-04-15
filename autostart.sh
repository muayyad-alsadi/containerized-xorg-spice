#! /bin/bash

for i in ~/.config/openbox/autostart.d/*
do
[ -x "$i" ] && {
  "$i" &
}
done
