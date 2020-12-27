import Types.CharacterType;
import Types.CharacterType;

class WhiteKnight extends Enemy {
	public var spawnerOne:BulletSpawner;
	public var bulletGroup:FlxTypedGroup<Bullet>;

	public function new(x:Float, y:Float, type:CharacterType,
			bulletGroup:FlxTypedGroup<Bullet>) {
		super(x, y, type);
		this.bulletGroup = bulletGroup;
		makeGraphic(32, 32, FlxColor.RED);
		this.health = 250;
		this.spawnerOne = new LineSpawner(this.x, this.y, ENEMYBULLET,
			this.bulletGroup);
		this.spawnerOne.start();
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
		this.updateSpawners(elapsed);
	}

	public function updateSpawners(elapsed:Float) {
		this.spawnerOne.firePoint = new FlxPoint(this.x + this.width / 2,
			this.y + this.width / 2);
		// How to rotate the point for gameplay in Flixel
		this.spawnerOne.fireDirection.rotateByDegrees(5);
		this.spawnerOne.update(elapsed);
	}
}