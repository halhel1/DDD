using Godot;
using System;

public partial class options : Control
{
	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		
	}
	

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
		
	}





	private void _on_graphics_mostly_placeholder_pressed()
	{
	// Replace with function body.
	}


	private void _on_volume_pressed()
	{
	// Replace with function body.
	}


	private void _on_home_pressed()
	{
		GetTree().ChangeSceneToFile("res://Scenes/Menu/MainMenu.tscn");
	}





	private void _on_quit_pressed()
	{
	GetTree().Quit();
	}

	private void _on_Language_pressed()
	{
		GetTree().ChangeSceneToFile("res://language/language_setting.tscn");
	}

}







