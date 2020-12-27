import Types.WordType;

class Word extends FlxText {
	public var wordType:WordType;

	public static inline var SIZE = 24;

	public function new(x:Float, y:Float, wordType:WordType) {
		super(x, y, -1, pickText(wordType), SIZE);
		this.wordType = wordType;
		this.color = pickColor(this.wordType);
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
}