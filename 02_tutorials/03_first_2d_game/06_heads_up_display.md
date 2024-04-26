

# Heads up display

The final piece our game needs is a User Interface (UI) to display things like
score, a "game over" message, and a restart button.

Create a new scene, and add a `CanvasLayer` node named
`HUD`. "HUD" stands for "heads-up display", an informational display that
appears as an overlay on top of the game view.

The `CanvasLayer` node lets us draw our UI elements on
a layer above the rest of the game, so that the information it displays isn't
covered up by any game elements like the player or mobs.

The HUD needs to display the following information:

- Score, changed by `ScoreTimer`.
- A message, such as "Game Over" or "Get Ready!"
- A "Start" button to begin the game.

The basic node for UI elements is `Control`. To create our
UI, we'll use two types of `Control` nodes: `Label
( Label )` and `Button`.

Create the following as children of the `HUD` node:

- `Label` named `ScoreLabel`.
- `Label` named `Message`.
- `Button` named `StartButton`.
- `Timer` named `MessageTimer`.

Click on the `ScoreLabel` and type a number into the `Text` field in the
Inspector. The default font for `Control` nodes is small and doesn't scale
well. There is a font file included in the game assets called
"Xolonium-Regular.ttf". To use this font, do the following:

1. Under **Theme overrides > Fonts** click on the empty box and select "New DynamicFont"

![](img/custom_font1.png)

2. Click on the "DynamicFont" you added, and under **Font > FontData**,
   choose "Load" and select the "Xolonium-Regular.ttf" file.

![](img/custom_font2.png)

Set the "Size" property under `Settings`, `64` works well.

![](img/custom_font3.png)

Once you've done this on the `ScoreLabel`, you can click the down arrow next
to the Font property and choose "Copy", then "Paste" it in the same place
on the other two Control nodes.

Note:
 **Anchors and Margins:** `Control` nodes have a position and size,
          but they also have anchors and margins. Anchors define the origin -
          the reference point for the edges of the node. Margins update
          automatically when you move or resize a control node. They represent
          the distance from the control node's edges to its anchor.

Arrange the nodes as shown below. Click the "Layout" button to set a Control
node's layout:

![](img/ui_anchor.png)

You can drag the nodes to place them manually, or for more precise placement,
use the following settings:

## ScoreLabel

-  *Layout* : "Top Wide"
-  *Text* : `0`
-  *Align* : "Center"

## Message

-  *Layout* : "HCenter Wide"
-  *Text* : `Dodge the Creeps!`
-  *Align* : "Center"
-  *Autowrap* : "On"

## StartButton

-  *Text* : `Start`
-  *Layout* : "Center Bottom"
-  *Margin* :

   -  Top: `-200`
   -  Bottom: `-100`

On the `MessageTimer`, set the `Wait Time` to `2` and set the `One Shot`
property to "On".

Now add this script to `HUD`:

gdscript GDScript

```
    extends CanvasLayer

    signal start_game
```

The `start_game` signal tells the `Main` node that the button
has been pressed.

gdscript GDScript

```
    func show_message(text):
        $Message.text = text
        $Message.show()
        $MessageTimer.start()
```

This function is called when we want to display a message
temporarily, such as "Get Ready".

gdscript GDScript

```
    func show_game_over():
        show_message("Game Over")
        # Wait until the MessageTimer has counted down.
        yield($MessageTimer, "timeout")

        $Message.text = "Dodge the\nCreeps!"
        $Message.show()
        # Make a one-shot timer and wait for it to finish.
        yield(get_tree().create_timer(1), "timeout")
        $StartButton.show()
```

This function is called when the player loses. It will show "Game Over" for 2
seconds, then return to the title screen and, after a brief pause, show the
"Start" button.

Note:
 When you need to pause for a brief time, an alternative to using a
          Timer node is to use the SceneTree's `create_timer()` function. This
          can be very useful to add delays such as in the above code, where we
          want to wait some time before showing the "Start" button.

gdscript GDScript

```
    func update_score(score):
        $ScoreLabel.text = str(score)
```

This function is called by `Main` whenever the score changes.

Connect the `timeout()` signal of `MessageTimer` and the `pressed()`
signal of `StartButton` and add the following code to the new functions:

gdscript GDScript

```
    func _on_StartButton_pressed():
        $StartButton.hide()
        emit_signal("start_game")

    func _on_MessageTimer_timeout():
        $Message.hide()
```

## Connecting HUD to Main

Now that we're done creating the `HUD` scene, go back to `Main`. Instance
the `HUD` scene in `Main` like you did the `Player` scene. The scene tree
should look like this, so make sure you didn't miss anything:

![](img/completed_main_scene.png)

Now we need to connect the `HUD` functionality to our `Main` script. This
requires a few additions to the `Main` scene:

In the Node tab, connect the HUD's `start_game` signal to the `new_game()`
function of the Main node by typing "new_game" in the "Receiver Method" in the
"Connect a Signal" window. Verify that the green connection icon now appears
next to `func new_game()` in the script.

In `new_game()`, update the score display and show the "Get Ready" message:

gdscript GDScript

```
        $HUD.update_score(score)
        $HUD.show_message("Get Ready")
```

In `game_over()` we need to call the corresponding `HUD` function:

gdscript GDScript

```
        $HUD.show_game_over()
```

Finally, add this to `on_ScoreTimer_timeout()` to keep the display in sync
with the changing score:

gdscript GDScript

```
        $HUD.update_score(score)
```

Now you're ready to play! Click the "Play the Project" button. You will be asked
to select a main scene, so choose `Main.tscn`.

## Removing old creeps

If you play until "Game Over" and then start a new game right away, the creeps
from the previous game may still be on the screen. It would be better if they
all disappeared at the start of a new game. We just need a way to tell *all* the
mobs to remove themselves. We can do this with the "group" feature.

In the `Mob` scene, select the root node and click the "Node" tab next to the
Inspector (the same place where you find the node's signals). Next to "Signals",
click "Groups" and you can type a new group name and click "Add".

![](img/group_tab.png)

Now all mobs will be in the "mobs" group. We can then add the following line to
the `new_game()` function in `Main`:

gdscript GDScript

```
        get_tree().call_group("mobs", "queue_free")
```

The `call_group()` function calls the named function on every node in a
group - in this case we are telling every mob to delete itself.

The game's mostly done at this point. In the next and last part, we'll polish it
a bit by adding a background, looping music, and some keyboard shortcuts.
