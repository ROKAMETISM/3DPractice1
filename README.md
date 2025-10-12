# 3dfps-practice-1

Practicing 3D programming in Godot by implementing DOOM-Like FPS.

https://www.youtube.com/watch?v=A3HLeyaBCq4&list=PLQZiuyZoMHcgqP-ERsVE4x4JSFojLdcBZ

##Todos

FiniteStateMachine for Enemy and Player

Pathfinding, NavigationMap and 3DMapEditing

Weapons : Sniper, GrenadeLauncher, PlasmaRifle, Machinegun, RocketLauncher

Ammosystem





##InputMaps

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


All Hitbox and Hurtbox are Area3Ds.
