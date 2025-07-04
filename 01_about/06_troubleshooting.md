
# Troubleshooting

This page lists common issues encountered when using Pandemonium and possible solutions.

See also: [using the web editor](../03_usage/18_editor/04_using_the_web_editor.md) for caveats specific to the HTML5 version
of the Pandemonium editor.

## Everything I do in the editor or project manager appears delayed by one frame.

This is a [known bug](https://github.com/godotengine/godot/issues/23069) on
Intel graphics drivers on Windows. Updating to the latest graphics driver
version *provided by Intel* should fix the issue.

You should use the graphics driver provided by Intel rather than the one
provided by your desktop or laptop's manufacturer because their version is often
outdated.

## The grid disappears and meshes turn black when I rotate the 3D camera in the editor.

This is a [known bug](https://github.com/godotengine/godot/issues/30330) on
Intel graphics drivers on Windows.

The only workaround, for now, is to switch to the GLES2 renderer. You can switch
the renderer in the top-right corner of the editor or the Project Settings.

If you use a computer allowing you to switch your graphics card, like NVIDIA
Optimus, you can use the dedicated graphics card to run Pandemonium.

## The editor or project takes a very long time to start.

This is a [known bug](https://github.com/godotengine/godot/issues/20566) on
Windows when you have specific USB peripherals connected. In particular,
Corsair's iCUE software seems to cause the bug. Try updating your USB
peripherals' drivers to their latest version. If the bug persists, you need to
disconnect the faulty peripherals before opening the editor. You can then
connect the peripheral again.

## Editor tooltips in the Inspector and Node docks blink when they're displayed.

This is a [known issue](https://github.com/godotengine/godot/issues/32990)
caused by the third-party Stardock Fences application on Windows.
The only known workaround is to disable Stardock Fences while using Pandemonium.

## The Pandemonium editor appears frozen after clicking the system console.

When running Pandemonium on Windows with the system console enabled, you can
accidentally enable *selection mode* by clicking inside the command window. This
Windows-specific behavior pauses the application to let you select text inside
the system console. Pandemonium cannot override this system-specific behavior.

To solve this, select the system console window and press Enter to leave
selection mode.

## Some text such as "NO DC" appears in the top-left corner of the project manager and editor window.

This is caused by the NVIDIA graphics driver injecting an overlay to display information.

To disable this overlay on Windows, restore your graphics driver settings to the
default values in the NVIDIA Control Panel.

To disable this overlay on Linux, open `nvidia-settings`, go to
**X Screen 0 &gt; OpenGL Settings** then uncheck **Enable Graphics API Visual Indicator**.

## The project window appears blurry, unlike the editor.

Unlike the editor, the project isn't marked as DPI-aware by default. This is
done to improve performance, especially on integrated graphics, where rendering
3D scenes in hiDPI is slow.

To resolve this, open **Project &gt; Project Settings** and enable
**Display &gt; Window &gt; Dpi &gt; Allow Hidpi**. On top of that, make sure your project is
configured to support [multiple resolutions](../03_usage/14_rendering/02_multiple_resolutions.md).

## The project window doesn't appear centered when I run the project.

This is a [known bug](https://github.com/godotengine/godot/issues/13017). To
resolve this, open **Project &gt; Project Settings** and enable
**Display &gt; Window &gt; Dpi &gt; Allow Hidpi**. On top of that, make sure your
project is configured to
support [multiple resolutions](../03_usage/14_rendering/02_multiple_resolutions.md).

## The project works when run from the editor, but fails to load some files when running from an exported copy.

This is usually caused by forgetting to specify a filter for non-resource files
in the Export dialog. By default, Pandemonium will only include actual *resources*
into the PCK file. Some files commonly used, such as JSON files, are not
considered resources. For example, if you load `test.json` in the exported
project, you need to specify `*.json` in the non-resource export filter.
[See](../03_usage/20_export/02_exporting_projects.md#resource-options) for more information.

On Windows, this can also be due to
[case sensitivity](../03_usage/22_best_practices/11_project_organization.md#case-sensitivity)
issues. If you reference a resource
in your script with a different case than on the filesystem, loading will fail
once you export the project. This is because the virtual PCK filesystem is
case-sensitive, while Windows's filesystem is case-insensitive by default.
