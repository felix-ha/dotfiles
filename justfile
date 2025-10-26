set windows-shell := ["powershell.exe", "-c"]

default:
    just --list

build:
    docker build -t dev-container .

enter:
    docker run -it -v "{{invocation_directory()}}:/host" dev-container bash


enter-unix:
    docker run -it -v "$(pwd):/host" dev-container bash

