# Decimal representation for longitudes and latitudes of population centers of US states

A population center of a US state is a point on which a flat surface in the shape of the state would balance if weights are population in the state. The US census bureau provides the longitudes and latitudes of such population centers of the 50 states and the DC from 1880 to 2010 in the following website:

https://www.census.gov/geographies/reference-files/time-series/geo/centers-population/historical-by-year.html

The longitudes and latitudes are represented in the "degree-minute-second" format. If you want to compute a distance between population centers of two states using the "sp" package in R, you need to translate a "degree-minute-second" form to its decimal representation. For example, in the census bureau's website, Alabama's center of population as of 1970 is "32° 59′ 28″," but you need to translate to "32.9911."


September 16, 2021