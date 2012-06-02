Overview
========
This little script is quite useful for geotagging images (write geographic
coordinates in latitude and longitude into the EXIF header) when having no
corresponding GPX track with GPS information. It allows to use the photo
afterwards for [photo mapping](http://wiki.openstreetmap.org/wiki/Photo_mapping)
with [OpenStreetMap](http://www.openstreetmap.org/) or upload it to a service
like [OpenStreetView](http://wiki.openstreetmap.org/wiki/OpenStreetView).

Requirements
============
- Linux (or some Unix-like operating system, cygwin may work, too)
- exiv2 (usually available via your package manager)

Usage
=====
Just run the script and pass lat, lon and the image filename as arguments.

Example: `./geocodeImages.sh 50.68329 11.27216 image.jpg`  
(will set the coordinates to *+50° 40' 59.84400"*, *+11° 16' 19.77600"*) 

License
=======
[GPL v3](http://www.gnu.org/licenses/gpl.html)
(c) [Alexander Heinlein](http://choerbaert.org), [Elwell](http://www.openstreetmap.org/user/Elwell)
