# pbdRPC

* **Version:** 0.1-1
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

### Alter login information as needed
rpcopt_set(user = "snoweye", hostname = "192.168.56.101")
rpc("whoami")

### Or

rpc("whoami", user = "snoweye", hostname = "192.168.56.101")
```


## Features
- The above example is completely done in an interactive `R` session.
- The `rpc()` is unified interface. The call is equivalent to
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

The package can be installed from the CRAN via the usual
`install.packages("pbdRPC")`, or via the `devtools` package:

```r
library(devtools)
install_github("RBigData/pbdRPC")
```


## Citation

When mentioning the pbdRPC, please cite:

```
@MISC{pbdRPC2017,
  author = {Chen, W.-C},
  title = {{pbdRPC}: Programming with Big Data -- Remote Procedure Call},
  year = {2017},
  note = {{R} Package, URL https://cran.r-project.org/package=pbdRPC}
}
```


## Authors

pbdRPC is authored and maintained by the pbdR core team:
* Wei-Chen Chen

