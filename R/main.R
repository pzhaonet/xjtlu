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
#' @param url The complete hyperlink of the webcam video. If NA, only merge the given videos.
#' @param camera_file The file name of the camera video.
#' @param desktop_file The file name of the desktop video.
#' @param merged_file The file name of the merged file. If Na, do not merge.
#' @param temp_file The file name of the temporary file.
#'
#' @return downloaded and/or merge video files
#' @export
#'
#' @examples
#' # download one
#' download_bbb("https://bbbload.xjtlu.edu.cn/presentation/4c0413f756243e7b71221b81e36488f80d15996c-1599613283607/video/webcams.webm")
#' # batch download
#' env203 <- function(video){
#'   paste0("https://bbbload.xjtlu.edu.cn/presentation/4c0413f756243e7b71221b81e36488f80d15996c-", video,"/video/webcams.webm")
#' }
#' urls <- env203(c("1599613283607", "1602031837942", "1600822173907", "1600217953595"))
#' for (i in 1:4) {
#'   download_bbb(urls[i],
#'                camera_file = paste0("cam", i, ".webm"),
#'                desktop_file = paste0("desk", i, ".webm"),
#'                temp_file = paste0("tmp", i, ".webm"),
#'                merged_file = paste0("bbb', i, '.webm"))
#' }
download_bbb <- function(url = NA,
                         camera_file = "webcams.webm",
                         desktop_file = "desktop.webm",
                         temp_file = "tmp.webm",
                         merged_file = NA){
  if (!is.na(url)){
    id <- gsub("^.+presentation/(.+)/video/webcams.webm", "\\1", url)
    url_desktop <- paste0("https://bbbload.xjtlu.edu.cn/presentation/", id, "/deskshare/deskshare.webm")

    message("Downloading the camera recoding...")
    download.file(url = url, destfile = camera_file, method = "curl")
    if (file.exists(camera_file)) message("Camera recoding downloaded!")

    message("Downloading the shared desktop...")
    download.file(url = url_desktop, destfile =  desktop_file, method = "curl")
    if (file.exists(desktop_file)) message("Share desktop downloaded!")
  }

  if (!is.na(merged_file)){
    message("Merging videos...")
    system(paste0('ffmpeg -i ', desktop_file, ' -vf "movie=', camera_file,', scale=300:-1 [inner]; [in][inner] overlay=1000:500 [out]" ', temp_file))
    system(paste0('ffmpeg -i ', temp_file,' -i ', camera_file, ' -c copy ', merged_file))
    if (file.exists(merged_file)) {
      message("Videos merged!")
      file.remove(temp_file)
    }
  }
  message("Mission accomplished!")
}
