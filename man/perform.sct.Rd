% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/perform.sct.normalisation.R
\name{perform.sct}
\alias{perform.sct}
\title{Performs SCTransform}
\usage{
perform.sct(object, assay, slot, new.assay.suffix = "", ...)
}
\arguments{
\item{object}{IBRAP S4 class object}

\item{assay}{A character string containing indicating which assay to use}

\item{slot}{String indicating which slot within the assay should be sourced}

\item{new.assay.suffix}{Character. What should be added as a suffix for SCT}

\item{do.scale}{Whether to scale residuals to have unit variance; default is FALSE}

\item{do.center}{Whether to center residuals to have mean zero; default is TRUE}

\item{vars.to.regress}{Character. Which data from `object@sample_metadata` should be regressed from the dataset.}

\item{n.genes}{Numerical value of how many highly variable genes should be retained. Default = 1500}

\item{min_cells}{Numerical value of minimum cells required for a gene to not be filtered. Default = 3}
}
\value{
Produces a new 'methods' assay containing normalised, scaled and HVGs.
}
\description{
Performs SCTransform normalisation, hvg selection, scaling and variance stabilisation and regression.
}
\examples{

object <- perform.sct(object = object, 
                      assay = 'RAW', 
                      slot = 'counts')

}
