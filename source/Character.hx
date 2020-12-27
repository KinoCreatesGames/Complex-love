import Types.CharacterType;

class Character extends FlxSprite {
	public var entityType:CharacterType;

	public function new(x:Float, y:Float, type:CharacterType) {
		super(x, y);
		this.entityType = type;
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
	}
}