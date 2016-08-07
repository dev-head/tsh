#!/bin/sh


APP=$(command -v fortune)

if [[ ! -z $APP ]]; then 
    fortune -s
fi