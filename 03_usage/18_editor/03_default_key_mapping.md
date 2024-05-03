

# Default editor shortcuts

Many of Pandemonium Editor functions can be executed with keyboard shortcuts. This page
lists functions which have associated shortcuts by default, but many others are
available for customization in editor settings as well. To change keys associated
with these and other actions navigate to `Editor -> Editor Settings -> Shortcuts`.

While some actions are universal, a lot of shortcuts are specific to individual
tools. For this reason it is possible for some key combinations to be assigned
to more than one function. The correct action will be performed depending on the
context.

Note:
 While Windows and Linux builds of the editor share most of the default settings,
          some shortcuts may differ for macOS version. This is done for better integration
          of the editor into macOS ecosystem. Users fluent with standard shortcuts on that
          OS should find Pandemonium Editor's default key mapping intuitive.

## General Editor Actions


| Action name           | Windows, Linux            | macOS                  | Editor setting                 |
|-----------------------|---------------------------|------------------------|--------------------------------|
| Open 2D Editor        | `Ctrl + F1`              | `Alt + 1`               | `editor/editor_2d`             |
| Open 3D Editor        | `Ctrl + F2`              | `Alt + 2`               | `editor/editor_3d`             |
| Open Script Editor    | `Ctrl + F3`              | `Alt + 3`               | `editor/editor_script`         |
| Search Help           | `F1`                     | `Alt + Space`           | `editor/editor_help`           |
| Distraction Free Mode | `Ctrl + Shift + F11`     | `Cmd + Ctrl + D`        | `editor/distraction_free_mode` |
| Next tab              | `Ctrl + Tab`             | `Cmd + Tab`             | `editor/next_tab`              |
| Previous tab          | `Ctrl + Shift + Tab`     | `Cmd + Shift + Tab`     | `editor/prev_tab`              |
| Filter Files          | `Ctrl + Alt + P`         | `Cmd + Alt + P`         | `editor/filter_files`          |
| Open Scene            | `Ctrl + O`               | `Cmd + O`               | `editor/open_scene`            |
| Close Scene           | `Ctrl + Shift + W`       | `Cmd + Shift + W`       | `editor/close_scene`           |
| Reopen Closed Scene   | `Ctrl + Shift + T`       | `Cmd + Shift + T`       | `editor/reopen_closed_scene`   |
| Save Scene            | `Ctrl + S`               | `Cmd + S`               | `editor/save_scene`            |
| Save Scene As         | `Ctrl + Shift + S`       | `Cmd + Shift + S`       | `editor/save_scene_as`         |
| Save All Scenes       | `Ctrl + Shift + Alt + S` | `Cmd + Shift + Alt + S` | `editor/save_all_scenes`       |
| Quick Open            | `Shift + Alt + O`        | `Shift + Alt + O`       | `editor/quick_open`            |
| Quick Open Scene      | `Ctrl + Shift + O`       | `Cmd + Shift + O`       | `editor/quick_open_scene`      |
| Quick Open Script     | `Ctrl + Alt + O`         | `Cmd + Alt + O`         | `editor/quick_open_script`     |
| Undo                  | `Ctrl + Z`               | `Cmd + Z`               | `editor/undo`                  |
| Redo                  | `Ctrl + Shift + Z`       | `Cmd + Shift + Z`       | `editor/redo`                  |
| Quit                  | `Ctrl + Q`               | `Cmd + Q`               | `editor/file_quit`             |
| Quit to Project List  | `Ctrl + Shift + Q`       | `Shift + Alt + Q`       | `editor/quit_to_project_list`  |
| Take Screenshot       | `Ctrl + F12`             | `Cmd + F12`             | `editor/take_screenshot`       |
| Toggle Fullscreen     | `Shift + F11`            | `Cmd + Ctrl + F`        | `editor/fullscreen_mode`       |
| Play                  | `F5`                     | `Cmd + B`               | `editor/play`                  |
| Pause Scene           | `F7`                     | `Cmd + Ctrl + Y`        | `editor/pause_scene`           |
| Stop                  | `F8`                     | `Cmd + .`               | `editor/stop`                  |
| Play Scene            | `F6`                     | `Cmd + R`               | `editor/play_scene`            |
| Play Custom Scene     | `Ctrl + Shift + F5`      | `Cmd + Shift + R`       | `editor/play_custom_scene`     |
| Expand Bottom Panel   | `Shift + F12`            | `Shift + F12`           | `editor/bottom_panel_expand`   |


