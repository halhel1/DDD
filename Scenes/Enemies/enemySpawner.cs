using Godot;
using System;
using System.Collections.Generic;
public partial class enemySpawner : spawner
{
	Color[] colors = new Color[] {
    new Color(0, 1, 0),      
    new Color(0, 1, 1),      
	new Color(0, 0.5f, 1),   
};
	public override void _Ready(){
		base._Ready();
		setEntity((PackedScene)ResourceLoader.Load("res://Scenes/Enemies/jellyfish.tscn"),200);
		spawnEntities(15,colors,"jellyfishSprite"); 
	}
	 protected override bool isValidEntity(Vector2 newPos){
		return base.isValidEntity(newPos);

	}
}