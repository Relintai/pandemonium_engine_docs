
# Quick start guide

- Turn on physics interpolation: `ProjectSettings.physics/common/physics_interpolation`.
- Make sure you move objects and run your game logic in `physics_process()` rather
  than `process()`. This includes moving objects directly *and indirectly* (by e.g.
  moving a parent, or using another mechanism to automatically move nodes).
- Be sure to call `Node.reset_physics_interpolation()` on nodes *after* you first
  position or teleport them, to prevent "streaking"
- Temporarily try setting `ProjectSettings.physics/common/physics_fps` to 10 to
  see the difference with and without interpolation.

