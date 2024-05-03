using Godot;
using System;
public partial class level_3_gen : proc_gen

{
	private Vector2I stoneAtlas = new Vector2I(6, 5);
	private Vector2I flowerAtlas = new Vector2I(3, 4);
	

	int width, height;

	public override void _Ready()
	{
		base._Ready(); 

		
		width = 50; 
		height = 100; 

		
		GenerateLevel(width, height, stoneAtlas, flowerAtlas, stoneAtlas);
	}

	public override void _Process(double delta)
	{
		// Process logic
	}
}
