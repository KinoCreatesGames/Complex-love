import Types.CharacterType;
import Types.CharacterType;

class WhiteKnight extends Enemy {
	public var spawnerOne:BulletSpawner;
	public var bulletGroup:FlxTypedGroup<Bullet>;
	public var wordGroup:FlxTypedGroup<FlxSprite>;
	public var ai:State;
	public var idleTimer:Float;
	public var patternTimer:Float;
	public var moveDirection:Int;
	public var maxHealth:Float;

	public static inline var SPEED:Int = 150;

	public function new(x:Float, y:Float, type:CharacterType,
			bulletGroup:FlxTypedGroup<Bullet>,
			wordGroup:FlxTypedGroup<FlxSprite>) {
		super(x, y, type);
		this.bulletGroup = bulletGroup;
		this.wordGroup = wordGroup;
		makeGraphic(32, 32, FlxColor.RED);
		health = 250;
		maxHealth = health;
		ai = new State(idle);
		idleTimer = 2.5;
		patternTimer = 2.5;
		moveDirection = 1;
		spawnerOne = new LineSpawner(this.x, this.y, ENEMYBULLET,
			this.bulletGroup);
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
		ai.update(elapsed);
	}

	public function updateSpawners(elapsed:Float) {}

	// States
	public function idle(elapsed:Float) {
		idleTimer -= elapsed;
		if (idleTimer <= 0) {
			idleTimer = 0;
			this.spawnerOne.start();
			ai.currentState = attackPatternOne;
		}
	}

	public function attackPatternOne(elapsed:Float) {
		this.spawnerOne.firePoint = new FlxPoint(this.x + this.width / 2,
			this.y + this.width / 2);
		// How to rotate the point for gameplay in Flixel
		this.spawnerOne.fireDirection.rotateByDegrees(5);
		this.spawnerOne.update(elapsed);

		if (rate() < 0.6) {
			ai.currentState = attackPatternTwo;
		}
		handleMovement(elapsed);
	}

	public function attackPatternTwo(elapsed:Float) {
		this.spawnerOne.update(elapsed);
	}

	public function spawnWords(elapsed:Float) {}

	public function handleMovement(elapsed:Float) {
		if (patternTimer <= 0) {
			moveDirection *= -1;
			patternTimer = 2.5 * 2;
		} else {
			patternTimer -= elapsed;
		}
		// Move From Side to Side
		velocity.set(SPEED * moveDirection, 0);
		// Keep boss within the game frame
		this.bound();
	}

	public function rate() {
		return health / maxHealth;
	}
}