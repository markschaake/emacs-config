#!/bin/bash

export _JAVA_AWT_WM_NONREPARENTING=1

#exec emacsclient -c
exec dbus-launch --exit-with-session emacs -mm --debug-init
