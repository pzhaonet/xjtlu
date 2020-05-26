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
#' @param english logical. Display English on the map.
#'
#' @return a map
#' @export
#'
#' @examples
#' get_map()
#' get_map(english = TRUE)
get_map <- function(english = FALSE){
  icon.fa <- leaflet::makeAwesomeIcon(icon = 'flag', markerColor = 'red', library='fa', iconColor = 'black')
  if(english){
    long <- 120.734
    lat <- 31.275
    link <- "https://{s}.tile.openstreetmap.de/tiles/osmde/{z}/{x}/{y}.png"
    # see http://leaflet-extras.github.io/leaflet-providers/preview/
    leaflet::setView(
      leaflet::addAwesomeMarkers(
        leaflet::addTiles(urlTemplate = link,
                          leaflet::leaflet()),
        long, lat, icon = icon.fa),
      long, lat - 0.0015, zoom = 16)
  } else{
    long <- 120.7385
    lat <- 31.273
    leafletCN::amap(
      leaflet::setView(
        leaflet::addAwesomeMarkers(
            leaflet::leaflet(),
          long, lat, icon = icon.fa),
        long, lat - 0.0015, zoom = 16)
    )
  }
}
