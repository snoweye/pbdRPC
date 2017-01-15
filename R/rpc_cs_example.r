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
#' @param machine
#' A machine configuration. See \code{?machine}.
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
#' # rpcopt_set(user = "snoweye", hostname = "192.168.56.101")
#' m <- machine(user = "snoweye", hostname = "192.168.56.101")
#'
#' check_cs(m)    # pid 2857 (may differ)
#' kill_cs(m)     # all pbdCS pids are killed
#' check_cs(m)    # make sure no pbdCS R cluster is running
#'
#' ### use "; " to bypass multiple commands
#' preload <- "source ~/work-my/00_set_devel_R; "
#'
#' ### start a new pbdCS R cluster
#' start_cs(m, preload = preload)
#' check_cs(m)
#' kill_cs(m)
#'
#' ### Example: for module load on supercomputers
#' preload <- "module load r; "    # e.g. via module load r
#' start_cs(m, preload = preload)
#' check_cs(m)
#' kill_cs(m)
#' }
#'
#' 
#' @rdname rpc_cs_example
#' @name rpc_cs_example
NULL


#' @rdname rpc_cs_example
#' @export
check_cs <- function(machine, cmd = .pbd_env$RPC.CS$check)
{
  check.is.machine(machine)
  
  ret <- suppressWarnings(
    rpc(cmd = cmd, machine = machine)
  )
  
  invisible(ret)
}


#' @rdname rpc_cs_example
#' @export
kill_cs <- function(machine, cmd = .pbd_env$RPC.CS$kill)
{
  check.is.machine(machine)
  
  ret <- suppressWarnings(
    rpc(cmd = cmd, machine = machine)
  )
  
  invisible(ret)
}


#' @rdname rpc_cs_example
#' @export
start_cs <- function(machine, cmd = .pbd_env$RPC.CS$start,
    preload = .pbd_env$RPC.CS$preload)
{
  check.is.machine(machine)
  
  cmd.all <- paste0(preload, cmd)
  ret <- suppressWarnings(
    rpc(cmd = cmd.all, machine = machine)
  )
  
  invisible(ret)
}
