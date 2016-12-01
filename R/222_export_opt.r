#' Initial controls in pbdRPC
#' 
#' Initial control functions
#' 
#' \code{.rpcopt_init()} initials default RPC controls.
#' 
#' @param envir 
#' an environment where RPC controls locate
#' 
#' @return 
#' \code{.rpcopt_init()} initial the RPC control
#' at \code{envir}.
#' 
#' @author Wei-Chen Chen \email{wccsnow@@gmail.com}.
#' 
#' @references ZeroMQ/4.1.0 API Reference:
#' \url{http://api.zeromq.org/4-1:_start}
#' 
#' Programming with Big Data in R Website: \url{http://r-pbd.org/}
#' 
#' @examples
#' \dontrun{
#' library(pbdRPC, quietly = TRUE)
#' rpcopt_set(user = "snoweye", hostname = "192.168.56.101")
#' 
#' ls(.pbd_env)
#' rm(.pbd_env)
#' .rpcopt_init()
#' ls(.pbd_env)
#'
#' .pbd_env$RPC.LI
#' }
#' 
#' @keywords programming
#' @seealso \code{.pbd_env}.
#' @rdname a0_c_options
#' @name Initial Control Functions


### Initial RPC options.
#' @export
#' @rdname a0_c_options
.rpcopt_init <- function(envir = .GlobalEnv){
  if(!exists(".pbd_env", envir = envir)){
    envir$.pbd_env <- new.env()
  } 
  envir$.pbd_env$RPC.CT <- RPC.CT()
  envir$.pbd_env$RPC.LI <- RPC.LI()
  # envir$.pbd_env$RPC.SO <- RPC.SO()
  envir$.pbd_env$RPC.RR <- RPC.RR()
  envir$.pbd_env$RPC.CS <- RPC.CS()

  invisible()
} # End of .rpcopt_init().