## 2D / Canvas Item Editor


| Action name                  | Windows, Linux     | macOS             | Editor setting                                       |
|------------------------------|--------------------|-------------------|------------------------------------------------------|
| Zoom In                      | `Ctrl + =`         | `Cmd + =`         | `canvas_item_editor/zoom_plus`                       |
| Zoom Out                     | `Ctrl + -`         | `Cmd + -`         | `canvas_item_editor/zoom_minus`                      |
| Zoom Reset                   | `Ctrl + 0`         | `Cmd + 0`         | `canvas_item_editor/zoom_reset`                      |
| Pan View                     | `Space`            | `Space`           | `canvas_item_editor/pan_view`                        |
| Select Mode                  | `Q`                | `Q`               | `canvas_item_editor/select_mode`                     |
| Move Mode                    | `W`                | `W`               | `canvas_item_editor/move_mode`                       |
| Rotate Mode                  | `E`                | `E`               | `canvas_item_editor/rotate_mode`                     |
| Scale Mode                   | `S`                | `S`               | `canvas_item_editor/scale_mode`                      |
| Ruler Mode                   | `R`                | `R`               | `canvas_item_editor/ruler_mode`                      |
| Use Smart Snap               | `Shift + S`        | `Shift + S`       | `canvas_item_editor/use_smart_snap`                  |
| Use Grid Snap                | `Shift + G`        | `Shift + G`       | `canvas_item_editor/use_grid_snap`                   |
| Multiply grid step by 2      | `Num *`            | `Num *`           | `canvas_item_editor/multiply_grid_step`              |
| Divide grid step by 2        | `Num /`            | `Num /`           | `canvas_item_editor/divide_grid_step`                |
| Always Show Grid             | `G`                | `G`               | `canvas_item_editor/show_grid`                       |
| Show Helpers                 | `H`                | `H`               | `canvas_item_editor/show_helpers`                    |
| Show Guides                  | `Y`                | `Y`               | `canvas_item_editor/show_guides`                     |
| Center Selection             | `F`                | `F`               | `canvas_item_editor/center_selection`                |
| Frame Selection              | `Shift + F`        | `Shift + F`       | `canvas_item_editor/frame_selection`                 |
| Preview Canvas Scale         | `Ctrl + Shift + P` | `Cmd + Shift + P` | `canvas_item_editor/preview_canvas_scale`            |
| Insert Key                   | `Ins`              | `Ins`             | `canvas_item_editor/anim_insert_key`                 |
| Insert Key (Existing Tracks) | `Ctrl + Ins`       | `Cmd + Ins`       | `canvas_item_editor/anim_insert_key_existing_tracks` |
| Make Custom Bones from Nodes | `Ctrl + Shift + B` | `Cmd + Shift + B` | `canvas_item_editor/skeleton_make_bones`             |
| Clear Pose                   | `Shift + K`        | `Shift + K`       | `canvas_item_editor/anim_clear_pose`                 |

## 3D / Spatial Editor


