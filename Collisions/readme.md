# Collision2D
## Links
* [01. Raycast](#1-raycast) : Guard.gd

## Hearts:
🤚 Layer  =  Who am I?

🕵️ Mask   =  Who am I looking for?

Ex. Player is mask1 can stand on the floor with Layer1.
### 1. Raycast
Checkout functions : check_line_sight(), _on_area_2d_body_entered(body: Node2D), and _on_area_2d_body_exited(body: Node2D).

<img width="262" height="277" alt="image" src="https://github.com/user-attachments/assets/301a9caf-101e-4780-97e1-4b6d61395806" />

* Target Position: Vector2
  ```
  ray_cast.target_position = to_local(player_body.global_position)
  ```
* force_raycast_update()
  
Get Raycast Info immediately. Normally Info is coming out after a frame.

* get_collider()
  
  Get what collided with the Raycast, Use with force_raycast_update() to gain updated Info.  ex.
  ``` var collider = ray_cast.get_coliider() ; if collider is Player ...```

### 2. Collision TileMap

* **🤚 Layer**
  
<img width="307" height="231" alt="image" src="https://github.com/user-attachments/assets/3e1c359a-2011-4ea5-8ba0-e412d64247ad" />

  ex. Floor = Layer1 , then player = mask1 

  
* **🕵️ Mask**
  
<img width="316" height="192" alt="image" src="https://github.com/user-attachments/assets/7dc82a26-d997-4997-b024-a5e64592a109" />

  ***Set up for detection***
  
  ex. Floor = mask 1,2, and 3, then the floor can detects Object with Layer 1,2, and 3.
  
  ex.2 Spike Floor mask = 2 can detect Enemy with Layer = 2, Not Player with Layer = 1.
  
  
* **🗺️ Set Up**

TileMap -> Tileset -> Set [ Physics layer ] -> Set [ Physics Layer ] Shape.

Please Refer to Movements/04.NavigateAgent2D -> Set Up
