using Godot;
using System;

public class LevelManagerWrapper
{
    private GDScript _levelManager;

    public LevelManagerWrapper(GDScript levelManager)
    {
        _levelManager = levelManager;
    }

    public void IncreaseLevel()
    {
        _levelManager.Call("increase_level");
    }

    public void SetCurrentLevel(int level)
    {
        _levelManager.Call("set_current_level", level);
    }

    public int GetCurrentLevel()
    {
        return (int)_levelManager.Call("get_current_level");
    }
}