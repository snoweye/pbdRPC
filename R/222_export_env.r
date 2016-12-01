#' Sets of controls in pbdRPC.
#' 
#' These sets of controls are used to provide default values in this package.
#' 
#' The elements of \code{.pbd_env$RPC.CT} are default values for looking RPC
#' control files.
#' 
#' The elements of \code{.pbd_env$RPC.LI} are default values for RPC defult
#' login information.
#' 
#' @name RPC Control Environment
#' @aliases .pbd_env
#' @docType data
#' @format Objects contain several parameters for communicators and methods.
#' @author Wei-Chen Chen \email{wccsnow@@gmail.com}.
#' 
#' Programming with Big Data in R Website: \url{http://r-pbd.org/}
#' @keywords global variables
#' @seealso \code{\link{.rpcopt_init}()}.
#' @rdname a0_b_control
NULL

### These are fake. These only be here for reference and to fool
### ``R CMD check''.
### The real one ``in practicee and runtime'' is initialed by the
### .rpcopt_init() which is always called by .OnLoad() in "zzz.r" to avoid
### overloaded and can be really accessed by users instead of sealed by R
### after loaded.
###
### WCC: DO ``NOT'' remark ``NOR'' use the next.
# .pbd_env <- new.env()
# .pbd_env$RPC.CT <- RPC.CT()
# .pbd_env$RPC.LI <- RPC.LI()
# .pbd_env$RPC.RR <- RPC.RR()
# .pbd_env$RPC.CS <- RPC.CS()

