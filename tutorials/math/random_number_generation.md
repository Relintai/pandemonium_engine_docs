

Random number generation
========================

Many games rely on randomness to implement core game mechanics. This page
guides you through common types of randomness and how to implement them in
Godot.

After giving you a brief overview of useful functions that generate random
numbers, you will learn how to get random elements from arrays, dictionaries,
and how to use a noise generator in GDScript.

Note:


    Computers cannot generate "true" random numbers. Instead, they rely on
    `pseudorandom number generators
    ( https://en.wikipedia.org/wiki/Pseudorandom_number_generator )` (PRNGs).

Global scope versus RandomNumberGenerator class
-----------------------------------------------

Godot exposes two ways to generate random numbers: via *global scope* methods or
using the `RandomNumberGenerator` class.

Global scope methods are easier to set up, but they don't offer as much control.

RandomNumberGenerator requires more code to use, but exposes many methods not
found in global scope such as `randi_range()
( RandomNumberGenerator_method_randi_range )` and `randfn()
( RandomNumberGenerator_method_randfn )`. On top of that, it allows creating
multiple instances each with their own seed.

This tutorial uses global scope methods, except when the method only exists in
the RandomNumberGenerator class.

The randomize() method
----------------------

In global scope, you can find a `randomize()
( @GDScript_method_randomize )` method. **This method should be called only
once when your project starts to initialize the random seed.** Calling it
multiple times is unnecessary and may impact performance negatively.

Putting it in your main scene script's `_ready()` method is a good choice:

gdscript GDScript

```
    func _ready():
        randomize()
```

You can also set a fixed random seed instead using `seed()
( @GDScript_method_seed )`. Doing so will give you *deterministic* results
across runs:

gdscript GDScript

```
    func _ready():
        seed(12345)
        # To use a string as a seed, you can hash it to a number.
        seed("Hello world".hash())
```

When using the RandomNumberGenerator class, you should call `randomize()` on
the instance since it has its own seed:

gdscript GDScript

```
    var random = RandomNumberGenerator.new()
    random.randomize()
```


Getting a random number
-----------------------

Let's look at some of the most commonly used functions and methods to generate
random numbers in Godot.

The function `randi()` returns a random
number between 0 and 2^32-1. Since the maximum value is huge, you most likely
want to use the modulo operator (`%`) to bound the result between 0 and the
denominator:

gdscript GDScript

```
    # Prints a random integer between 0 and 49.
    print(randi() % 50)

    # Prints a random integer between 10 and 60.
    print(randi() % 51 + 10)
```


`randf()` returns a random floating-point
number between 0 and 1. This is useful to implement a
`doc_random_number_generation_weighted_random_probability` system, among
other things.

`randfn()` returns a random
floating-point number following a `normal distribution
( https://en.wikipedia.org/wiki/Normal_distribution )`. This means the returned
value is more likely to be around the mean (0.0 by default),
varying by the deviation (1.0 by default):

gdscript GDScript

```
    # Prints a random floating-point number from a normal distribution with a mean 0.0 and deviation 1.0.
    var random = RandomNumberGenerator.new()
    random.randomize()
    print(random.randfn())
```

`rand_range()` takes two arguments
`from` and `to`, and returns a random floating-point number between `from`
and `to`:

gdscript GDScript

```
    # Prints a random floating-point number between -4 and 6.5.
    print(rand_range(-4, 6.5))
```

`RandomNumberGenerator.randi_range()
( RandomNumberGenerator_method_randi_range )` takes two arguments `from`
and `to`, and returns a random integer between `from` and `to`:

gdscript GDScript

```
    # Prints a random integer between -10 and 10.
    var random = RandomNumberGenerator.new()
    random.randomize()
    print(random.randi_range(-10, 10))
```

Get a random array element
--------------------------

We can use random integer generation to get a random element from an array:

gdscript GDScript

```
    var _fruits = ["apple", "orange", "pear", "banana"]

    func _ready():
        randomize()

        for i in range(100):
            # Pick 100 fruits randomly.
            print(get_fruit())


    func get_fruit():
        var random_fruit = _fruits[randi() % _fruits.size()]
        # Returns "apple", "orange", "pear", or "banana" every time the code runs.
        # We may get the same fruit multiple times in a row.
        return random_fruit
```

To prevent the same fruit from being picked more than once in a row, we can add
more logic to this method:

gdscript GDScript

