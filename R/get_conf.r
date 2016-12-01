get.conf <- function(arg){
  if(arg == "SYS_NAME"){
    cat(Sys.info()['sysname'])
  } else if(arg == "OS_TYPE"){
    cat(.Platform$OS.type)
  } else{
    stop(paste0("The arg (", arg, ") is not implemented."))
  }
  invisible()
}
