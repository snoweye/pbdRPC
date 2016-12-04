#' Sets of controls in pbdRPC.
#' 
#' These sets of controls are used to provide default values in pbdRPC package.
#' 
#' @param verbose,intern,wait,check.exec,use.shell.exec,pause
#' RPC control for \code{system}, \code{shell.exec}, and so on.
#' \code{wait = FALSE} allows asynchronous commands which need more test.
#' e.g. continuously port forwarding without sending commands to background.
#'
#' @param exec.type,args,pport,user,hostname,priv.key,priv.key.ppk
#' RPC login information used by \code{\link{rpc}()}, \code{\link{ssh}()}, or
#' \code{\link{plink}()}.
#' 
# #' @param unix,macos,windows
#'
#' @param check,kill,start,preload
#' RPC remoter commands used by \code{\link{check_rr}()},
#' \code{\link{kill_rr}()}, or \code{\link{start_rr}()}.
#' RPC pbdCS commands used by \code{\link{check_cs}()},
#' \code{\link{kill_cs}()}, or \code{\link{start_cs}()}.
#' 
#' @author Wei-Chen Chen \email{wccsnow@@gmail.com}.
#' 
#' Programming with Big Data in R Website: \url{http://r-pbd.org/}
#' 
#' @keywords global variables
#' @seealso \code{\link{.pbd_env}}.
#' @name RPC Control Functions
#' @rdname zz_rpc_control
NULL


### For RPC control.
#' @export
#' @rdname zz_rpc_control
RPC.CT <- function(
  verbose = FALSE,
  intern = FALSE,
  wait = TRUE,
  check.exec = FALSE,
  use.shell.exec = TRUE,
  pause = TRUE
){
  list(
    verbose = verbose,
    intern = intern,
    wait = wait,
    check.exec = check.exec,
    use.shell.exec = use.shell.exec,
    pause = pause
  )
}


### For RPC login information.
#' @export
#' @rdname zz_rpc_control
RPC.LI <- function(
  exec.type = "ssh",
  args = "",
  pport = "22",
  user = "snoweye",
  hostname = "192.168.56.101",
  priv.key = "~/.ssh/id_rsa",
  priv.key.ppk = "./id_rsa.ppk"
){
  list(
    exec.type = exec.type,
    args = args,
    pport = pport,
    user = user,
    hostname = hostname,
    priv.key = priv.key,
    priv.key.ppk = priv.key.ppk
  )
}


### For RPC searching order. TODO: further automation and detection.
# #' @export
# #' @rdname zz_rpc_control
# RPC.SO <- function(
#   unix = c("ssh", "plink", "pbdRPC/libs/plink"),
#   macos = c("ssh", "plink", "pbdRPC/libs/plink"),
#   windows = c("ssh",
#               "C:/Program Files/OpenSSH/ssh",
#               "C:/Program Files (x86)/OpenSSH/ssh",
#               "plink",
#               "C:/Program Files/PuTTY/plink.exe",
#               "C:/Program Files (x86)/PuTTY/plink.exe",
#               "pbdRPC/libs/i386/plink.exe",
#               "pbdRPC/libs/x64/plink.exe")
# ){
#   list(
#     unix = unix,
#     macos = macos,
#     windows = windows
#   )
# }


### For RPC remoter commands.
#' @export
#' @rdname zz_rpc_control
RPC.RR <- function(
  check = "ps ax|grep '[r]emoter::server'",
  kill = "kill -9 $(ps ax|grep '[r]emoter::server'|awk '{print $1}')",
  start = "nohup Rscript -e 'remoter::server()' > .rrlog 2>&1 < /dev/null &",
  preload = "source ~/work-my/00_set_devel_R; "
){
  list(
    check = check,
    kill = kill,
    start = start,
    preload = preload
  )
}

### For RPC pbdCS commands.
# #' @export
# #' @rdname zz_rpc_control
### No need to export the above. Long command mad the R CMD check.
RPC.CS <- function(
  check = "ps ax|grep '[p]bdCS::pbdserver'",
  kill = "kill -9 $(ps ax|grep '[p]bdCS::pbdserver'|awk '{print $1}')",
  start = "nohup mpiexec -np 4 Rscript -e 'pbdCS::pbdserver()' > .cslog 2>&1 < /dev/null &",
  preload = "source ~/work-my/00_set_devel_R; "
){
  list(
    check = check,
    kill = kill,
    start = start,
    preload = preload
  )
}

