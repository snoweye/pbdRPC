#' Find plink
#'
#' Find the plink internal compiled with pbdRPC package.
#'
#' @details
#' The function returns a full path to the \code{plink} or \code{plink.exe}
#' command if found.
#'
#' @return
#' A full path a full path to the \code{plink} or \code{plink.exe}
#' command if found. Otherwise, "plink" is returned.
#'
#' @examples
#' \dontrun{
#' library(pbdRPC, quietly = TRUE)
#'
#' find_plink()
#' }
#'
#' @export
find_plink <- function()
{
  PACKAGE <- "pbdRPC"
  ret <- as.character(Sys.which("plink"))

  pkg.path <- find.package(PACKAGE, quiet = TRUE)[1]
  if (length(pkg.path) == 1)
  {
    if (.Platform$OS.type == "windows")
      fn <- paste(pkg.path, "/libs", Sys.getenv("R_ARCH"),
                  "/plink.exe", sep = "")
    else
      fn <- paste(pkg.path, "/libs", Sys.getenv("R_ARCH"), "/plink", sep = "")

    if (file.exists(fn))
      ret <- fn
  }

  if (ret == "")
  {
    message("Use `sudo apt-get install putty` to install a plink executable.") 
    stop("Neither system nor internal compiled plink(.exe) are found.")
  }

  return(ret)
}

