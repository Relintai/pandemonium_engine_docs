
# Using multiple threads

## Threads

Threads allow simultaneous execution of code. It allows off-loading work
from the main thread.

Pandemonium supports threads and provides many handy functions to use them.

Note: If using other languages (C#, C++), it may be easier to use the
threading classes they support.

## Creating a Thread

Creating a thread is very simple, just use the following code:

```
var thread

# The thread will start here.
func _ready():
    thread = Thread.new()
    # Third argument is optional userdata, it can be any variable.
    thread.start(self, "_thread_function", "Wafflecopter")


# Run here and exit.
# The argument is the userdata passed from start().
# If no argument was passed, this one still needs to
# be here and it will be null.
func _thread_function(userdata):
    # Print the userdata ("Wafflecopter")
    print("I'm a thread! Userdata is: ", userdata)

# Thread must be disposed (or "joined"), for portability.
func _exit_tree():
    thread.wait_to_finish()
```

Your function will, then, run in a separate thread until it returns.
Even if the function has returned already, the thread must collect it, so call
`Thread.wait_to_finish()`, which will
wait until the thread is done (if not done yet), then properly dispose of it.

## Mutexes

Accessing objects or data from multiple threads is not always supported (if you
do it, it will cause unexpected behaviors or crashes).

When processing your own data or calling your own functions, as a rule, try to
avoid accessing the same data directly from different threads. You may run into
synchronization problems, as the data is not always updated between CPU cores
when modified. Always use a `Mutex` (or `RWLock`) when accessing
a piece of data from different threads.

When calling `Mutex.lock()`, a thread ensures that
all other threads will be blocked (put on suspended state) if they try to *lock*
the same mutex. When the mutex is unlocked by calling
`Mutex.unlock()`, the other threads will be
allowed to proceed with the lock (but only one at a time).

Here is an example of using a Mutex:

```
var counter = 0
var mutex
var thread


# The thread will start here.
func _ready():
    mutex = Mutex.new()
    thread = Thread.new()
    thread.start(self, "_thread_function")

    # Increase value, protect it with Mutex.
    mutex.lock()
    counter += 1
    mutex.unlock()


# Increment the value from the thread, too.
func _thread_function(userdata):
    mutex.lock()
    counter += 1
    mutex.unlock()


# Thread must be disposed (or "joined"), for portability.
func _exit_tree():
    thread.wait_to_finish()
    print("Counter is: ", counter) # Should be 2.
```

## Semaphores

Sometimes you want your thread to work *"on demand"*. In other words, tell it
when to work and let it suspend when it isn't doing anything.
For this, `Semaphores` are used. The function
`Semaphore.wait()` is used in the thread to
suspend it until some data arrives.

The main thread, instead, uses
`Semaphore.post()` to signal that data is
ready to be processed:

```
var counter = 0
var mutex
var semaphore
var thread
var exit_thread = false


# The thread will start here.
func _ready():
    mutex = Mutex.new()
    semaphore = Semaphore.new()
    exit_thread = false

    thread = Thread.new()
    thread.start(self, "_thread_function")


func _thread_function(userdata):
    while true:
        semaphore.wait() # Wait until posted.

        mutex.lock()
        var should_exit = exit_thread # Protect with Mutex.
        mutex.unlock()

        if should_exit:
            break

        mutex.lock()
        counter += 1 # Increment counter, protect with Mutex.
        mutex.unlock()


func increment_counter():
    semaphore.post() # Make the thread process.


func get_counter():
    mutex.lock()
    # Copy counter, protect with Mutex.
    var counter_value = counter
    mutex.unlock()
    return counter_value


# Thread must be disposed (or "joined"), for portability.
func _exit_tree():
    # Set exit condition to true.
    mutex.lock()
    exit_thread = true # Protect with Mutex.
    mutex.unlock()

    # Unblock by posting.
    semaphore.post()

    # Wait until it exits.
    thread.wait_to_finish()

    # Print the counter.
    print("Counter is: ", counter)
```

