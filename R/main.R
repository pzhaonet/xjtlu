#' Get the full name of an abbreviation
#'
#' @param x short name
#'
#' @return full name
#' @export
#'
#' @examples get_fullname()
get_fullname <- function(x = c("XJTLU", "AMO")){
  y <- xjtlu::abbreviation[match(x, abbreviation$short), ]
  cat(apply(y, 1, paste, collapse = ": "), sep = "\n")
}

#' Plot a campus map of XJTLU
#'
#' @return a map
#' @export
#'
#' @examples get_map()
get_map <- function(){
  leaflet::setView(leaflet::addAwesomeMarkers(leaflet::addTiles(leaflet::leaflet()), 120.734, 31.275),120.735, 31.273, zoom = 15.4)
}
