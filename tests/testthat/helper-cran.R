cran_limits_cores <- function() {
  value <- tolower(Sys.getenv("_R_CHECK_LIMIT_CORES_", unset = "false"))
  value %in% c("true", "1", "yes")
}

skip_if_cran_limits_cores <- function() {
  testthat::skip_if(
    cran_limits_cores(),
    "CRAN limits simultaneous parallel worker processes."
  )
}

skip_if_no_cvxr_conic_solver <- function() {
  testthat::skip_if_not_installed("CVXR")

  installed_solvers <- tryCatch(
    getExportedValue("CVXR", "installed_solvers")(),
    error = function(e) character()
  )
  installed_solvers <- toupper(as.character(installed_solvers))
  preferred <- c("CLARABEL", "ECOS", "SCS")

  testthat::skip_if(
    !any(preferred %in% installed_solvers),
    "CVXR has no non-MOSEK conic solver available."
  )
}
