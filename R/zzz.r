.onLoad <- function(libname, pkgname){
  ### Preload to global environment.
  invisible(eval(parse(text = "pbdRPC:::.rpcopt_init()")))

  invisible()
} # End of .onLoad().

.onUnload <- function(libpath){
  invisible()
} # End of .onUnload().

.onAttach <- function(libname, pkgname){
  invisible()
} # End of .onAttach().

