
# Support different actor area access

![](img/nav_actor_doors.png)

A typical example for different area access in gameplay are doors that connect rooms
with different navigation meshes and are not accessible by all actors all the time.

Add a NavigationRegion at the door position.
Add an appropriated navigationmesh the size of the door that can connect with the surrounding navigationmeshes.
In order to control access enable / disable navigation layer bits so path queries
that use the same navigation layer bits can find a path through the "door" navigationmesh.

The bitmask can act as a set of door keys or abilities and only actors with at least
one matching and enabled bit layer in their pathfinding query will find a path through this region.

![](img/nav_actor_doorbitmask.png)

The entire "door" region can also be enabled / disable if required but if disabled will block access for all path queries.

Prefer working with navigation layers in path queries whenever possible as enabling or disabling
navigation layers on a region triggers a performance costly recalculation of the navigation map connections.

Warning: Changing navigation layers will only affect new path queries but not automatically update existing paths.

