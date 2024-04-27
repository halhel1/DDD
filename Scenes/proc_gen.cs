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
    private int height = 100;
    private TileMap tileMap;
    private int sourceId=0;
    private Vector2I dirtAtlas= new Vector2I(3,2);
    private Vector2I seaweedAtlas=new Vector2I(10,3);
    private Vector2I grassAtlas=new Vector2I(4,2);
    private Vector2I borderAtlas=new Vector2I(8,5);
    Random rand = new Random();
    int ground=0;
    int ground1=1;
    int ground2=2;
    int ground3=3;
    int ground4=4;
    public override void _Ready()
    {
        tileMap = GetNode<TileMap>("TileMap");
        noise = new FastNoiseLite(); 
        noise.SetSeed((int)DateTime.Now.Ticks);
        noise.SetNoiseType(FastNoiseLite.NoiseType.Perlin);
        noise.SetFrequency((float)0.04);
        GenerateLevel();
    }
    void GenerateLevel()
    {
        noiseValArr = new float[(width) * (height)];
     
        for (int x = 1; x < width-1; x++)
        {
            for (int y = 1; y < height-1; y++)
            {
                float noiseVal = noise.GetNoise(x, y);
                noiseValArr[x + y * width] = noiseVal;
                if(noiseVal >= 0.0){
                    tileMap.SetCell(ground,new Vector2I(x,y),0,dirtAtlas,0);
                    if (rand.Next(3) == 0){
                    tileMap.SetCell(ground1, new Vector2I(x, y), 0, seaweedAtlas, 0);
                    }
                }
                 else if(noiseVal >= -0.5){
                    tileMap.SetCell(ground1,new Vector2I(x,y),0,grassAtlas,0);
                    if (rand.Next(3) == 0){
                    tileMap.SetCell(ground1, new Vector2I(x, y), 0, dirtAtlas, 0);
                    }
                }
                else {
                    tileMap.SetCell(ground2,new Vector2I(x,y),0,dirtAtlas,0);
                    if (rand.Next(9) == 0){
                    tileMap.SetCell(ground2, new Vector2I(x, y), 0, grassAtlas, 0);
                    } 
                }
            
            }
        }
    }
}