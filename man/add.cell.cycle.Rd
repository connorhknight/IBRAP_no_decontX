% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/add.cell.cycle.R
\name{add.cell.cycle}
\alias{add.cell.cycle}
\title{Scores cell cycle phases}
\usage{
add.cell.cycle(object = obj, assay = 'RAW', slot = 'counts')
}
\arguments{
\item{object}{IBRAP S4 class object}

\item{assay}{A character string containing indicating which assay to use}

\item{slot}{String indicating which slot within the assay should be sourced}

\item{transform}{Boolean. If raw counts are supplied, this must be TRUE to normalise data}
}
\value{
IBRAP S4 class object containing cell cycle assignments and scores for each cell in the metadata
}
\description{
Scores each cell in which cell cycle stage it is currently in.
}
\examples{

object <- add.cell.cycle(object = object, 

}