```
    var _fruits = ["apple", "orange", "pear", "banana"]
    var _last_fruit = ""


    func _ready():
        randomize()

        # Pick 100 fruits randomly.
        for i in range(100):
            print(get_fruit())


    func get_fruit():
        var random_fruit = _fruits[randi() % _fruits.size()]
        while random_fruit == _last_fruit:
            # The last fruit was picked, try again until we get a different fruit.
            random_fruit = _fruits[randi() % _fruits.size()]

        # Note: if the random element to pick is passed by reference,
        # such as an array or dictionary,
        # use `_last_fruit = random_fruit.duplicate()` instead.
        _last_fruit = random_fruit

        # Returns "apple", "orange", "pear", or "banana" every time the code runs.
        # The function will never return the same fruit more than once in a row.
        return random_fruit
```

This approach can be useful to make random number generation feel less
repetitive. Still, it doesn't prevent results from "ping-ponging" between a
limited set of values. To prevent this, use the `shuffle bag
( doc_random_number_generation_shuffle_bags )` pattern instead.

Get a random dictionary value
-----------------------------

We can apply similar logic from arrays to dictionaries as well:

gdscript GDScript

```
    var metals = {
        "copper": {"quantity": 50, "price": 50},
        "silver": {"quantity": 20, "price": 150},
        "gold": {"quantity": 3, "price": 500},
    }


    func _ready():
        randomize()

        for i in range(20):
            print(get_metal())


    func get_metal():
        var random_metal = metals.values()[randi() % metals.size()]
        # Returns a random metal value dictionary every time the code runs.
        # The same metal may be selected multiple times in succession.
        return random_metal
```



Weighted random probability
---------------------------

The `randf()` method returns a
floating-point number between 0.0 and 1.0. We can use this to create a
"weighted" probability where different outcomes have different likelihoods:

gdscript GDScript

```
    func _ready():
        randomize()

        for i in range(100):
            print(get_item_rarity())


    func get_item_rarity():
        var random_float = randf()

        if random_float < 0.8:
            # 80% chance of being returned.
            return "Common"
        elif random_float < 0.95:
            # 15% chance of being returned.
            return "Uncommon"
        else:
            # 5% chance of being returned.
            return "Rare"
```



"Better" randomness using shuffle bags
--------------------------------------

Taking the same example as above, we would like to pick fruits at random.
However, relying on random number generation every time a fruit is selected can
lead to a less *uniform* distribution. If the player is lucky (or unlucky), they
could get the same fruit three or more times in a row.

You can accomplish this using the *shuffle bag* pattern. It works by removing an
element from the array after choosing it. After multiple selections, the array
ends up empty. When that happens, you reinitialize it to its default value::

    var _fruits = ["apple", "orange", "pear", "banana"]
    # A copy of the fruits array so we can restore the original value into `fruits`.
    var _fruits_full = []


    func _ready():
        randomize()
        _fruits_full = _fruits.duplicate()
        _fruits.shuffle()

        for i in 100:
            print(get_fruit())


    func get_fruit():
        if _fruits.empty():
            # Fill the fruits array again and shuffle it.
            _fruits = _fruits_full.duplicate()
            _fruits.shuffle()

        # Get a random fruit, since we shuffled the array,
        # and remove it from the `_fruits` array.
        var random_fruit = _fruits.pop_front()
        # Prints "apple", "orange", "pear", or "banana" every time the code runs.
        return random_fruit

When running the above code, there is a chance to get the same fruit twice in a
row. Once we picked a fruit, it will no longer be a possible return value unless
the array is now empty. When the array is empty, we reset it back to its default
value, making it possible to have the same fruit again, but only once.

Random noise
------------

The random number generation shown above can show its limits when you need a
value that *slowly* changes depending on the input. The input can be a position,
time, or anything else.

To achieve this, you can use random *noise* functions. Noise functions are
especially popular in procedural generation to generate realistic-looking
terrain. Godot provides `opensimplexnoise` for this, which supports
1D, 2D, 3D, and 4D noise. Here's an example with 1D noise:

gdscript GDScript

```
    var _noise = OpenSimplexNoise.new()

    func _ready():
        randomize()
        # Configure the OpenSimplexNoise instance.
        _noise.seed = randi()
        _noise.octaves = 4
        _noise.period = 20.0
        _noise.persistence = 0.8

        for i in 100:
            # Prints a slowly-changing series of floating-point numbers
            # between -1.0 and 1.0.
            print(_noise.get_noise_1d(i))
```
