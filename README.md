# phpenv-pie

## How to use

This project is a tool that downloads PIE (The PHP Installer for Extensions)
and makes it availabe as a plugin for phpenv: 

```
$ phpenv pie -V
🥧 PHP Installer for Extensions (PIE) 1.3.8
```

### Use standalone

```
% git clone https://github.com/virlatinus/phpenv-pie.git
% cd phpenv-pie
% make install
% bin/phpenv-pie install "vendor/package_name"
```

### Use phpenv plugins

```
% git clone https://github.com/virlatinus/phpenv-pie.git $(phpenv root)/plugins/phpenv-pie
% cd $(phpenv root)/plugins/phpenv-pie
% make install
% phpenv pie install "vendor/package_name"
```

`make install` detects your OS and CPU architecture, downloads the matching
PIE release binary from the [php/pie](https://github.com/php/pie) GitHub
releases, and places it at `bin/phpenv-pie` so phpenv can find it. Requires
`curl` and `jq`. Currently supported platforms are Linux and macOS on x86_64
or arm64.

Run `make clean` to remove the installed binary.

More information about PIE can be found on its repository: [https://github.com/php/pie](https://github.com/php/pie)

You can also run `phpenv pie` without parameters to display the available command options.


## ChangeLog

### v0.2.0 2026/08/19

* Replaced `install.sh` with a `Makefile` (`make`, `make install`, `make clean`).
* Fixed a bug where the installer always downloaded the first release asset
  (`pie-Linux-ARM64`) regardless of the host OS/architecture, producing a
  binary that failed with `Exec format error` on other platforms. The
  installer now selects the release asset matching the detected OS and
  architecture.

### v0.1.0 2026/02/10

* Initial Version

AUTHOR:: Werner Garcia <virlatinus@gmail.com>
