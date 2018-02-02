# pbdRPC

* **Version:** 0.2-0
* **License:** [![License](http://img.shields.io/badge/license-MPL%202-orange.svg?style=flat)](https://www.mozilla.org/MPL/2.0/)
* **Download:** [![Download](http://cranlogs.r-pkg.org/badges/pbdRPC)](https://cran.r-project.org/package=pbdRPC)
* **Status:** [![Build Status](https://travis-ci.org/snoweye/pbdRPC.png)](https://travis-ci.org/snoweye/pbdRPC)
* **Author:** See section below.


A very light yet secure implementation for remote procedure calls with
unified interface via ssh (OpenSSH) or plink/plink.exe (PuTTY).

See [pbdRPC vignette](./inst/doc/pbdRPC-guide.pdf) for more details and
applications.


## Usage



```r
library(pbdRPC)

m <- machine("192.168.56.101", "snoweye")
m
## Machine config for snoweye@192.168.56.101
##     pport = 22
##     type = ssh
##     args = ""
##     priv.key = ~/.ssh/id_rsa
##     priv.key.ppk = ./id_rsa.ppk

rpc(m, "whoami")
## snoweye
```

If no username is supplied during machine configuration, then we take the local system user name (which of course may not be correct...):

```r
m <- machine("192.168.56.101")
rpc(m, "whoami")
## snoweye
```


## Features
- The `rpc()` or `srpc()` are unified interfaces across most popular OSs
  including Linux, Mac OSX, MS Windows, and Solaris.
- The above example is completely done in an interactive `R` session.
- The call is equivalent to
  `ssh snoweye@192.168.56.101 "whoami"` in a Linux-like system and
  `plink.exe snoweye@192.168.56.101 "whoami"` in a windows system,
  provided that `ssh` and `plink.exe` are reachable through the
  environment variable, `PATH`.
- The default communications between the local `R` and the remote server
  (`192.168.56.101` in this case) are encrypted and secure, by default
  using RSA version 2.
- Private and public paired key authentications are supported,
  i.e. login without password.
- Port forwarding is also supported for two way tunneling, both
  local `-L` and remote/reverse `-R`.


## Installation

To install the R package, run:

```r
install.package("coop")
```

The development version is maintained on GitHub, and can easily be installed by any of the packages that offer installations from GitHub:

```r
### Pick your preference
devtools::install_github("RBigData/pbdRPC")
ghit::install_github("RBigData/pbdRPC")
remotes::install_github("RBigData/pbdRPC")
```


## Citation

When mentioning the pbdRPC, please cite:

```
@MISC{pbdRPC2017,
  author = {Chen, W.-C and Schmidt, D.},
  title = {{pbdRPC}: Programming with Big Data -- Remote Procedure Call},
  year = {2017},
  note = {{R} Package, URL https://cran.r-project.org/package=pbdRPC}
}
```


## Authors

pbdRPC is authored and maintained by the pbdR core team:

* Wei-Chen Chen
* Drew Schmidt

