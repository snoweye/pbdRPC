is.badval <- function(x)
{
	is.na(x) || is.nan(x) || is.infinite(x)
}

is.inty <- function(x)
{
	abs(x - round(x)) < 1e-10
}

is.zero <- function(x)
{
	abs(x) < 1e-10
}

is.negative <- function(x)
{
	x < 0
}

is.annoying <- function(x)
{
	length(x) != 1 || is.badval(x)
}

is.string <- function(x)
{
	if (!is.character(x) || is.annoying(x))
		FALSE
	else
		TRUE
}



check.is.string <- function(x, msg=NULL)
{
	if (!is.string(x))
	{
		if (is.null(msg))
		{
			nm <- deparse(substitute(x))
			stop(paste0("argument '", nm, "' must be a single string"), call.=FALSE)
		}
		else
			stop(msg, call.=FALSE)
	}
	
	invisible(TRUE)
}

check.is.posint <- function(x, msg=NULL)
{
	if (!is.numeric(x) || is.annoying(x) || !is.inty(x) || is.negative(x) || is.zero(x))
	{
		if (is.null(msg))
		{
			nm <- deparse(substitute(x))
			stop(paste0("argument '", nm, "' must be a positive integer"), call.=FALSE)
		}
		else
			stop(msg, call.=FALSE)
	}
	
	invisible(TRUE)
}

check.is.flag <- function(x, msg=NULL)
{
	if (!is.logical(x) || is.annoying(x))
	{
		if (is.null(msg))
		{
			nm <- deparse(substitute(x))
			stop(paste0("argument '", nm, "' must be TRUE or FALSE"), call.=FALSE)
		}
		else
			stop(msg, call.=FALSE)
	}
	
	invisible(TRUE)
}
