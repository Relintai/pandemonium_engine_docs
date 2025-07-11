
# Handling quit requests

## Quitting

Most platforms have the option to request the application to quit. On
desktops, this is usually done with the "x" icon on the window title bar.
On Android, the back button is used to quit when on the main screen (and
to go back otherwise).

## Handling the notification

On desktop platforms, the `MainLoop`
has a special `MainLoop.NOTIFICATION_WM_QUIT_REQUEST` notification that is
sent to all nodes when quitting is requested.

On Android, `MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST` is sent instead.
Pressing the Back button will exit the application if
**Application &gt; Config &gt; Quit On Go Back** is checked in the Project Settings
(which is the default).

Note: `MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST` isn't supported on iOS, as
iOS devices don't have a physical Back button.

Handling the notification is done as follows (on any node):

```
func _notification(what):
    if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
        get_tree().quit() # default behavior
```

When developing mobile apps, quitting is not desired unless the user is
on the main screen, so the behavior can be changed.

It is important to note that by default, Pandemonium apps have the built-in
behavior to quit when quit is requested, this can be changed:

```
get_tree().set_auto_accept_quit(false)
```

## Sending your own quit notification

While forcing the application to close can be done by calling `SceneTree.quit`,
doing so will not send the quit *notification*. This means the function
described above won't be called. Quitting by calling
`SceneTree.quit` will not allow custom actions
to complete (such as saving, confirming the quit, or debugging), even if you try
to delay the line that forces the quit.

Instead, you should send a quit request:

```
get_tree().notification(MainLoop.NOTIFICATION_WM_QUIT_REQUEST)
```

