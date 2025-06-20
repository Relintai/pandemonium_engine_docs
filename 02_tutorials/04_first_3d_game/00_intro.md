
# Your first 3D game

In this step-by-step tutorial series, you will create your first complete 3D
game with Pandemonium. By the end of the series, you will have a simple yet finished
project of your own like the animated gif below.

![](img/squash-the-creeps-final.gif)

The game we'll code here is similar to [your first 2d game](../03_first_2d_game/), with a twist:
you can now jump and your goal is to squash the creeps. This way, you will both
**recognize patterns** you learned in the previous tutorial and **build upon
them** with new code and features.

You will learn to:

- Work with 3D coordinates with a jumping mechanic.
- Use kinematic bodies to move 3D characters and detect when and how they
  collide.
- Use physics layers and a group to detect interactions with specific entities.
- Code basic procedural gameplay by instancing monsters at regular time
  intervals.
- Design a movement animation and change its speed at run-time.
- Draw a user interface on a 3D game.

And more.

This tutorial is for beginners who followed the complete getting started series.
We'll start slow with detailed instructions and shorten them as we do similar
steps.

We prepared some game assets so we can jump straight to the code. You can
download them here: [Squash the Creeps assets](files/squash_the_creeps.zip).

We will first work on a basic prototype for the player's movement. We will then
add the monsters that we'll spawn randomly around the screen. After that, we'll
implement the jump and squashing mechanic before refining the game with some
nice animation. We'll wrap up with the score and the retry screen.

