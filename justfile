default:
    just --list

build:
    docker build -t dev-container .

enter:
    docker run -it -v $(pwd):/host dev-container bash

