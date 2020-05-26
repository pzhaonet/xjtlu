xjtlu: An R Package for Xi’an Jiaotong-Liverpool University
================
2020-05-26

# Installation

``` r
remotes::install_github("pzhaonet/xjtlu")
remotes::install_github("pzhaonet/drposter")
install.packages("xaringan")
```

# Load

``` r
require("xjtlu")
```

# Functions

## Get full name of an abbreviation

``` r
get_fullname("XJTLU")
```

    ## XJTLU: Xi'an Jiaotong-Liverpool University

``` r
get_fullname(c("XJTLU", "ENV", "HoD"))
```

    ## XJTLU: Xi'an Jiaotong-Liverpool University
    ## ENV: Department of Environmental Science
    ## HoD: Head of Department

## Plot a campus map of XJTLU

``` r
# in Chinese
get_map()
```

<img src="https://pzhaonet.github.io/xjtlu/docs/image/map-1.png" width="60%" />

``` r
# in English
get_map(english = TRUE)
```

<img src="https://pzhaonet.github.io/xjtlu/docs/image/map-2.png" width="60%" />

## XJTLU poster template

RStudio: File - New File - R Markdown - From Template - XJTLU poster

<img src="https://pzhaonet.github.io/xjtlu/docs/image/poster.jpg" width="60%" />

## XJTLU slides template

RStudio: File - New File - R Markdown - From Template - XJTLU slides

<img src="https://pzhaonet.github.io/xjtlu/docs/image/slides.jpg" width="60%" />

# License

Copyright [Peng Zhao](http://pzhao.org).

Released under the GPL-3 license.
