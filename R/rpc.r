#' Remote Procedure Call
#'
#' Launch a command via ssh or plink on a (remote) server.
#'
#' @details
#' Using either \code{ssh} or \code{plink} to launch a command on a (remote)
#' server.
#' Authentication is working currently for \code{ssh}.
#'
#' NO further input from \code{stdin} is expected.
#' Outputs or errors may not be captured by R.
#'
#' @param machine
#' A machine configuration. See \code{?machine}.
#' @param cmd
#' the command to be executed on the server.
#' @param intern,wait
#' arguments passed to \code{system()} or \code{shell()}
#' whereever they are applicable.
#'
#' @return
#' Mainly the message received from the command line of server
#' may be returned but may not be captured by R.
#'
#' For example, Windows with \code{plink} will not capture the return because
#' currently the authentication is not working. A windows \code{bat} file is
#' launched by \code{shell.exec()} in an additional \code{cmd.exe} window
#' to avoid saving password inside R.
#'
#' @seealso \code{\link{machine}()}, \code{\link{start_rr}()},
#'          \code{\link{check_rr}()}, \code{\link{kill_rr}()},
#'          \code{\link{srpc}()},
#'          \code{\link{ssh}()}, and \code{\link{plink}()}.
#'
#' @export
rpc <- function(machine, cmd = "whoami", intern = .pbd_env$RPC.CT$intern,
  wait = .pbd_env$RPC.CT$wait)
{
  check.is.machine(machine)
  exec.type <- machine$exec.type
  args <- machine$args
  pport <- machine$pport
  user <- machine$user
  hostname <- machine$hostname
  priv.key <- machine$priv.key
  priv.key.ppk <- machine$priv.key.ppk

  srpc(cmd = cmd, exec.type = exec.type, args = args, pport = pport,
       user = user, hostname = hostname, priv.key = priv.key,
       priv.key.ppk = priv.key.ppk, intern = intern, wait = wait)
}
