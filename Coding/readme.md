## Null Instance due to Loading not successful.
### new() vs instantiate()

***Use Class.new() if***
1. Class is Pure Code: Resources, custom data classes, pure code objects ( ex. AttackObserver )
  
2. You need to access a function in class.

#### Example: 

1. If a class is an extends of **node** . You can access a child node function in that node by 
   
```
  SceneTree --> Main
            -----> Hello : Hello.gd
            -----> Error_Label : Error_Label.gd <-- We want "Main" in SceneTree to use a function in Error_Label.gd
```

In Error_Label.gd
```
class_name ErrorDisplayNode
extends Label
func set_error_text(_text:String): <-- We want this!
```

In Hello.gd, 

```
@onready var error_display: ErrorDisplayNode = %"Error Display" <-- Identified class name " ErrorDisplayNode" to var "error_display" first
error_display.set_error_text() <-- AutoComplete!
```

2.



---
3. If a class is an extends of **RefCounted**

4. Code doesn't need to have @onready and them


   ** How to Access**
   
   ``` var an_observer = AnObserver.new()```


***Use Class.instantiate() if***
1. Class is Scene. You need .tscn.
2. Code need to have @onready and them
  ** How to Access**
   
1. *Preload* ```@onready var scene:packedScene = load("%some_uid")```
   
2. *Export : Easy way* ```@export var wanted_scene : PackedScene```
   
  ```var scene = wanted_scene.instantiate()```
### Always Remember Order for Scene!!!:
1. Instantiate Scene        ```var child = ABC.instantiate() ```          
2.  Add child **first**      ```   A_Node.add_child(child) <-- Now, _onready is called. All @onready var is ready!```
3. Then,  Set Variables in child                   ``` A_Node.add_child(child)  < -- You can set @onready var child_node's property here ``````


## Direct class_name function called.
ex. When DamageNumber is a class.
```
DamageNumber.deal_damage(collider,damage,is_critical)
```
*deal_damage* can be called if it is a **static function**.

A **static function** is:

1. A function that belongs to the class itself rather than a specific instance of that class. I.E., no extends can be use this function.

2. No self access: Because it runs outside the context of an instance, a static function cannot access self
