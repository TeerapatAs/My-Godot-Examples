# Collision2D
## Links
* [01. Raycast](#-01-movement-through-character2d-and-player-input)

## Hearts:
👩‍🦲 Layer  =  Who am I?

▶️ Mask   =  Who am I looking for?

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


