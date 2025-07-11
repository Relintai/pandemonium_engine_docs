
# Autoloads versus regular nodes

Pandemonium offers a feature to automatically load nodes at the root of your project,
allowing you to access them globally, that can fulfill the role of a Singleton:
`doc_singletons_autoload`. These auto-loaded nodes are not freed when you
change the scene from code with `SceneTree.change_scene`.

In this guide, you will learn when to use the Autoload feature, and techniques
you can use to avoid it.

## The cutting audio issue

Other engines can encourage the use of creating manager classes, singletons that
organize a lot of functionality into a globally accessible object. Pandemonium offers
many ways to avoid global state thanks to the node tree and signals.

For example, let's say we are building a platformer and want to collect coins
that play a sound effect. There's a node for that: the `AudioStreamPlayer`.
But if we call the `AudioStreamPlayer` while it is
already playing a sound, the new sound interrupts the first.

A solution is to code a global, auto-loaded sound manager class. It generates a
pool of `AudioStreamPlayer` nodes that cycle through as each new request for
sound effects comes in. Say we call that class `Sound`, you can use it from
anywhere in your project by calling `Sound.play("coin_pickup.ogg")`. This
solves the problem in the short term but causes more problems:

1. **Global state**: one object is now responsible for all objects' data. If the
   `Sound` class has errors or doesn't have an AudioStreamPlayer available,
   all the nodes calling it can break.

2. **Global access**: now that any object can call `Sound.play(sound_path)`
   from anywhere, there's no longer an easy way to find the source of a bug.

3. **Global resource allocation**: with a pool of `AudioStreamPlayer` nodes
   stored from the start, you can either have too few and face bugs, or too many
   and use more memory than you need.

Note:

- About global access, the problem is that Any code anywhere could pass wrong
  data to the `Sound` autoload in our example. As a result, the domain to
  explore to fix the bug spans the entire project.
- When you keep code inside a scene, only one or two scripts may be
  involved in audio.

Contrast this with each scene keeping as many `AudioStreamPlayer` nodes as it
needs within itself and all these problems go away:

1. Each scene manages its own state information. If there is a problem with the
   data, it will only cause issues in that one scene.

2. Each scene accesses only its own nodes. Now, if there is
   a bug, it's easy to find which node is at fault.

3. Each scene allocates exactly the amount of resources it needs.

## Managing shared functionality or data

Another reason to use an Autoload can be that you want to reuse the same method
or data across many scenes.

In the case of functions, you can create a new type of `Node` that provides
that feature for an individual scene using the `name` keyword in GDScript.

When it comes to data, you can either:

1. Create a new type of `Resource` to share the data.

2. Store the data in an object to which each node has access, for example using
   the `owner` property to access the scene's root node.

## When you should use an Autoload

Auto-loaded nodes can simplify your code in some cases:

- **Static Data**: if you need data that is exclusive to one class, like a
  database, then an autoload can be a good tool. There is no scripting API in
  Pandemonium to create and manage static data otherwise.

- **Static functions**: creating a library of functions that only return values.

- **Systems with a wide scope**: If the singleton is managing its own
  information and not invading the data of other objects, then it's a great way to
  create systems that handle broad-scoped tasks. For example, a quest or a
  dialogue system.

Until Pandemonium 3.1, another use was just for convenience: autoloads have a global
variable for their name generated in GDScript, allowing you to call them from
any script file in your project. But now, you can use the `name` keyword
instead to get auto-completion for a type in your entire project.

Note:

Autoload is not exactly a Singleton. Nothing prevents you from instantiating
copies of an auto-loaded node. It is only a tool that makes a node load
automatically as a child of the root of your scene tree, regardless of your
game's node structure or which scene you run, e.g. by pressing :kbd:`F6` key.

As a result, you can get the auto-loaded node, for example an autoload called
`Sound`, by calling `get_node("/root/Sound")`.

