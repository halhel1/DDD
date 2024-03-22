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

	private void _on_back_pressed(){
		Console.WriteLine("hi");
		GetTree().ChangeSceneToFile("res://Scenes/Menu/MainMenu.tscn");
	}

	private void _on_return_home_pressed(){
		GetTree().ChangeSceneToFile("res://Scenes/Menu/MainMenu.tscn");

	}
}

