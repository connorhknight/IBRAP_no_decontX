#' @name plot.reduced.dim
#' @aliases plot.reduced.dim.
#' 
#' @title Plot of reduced dimensions and labels
#'
#' @param object An IBRAP S4 class object
#' @param reduction Character. Which reduction to use to display points
#' @param assay Character. Which assay within the object to access
#' @param clust.method Character. Which clustering method to access, supply the name of any dataframe contained in the cluster_assignments sections. If you wish to access metadata, just specify 'metadata'
#' @param column Character. Which column to access within the supplied clust.column
#' @param pt.size Numeric. What should the point size be
#' @param cells Numeric. Which cells should be subset for plotting, Default = NULL
#' 
#' @return A plot of reduced dimensions annotated with assignments
#'
#' @export plot.reduced.dim

plot.reduced.dim <- function(object,
                             reduction,
                             assay,
                             clust.method,
                             column,
                             pt.size=0.5, 
                             add.label = TRUE,
                             cells = NULL) {
  
  if(!is(object = object, class2 = 'IBRAP')) {
    
    stop('object must be of class IBRAP\n')
    
  }
  
  if(!is.character(reduction)) {
    
    stop('reduction must be character string\n')
    
  }
  
  if(!assay %in% names(object@methods)) {
    
    stop('assay does not exist\n')
    
  }
  
  if(!reduction %in% names(c(object@methods[[assay]]@computational_reductions, 
                             object@methods[[assay]]@visualisation_reductions, 
                             object@methods[[assay]]@integration_reductions))) {
    
    stop('reduction does not exist\n')
    
  }
  
  if(!is.character(clust.method)) {
    
    stop('clust.method must be character string\n')
    
  }
  
  if(!clust.method %in% names(object@methods[[assay]]@cluster_assignments)) {
    
    if(!clust.method == 'metadata') {
      
      stop('clust.method does not exist\n')
      
    }
    
  }
  
  if(!is.character(column)) {
    
    stop('column must be character string\n')
    
  }
  
  if(!column %in% colnames(object@methods[[assay]]@cluster_assignments[[clust.method]])) {
    
    if(!column %in% colnames(object@sample_metadata)) {
      
      stop('column:', column, ', does not exist in clust.method: ', clust.method, '\n')
      
    }
    
  }
  
  if(!is.numeric(pt.size)) {
    
    stop('pt.size must be numerical\n')
    
  }
  
  reduction.list <- list()
  red.names <- c(names(object@methods[[assay]]@computational_reductions), 
                 names(object@methods[[assay]]@integration_reductions),
                 names(object@methods[[assay]]@visualisation_reductions))
  
  for(i in red.names) {
    
    if(i %in% names(object@methods[[assay]]@computational_reductions)) {
      
      reduction.list[[i]] <- object@methods[[assay]]@computational_reductions[[i]]
      
    }
    
    if(i %in% names(object@methods[[assay]]@integration_reductions)) {
      
      reduction.list[[i]] <- object@methods[[assay]]@integration_reductions[[i]]
      
    }
    
    if(i %in% names(object@methods[[assay]]@visualisation_reductions)) {
      
      reduction.list[[i]] <- object@methods[[assay]]@visualisation_reductions[[i]]
      
    }
    
  }
  
  if(clust.method == 'metadata') {
    
    project.met <- object@sample_metadata
    
    results <- as.data.frame(reduction.list[[reduction]])
    
    results <- results[,1:2]
    
    orig.names <- colnames(results)
    
    results <- cbind(results, project.met[,column])
    
    colnames(results) <- c(orig.names, 'variable')
    
    rownames(results) <- colnames(object)
    
    if(!is.null(cells)) {
      
      results <- results[cells,]
      
    }
    
  } else {
    
    results <- as.data.frame(reduction.list[[reduction]])
    
    assay.met <- object@methods[[assay]]@cluster_assignments[[clust.method]]

    assay.met <- assay.met[match(rownames(results), rownames(assay.met)),]
    
    orig.names <- colnames(results)
    
    results <- cbind(results, assay.met[,column])

    colnames(results) <- c(orig.names, 'variable')
    
    rownames(results) <- colnames(object)

    if(!is.null(cells)) {
      
      results <- results[cells,]
      
    }
    
  }
  
  if(isTRUE(add.label)) {
    
    clust_centres <- data.frame(clusters = unique(results$variable))
    
    centre_1 <- list()
    centre_2 <- list()
    
    count <- 1
    
    for(x in unique(results$variable)) {
      
      centre_1[[count]] <- mean(results[results[,'variable'] == x,][,orig.names[1]])
      centre_2[[count]] <- mean(results[results[,'variable'] == x,][,orig.names[2]])
      
      count <- count + 1
      
    }
    
    clust_centres[,orig.names[1]] <- unlist(centre_1)
    clust_centres[,orig.names[2]] <- unlist(centre_2)
    clust_centres$variable <- unique(results$variable)
    
  }
  

  
  p <- ggplot2::ggplot(data = results, 
                       mapping = ggplot2::aes_string(x = colnames(results)[1], 
                                                     y = colnames(results)[2], 
                                                     col = colnames(results)[3])) +
    ggplot2::geom_point(size = pt.size) + 
    ggplot2::scale_color_manual(values = colorspace::qualitative_hcl(n = length(unique(results[,3])), palette = 'Dark 3')) + 
    ggplot2::theme_classic() + 
    ggplot2::theme(legend.title.align=0.5) + 
    ggplot2::guides(colour = ggplot2::guide_legend(override.aes = list(size=2)))
  
  if(isTRUE(add.label)) {

    p <- p + 
      ggrepel::geom_label_repel(data = clust_centres, mapping = 
                                  ggplot2::aes_string(x = colnames(results)[1], 
                                                      y = colnames(results)[2], 
                                                      label = 'variable'), 
                                color = 'black', label.size = NA, fill = NA) + 
      
      ggplot2::theme(legend.position = "none")
    
  }
  
  return(p)
  
}
  