### Modified from Rserve/src/install.libs.R
### For plink
files <- c("plink", "plink.exe")
files <- files[file.exists(files)]
if(length(files) > 0){
  libsarch <- if (nzchar(R_ARCH)) paste("libs", R_ARCH, sep='') else "libs"
  dest <- file.path(R_PACKAGE_DIR, libsarch)
  dir.create(dest, recursive = TRUE, showWarnings = FALSE)
  file.copy(files, dest, overwrite = TRUE, recursive = TRUE)

}

# if(.Platform$OS.type == "windows" && R_ARCH == "/x64"){
#   files <- "../src-i386/plink.exe"
#   libsarch <- if (nzchar(R_ARCH)) paste("libs", R_ARCH, sep='') else "libs"
#   dest <- file.path(R_PACKAGE_DIR, libsarch)
#   dir.create(dest, recursive = TRUE, showWarnings = FALSE)
#   file.copy(files, dest, overwrite = TRUE, recursive = TRUE)
# }
