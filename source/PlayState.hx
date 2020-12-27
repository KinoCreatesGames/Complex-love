package;

import Player;
import Types.CharacterType;
import flixel.FlxState;
import flixel.util.FlxAxes;

class PlayState extends FlxState {
	public var characters:FlxTypedGroup<Character>;
	public var enemies:FlxTypedGroup<Enemy>;
	public var player:Player;
	public var playerBullets:FlxTypedGroup<Bullet>;
	public var enemyBullets:FlxTypedGroup<Bullet>;
	public var bossHealthBar:FlxBar;
	public var playerCommandHUD:CommandHUD;

	override public function create() {
		// Add Groups -- > Adding groups shows them in the state
		characters = new FlxTypedGroup<Character>();
		enemies = new FlxTypedGroup<Enemy>();
		playerBullets = new FlxTypedGroup<Bullet>(50);
		enemyBullets = new FlxTypedGroup<Bullet>(1000);
		add(characters);
		add(enemies);
		add(playerBullets);
		add(enemyBullets);

		// ========= Add Characters
		var text = new FlxText(10, 10, 100, "Hello, World!");
		var player = new Player(20, 0, PLAYER, playerBullets);
		var boss = new WhiteKnight(20, 150, BOSS, enemyBullets);

		this.player = player;

		// Add UI
		bossHealthBar = new FlxBar(0, 0, LEFT_TO_RIGHT, 400, 40, boss,
			'health', 0, boss.health, true);
		bossHealthBar.createFilledBar(FlxColor.GRAY, FlxColor.RED);
		// bossHealthBar.color = FlxColor.RED;
		bossHealthBar.screenCenter(FlxAxes.X);

		playerCommandHUD = new CommandHUD(this.player);

		add(playerCommandHUD);

		characters.add(player);
		characters.add(boss);
		enemies.add(boss);
		add(bossHealthBar);
		placeEntities();
		super.create();
	}

	public function placeEntities() {
		for (character in characters) {
			switch (character.entityType) {
				case PLAYER:
					character.screenCenter();
				case BOSS:
					character.screenCenter(FlxAxes.X);
				case WORD:
					// Do nothing
			}
		}
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
		updateGameOverState();
		updatePauseState();
		updateCollisions();
	}

	public function updateGameOverState() {
		if (!player.alive) {
			openSubState(new GameOverSubState(FlxColor.BLACK));
		}
	}

	public function updatePauseState() {
		if (FlxG.keys.anyJustPressed([ESCAPE])) {
			openSubState(new PauseSubState());
		}
	}

	public function updateCollisions() {
		updatePlayerCollisions();
		updateEnemyCollisions();
	}

	public function updatePlayerCollisions() {
		FlxG.overlap(player, enemyBullets, enemyBulletTouchPlayer);
	}

	public function updateEnemyCollisions() {
		FlxG.overlap(enemies, playerBullets, playerBulletTouchEnemy);
	}

	public function playerBulletTouchEnemy(enemy:Enemy, bullet:Bullet) {
		// Enemy Take Hp
		enemy.health -= 1;

		if (enemy.health <= 0) {
			bossHealthBar.kill();
			enemy.kill();
		}
		bullet.kill();
	}

	public function enemyBulletTouchPlayer(player:Player, bullet:Bullet) {
		shakeCamera();
		player.health -= 1;
		if (player.health <= 0) {
			player.kill();
		}
		bullet.kill();
	}

	public function shakeCamera() {
		FlxG.camera.shake(0.01, 0.1);
	}
}