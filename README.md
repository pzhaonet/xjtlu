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

![](inst2/image/map-1.png)<!-- -->

``` r
# in English
get_map(english = TRUE)
```

![](inst2/image/map-2.png)<!-- -->

## XJTLU poster template

RStudio: File - New File - R Markdown - From Template - XJTLU poster

![](inst2/image/poster.jpg)

## XJTLU slides template

RStudio: File - New File - R Markdown - From Template - XJTLU slides

![](inst2/image/slides.jpg)

# License

Copyright [Peng Zhao](http://pzhao.org).

Released under the GPL-3 license.