| Action name                        | Windows, Linux   | macOS           | Editor setting                                 |
|------------------------------------|------------------|-----------------|------------------------------------------------|
| Toggle Freelook                    | `Shift + F`      | `Shift + F`     | `spatial_editor/freelook_toggle`               |
| Freelook Left                      | `A`              | `A`             | `spatial_editor/freelook_left`                 |
| Freelook Right                     | `D`              | `D`             | `spatial_editor/freelook_right`                |
| Freelook Forward                   | `W`              | `W`             | `spatial_editor/freelook_forward`              |
| Freelook Backwards                 | `S`              | `S`             | `spatial_editor/freelook_backwards`            |
| Freelook Up                        | `E`              | `E`             | `spatial_editor/freelook_up`                   |
| Freelook Down                      | `Q`              | `Q`             | `spatial_editor/freelook_down`                 |
| Freelook Speed Modifier            | `Shift`          | `Shift`         | `spatial_editor/freelook_speed_modifier`       |
| Freelook Slow Modifier             | `Alt`            | `Alt`           | `spatial_editor/freelook_slow_modifier`        |
| Select Mode                        | `Q`              | `Q`             | `spatial_editor/tool_select`                   |
| Move Mode                          | `W`              | `W`             | `spatial_editor/tool_move`                     |
| Rotate Mode                        | `E`              | `E`             | `spatial_editor/tool_rotate`                   |
| Scale Mode                         | `R`              | `R`             | `spatial_editor/tool_scale`                    |
| Use Local Space                    | `T`              | `T`             | `spatial_editor/local_coords`                  |
| Use Snap                           | `Y`              | `Y`             | `spatial_editor/snap`                          |
| Snap Object to Floor               | `PgDown`         | `PgDown`        | `spatial_editor/snap_to_floor`                 |
| Top View                           | `Num 7`          | `Num 7`         | `spatial_editor/top_view`                      |
| Bottom View                        | `Alt + Num 7`    | `Alt + Num 7`   | `spatial_editor/bottom_view`                   |
| Front View                         | `Num 1`          | `Num 1`         | `spatial_editor/front_view`                    |
| Rear View                          | `Alt + Num 1`    | `Alt + Num 1`   | `spatial_editor/rear_view`                     |
| Right View                         | `Num 3`          | `Num 3`         | `spatial_editor/right_view`                    |
| Left View                          | `Alt + Num 3`    | `Alt + Num 3`   | `spatial_editor/left_view`                     |
| Switch Perspective/Orthogonal View | `Num 5`          | `Num 5`         | `spatial_editor/switch_perspective_orthogonal` |
| Insert Animation Key               | `K`              | `K`             | `spatial_editor/insert_anim_key`               |
| Focus Origin                       | `O`              | `O`             | `spatial_editor/focus_origin`                  |
| Focus Selection                    | `F`              | `F`             | `spatial_editor/focus_selection`               |
| Align Transform with View          | `Ctrl + Alt + M` | `Cmd + Alt + M` | `spatial_editor/align_transform_with_view`     |
| Align Rotation with View           | `Ctrl + Alt + F` | `Cmd + Alt + F` | `spatial_editor/align_rotation_with_view`      |
| 1 Viewport                         | `Ctrl + 1`       | `Cmd + 1`       | `spatial_editor/1_viewport`                    |
| 2 Viewports                        | `Ctrl + 2`       | `Cmd + 2`       | `spatial_editor/2_viewports`                   |
| 2 Viewports (Alt)                  | `Ctrl + Alt + 2` | `Cmd + Alt + 2` | `spatial_editor/2_viewports_alt`               |
| 3 Viewports                        | `Ctrl + 3`       | `Cmd + 3`       | `spatial_editor/3_viewports`                   |
| 3 Viewports (Alt)                  | `Ctrl + Alt + 3` | `Cmd + Alt + 3` | `spatial_editor/3_viewports_alt`               |
| 4 Viewports                        | `Ctrl + 4`       | `Cmd + 4`       | `spatial_editor/4_viewports`                   |


## Text Editor


