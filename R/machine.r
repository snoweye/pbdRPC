#' machine
#' 
#' Remote machine configuration settings. 
#' 
#' @param exec.type
#' either "ssh" or "plink" in character. Windows will force to use "plink".
#' @param args
#' further arguments to "ssh" or "plink" for connecting to the server
#' in addition to port, user id, and host name.
#' @param pport
#' ssh port opened on the server.
#' @param user
#' user id for logging to the server.  If none is supplied, then the system user
#' name will be used instead.
#' @param hostname
#' the server ip or host name.
#' @param priv.key,priv.key.ppk
#' location of the private key for user authentication, the file will be
#' checked first then \code{-i priv.key} will be added to \code{args}
#' when the file exists.
#' \code{priv.key.ppk} is only used when \code{plink} is called.
#' 
#' @return
#' An object of class \code{machine}.
#' 
#' @examples
#' \dontrun{
#' # note: not my actual aws url
#' myaws <- machine("ec2-1-2-3-4.compute-1.amazonaws.com", user="my_aws_username")
#' 
#' # if you don't specify 'user', we use your host machine's user name
#' myvm <- machine("192.168.1.10")
#' }
#' 
#' @name machine
#' @export
machine <- function(hostname, user, exec.type = .pbd_env$RPC.LI$exec.type,
  args = .pbd_env$RPC.LI$args, pport = .pbd_env$RPC.LI$pport,
  priv.key = .pbd_env$RPC.LI$priv.key,
  priv.key.ppk = .pbd_env$RPC.LI$priv.key.ppk)
{
  if (missing(user))
  {
    if (.Platform$OS.type == "windows")
      user <- shell("echo %username%", intern=TRUE)
    else
      user <- system("whoami", intern=TRUE)
    warning("No user name supplied; using system user name...")
  }
  
  if (missing(hostname))
    stop("You must supply a host name or ip in machine() call; i.e. what do you want to connect to?")
  
  check.is.string(hostname)
  check.is.string(user)
  check.is.string(exec.type)
  check.is.string(args)
  check.is.posint(pport)
  check.is.string(priv.key)
  check.is.string(priv.key.ppk)
  
  if (.Platform$OS.type == "windows")
    exec.type <- "plink"
  if (exec.type != "ssh" && exec.type != "plink")
    stop(paste0("exec.type (", exec.type, ") is not found."))
  
  m <- list(hostname=hostname, user=user, exec.type=exec.type, args=args,
    pport=pport, priv.key=priv.key, priv.key.ppk=priv.key.ppk)
  class(m) <- "machine"
  
  return(m)
}

check.is.machine <- function(machine)
{
  # the error message isn't super informative, but the individual argument
  # checks can only fail if they go meddling with an object after creation
  # via machine(), and such people get what they deserve
  errmsg <- "argument 'machine' seemingly not generated via call to machine()"
  
  if (!inherits(machine, "machine"))
    stop(errmsg)
  
  check.is.string(machine$hostname, msg=errmsg)
  check.is.string(machine$user, msg=errmsg)
  check.is.string(machine$exec.type, msg=errmsg)
  check.is.string(machine$args, msg=errmsg)
  check.is.posint(machine$pport, msg=errmsg)
  check.is.string(machine$priv.key, msg=errmsg)
  check.is.string(machine$priv.key.ppk, msg=errmsg)
  
  if (machine$exec.type != "ssh" && machine$exec.type != "plink")
    stop(errmsg)
  
  invisible(TRUE)
}



#' @title print-machine
#' @description Printing for machine class objects.
#' @param x machine class object
#' @param ... ignored
#' @rdname print-machine
#' @name print-machine
#' @method print machine
#' @export
print.machine <- function(x, ...)
{
  cat(paste0("Machine config for ", x$user, "@", x$hostname, "\n"))
  cat(paste0("    pport = ", x$pport, "\n"))
  cat(paste0("    type = ", x$exec.type, "\n"))
  cat(paste0("    args = \"", x$args, "\"\n"))
  cat(paste0("    priv.key = ", x$priv.key, "\n"))
  cat(paste0("    priv.key.ppk = ", x$priv.key.ppk, "\n"))
}
