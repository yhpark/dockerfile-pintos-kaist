# dockerfile-pintos-kaist
Pintos dockerfile for CS330 at KAIST

### How to use

Get the Docker from your terminal:

``` sh
docker pull yhpark/pintos-kaist
```

Attach volume `/pintos` with your pintos directory, and run commands.

``` sh
docker run -i -t -v <PATH_TO_PINTOS>:/pintos yhpark/pintos-kaist bash
```

Docker runs as root, so if you execute `make` or some commands which generate
files, generated files are remained as owned by `root`. To avoid this, consider
adding `entry.sh` into your `pintos` directory:

``` sh
#!/bin/bash
useradd -u <UID> <USER>
su <USER> --session-command bash
```

Note that `<UID>` is needed if you want Docker run as user which is as same as
on your local machine. The `--session-command` option prevents `Ctrl-C` to kill
the whole `su` process. After adding the `entry.sh` file, you can run the
following command:

``` sh
docker run -i -t -v <PATH_TO_PINTOS>:/pintos yhpark/pintos-kaist /pintos/entry.sh
```

### Important note

* This is only targeted for the specific version of Pintos used in class CS330 at KAIST.
