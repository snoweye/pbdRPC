#' Example Functions of RPC Related to pbdCS
#'
#' Example functions of RPC related to pbdCS
#'
#' @details
#' Using either \code{ssh} or \code{plink} to launch a pbdCS R cluster.
#'
#' NO further input from \code{stdin} is expected.
#' Outputs or errors may not be captured by R.
#'
#' \code{start_cs()} starts a pbdCS R cluster on remote servers.
#' Typical commands to launch a pbdCS R cluster is given in the example.
#' The linux/unix commands are as the following:
#' \itemize{
#' \item{1)}{\code{nohup} is for the non-stop call after disconnection.}
#' \item{2)}{\code{mpiexec -np 4} is for launching 4 MPI instances.}
#' \item{3)}{\code{Rscript -e 'pbdCS::pbdserver()'} is for R to start the
#'           pbdCS R cluster within MPI in batch.}
#' \item{4)}{\code{> .rrlog} is to direct the \code{stdout} to a file
#'           \code{.rrlog}}
#' \item{5)}{\code{2>&1} is to turn \code{stderr} to \code{stdout} which
#'           is the file \code{.cslog}.}
#' \item{6)}{\code{< /dev/null} is to get \code{stdin} from
#'           \code{/dev/null} which is nothing happen.}
#' \item{7)}{\code{&} is to put the batch command for the pbdCS R cluster
#'           in background.}
#' }
#'
#' \code{check_cs()} checks if there is a pbdCS R cluster on a remote
#' server. Lunix/unix commands \code{ps} and \code{grep} are used.
#'
#' \code{kill_cs()} kills the pbdCS R cluster if found.
#' Lunix/unix commands \code{ps}, \code{grep}, \code{awk}, and \code{kill}
#' are used.
#'
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
#' @param preload
#' further commands preloaded before the main \code{command} is executed. 
#' @param cmd
#' the main command to be executed on the server.
#'
#' @return
#' Mainly the message received at the command line will be printed, but
#' may not be captured by R.
#'
#' @examples
#' \dontrun{
#' library(pbdRPC, quietly = TRUE)
#' rpcopt_set(user = "snoweye", hostname = "192.168.56.101")
#'
#' check_cs()    # pid 2857 (may differ)
#' kill_cs()     # all pbdCS pids are killed
#' check_cs()    # make sure no pbdCS R cluster is running
#'
#' ### use "; " to bypass multiple commands
#' preload <- "source ~/work-my/00_set_devel_R; "
#'
#' ### start a new pbdCS R cluster
#' start_cs(preload = preload)
#' check_cs()
#' kill_cs()
#'
#' ### Example: for module load on supercomputers
#' preload <- "module load r; "    # e.g. via module load r
#' start_cs(preload = preload)
#' check_cs()
#' kill_cs()
#' }
#'
#' 
#' @rdname rpc_cs_example
#' @name rpc_cs_example
NULL


#' @rdname rpc_cs_example
#' @export
check_cs <- function(exec.type = .pbd_env$RPC.LI$exec.type,
    args = .pbd_env$RPC.LI$args, pport = .pbd_env$RPC.LI$pport,
    user = .pbd_env$RPC.LI$user, hostname = .pbd_env$RPC.LI$hostname,
    priv.key = .pbd_env$RPC.LI$priv.key,
    priv.key.ppk = .pbd_env$RPC.LI$priv.key.ppk,
    cmd = .pbd_env$RPC.CS$check)
{
  ret <- suppressWarnings(
           rpc(cmd = cmd, exec.type = exec.type, args = args, pport = pport,
               user = user, hostname = hostname, priv.key = priv.key,
               priv.key.ppk = priv.key.ppk)
         )
  return(ret)
}


#' @rdname rpc_cs_example
#' @export
kill_cs <- function(exec.type = .pbd_env$RPC.LI$exec.type,
    args = .pbd_env$RPC.LI$args, pport = .pbd_env$RPC.LI$pport,
    user = .pbd_env$RPC.LI$user, hostname = .pbd_env$RPC.LI$hostname,
    priv.key = .pbd_env$RPC.LI$priv.key,
    priv.key.ppk = .pbd_env$RPC.LI$priv.key.ppk,
    cmd = .pbd_env$RPC.CS$kill)
{
  ret <- suppressWarnings(
           rpc(cmd = cmd, exec.type = exec.type, args = args, pport = pport,
               user = user, hostname = hostname, priv.key = priv.key,
               priv.key.ppk = priv.key.ppk)
         )
  return(ret)
}


#' @rdname rpc_cs_example
#' @export
start_cs <- function(exec.type = .pbd_env$RPC.LI$exec.type,
    args = .pbd_env$RPC.LI$args, pport = .pbd_env$RPC.LI$pport,
    user = .pbd_env$RPC.LI$user, hostname = .pbd_env$RPC.LI$hostname,
    priv.key = .pbd_env$RPC.LI$priv.key,
    priv.key.ppk = .pbd_env$RPC.LI$priv.key.ppk,
    preload = .pbd_env$RPC.CS$preload,
    cmd = .pbd_env$RPC.CS$start)
{
  cmd.all <- paste0(preload, cmd)
  ret <- suppressWarnings(
           rpc(cmd = cmd.all, exec.type = exec.type, args = args, pport = pport,
               user = user, hostname = hostname, priv.key = priv.key,
               priv.key.ppk = priv.key.ppk)
         )
  return(ret)
}

