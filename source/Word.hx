import Types.WordType;
import flixel.FlxObject;
import flixel.math.FlxMath;

class Word extends FlxText {
	public var wordType:WordType;
	public var lifeCount:Float;

	public static inline var SIZE = 24;

	public function new(x:Float, y:Float, wordType:WordType) {
		super(x, y, -1, pickText(wordType), SIZE);
		this.wordType = wordType;
		this.color = pickColor(this.wordType);
		lifeCount = 0;
		// By default Flx Text do not allow for collisions width/height work
		allowCollisions = FlxObject.ANY;
		// trace(this.allowCollisions);
	}

	public function pickText(wordType:WordType):String {
		return switch (wordType) {
			case CONSOLE:
				'Console';
			case SHAME:
				'Shame';
			case LOVE:
				'Love';
			case HATE:
				'Hate';
		}
	}

	public function pickColor(wordType:WordType) {
		return switch (wordType) {
			case CONSOLE:
				FlxColor.WHITE;
			case SHAME:
				FlxColor.BLUE;
			case LOVE:
				0xFF206EFF;
			case HATE:
				FlxColor.RED;
		}
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
		grow(elapsed);
	}

	public function grow(elapsed:Float) {
		var formula = (lifeCount % 360).degToRad();
		trace(FlxMath.fastSin(formula));
		this.scale.y = Math.abs(FlxMath.fastSin(formula)).clampf(0.5, 1);
		// this.scale.x = Math.abs(FlxMath.fastCos(formula)).clampf(0.5, 1);
		lifeCount += 1;
		updateHitbox();
	}
}