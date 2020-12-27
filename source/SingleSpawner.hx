import flixel.math.FlxVector;

class SingleSpawner extends BulletSpawner {
	override public function spawnBullets() {
		var startAngle = 180;
		var fireDirection = new FlxVector(1, 0);
		fireDirection = this.fireDirection.copyTo(fireDirection);
		var bullet = this.createBullet();
		fireDirection = fireDirection.rotateByDegrees(startAngle + this.angle);
		this.bulletGroup.add(bullet);
		bullet.fire(fireDirection);
	}
}