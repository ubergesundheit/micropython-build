Micropython on ESP8266
======================
The repository provides a `Dockerfile` to build the [Micropython](https://micropython.org/) firmware for [ESP8266](https://en.wikipedia.org/wiki/ESP8266) boards.

***Attention***: The binary has been built and tested on OSX 10.11 running `docker-machine`

Build Instructions
------------------

Build the docker image. To specify a particular version of micropython provide it through the `build-arg`. Otherwise the HEAD of the master branch will be used.

```bash
  docker build -t micropython --build-arg VERSION=v1.8.1 .
```

Once the container is built successfuly create a container from the image

```bash
  docker create --name micropython micropython
```

Then copy the the built firmware into the host machine.

```bash
  docker cp micropython:/micropython/esp8266/build/firmware-combined.bin firmware-combined.bin
```

The firmware can then be uploaded with the esptool

```bash
  esptool.py --port ${SERIAL_PORT} --baud 115200 write_flash --verify --flash_size=8m 0 firmware-combined.bin
```

Here `${SERIAL_PORT}` is the path to the serial device on which the board is connected.

Flash from within Container
---------------------------

If you have built the image directly on your host (Linux), you also can flash your ESP directly by running a container from the image.

```bash
docker run --rm -it --device ${SERIAL_PORT} --user root --workdir /micropython/esp8266 micropython make PORT=${SERIAL_PORT} deploy
```

Here `${SERIAL_PORT}` is the path to the serial device on which the board is connected.
