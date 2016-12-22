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
#' @param cmd
#' the command to be executed on the server.
#' @param exec.type
#' either "ssh" or "plink" in character. Windows will force to use "plink".
#' @param args
#' further arguments to "ssh" or "plink" for connecting to the server
#' in addition to port, user id, and host name.
#' @param pport
#' ssh port opened on the server.
#' @param user
#' user id for logging to the server.
#' @param hostname
#' the server ip or host name.
#' @param priv.key,priv.key.ppk
#' location of the private key for user authentication, the file will be
#' checked first then \code{-i priv.key} will be added to \code{args}
#' when the file exists.
#' \code{priv.key.ppk} is only used when \code{plink} is called.
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
#' @seealso \code{\link{start_rr}()},
#'          \code{\link{check_rr}()}, \code{\link{kill_rr}()},
#'          \code{\link{ssh}()}, and \code{\link{plink}()}.
#'
#' @examples
#' \dontrun{
#' library(pbdRPC, quietly = TRUE)
#' rpcopt_set(user = "snoweye", hostname = "192.168.56.101")
#'
#' ### see start_rr(), check_rr(), and kill_rr() for more examples.
#' rpc()
#' rpc("ls")
#' rpc("ls ~/work-my")
#' rpc("cat ~/work-my/00_set_devel_R")
#'
#' ### see ssh(), plink(), and run_args() for lower level examples.
#'
#' ### Local port forwarding
#' rpc(args = "-N -T -L 55555:localhost:55555")
#' start_rr()
#'
#' library(remoter)
#' client()    # equivalent to client(addr = "192.168.56.101")
#' }
#'
#' @export
rpc <- function(cmd = "whoami", exec.type = .pbd_env$RPC.LI$exec.type,
    args = .pbd_env$RPC.LI$args, pport = .pbd_env$RPC.LI$pport,
    user = .pbd_env$RPC.LI$user, hostname = .pbd_env$RPC.LI$hostname,
    priv.key = .pbd_env$RPC.LI$priv.key,
    priv.key.ppk = .pbd_env$RPC.LI$priv.key.ppk,
    intern = .pbd_env$RPC.CT$intern, wait = .pbd_env$RPC.CT$wait)
{
  ### Pre-check.
  if (.Platform$OS.type == "windows")
    exec.type <- "plink"
  if (exec.type != "ssh" && exec.type != "plink")
    stop(paste0("exec.type (", exec.type, ") is not found."))

  ### Get port arguments.
  if (length(grep("-(P|p) [0-9]{1-5} ", args)) == 0)
  {
    if (exec.type == "ssh")
      args.pport <- paste0("-p ", pport)
    else
      args.pport <- paste0("-P ", pport)
  }

  ### Get private key arguments.
  if (length(grep("-i (.*) ", args)) == 0)
  {
    if (exec.type == "ssh")
      args.priv.key <- paste0("-i ", priv.key)
    else
      args.priv.key <- paste0("-i ", priv.key.ppk)
  }

  ### Get user and hostname arguments.
  if (length(grep("(.*)@(.*)", args)) == 0 &&
      length(grep("-l (.*) ", args)) == 0)
    user.hostname <- paste0(user, "@", hostname)

  ### Assemble and execute the cmd.
  args <- paste(args.pport, args.priv.key, args, user.hostname,
                paste0("\"", cmd, "\""), sep = " ")
  if (exec.type == "ssh")
    ret <- ssh(args, intern = intern, wait = wait)
  else
    ret <- plink(args, intern = intern, wait = wait)

  ### For return.
  if (.Platform$OS.type == "windows")
  {
    if (.pbd_env$RPC.CT$use.shell.exec)
      return(invisible(ret))
  }

  if (intern)
    return(ret)
  else
    return(invisible(ret))
}

