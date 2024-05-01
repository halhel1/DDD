using Godot;
using System;

public partial class game_over : Control
{
private void _on_restart_pressed()
{
	GetTree().ChangeSceneToFile("res://Scenes/Levels/level_1.tscn");
}

private void _on_return_home_pressed()
{
GetTree().ChangeSceneToFile("res://Scenes/Menu/MainMenu.tscn");
}
}
