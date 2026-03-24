FROM alpine:latest
CMD sh -c 'echo "Hello, ${1:-Captain}!"' --
