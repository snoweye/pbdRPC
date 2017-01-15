#' tunnel
#' 
#' @param hostname
#' the server ip or host name.
#' @param lport,rport
#' local and remote ports.
#' @param rhostname
#' the local ip or host name.
#' @param pport,user,priv.key,priv.key.ppk
#' See \code{?pbdRPC::srpc}.
#' 
#' @export
tunnel <- function(pport = .pbd_env$RPC.LI$pport, user = .pbd_env$RPC.LI$user, 
    hostname = .pbd_env$RPC.LI$hostname, priv.key = .pbd_env$RPC.LI$priv.key, 
    priv.key.ppk = .pbd_env$RPC.LI$priv.key.ppk,
    lport = 55555, rport = 55555,
    rhostname = "127.0.0.1")
{
  args <- paste0("-N -T -L ", lport, ":", rhostname, ":", rport)
  ret <- srpc(cmd="", args=args, pport=pport, user=user, hostname=hostname,
              priv.key=priv.key, priv.key.ppk=priv.key.ppk,
              intern=FALSE, wait=FALSE)
  invisible(ret)
}

