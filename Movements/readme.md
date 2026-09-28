# Movements
* [01. Movement through Character2D and Player Input](#-01-movement-through-character2d-and-player-input)
* [02. Movement through Kinetic script](#-02-movement-through-kinetic-script)
* [03. Movement through NavigateAgent2D: PATROL, PURSUIT, and WANDER](#-03-movement-through-navigateagent2d--patrol-pursuit-and-wander)
* [04. NavigateAgent2D](#-🗺️-04-navigateagent2d)
## 🏃 01. Movement through Character2D and Player Input
<img width="200" height="100" alt="image" src="https://github.com/user-attachments/assets/12188060-68f7-471b-90a4-1bf63dd8aacd" /> <img width="200" height="100" alt="image" src="https://github.com/user-attachments/assets/8de13339-3fa3-4846-a06b-1dcf1a244471" />

Use move_and_slide() to update the position to the desired location.

## 🏃 02. Movement through Kinetic script
<img width="200" height="93" alt="image" src="https://github.com/user-attachments/assets/87efbfae-8b87-47b9-a58c-655f1b17a1c1" />

Use [velocity] to update the position and rotation to the desired location. No need for move_and_slide().

## 🗺️ 📌 03. Movement through NavigateAgent2D: PATROL, PURSUIT, and WANDER

<img width="200" height="100" alt="image" src="https://github.com/user-attachments/assets/01d7fa14-385e-4daf-aaa0-902d8fe56d7e" />

Use [NavigateAgent2D] to update the position.

**This script includes**
1. Area2D --> [ Collision2D ] [ Raycast ]
2. NaviateAgent2D

**🚶‍♂️ WANDER**

<img width="200" height="100" alt="image" src="https://github.com/user-attachments/assets/e85b730e-4383-4d27-be4d-dd63d284530e" />

Move in random direction with random [velocity] Vector.   

## 🧙 🗺️ 04. NavigateAgent2D
<img width="300" height="100" alt="image" src="https://github.com/user-attachments/assets/b800bd75-246a-4d0c-ac6b-aac06d2d37de" />

### 🥇 Common Var and Func.
* target_position: Vector2                    Use to set a new target ending point.

***Warning***: Setting [ target_position ] multiple times in one frame ( Ex. Updating target_position on _process() )
make Navigation Logic error! 

🩹 FIX: Only update when a new [ target_position ] is not the same vector as the old one.
```
if navigation_agent_2d.target_position != target_pos:
		navigation_agent_2d.target_position = target_pos
```
* is_navigation_finished() -> bool					true if Node reaches [target_position].
  
* get_next_path_position() -> Vector2				return next point in path for Node to move to.
  
  <img width="120" height="120" alt="image" src="https://github.com/user-attachments/assets/fd2ea0ab-ea30-4fe4-9e05-f290f4a563d9" />

### 🗺️ Set Up TileMap for NavigateAgent
**Note:** The navigation only works on the tilemap that is set. If you don't set the tile, that tile is invisible to NavigateAgent. 
* 📓 **Set Navigation Layer**: TileMap -> Tileset -> Set [ Navigation Layer ] as same as the [ Navigation Layer ] in [NavigateAgent2D]
  
<img width="230" height="250" alt="image" src="https://github.com/user-attachments/assets/6aa262d9-808b-46a1-8d9d-3f2a81e085b0" />
<img width="230" height="250" alt="image" src="https://github.com/user-attachments/assets/9176c448-f486-48d8-9f05-08f2ebb5d517" />

* ☑️ **Set navigation Shape**: Follow pics. After this, the tile should be covered in blue like in the last pic.

<img width="230" height="200" alt="image" src="https://github.com/user-attachments/assets/835e2533-63ed-4fcb-9a49-edc7eba7cbe9" />
<img width="150" height="100" alt="image" src="https://github.com/user-attachments/assets/e848586e-c4e6-4762-9d39-d7037ec0d441" />
<img width="120" height="150" alt="image" src="https://github.com/user-attachments/assets/6a3f8d2c-6984-49f4-921e-04fc7aa2b2a8" />






