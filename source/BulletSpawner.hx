import Types.BulletType;
import flixel.math.FlxVector;

class BulletSpawner extends FlxSprite {
	public var speed:Float;
	public var timeScale:Float;
	public var bulletGroup:FlxTypedGroup<Bullet>;
	public var bulletType:BulletType;
	public var isStarted:Bool;
	public var initialFireCD:Float;
	public var fireCD:Float;

	/**
	 * Default to [0, 1] (For Enemies)
	 */
	public var fireDirection:FlxVector;

	public var firePoint:FlxPoint;

	public function new(x:Float, y:Float, bulletType:BulletType,
			bulletGroup:FlxTypedGroup<Bullet>) {
		super(x, y);
		this.speed = 200;
		this.initialFireCD = 0.25;
		this.fireCD = this.initialFireCD;
		this.timeScale = 1.0;
		this.bulletType = bulletType;
		this.bulletGroup = bulletGroup;
		this.firePoint = this.getPosition();
		this.fireDirection = new FlxVector(1, 0);
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
		this.updateFiring(elapsed * this.timeScale);
	}

	public function updateFiring(elapsed:Float) {
		if (isStarted && this.fireCD <= 0) {
			spawnBullets();
			this.fireCD = this.initialFireCD;
		} else {
			this.fireCD -= elapsed;
		}
	}

	public function spawnBullets() {}

	public function createBullet():Bullet {
		var bullet = null;
		if (bulletGroup.length < bulletGroup.maxSize) {
			bullet = new Bullet(this.bulletType);
		} else {
			bullet = bulletGroup.getFirstDead();
			bullet.revive();
		}
		this.firePoint = this.firePoint.rotate(FlxPoint.weak(0, 0), this.angle);
		bullet.setPosition(this.firePoint.x, this.firePoint.y);
		return bullet;
	}

	public function start() {
		isStarted = true;
	}

	public function stop() {
		isStarted = false;
	}
}