#' XJTLU html template
#'
#' @param template_name the template name.
#' @inheritParams rmarkdown::html_document
#' @param
#'   ..., toc, code_folding, number_sections
#'   Arguments passed to \code{rmarkdown::html_document()}.
#' @return An R Markdown output format.
#' @details adapted from \url{https://github.com/holtzy/epuRate}.
#' @export
html_template <- function(...,
                          template_name,
                          toc = TRUE,
                          code_folding = "hide",
                          number_sections = TRUE) {

  # get the locations of resource files located within the package
  css <- system.file("rmarkdown", "templates", template_name, "resources", "style.css", package = "xjtlu")
  template <- system.file("rmarkdown", "templates", template_name, "resources", "template.html", package = "xjtlu")

  # call the base html_document function
  # bookdown::html_document2(
  rmarkdown::html_document(
    ...,
    theme = "lumen",
    template = template,
    css = css,
    toc = toc,
    toc_float = TRUE,
    toc_depth = 2,
    number_sections= number_sections,
    df_print = "paged",
    code_folding = code_folding,
  )
}

#' @rdname html_template
#' @export
xjtlu_html_report <- function(...){
  html_template(template_name = "xjtlu_html_report", ...)
}
