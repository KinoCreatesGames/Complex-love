import flixel.math.FlxVector;

class VSpawner extends BulletSpawner {
	override public function spawnBullets() {
		var xBulletLength = 2;
		var startAngle = 45;
		var fireDirection = new FlxVector(1, 0);
		fireDirection = this.fireDirection.copyTo(fireDirection);
		for (i in 0...xBulletLength) {
			var bullet = this.createBullet();

			fireDirection = fireDirection.rotateByDegrees(startAngle
				+ this.angle);
			this.bulletGroup.add(bullet);
			bullet.fire(fireDirection);
			startAngle = 90;
		}
	}
}