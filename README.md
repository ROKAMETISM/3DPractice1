# 3DFPS Practice1

Practicing 3D programming in Godot by implementing DOOM-Like FPS.

https://www.youtube.com/watch?v=A3HLeyaBCq4&list=PLQZiuyZoMHcgqP-ERsVE4x4JSFojLdcBZ

##Todos

###FiniteStateMachine for Enemy and Player

https://www.youtube.com/watch?v=bNdFXooM1MQ

https://github.com/theshaggydev/the-shaggy-dev-projects/tree/main/projects/godot-4/advanced-state-machines

https://shaggydev.com/2023/11/28/godot-4-advanced-state-machines/

###Pathfinding, NavigationMap and 3DMapEditing

###Weapons : Sniper, Machinegun, Ballista, BFG

###Ammosystem

###Collectables

###Weapon Visualization on screen

Weapon Visualization is affected by camera FOV...

Possible Solutions : 
	
	- draw weapon_vis on canvaslayer
	
	- use multiple cameras and combine them with subviewports

###Enemy AI and enemy variations

AI Behavior tree

##==InputMaps==

[WASD] : Player Movement

[CTRL] : Sprint

[Shift] : Dash

[Space] : Jump

[Mouse Left Button] : Fire Main

[Mouse Right Button] : Fire Special

[Mouse Scroll Up] / [>] : Switch Weapon to Next

[Mouse Scroll Down] / [<] : Switch Weapon to Previous



##Collision Layer Data

Layer 1 (Body) : PhysicsCollision for movement.

Layer 2 (Area) : Collision for environment (to block bullets etc.)

Layer 3 (Area) : Player Hurtbox

Layer 4 (Area) : Player (and all player-driven obejects) Hitbox

Layer 5 (Area) : Enemy Hurtbox

Layer 6 (Area) : Enemy Hitbox

Layer 7 (Area) : Collectable Hurtbox so that player can grab these


All Hitbox and Hurtbox are Area3Ds.
