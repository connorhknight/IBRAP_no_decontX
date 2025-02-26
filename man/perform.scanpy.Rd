% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/perform.scanpy.normalisation.R
\name{perform.scanpy}
\alias{perform.scanpy}
\title{Performs Scanpy normalisation, hvg selection, scaling and variance stabilisation and regression.}
\usage{
perform.scanpy(
  object,
  assay = "RAW",
  slot = "counts",
  new.assay.suffix = "",
  target_sum = 10000,
  exclude_highly_expressed = FALSE,
  max_fraction = 0.05,
  key_added = "scanpy_norm_factor",
  log1 = TRUE,
  n_top_genes = NULL,
  max_mean = 6,
  min_mean = 0.0125,
  min_disp = 0.5,
  span = 0.3,
  n_bins = 20,
  flavor = "seurat",
  batch_key = NULL,
  vars.to.regress = NULL
)
}
\arguments{
\item{object}{IBRAP S4 class object}

\item{assay}{Character. String containing indicating which assay to use}

\item{slot}{Character. String indicating which slot within the assay should be sourced}

\item{new.assay.suffix}{Character. What should be added as a suffix to 'SCANPY}

\item{target_sum}{Numerical. What should the data be scaled to. Default = 1e6}

\item{exclude_highly_expressed}{Boolean. Should highly expressed genes be excluded. Default = FALSE}

\item{max_fraction}{Numerical. If exclude_highly_expressed=True, consider cells as highly expressed that have more counts than max_fraction of the original total counts in at least one cell. Default = 0.05}

\item{key_added}{Character. What should the column name be that contains cell scaling factors. Default = 'scanpy_norm_factor'}

\item{n_top_genes}{Numerical. How many HVGs should be identified. Default = NULL}

\item{max_mean}{Numerical. If n_top_genes is NULL, this is the maximum mean to determine HVGs. Default = 6}

\item{min_mean}{Numerical. If n_top_genes is NULL, this is the minimum mean to determine HVGs. Default = 0.0125}

\item{min_disp}{Numerical. If n_top_genes is NULL, The minimum dispersion that should be presented in a gene for it to be considered highly varaible. Default = 0.5}

\item{span}{Numerical. The fraction of cells that should be subset for the LOESS fit model. Default = 0.3}

\item{n_bins}{Numerical. Number of bins to produce when determining HVGs}

\item{batch_key}{Character. Which column in the metadata identifies the batches of the cells. Default = NULL}

\item{vars.to.regress}{Character. A single or multiple columns of information in the metadata that should be regressed from the dataset. Default = NULL}

\item{flavour}{Character. Choosing which HVG selection method to use when, options: 'seurat', 'cell_ranger', 'seurat_v3'. Default = 'seurat'}
}
\value{
Produces a new 'methods' assay containing normalised, scaled and HVGs.
}
\description{
A new method-assay is produced. Raw counts are normalised and HVGs identified using Scanpy
}
\examples{

object <- perform.scanpy(object = object, 
                         vars.to.regress = 'RAW_total.counts')

}
