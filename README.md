# phpenv-pie

## How to use

This project is a utility that downloads PIE (The PHP Installer for Extensions)
and makes it availabe as a command for phpenv: `phpenv pie -V`

### Use standalone

```
% git clone https://github.com/virlatinus/phpenv-pie.git
% cd phpenv-pie
% sh install.sh
% bin/phpenv-pie install "vendor/package_name"
```

### Use phpenv plugins

```
% git clone https://github.com/virlatinus/phpenv-pie.git $PHPENV_ROOT/plugins/phpenv-pie
% cd $PHPENV_ROOT/plugins/phpenv-pie
% sh install.sh
% phpenv pie install "vendor/package_name"
```

More information about PIE can be found on its repository: [https://github.com/php/pie](https://github.com/php/pie)

You can also run `phpenv pie` without parameters to display the available command options.


## ChangeLog

### v0.1.0 2026/02/10

* Initial Version

AUTHOR:: Werner Garcia <virlatinus@gmail.com>
