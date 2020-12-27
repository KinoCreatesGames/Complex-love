package;

import Types.CharacterType;
import flixel.math.FlxVector;

class Player extends Character {
	static inline var SPEED:Float = 200;
	static inline var BULLETCD:Float = 0.15;

	public var fireCD:Float;

	public var playerBullets:FlxTypedGroup<Bullet>;

	public var firePoint:FlxPoint;

	public function new(x:Float = 0, y:Float = 0, type:CharacterType,
			bulletGroup:FlxTypedGroup<Bullet>) {
		super(x, y, type);
		makeGraphic(16, 16, FlxColor.WHITE);
		this.playerBullets = bulletGroup;
		this.health = 3;
		fireCD = BULLETCD;
		// Temporarily slow down player for when buttons not pressed
		drag.x = drag.y = 1600;
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
		updateFire(elapsed);
		updateMovement(elapsed);
	}

	public function updateFire(elapsed:Float) {
		var firing = false;
		firing = FlxG.keys.anyPressed([Z]);

		if (firing && fireCD <= 0) {
			fireCD = BULLETCD;
			trace('Firing');
			var xOffset = 12;
			this.firePoint = new FlxPoint(8 + x, 8 + y);
			var bullet = null;
			var secondBullet = null;
			var fireVec = new FlxVector(0, -1);
			if (playerBullets.length < 50) {
				bullet = new Bullet(PLAYERBULLET);
				secondBullet = new Bullet(PLAYERBULLET);
				playerBullets.add(bullet);
				playerBullets.add(secondBullet);
			} else {
				bullet = playerBullets.getFirstDead();
				bullet.revive();
				secondBullet = playerBullets.getFirstDead();
				secondBullet.revive();
			}
			bullet.setPosition(this.firePoint.x - xOffset, this.firePoint.y);
			bullet.fire(fireVec);
			secondBullet.setPosition(this.firePoint.x + xOffset,
				this.firePoint.y);
			secondBullet.fire(fireVec);
		}
		fireCD -= elapsed;
	}

	public function updateMovement(elapsed:Float) {
		var up = false;
		var down = false;
		var left = false;
		var right = false;

		up = FlxG.keys.anyPressed([UP, W]);
		down = FlxG.keys.anyPressed([DOWN, S]);
		left = FlxG.keys.anyPressed([LEFT, A]);
		right = FlxG.keys.anyPressed([RIGHT, D]);

		if (up && down) up = down = false;
		if (left && right) left = right = false;

		// Handle Actual Movement
		if (up || down || left || right) {
			var newAngle:Float = 0;
			if (up) {
				newAngle = -90;
				if (left) newAngle -= 45; else if (right) newAngle += 45;
			} else if (down) {
				newAngle = 90;
				if (left) newAngle += 45; else if (right) newAngle -= 45;
			} else if (left) {
				newAngle = 180;
			} else if (right) {
				newAngle = 0;
			}

			velocity.set(SPEED, 0);
			velocity.rotate(FlxPoint.weak(0, 0), newAngle);
		}
	}
}