#' Set and Get Options for Remote Procedure Call
#'
#' Set and get default options of login information for \code{rpc()}.
#'
#' @details
#' \code{rpcopt_set()} is to alter default options of login information. 
#' The user defined options are set to \code{.pbd_env$RPC.LI}.
#' \code{rpcopt_get()} is to get default options of login information
#' from \code{.pbd_env$RPC.LI}.
#'
#' @param user
#' user id for logging to the server.
#' @param hostname
#' the server ip or host name.
#' @param pport
#' ssh port opened on the server.
#' @param exec.type
#' either "ssh" or "plink".
#' @param args
#' arguments to the \code{ssh} or \code{plink.exe}.
#' @param priv.key
#' file name/path to the private key in OpenSSH format.
#' @param priv.key.ppk
#' file name/path to the private key in PuTTY format.
#'
#' @return
#' A list is returned.
#'
#' @seealso \code{\link{rpc}()}.
#'
#' @examples
#' \dontrun{
#' library(pbdRPC, quietly = TRUE)
#' rpcopt_set(user = "snoweye", hostname = "192.168.56.101")
#'
#' rpcopt_get()
#' }
#'
#' @rdname rpc_options
#' @name rpc_options
NULL


### Default functions
#' @rdname rpc_options
#' @export
rpcopt_set <- function(user = NULL, hostname = NULL, pport = NULL,
    exec.type = NULL, args = NULL, priv.key = NULL, priv.key.ppk = NULL)
{
  if (!is.null(user))
    .pbd_env$RPC.LI$user <- user
  if (!is.null(hostname))
    .pbd_env$RPC.LI$hostname <- hostname
  if (!is.null(pport))
    .pbd_env$RPC.LI$pport <- pport
  if (!is.null(exec.type))
    .pbd_env$RPC.LI$exec.type <- exec.type
  if (!is.null(args))
    .pbd_env$RPC.LI$args <- args
  if (!is.null(priv.key))
    .pbd_env$RPC.LI$priv.key <- priv.key
  if (!is.null(priv.key.ppk))
    .pbd_env$RPC.LI$priv.key.ppk <- priv.key.ppk

  return(invisible(.pbd_env$RPC.LI))
}


### Default functions
#' @rdname rpc_options
#' @export
rpcopt_get <- function()
{
  return(.pbd_env$RPC.LI)
}

