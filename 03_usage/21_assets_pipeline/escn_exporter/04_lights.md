
# Lights

Warning: By default, lamps in Blender have shadows enabled. This can cause
performance issues in Pandemonium.

Warning: Lamps are exported using their "Blender Render" settings. When Blender 2.8
is released, this will be removed and this part of the exporter will change.

Sun, point and spot lamps are all exported from Blender along with many of their
properties:

![](img/light_properties.jpg)

There are some things to note:

 - In Blender, a light casts light all the way to infinity. In Pandemonium, it is
   clamped by the attenuation distance. To most closely match between the
   viewport and Pandemonium, enable the "Sphere" checkbox. (Highlighted green)
 - Light attenuation models differ between Pandemonium and Blender. The exporter
   attempts to make them match, but it isn't always very good.
 - Spotlight angular attenuation models also differ between Pandemonium and Blender.
   The exporter attempts to make them similar, but it doesn't always look the
   same.
 - There is no difference between buffer shadow and ray shadow in the export.