| Action name               | Windows, Linux      | macOS                 | Editor setting                                |
|---------------------------|---------------------|-----------------------|-----------------------------------------------|
| Cut                       | `Ctrl + X`          | `Cmd + X`             | `script_text_editor/cut`                      |
| Copy                      | `Ctrl + C`          | `Cmd + C`             | `script_text_editor/copy`                     |
| Paste                     | `Ctrl + V`          | `Cmd + V`             | `script_text_editor/paste`                    |
| Select All                | `Ctrl + A`          | `Cmd + A`             | `script_text_editor/select_all`               |
| Find                      | `Ctrl + F`          | `Cmd + F`             | `script_text_editor/find`                     |
| Find Next                 | `F3`                | `Cmd + G`             | `script_text_editor/find_next`                |
| Find Previous             | `Shift + F3`        | `Cmd + Shift + G`     | `script_text_editor/find_previous`            |
| Find in Files             | `Ctrl + Shift + F`  | `Cmd + Shift + F`     | `script_text_editor/find_in_files`            |
| Replace                   | `Ctrl + R`          | `Alt + Cmd + F`       | `script_text_editor/replace`                  |
| Replace in Files          | `Ctrl + Shift + R`  | `Cmd + Shift + R`     | `script_text_editor/replace_in_files`         |
| Undo                      | `Ctrl + Z`          | `Cmd + Z`             | `script_text_editor/undo`                     |
| Redo                      | `Ctrl + Y`          | `Cmd + Y`             | `script_text_editor/redo`                     |
| Move Up                   | `Alt + Up Arrow`    | `Alt + Up Arrow`      | `script_text_editor/move_up`                  |
| Move Down                 | `Alt + Down Arrow`  | `Alt + Down Arrow`    | `script_text_editor/move_down`                |
| Delete Line               | `Ctrl + Shift + K`  | `Cmd + Shift + K`     | `script_text_editor/delete_line`              |
| Toggle Comment            | `Ctrl + K`          | `Cmd + K`             | `script_text_editor/toggle_comment`           |
| Fold/Unfold Line          | `Alt + F`           | `Alt + F`             | `script_text_editor/toggle_fold_line`         |
| Clone Down                | `Ctrl + D`          | `Cmd + Shift + C`     | `script_text_editor/clone_down`               |
| Complete Symbol           | `Ctrl + Space`      | `Ctrl + Space`        | `script_text_editor/complete_symbol`          |
| Evaluate Selection        | `Ctrl + Shift + E`  | `Cmd + Shift + E`     | `script_text_editor/evaluate_selection`       |
| Trim Trailing Whitespace  | `Ctrl + Alt + T`    | `Cmd + Alt + T`       | `script_text_editor/trim_trailing_whitespace` |
| Uppercase                 | `Shift + F4`        | `Shift + F4`          | `script_text_editor/convert_to_uppercase`     |
| Lowercase                 | `Shift + F5`        | `Shift + F5`          | `script_text_editor/convert_to_lowercase`     |
| Capitalize                | `Shift + F6`        | `Shift + F6`          | `script_text_editor/capitalize`               |
| Convert Indent to Spaces  | `Ctrl + Shift + Y`  | `Cmd + Shift + Y`     | `script_text_editor/convert_indent_to_spaces` |
| Convert Indent to Tabs    | `Ctrl + Shift + I`  | `Cmd + Shift + I`     | `script_text_editor/convert_indent_to_tabs`   |
| Auto Indent               | `Ctrl + I`          | `Cmd + I`             | `script_text_editor/auto_indent`              |
| Toggle Bookmark           | `Ctrl + Alt + B`    | `Cmd + Alt + B`       | `script_text_editor/toggle_bookmark`          |
| Go to Next Bookmark       | `Ctrl + B`          | `Cmd + B`             | `script_text_editor/goto_next_bookmark`       |
| Go to Previous Bookmark   | `Ctrl + Shift + B`  | `Cmd + Shift + B`     | `script_text_editor/goto_previous_bookmark`   |
| Go to Function            | `Ctrl + Alt + F`    | `Ctrl + Cmd + J`      | `script_text_editor/goto_function`            |
| Go to Line                | `Ctrl + L`          | `Cmd + L`             | `script_text_editor/goto_line`                |
| Toggle Breakpoint         | `F9`                | `Cmd + Shift + B`     | `script_text_editor/toggle_breakpoint`        |
| Remove All Breakpoints    | `Ctrl + Shift + F9` | `Cmd + Shift + F9`    | `script_text_editor/remove_all_breakpoints`   |
| Go to Next Breakpoint     | `Ctrl + .`          | `Cmd + .`             | `script_text_editor/goto_next_breakpoint`     |
| Go to Previous Breakpoint | `Ctrl + ,`          | `Cmd + ,`             | `script_text_editor/goto_previous_breakpoint` |
| Contextual Help           | `Alt + F1`          | `Alt + Shift + Space` | `script_text_editor/contextual_help`          |


## Script Editor


