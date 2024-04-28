using Godot;
using System;
using System.Collections.Generic;
using System.Linq;
public partial class proc_gen : Node2D
{ 
    [Export]
    public NoiseTexture2D noiseHeightTeXt;
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
    PackedScene Border;
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
        for (int X = 0; X < width; X++)
    {
        for (int Y = 0; Y < height; Y++)
        {
            if (X == 0 || X == width - 1 || Y == 0 || Y == height - 1)
            {
                
                tileMap.SetCell(ground3, new Vector2I(X, Y), 0, borderAtlas, 0);
                
                
            }
        }
    }
     
        for (int X = 1; X < width-1; X++)
        {
            for (int Y = 1; Y < height-1; Y++)
            {
                float noiseVal = noise.GetNoise(X, Y);
                noiseValArr[X + Y * width] = noiseVal;
                if(noiseVal >= 0.0){
                    tileMap.SetCell(ground,new Vector2I(X,Y),0,dirtAtlas,0);
                    if (rand.Next(3) == 0){
                    tileMap.SetCell(ground1, new Vector2I(X, Y), 0, seaweedAtlas, 0);
                    }
                }
                 else if(noiseVal >= -0.5){
                    tileMap.SetCell(ground1,new Vector2I(X,Y),0,grassAtlas,0);
                    if (rand.Next(3) == 0){
                    tileMap.SetCell(ground1, new Vector2I(X, Y), 0, dirtAtlas, 0);
                    }
                }
                else {
                    tileMap.SetCell(ground2,new Vector2I(X,Y),0,dirtAtlas,0);
                    if (rand.Next(9) == 0){
                    tileMap.SetCell(ground2, new Vector2I(X, Y), 0, grassAtlas, 0);
                    } 
                }
            
            }
        }
    }
   
}