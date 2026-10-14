## Null Instance due to Loading not successful.
### new() vs instantiate()

***Use Class.new() if***
1. Class is Pure Code: Resources, custom data classes, pure code objects ( ex. AttackObserver )
2. Code doesn't need to have @onready and them
   ** How to Access**
   ``` var an_observer = AnObserver.new()```

***Use Class.instantiate() if***
1. Class is Scene. You need .tscn.
2. Code need to have @onready and them
  ** How to Access**
   ```@export var wanted_scene : PackedScene
  var scene = wanted_scene.instantiate()```
### Always Remember Order for Scene!!!:
1. Instantiate Scene        ```var child = ABC.instantiate() ```          
2. Set Variables in child **first**      ``` set_variables(child)   < -- You can set @onready var child_node's property here ```
3. Then, Add Child!                   ``` A_Node.add_child(child) ```


## Direct class_name function called.
ex. When DamageNumber is a class.
```
DamageNumber.deal_damage(collider,damage,is_critical)
```
*deal_damage* can be called if it is a **static function**.

A **static function** is:

1. A function that belongs to the class itself rather than a specific instance of that class. I.E., no extends can be use this function.

2. No self access: Because it runs outside the context of an instance, a static function cannot access self