| Action name          | Windows, Linux             | macOS                      | Editor setting                       |
|----------------------|----------------------------|----------------------------|--------------------------------------|
| Find                 | `Ctrl + F`                 | `Cmd + F`                  | `script_editor/find`                 |
| Find Next            | `F3`                       | `F3`                       | `script_editor/find_next`            |
| Find Previous        | `Shift + F3`               | `Shift + F3`               | `script_editor/find_previous`        |
| Find in Files        | `Ctrl + Shift + F`         | `Cmd + Shift + F`          | `script_editor/find_in_files`        |
| Move Up              | `Shift + Alt + Up Arrow`   | `Shift + Alt + Up Arrow`   | `script_editor/window_move_up`       |
| Move Down            | `Shift + Alt + Down Arrow` | `Shift + Alt + Down Arrow` | `script_editor/window_move_down`     |
| Next Script          | `Ctrl + Shift + .`         | `Cmd + Shift + .`          | `script_editor/next_script`          |
| Previous Script      | `Ctrl + Shift + ,`         | `Cmd + Shift + ,`          | `script_editor/prev_script`          |
| Reopen Closed Script | `Ctrl + Shift + T`         | `Cmd + Shift + T`          | `script_editor/reopen_closed_script` |
| Save                 | `Ctrl + Alt + S`           | `Cmd + Alt + S`            | `script_editor/save`                 |
| Save All             | `Ctrl + Shift + Alt + S`   | `Cmd + Shift + Alt + S`    | `script_editor/save_all`             |
| Soft Reload Script   | `Ctrl + Shift + R`         | `Cmd + Shift + R`          | `script_editor/reload_script_soft`   |
| History Previous     | `Alt + Left Arrow`         | `Alt + Left Arrow`         | `script_editor/history_previous`     |
| History Next         | `Alt + Right Arrow`        | `Alt + Right Arrow`        | `script_editor/history_next`         |
| Close                | `Ctrl + W`                 | `Cmd + W`                  | `script_editor/close_file`           |
| Run                  | `Ctrl + Shift + X`         | `Cmd + Shift + X`          | `script_editor/run_file`             |
| Toggle Scripts Panel | `Ctrl + \\`                | `Cmd + \\`                 | `script_editor/toggle_scripts_panel` |
| Zoom In              | `Ctrl + =`                 | `Cmd + =`                  | `script_editor/zoom_in`              |
| Zoom Out             | `Ctrl + -`                 | `Cmd + -`                  | `script_editor/zoom_out`             |
| Reset Zoom           | `Ctrl + 0`                 | `Cmd + 0`                  | `script_editor/reset_zoom`           |


## Editor Output

| Action name    | Windows, Linux     | macOS             | Editor setting        |
|----------------|--------------------|-------------------|-----------------------|
| Copy Selection | `Ctrl + C`         | `Cmd + C`         | `editor/copy_output`  |
| Clear Output   | `Ctrl + Shift + K` | `Cmd + Shift + K` | `editor/clear_output` |

## Debugger

| Action name | Windows, Linux | macOS | Editor setting       |
|-------------|----------------|-------|----------------------|
| Step Into   | `F11`          | `F11` | `debugger/step_into` |
| Step Over   | `F10`          | `F10` | `debugger/step_over` |
| Continue    | `F12`          | `F12` | `debugger/continue`  |

## File Dialog


| Action name         | Windows, Linux      | macOS               | Editor setting                    |
|---------------------|---------------------|---------------------|-----------------------------------|
| Go Back             | `Alt + Left Arrow`  | `Alt + Left Arrow`  | `file_dialog/go_back`             |
| Go Forward          | `Alt + Right Arrow` | `Alt + Right Arrow` | `file_dialog/go_forward`          |
| Go Up               | `Alt + Up Arrow`    | `Alt + Up Arrow`    | `file_dialog/go_up`               |
| Refresh             | `F5`                | `F5`                | `file_dialog/refresh`             |
| Toggle Hidden Files | `Ctrl + H`          | `Cmd + H`           | `file_dialog/toggle_hidden_files` |
| Toggle Favorite     | `Alt + F`           | `Alt + F`           | `file_dialog/toggle_favorite`     |
| Toggle Mode         | `Alt + V`           | `Alt + V`           | `file_dialog/toggle_mode`         |
| Create Folder       | `Ctrl + N`          | `Cmd + N`           | `file_dialog/create_folder`       |
| Delete              | `Del`               | `Cmd + BkSp`        | `file_dialog/delete`              |
| Focus Path          | `Ctrl + D`          | `Cmd + D`           | `file_dialog/focus_path`          |
| Move Favorite Up    | `Ctrl + Up Arrow`   | `Cmd + Up Arrow`    | `file_dialog/move_favorite_up`    |
| Move Favorite Down  | `Ctrl + Down Arrow` | `Cmd + Down Arrow`  | `file_dialog/move_favorite_down`  |


## FileSystem Dock

| Action name | Windows, Linux  | macOS        | Editor setting              |
|-------------|-----------------|--------------|-----------------------------|
| Copy Path   | `Ctrl + C`      | `Cmd + C`    | `filesystem_dock/copy_path` |
| Duplicate   | `Ctrl + D`      | `Cmd + D`    | `filesystem_dock/duplicate` |
| Delete      | `Del`           | `Cmd + BkSp` | `filesystem_dock/delete`    |

## Scene Tree Dock

