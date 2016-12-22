#' ssh and plink
#'
#' Commend line tools including \code{ssh} for Linux, Mac OSX, Solaris,
#' or \code{plink} for Windows.
#'
#' @details
#' These functions only execute option/command on remote servers via secure
#' client commands.
#'
#' NO further input from \code{stdin} is expected.
#' Outputs or errors may not be captured by R.
#'
#' \code{ssh()} starts a ssh command.
#'
#' \code{plink()} starts a plink command used by default for Windows.
#'
#' \code{check_exec()} runs a quick check on the exec (either ssh or plink)
#' for rpc.
#'
#' \code{run_args()} runs a rpc via either \code{ssh} or \code{plink}.
#'
#' @param args
#' All in text/characters that are passed to the command line.
#' @param use.shell.exec
#' if \code{shell.exec()} is used to execute the \code{plink} command in
#' windows. No returns can be captured by R when this is \code{TRUE} as
#' the default, because the authentication may not be generally
#' available in most windows system. No easy yet secure way to by passing
#' the password from R to external calls in shell.
#' @param pause
#' if pause when \code{shell.exec} is used in Windows.
#' @param exec
#' either \code{ssh} (i.e. \code{/usr/bin/ssh}) or a ``full path''
#' to \code{plink}.
#' @param intern,wait
#' arguments passed to \code{system()} or \code{shell()}
#' whereever they are applicable.
#'
#' @return
#' Mainly the message received at the command line will be returned.
#'
#' @examples
#' \dontrun{
#' library(pbdRPC, quietly = TRUE)
#' rpcopt_set(user = "snoweye", hostname = "192.168.56.101")
#'
#' ### Check an R session.
#' cmd <- "Rscript -e 'sessionInfo()'"
#'
#' ### For Linux, Mac OSX, Solaris.
#' rpc(cmd = cmd, exec.type = "ssh")
#'
#' ### For Windows.
#' rpc(cmd = cmd, exec.type = "plink")
#'
#' ### Manually
#' args <- "snoweye@192.168.56.101 Rscript -e 'sessionInfo()'"
#' ssh(args)      # Note ssh uses "-p" for server port.
#' plink(args)    # Note plink uses "-P" for server port.
#'
#' ### Manually launch a remoter server at background.
#' user.hostname <- "snoweye@192.168.56.101"
#' preload <- "source ./work-my/00_devel_R"
#' rr <- "nohup Rscript -e 'remoter::server()' > .rrlog 2>&1 < /dev/null &"
#' args <- paste(user.hostname, " \"", preload, "; ", rr, "\"", sep = "")
#' plink(args)
#' }
#'
#' @rdname ssh_plink
#' @name ssh_plink
NULL


#' @rdname ssh_plink
#' @export
ssh <- function(args = "snoweye@192.168.56.101 whoami",
    intern = .pbd_env$RPC.CT$intern, wait = .pbd_env$RPC.CT$wait)
{
  tmp.exec <- "ssh"
  if(.pbd_env$RPC.CT$check.exec)
    check_exec(tmp.exec)
  run_args(exec = tmp.exec, args = args,
           intern = intern, wait = wait)
}


#' @rdname ssh_plink
#' @export
plink <- function(args = "snoweye@192.168.56.101 whoami",
    use.shell.exec = .pbd_env$RPC.CT$use.shell.exec,
    pause = .pbd_env$RPC.CT$pause,
    intern = .pbd_env$RPC.CT$intern, wait = .pbd_env$RPC.CT$wait)
{
  tmp.exec <- find_plink()
  if(.pbd_env$RPC.CT$check.exec)
    check_exec(tmp.exec)
  run_args(exec = tmp.exec, args = args,
           use.shell.exec = use.shell.exec, pause = pause,
           intern = intern, wait = wait)
}


#' @rdname ssh_plink
#' @export
check_exec <- function(exec)
{
  ### Double check if exec is doable.
  if (.Platform$OS.type == "windows")
  {
    check.exec <- try(suppressWarnings(
                        system(paste0(exec, " -V"),
                               intern = TRUE, wait = FALSE,
                               show.output.on.console = FALSE)
                      ), silent = TRUE)
  }
  else
  {
    check.exec <- try(suppressWarnings(
                        system(paste0(exec, " -V"),
                               intern = TRUE, wait = FALSE)
                      ), silent = TRUE)
  }

  if (class(check.exec) == "try-error")
    stop(paste0("exec (", exec, ") is not found."))

  invisible()
}


#' @rdname ssh_plink
#' @export
run_args <- function(exec = "ssh", args = "",
    use.shell.exec = .pbd_env$RPC.CT$use.shell.exec,
    pause = .pbd_env$RPC.CT$pause,
    intern = .pbd_env$RPC.CT$intern, wait = .pbd_env$RPC.CT$wait)
{
  ### Assemble cmd.
  cmd <- paste(exec, args, sep = " ")
  if (.pbd_env$RPC.CT$verbose)
    cat(cmd, "\n", sep = "")

  ### Execute the cmd from system or shell.
  if (.Platform$OS.type == "windows")
  {
    if (use.shell.exec)
    {
      cmd.fn <- tempfile(fileext = ".bat")

      if (pause)
        cat(cmd, "pause", file = cmd.fn, sep = "\n")
      else
        cat(cmd, file = cmd.fn, sep = "\n")

      ret <- shell.exec(cmd.fn)
      return(invisible(ret))
    }
    else
    {
      ret <- try(system(cmd, intern = intern, wait = wait),
                 silent = TRUE)
      if (intern)
        return(ret)
      else
        return(invisible(ret))
    }
  }
  else
  {
    ret <- try(system(cmd, intern = intern, wait = wait),
               silent = TRUE)
    if (intern)
      return(ret)
    else
      return(invisible(ret))
  }
}

