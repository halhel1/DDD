using Godot;
using System;
using System.Collections.Generic;
using System.Linq;
public partial class proc_gen : Node2D
{ 
    [Export]
    public NoiseTexture2D noiseHeightText;
    private FastNoiseLite noise;
    private float[] noiseValArr;
    private int width = 50;
    private int height = 50;
    private TileMap tileMap;
    private int sourceId=0;
    private Vector2I dirtAtlas= new Vector2I(3,2);
    private Vector2I seaweedAtlas=new Vector2I(10,3);
    private Vector2I wallAtlas=new Vector2I(4,2);
    Random rand = new Random();
    public override void _Ready()
    {
        tileMap = GetNode<TileMap>("TileMap");
        noise = new FastNoiseLite(); 
        noise.SetSeed((int)DateTime.Now.Ticks);
        noise.SetNoiseType(FastNoiseLite.NoiseType.Perlin);
        noise.SetFrequency((float)0.04);
        GenerateWorld();
    }

    void GenerateWorld()
    {
        noiseValArr = new float[width * height];
        for (int x = 0; x < width; x++)
        {
            for (int y = 0; y < height; y++)
            {
                float noiseVal = noise.GetNoise(x, y);
                noiseValArr[x + y * width] = noiseVal;
                if(noiseVal >= 0.0){
                    tileMap.SetCell(-2,new Vector2I(x,y),0,dirtAtlas,0);
                    if (rand.Next(3) == 0){
                    tileMap.SetCell(-3, new Vector2I(x, y), 0, seaweedAtlas, 0);
                    }
                }
                 else if(noiseVal >= 0.3){
                    
                    tileMap.SetCell(-3,new Vector2I(x,y),0,wallAtlas,0);
                    if (rand.Next(3) == 0){
                    tileMap.SetCell(-3, new Vector2I(x, y), 0, dirtAtlas, 0);
                    }
                    
                }
                else if(noiseVal < 0.3){
                    
                    tileMap.SetCell(-4,new Vector2I(x,y),0,wallAtlas,0);
                    if (rand.Next(3) == 0){
                    tileMap.SetCell(-4, new Vector2I(x, y), 0, dirtAtlas, 0);
                    } 
                }
            }
        }
    }
}