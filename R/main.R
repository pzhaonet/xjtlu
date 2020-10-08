#' Get the full name of an abbreviation
#'
#' @param x short name
#'
#' @return full name
#' @export
#'
#' @examples get_fullname(c("XJTLU", "HoD", "ENV"))
get_fullname <- function(x = ""){
  if(x == "") xjtlu::abbreviation
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

# 4c0413f756243e7b71221b81e36488f80d15996c-1602031837942
#' Download video recodings from BBB
#'
#' @param destfolder destination folder
#' @param url complete of the hyperlink of the webcam video
#' @param if_merge whether merge.
#'
#' @return downloaded video files
#' @export
#'
#' @examples
#' download_bbb("https://bbbload.xjtlu.edu.cn/presentation/4c0413f756243e7b71221b81e36488f80d15996c-1599613283607/video/webcams.webm")
download_bbb <- function(url, destfolder = ".", if_merge = FALSE){
  id <- gsub("^.+presentation/(.+)/video/webcams.webm", "\\1", url)
  url_desktop <- paste0("https://bbbload.xjtlu.edu.cn/presentation/", id, "/deskshare/deskshare.webm")

  message("Downloading the camera recoding...")
  download.file(url = url, destfile =  file.path(destfolder, "webcams.webm"), method = "curl")
  if (file.exists(file.path(destfolder, "webcams.webm"))) message("Camera recoding downloaded!")

  message("Downloading the shared desktop...")
  download.file(url = url_desktop, destfile =  file.path(destfolder, "desktop.webm"), method = "curl")
  if (file.exists(file.path(destfolder, "desktop.webm"))) message("Share desktop downloaded!")

  if (if_merge){
    message("Merging videos...")
    system('ffmpeg -i desktop.webm -vf "movie=webcams.webm, scale=300:-1 [inner]; [in][inner] overlay=1000:500 [out]" tmp.webm')
    system('ffmpeg -i tmp.webm -i webcams.webm -c copy bbb.webm')
    if (file.exists(file.path(destfolder, "bbb.webm"))) {
      message("Videos merged!")
      file.remove("tmp.webm")
    }
  }
  message("Mission accomplished!")
}
