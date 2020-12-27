class MsgWindow extends FlxTypedGroup<FlxSprite> {
	public var position:FlxPoint;
	public var background:FlxSprite;
	public var text:FlxText;

	public static inline var WIDTH:Int = 400;
	public static inline var HEIGHT:Int = 200;
	public static inline var BGCOLOR:Int = FlxColor.BLACK;

	public function new() {
		super();
		create();
	}

	public function create() {
		createBackground(position);
		createText(position);
	}

	public function createBackground(positioin:FlxPoint) {
		background = new FlxSprite(position.x,
			position.y).makeGraphic(WIDTH, HEIGHT, BGCOLOR);
		add(background);
	}

	public function createText(position:FlxPoint) {
		var x = position.x + 12;
		var y = position.y + 12;
		text = new FlxText(x, y, WIDTH - 12, '', 16);
		text.wordWrap = true;
		add(text);
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
	}

	public function sendMessage(text:String, ?speakerName:String) {
		if (speakerName != null) {
			this.text.text = '${speakerName}:${text}';
		} else {
			this.text.text = '${text}';
		}
	}

	public function show() {
		visible = true;
	}

	public function hide() {
		visible = false;
	}
}