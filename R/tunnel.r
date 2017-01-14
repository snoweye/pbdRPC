#' tunnel
#' 
#' @param hostname
#' the server ip or host name.
#' @param lport,rport
#' local and remote ports.
#' @param lhostname
#' the local ip or host name.
#' @param pport,user,priv.key,priv.key.ppk,intern,wait
#' See \code{?pbdRPC::srpc}.
#' 
#' @export
tunnel <- function(pport = .pbd_env$RPC.LI$pport, user = .pbd_env$RPC.LI$user, 
    hostname = .pbd_env$RPC.LI$hostname, priv.key = .pbd_env$RPC.LI$priv.key, 
    priv.key.ppk = .pbd_env$RPC.LI$priv.key.ppk,
    intern = .pbd_env$RPC.CT$intern, 
    wait = .pbd_env$RPC.CT$wait, lport = 55555, rport = 55555,
    lhostname = "127.0.0.1")
{
  args <- paste0("-N -T -L ", lport, ":", lhostname, ":", rport)
  ret <- srpc(cmd="", args=args, pport=pport, user=user, hostname=hostname,
              priv.key=priv.key, priv.key.ppk=priv.key.ppk,
              intern=intern, wait=wait)
  invisible(ret)
}

