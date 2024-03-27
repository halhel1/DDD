using Godot;
using System;
using System.Collections.Generic;

public partial class obstacleSpawner : Node2D
{
	
	private  PackedScene obstacleScene;
	private PackedScene playerScene;
	private Node2D player;
	 private Random random = new Random();
	 private float minX = -500;
    private float maxX = 1500;
    private float minY = -500;
    private float maxY = 1500;
	private float obstacleRadius=200;
	private List<Vector2>obstaclePositions=new List<Vector2>();
	
	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		obstacleScene=(PackedScene)ResourceLoader.Load("res://Scenes/terrain.tscn");
		playerScene=(PackedScene)ResourceLoader.Load("res://Scenes/Player/player.tscn");
		player=GetNode<Node2D>("Player");
		spawnObstacles(10);
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
	}

	 private void spawnObstacles(int numObstacles)
    {
        for (int i = 0; i < numObstacles; i++)
        {
			Vector2 randomPosition;
			float randomScale;
			bool posValid=false;
			do{
			float randomX = (float)random.NextDouble() * (maxX - minX) + minX;
            float randomY = (float)random.NextDouble() * (maxY - minY) + minY;
			randomPosition = new Vector2(randomX, randomY);
			randomScale=(float)random.NextDouble()*(float)(0.9-0.2)+(float)0.8;
			posValid=isValidObstacle(randomPosition) && !isPlayerClose(randomPosition);

			}
			while(!posValid);
			obstaclePositions.Add(randomPosition);
            Node2D obstacleInstance = (Node2D)obstacleScene.Instantiate();
            obstacleInstance.Position = randomPosition;
			obstacleInstance.Scale=new Vector2(randomScale,randomScale);
            AddChild(obstacleInstance);
			
           
        }
    }

	private bool isValidObstacle(Vector2 newPosition){
		foreach(Vector2 position in obstaclePositions){
			if(newPosition.DistanceTo(position)<obstacleRadius*2){
				return false;
			}
		}
		return true;

	}

	private bool isPlayerClose(Vector2 newPosition){
		if(player!=null){
			float distanceToPlayer=player.Position.DistanceTo(newPosition);
			if(distanceToPlayer<obstacleRadius *2){
				return true;
			}
		}
		return false;

	}

	
}
