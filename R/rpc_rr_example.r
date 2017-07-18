#' Example Functions of RPC Related to Remote R Server
#'
#' Example functions of RPC related to remote R server
#'
#' @details
#' Using either \code{ssh} or \code{plink} to launch a remote R server.
#'
#' NO further input from \code{stdin} is expected.
#' Outputs or errors may not be captured by R.
#'
#' \code{start_rr()} starts a remote R server on a remote server.
#' Typical commands to launch a remoter R server is given in the example.
#' The linux/unix commands are as the following:
#' \itemize{
#' \item{1)}{\code{nohup} is for the non-stop call after disconnection.}
#' \item{2)}{\code{Rscript -e 'remoter::server()'} is for R to start the
#'           remote R server in batch.}
#' \item{3)}{\code{> .rrlog} is to direct the \code{stdout} to a file
#'           \code{.rrlog}}
#' \item{4)}{\code{2>&1} is to turn \code{stderr} to \code{stdout} which
#'           is the file \code{.rrlog}.}
#' \item{5)}{\code{< /dev/null} is to get \code{stdin} from
#'           \code{/dev/null} which is nothing happen.}
#' \item{6)}{\code{&} is to put the batch command for the remoter R server
#'           in background.}
#' }
#'
#' \code{check_rr()} checks if there is a remote R server on a remote
#' server. Lunix/unix commands \code{ps} and \code{grep} are used.
#'
#' \code{kill_rr()} kills remote R servers if found.
#' Lunix/unix commands \code{ps}, \code{grep}, \code{awk}, and \code{kill}
#' are used.
#'
#' \code{checkx_rr()}, \code{killx_rr()}, and \code{startx_rr()} are functions
#' with virtual X11 windows.
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
#' check_rr(m)    # pid 2857 (may differ)
#' kill_rr(m)     # all remoter pids are killed
#' check_rr(m)    # make sure no remoter servers are running
#'
#' ### use "; " to bypass multiple commands
#' preload <- "source ~/work-my/00_set_devel_R; "
#'
#' ### start a new remoter server
#' start_rr(m, preload = preload)
#' check_rr(m)
#' kill_rr(m)
#'
#' ### Example: for module load on supercomputers
#' preload <- "module load r; "    # e.g. via module load r
#' start_rr(m, preload = preload)
#' check_rr(m)
#' kill_rr(m)
#' }
#'
#' 
#' @rdname rpc_rr_example
#' @name rpc_rr_example
NULL


#' @rdname rpc_rr_example
#' @export
check_rr <- function(machine, cmd = .pbd_env$RPC.RR$check)
{
  check.is.machine(machine)
  
  ret <- suppressWarnings(
    rpc(cmd = cmd, machine = machine)
  )
  
  invisible(ret)
}


#' @rdname rpc_rr_example
#' @export
checkx_rr <- function(machine, cmd = .pbd_env$RPC.RR$checkx)
{
  check.is.machine(machine)
  
  ret <- suppressWarnings(
    rpc(cmd = cmd, machine = machine)
  )
  
  invisible(ret)
}


#' @rdname rpc_rr_example
#' @export
kill_rr <- function(machine, cmd = .pbd_env$RPC.RR$kill)
{
  check.is.machine(machine)
  
  ret <- suppressWarnings(
    rpc(cmd = cmd, machine = machine)
  )
  
  invisible(ret)
}


#' @rdname rpc_rr_example
#' @export
killx_rr <- function(machine, cmd = .pbd_env$RPC.RR$killx)
{
  check.is.machine(machine)
  
  ret <- suppressWarnings(
    rpc(cmd = cmd, machine = machine)
  )
  
  invisible(ret)
}


#' @rdname rpc_rr_example
#' @export
start_rr <- function(machine, cmd = .pbd_env$RPC.RR$start,
    preload = .pbd_env$RPC.RR$preload)
{
  check.is.machine(machine)
  
  cmd.all <- paste0(preload, cmd)
  ret <- suppressWarnings(
    rpc(cmd = cmd.all, machine = machine)
  )
  
  invisible(ret)
}


#' @rdname rpc_rr_example
#' @export
startx_rr <- function(machine, cmd = .pbd_env$RPC.RR$startx,
    preload = .pbd_env$RPC.RR$preload)
{
  check.is.machine(machine)
  
  cmd.all <- paste0(preload, cmd)
  ret <- suppressWarnings(
    rpc(cmd = cmd.all, machine = machine)
  )
  
  invisible(ret)
}
