using Godot;
using System;

public partial class game_over : Control
{
	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
		
	}
	
	

	








private void _on_restart_pressed()
{
	GetTree().ChangeSceneToFile("res://Scenes/root.tscn");
}


private void _on_return_home_pressed()
{
GetTree().ChangeSceneToFile("res://Scenes/Menu/MainMenu.tscn");
}

}
