class CommandHUD extends FlxTypedGroup<FlxSprite> {
	public var background:FlxSprite;
	public var commandText:FlxText;
	public var healthCounter:FlxText;
	public var attackButton:FlxButton;
	public var player:Player;

	public static inline var WIDTH = 200;

	public function new(?maxSize:Int, player:Player) {
		super(maxSize);
		this.player = player;
		create();
	}

	public function create() {
		var position = new FlxPoint(FlxG.width - WIDTH, 0);
		createBackground(position);
		createText(position);
		createBackground(position);
	}

	public function createBackground(position:FlxPoint) {
		background = new FlxSprite(position.x,
			position.y).makeGraphic(WIDTH, FlxG.height, 0x0C0F0AFF);
		// background.drawRect(0, 2, 98, FlxG.height, FlxColor.WHITE);
		add(background);
	}

	public function createText(position:FlxPoint) {
		var y = 0;
		// assumed max is 3 for hp
		healthCounter = new FlxText(position.x + 0, position.y + 200 + y,
			WIDTH, 'HP: ${player.health}/3', 24);
		y += 50;
		commandText = new FlxText(position.x + 0, position.y + 200 + y, WIDTH,
			'Commands', 24);

		add(healthCounter);
		add(commandText);
	}

	public function createButtons(position:FlxPoint) {
		attackButton = new FlxButton(position.x + 0, position.y + 240,
			'Attack', clickAttack);
		add(attackButton);
	}

	public function clickAttack() {}

	override public function update(elapsed:Float) {
		super.update(elapsed);
		updatePlayerHealth();
	}

	public function updatePlayerHealth() {
		healthCounter.text = 'HP: ${player.health}/3';
	}
}