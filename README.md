# static.rb

Demo project showing how to build small self contained static ELF binaries
from mruby source files.

static.rb uses [musl](https://musl.libc.org/) libc. The binary is further
`strip(1)`ed and packed with `upx(1)`.

## Requirements

- GNU make
- Ubuntu based build system. Tested on Ubuntu 18.04.4 (bionic).

## Usage

1. edit contents of 'static.rb'
2. run `make`
3. run ./static

### Example

```
dev@dev:~/src/static-rb$ cat static.rb
puts "Hello, world!"
dev@dev:~/src/static-rb$ make
[ -d tmp/mruby ] || git clone git@github.com:/mruby/mruby.git tmp/mruby
Reset branch '2.1.0'
make[1]: Entering directory '/home/dev/src/static-rb/tmp/mruby'
rake
...
%< --- output trimmed for brevity---
...
make[1]: Leaving directory '/home/dev/src/static-rb/tmp/mruby'
dev@dev:~/src/static-rb$ file static
static: ELF 64-bit LSB executable, x86-64, version 1 (SYSV), statically linked, stripped
dev@dev:~/src/static-rb$ ls -lh static
-rwxrwxr-x 1 dev dev 295K May 18 18:17 static
dev@dev:~/src/static-rb$ ./static
Hello, world!
```

## Contributing

Patches/comments/bug reports/suggestions welcome.

## LICENSE

Released under [MIT](https://opensource.org/licenses/MIT) license.
