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

#' Download video recordings from BBB
#'
#' @param url The complete hyperlink of the webcam video. If NA, only merge the given videos.
#' @param webcams_file The file name of the camera video.
#' @param deskshare_file The file name of the desktop video.
#' @param merged_file The file name of the merged file. If Na, do not merge.
#' @param tmp_file The file name of the temporary file.
#'
#' @return downloaded and/or merge video files
#' @export
#'
#' @examples
#' # download one
#' download_bbb("https://bbbload.xjtlu.edu.cn/presentation/4c0413f756243e7b71221b81e36488f80d15996c-1599613283607/video/webcams.webm")
#'
#' # batch download and merge
#' urls <- c("https://bbbload.xjtlu.edu.cn/presentation/4c0413f756243e7b71221b81e36488f80d15996c-1599613283607/video/webcams.webm",
#'           "https://bbbload.xjtlu.edu.cn/presentation/4c0413f756243e7b71221b81e36488f80d15996c-1602031837942/video/webcams.webm",
#'           "https://bbbload.xjtlu.edu.cn/presentation/4c0413f756243e7b71221b81e36488f80d15996c-1600217953595/video/webcams.webm")
#' for (i in 1:3) {
#'   download_bbb(
#'     urls[i],
#'     webcams_file = paste0("cam_chapter_", i, ".webm"),
#'     deskshare_file = paste0("desk_chapter_", i, ".webm"),
#'     tmp_file = paste0("tmp_chapter_", i, ".webm"),
#'     merged_file = paste0("bbb_chapter_", i, ".webm")
#'   )
#' }
download_bbb <- function(url = NA,
                         webcams_file = "webcams.webm",
                         deskshare_file = "deskshare.webm",
                         tmp_file = "tmp.webm",
                         merged_file = NA){
  report <- data.frame()
  if (!is.na(url)){
    if (grepl("/", id)) id <- gsub(".+[=/]([a-z0-9]+-[a-z0-9]+).*", "\\1", id)
    url_webcams <- paste0("https://bbbload.xjtlu.edu.cn/presentation/", id, "/video/webcams.webm")
    url_desktop <- paste0("https://bbbload.xjtlu.edu.cn/presentation/", id, "/deskshare/deskshare.webm")

    start_time <- Sys.time()
    message(start_time, ": Downloading the camera recording ", id, "...")
    download.file(url = url_webcams, destfile = webcams_file, method = "curl")
    end_time <- Sys.time()
    if (file.exists(webcams_file)) message(end_time, ": Camera recording downloaded! ", id)
    report <- rbind(report, c(webcams_file, as.character(start_time), as.character(end_time), round(difftime(end_time, start_time, units = "min"), 1)))

    start_time <- Sys.time()
    message(start_time, ": Downloading the shared desktop ", id, "...")
    download.file(url = url_desktop, destfile =  deskshare_file, method = "curl")
    end_time <- Sys.time()
    if (file.exists(deskshare_file)) message(end_time, ": Shared desktop downloaded! ", id)
    report <- rbind(report, c(deskshare_file, as.character(start_time), as.character(end_time), round(difftime(end_time, start_time, units = "min"), 1)))
  }

  if (!is.na(merged_file)){
    start_time <- Sys.time()
    message(start_time, ": Merging videos ", ifelse(is.na(url), NULL, id), "...")

    system(paste0('ffmpeg -i ', deskshare_file, ' -vf "movie=', webcams_file,', scale=300:-1 [inner]; [in][inner] overlay=1000:500 [out]" ', tmp_file))
    system(paste0('ffmpeg -i ', tmp_file,' -i ', webcams_file, ' -c copy ', merged_file))
    end_time <- Sys.time()
    if (file.exists(merged_file)) {
      message(Sys.time(), ": Videos merged!", ifelse(is.na(url), NULL, id))
      file.remove(tmp_file)
      report <- rbind(report, c(merged_file, as.character(start_time), as.character(end_time), round(difftime(end_time, start_time, units = "min"), 1)))
    }
  }
  message(Sys.time(), ": Mission accomplished!")
  if (nrow(report) > 0) {
    names(report) <- c("Mission", "Start", "End", "Elapse (min)")
    print(report)
  }
}
