using Godot;
using System;
using System.Collections.Generic;

public partial class spawner : Node2D
{
	private  PackedScene entityScene;
	private PackedScene playerScene;
	private Node2D player;
	 private Random random = new Random();
	 private float minX = 200;
    private float maxX = 4000;
    private float minY = 0;
    private float maxY = 1000;
	private float entityRadius;
	private List<Vector2>spawnPositions=new List<Vector2>();
	
	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
        
		playerScene=(PackedScene)ResourceLoader.Load("res://Scenes/Player/player.tscn");
		player=(Node2D)playerScene.Instantiate();
		
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
	}
    public void setEntity(PackedScene entityScene, float entityRadius){
        this.entityScene=entityScene;
        this.entityRadius=entityRadius;

    }

	 protected void spawnEntities(int numEntities,Color[]colors,string sprite)
    {
        for (int i = 0; i < numEntities; i++)
        {
			Vector2 randomPos;
			float randomScale;
			bool posValid=false;
			do{
			float randomX = (float)random.NextDouble() * (maxX - minX) + minX;
            float randomY = (float)random.NextDouble() * (maxY - minY) + minY;
			randomPos = new Vector2(randomX, randomY);
			randomScale=(float)random.NextDouble()*(float)(0.9-0.2)+(float)0.8;
			posValid=isValidEntity(randomPos) && !isPlayerClose(randomPos);
			}
			while(!posValid);
			spawnPositions.Add(randomPos);
            Node2D obstacleInstance = (Node2D)entityScene
    .Instantiate();
            obstacleInstance.Position = randomPos;
			obstacleInstance.Scale=new Vector2(randomScale,randomScale);
			AnimatedSprite2D entitySprite=obstacleInstance.GetNode<Godot.AnimatedSprite2D>(sprite);
			if(entitySprite!=null){
				entitySprite.Modulate = Colors.White;
				int colorIndex = random.Next(0, colors.Length);
				entitySprite.Modulate *= colors[colorIndex];
			}
			AddChild(obstacleInstance);
        }
    }

	 protected void spawnEntities(int numEntities)
    {
        for (int i = 0; i < numEntities; i++)
        {
			Vector2 randomPos;
			float randomScale;
			bool posValid=false;
			do{
			float randomX = (float)random.NextDouble() * (maxX - minX) + minX;
            float randomY = (float)random.NextDouble() * (maxY - minY) + minY;
			randomPos = new Vector2(randomX, randomY);
			randomScale=(float)random.NextDouble()*(float)(0.9-0.2)+(float)0.8;
			posValid=isValidEntity(randomPos) && !isPlayerClose(randomPos);
			}
			while(!posValid);
			spawnPositions.Add(randomPos);
            Node2D obstacleInstance = (Node2D)entityScene
    .Instantiate();
            obstacleInstance.Position = randomPos;
			obstacleInstance.Scale=new Vector2(randomScale,randomScale);
			AddChild(obstacleInstance);
        }
    }

	protected virtual bool isValidEntity(Vector2 newPos){
		foreach(Vector2 position in spawnPositions){
			if(newPos.DistanceTo(position)<entityRadius*2){
				return false;
			}
		}
		return true;

	}

	private bool isPlayerClose(Vector2 newPos){
		if(player!=null){
			float distanceToPlayer=player.Position.DistanceTo(newPos);
			if(distanceToPlayer<entityRadius * 2){
				
				return true;
			}
		}
		return false;

	}
}
