## Null Instance due to Loading not successful.

**Always Remember:**

1. Instantiate                       ```var child = ABC.new() ```          
2. Set Variables in child **first**      ``` set_variables(child) ```
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
