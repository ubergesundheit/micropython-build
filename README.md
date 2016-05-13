build micropython in docker..

`docker build -t micropython .`

`docker run --rm -it micropython cat /micropython/esp8266/build/firmware-combined.bin > firmware-combined.bin`
