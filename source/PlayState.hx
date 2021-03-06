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
		bossHealthBar = new FlxBar(0, 0, LEFT_TO_RIGHT, 400, 40, boss,
			'health', 0, boss.health, true);
		bossHealthBar.createFilledBar(FlxColor.GRAY, FlxColor.RED);
		// bossHealthBar.color = FlxColor.RED;
		bossHealthBar.screenCenter(FlxAxes.X);
		this.player = player;

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
		updatePauseState();
		updateCollisions();
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

	public function updatePlayerCollisions() {}

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
}