#' Search or kill possible pid's of Remote Procedure Call
#'
#' Search or kill possible pid's that running remote procedure calls
#' in background.
#'
#' @param pid
#' a vector containing proccess id's in interger.
#'
#' @details
#' \code{rpc_ps()} prints possible pid's that running remote procedure
#' calls in background via one of
#' \code{ssh}, \code{plink}, \code{plink.exe}, or \code{cmd.exe}.
#'
#' \code{rpc_kill()} kill pid's.
#'
#' @return
#' List or kill all possible pid's.
#'
#' @rdname rpc_pid
#' @name rpc_pid
NULL


#' @rdname rpc_pid
#' @export
rpc_ps <- function()
{
  if (.Platform$OS.type == "windows")
  {
    cmd <- 'Tasklist /FI "IMAGENAME eq plink.exe"'
    cat("cmd: ", cmd, "\n", sep = "")
    pid <- system(cmd, intern = TRUE)
    cat(pid, sep = "\n")
    cmd <- 'Tasklist /FI "IMAGENAME eq cmd.exe"'
    cat("cmd: ", cmd, "\n", sep = "")
    pid <- system(cmd, intern = TRUE)
    cat(pid, sep = "\n")
  }
  else
  {
    cmd <- '/bin/ps uxww'
    cat("cmd: ", cmd, "\n", sep = "")
    pid <- system(cmd, intern = TRUE)
    pid <- grep("(ssh|plink) ", pid, value = TRUE)
    cat(pid, sep = "\n")
  }

  return(invisible(pid))
}


#' @rdname rpc_pid
#' @export
rpc_kill <- function(pid)
{
  tools::pskill(pid)
}