| Action name    | Windows, Linux      | macOS              | Editor setting                 |
|----------------|---------------------|--------------------|--------------------------------|
| Add Child Node | `Ctrl + A`          | `Cmd + A`          | `scene_tree/add_child_node`    |
| Batch Rename   | `Ctrl + F2`         | `Cmd + F2`         | `scene_tree/batch_rename`      |
| Copy Node Path | `Ctrl + C`          | `Cmd + C`          | `scene_tree/copy_node_path`    |
| Delete         | `Del`               | `Cmd + BkSp`       | `scene_tree/delete`            |
| Force Delete   | `Shift + Del`       | `Shift + Del`      | `scene_tree/delete_no_confirm` |
| Duplicate      | `Ctrl + D`          | `Cmd + D`          | `scene_tree/duplicate`         |
| Move Up        | `Ctrl + Up Arrow`   | `Cmd + Up Arrow`   | `scene_tree/move_up`           |
| Move Down      | `Ctrl + Down Arrow` | `Cmd + Down Arrow` | `scene_tree/move_down`         |

## Animation Track Editor

| Action name          | Windows, Linux       | macOS               | Editor setting                                    |
|----------------------|----------------------|---------------------|---------------------------------------------------|
| Duplicate Selection  | `Ctrl + D`           | `Cmd + D`           | `animation_editor/duplicate_selection`            |
| Duplicate Transposed | `Ctrl + Shift + D`   | `Cmd + Shift + D`   | `animation_editor/duplicate_selection_transposed` |
| Delete Selection     | `Del`                | `Cmd + BkSp`        | `animation_editor/delete_selection`               |
| Go to Next Step      | `Ctrl + Right Arrow` | `Cmd + Right Arrow` | `animation_editor/goto_next_step`                 |
| Go to Previous Step  | `Ctrl + Left Arrow`  | `Cmd + Left Arrow`  | `animation_editor/goto_prev_step`                 |

## Tile Map Editor

| Action name       | Windows, Linux | macOS        | Editor setting                    |
|-------------------|----------------|--------------|-----------------------------------|
| Find Tile         | `Ctrl + F`     | `Cmd + F`    | `tile_map_editor/find_tile`       |
| Pick Tile         | `I`            | `I`          | `tile_map_editor/pick_tile`       |
| Paint Tile        | `P`            | `P`          | `tile_map_editor/paint_tile`      |
| Bucket Fill       | `G`            | `G`          | `tile_map_editor/bucket_fill`     |
| Transpose         | `T`            | `T`          | `tile_map_editor/transpose`       |
| Flip Horizontally | `X`            | `X`          | `tile_map_editor/flip_horizontal` |
| Flip Vertically   | `Z`            | `Z`          | `tile_map_editor/flip_vertical`   |
| Rotate Left       | `A`            | `A`          | `tile_map_editor/rotate_left`     |
| Rotate Right      | `S`            | `S`          | `tile_map_editor/rotate_right`    |
| Clear Transform   | `W`            | `W`          | `tile_map_editor/clear_transform` |
| Select            | `M`            | `M`          | `tile_map_editor/select`          |
| Cut Selection     | `Ctrl + X`     | `Cmd + X`    | `tile_map_editor/cut_selection`   |
| Copy Selection    | `Ctrl + C`     | `Cmd + C`    | `tile_map_editor/copy_selection`  |
| Erase Selection   | `Del`          | `Cmd + BkSp` | `tile_map_editor/erase_selection` |

## Tileset Editor

| Action name         | Windows, Linux | macOS    | Editor setting                       |
|---------------------|----------------|----------|--------------------------------------|
| Next Coordinate     | `PgDown`       | `PgDown` | `tileset_editor/next_shape`          |
| Previous Coordinate | `PgUp`         | `PgUp`   | `tileset_editor/previous_shape`      |
| Region Mode         | `1`            | `1`      | `tileset_editor/editmode_region`     |
| Collision Mode      | `2`            | `2`      | `tileset_editor/editmode_collision`  |
| Occlusion Mode      | `3`            | `3`      | `tileset_editor/editmode_occlusion`  |
| Navigation Mode     | `4`            | `4`      | `tileset_editor/editmode_navigation` |
| Bitmask Mode        | `5`            | `5`      | `tileset_editor/editmode_bitmask`    |
| Priority Mode       | `6`            | `6`      | `tileset_editor/editmode_priority`   |
| Icon Mode           | `7`            | `7`      | `tileset_editor/editmode_icon`       |
| Z Index Mode        | `8`            | `8`      | `tileset_editor/editmode_z_index`    |

