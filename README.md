# pbdRPC

* **Version:** 0.1-1
* **License:** [![License](http://img.shields.io/badge/license-MPL%202-orange.svg?style=flat)](https://www.mozilla.org/MPL/2.0/)
* **Download:** [![Download](http://cranlogs.r-pkg.org/badges/pbdRPC)](https://cran.r-project.org/package=pbdRPC)
* **Status:** [![Build Status](https://travis-ci.org/snoweye/pbdRPC.png)](https://travis-ci.org/snoweye/pbdRPC)
* **Author:** See section below.


A very light yet secure implementation for remote procedure calls via ssh (OpenSSH) or plink/plink.exe (PuTTY).


## Usage

```r
# load the package
library(pbdRPC)

find_plink()

rpc()          # default 'whoami' is called at remote server
rpc("ls -la")  # 'ls -la' is called
```


## Installation

The package can be installed from the CRAN via the usual
`install.packages("pbdRPC")`, or via the devtools package:

```r
library(devtools)
install_github("RBigData/pbdRPC")
```


## Authors

pbdRPC is authored and maintained by the pbdR core team:
* Wei-Chen Chen

