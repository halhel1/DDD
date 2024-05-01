using Godot;
using System;
public class levelManager
{
    private int currentLevel = 1; 

   
    public int GetCurrentLevel()
    {
        return currentLevel;
    }

    
    public void IncreaseLevel()
    {
        currentLevel++;
    }

   
    public void SetCurrentLevel(int level)
    {
        currentLevel = Mathf.Max(1, level); 
    }
}