using Godot;
using System;
using System.Collections.Generic;

public partial class enemySpawner : Node2D
{
	
	private  PackedScene enemyScene;
	private PackedScene playerScene;
	private Node2D player;
	 private Random random = new Random();
	 private float minX = -500;
    private float maxX = 1500;
    private float minY = -500;
    private float maxY = 1500;
	private float enemyRadius=50;
	private List<Vector2>enemyPositions=new List<Vector2>();
	
	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		enemyScene=(PackedScene)ResourceLoader.Load("res://Scenes/Enemies/enemy.tscn");
		playerScene=(PackedScene)ResourceLoader.Load("res://Scenes/Player/player.tscn");
		player=GetNode<Node2D>("Player");
		spawnEnemies(10);
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
	}

	 private void spawnEnemies(int numEnemies)
    {
        for (int i = 0; i < numEnemies; i++)
        {
			Vector2 randomPosition;
			float randomScale;
			bool posValid=false;
			do{
			float randomX = (float)random.NextDouble() * (maxX - minX) + minX;
            float randomY = (float)random.NextDouble() * (maxY - minY) + minY;
			randomPosition = new Vector2(randomX, randomY);
			randomScale=(float)random.NextDouble()*(float)(0.9-0.2)+(float)0.8;
			posValid=isValidEnemy(randomPosition) && !isPlayerClose(randomPosition);

			}
			while(!posValid);
			enemyPositions.Add(randomPosition);
            Node2D enemyInstance = (Node2D)enemyScene.Instantiate();
            enemyInstance.Position = randomPosition;
			enemyInstance.Scale=new Vector2(randomScale,randomScale);
            AddChild(enemyInstance);
			
           
        }
    }

	private bool isValidEnemy(Vector2 newPosition){
		foreach(Vector2 position in enemyPositions){
			if(newPosition.DistanceTo(position)<enemyRadius*2){
				return false;
			}
		}
		return true;

	}

	private bool isPlayerClose(Vector2 newPosition){
		if(player!=null){
			float distanceToPlayer=player.Position.DistanceTo(newPosition);
			if(distanceToPlayer<enemyRadius *2){
				return true;
			}
		}
		return false;

	}

	
}
