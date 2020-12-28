class CommandHUD extends FlxTypedGroup<FlxSprite> {
	public var background:FlxSprite;
	public var commandText:FlxText;
	public var healthCounter:FlxText;
	public var attackButton:FlxButton;
	public var consoleButton:FlxButton;
	public var loveButton:FlxButton;
	public var shameButton:FlxButton;
	public var hateButton:FlxButton;
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
		createButtons(position);
	}

	public function createBackground(position:FlxPoint) {
		background = new FlxSprite(position.x,
			position.y).makeGraphic(WIDTH, FlxG.height, 0x0C0F0AFF);
		// background.drawRect(0, 2, 98, FlxG.height, FlxColor.WHITE);
		add(background);
	}

	public function createText(position:FlxPoint) {
		var y = position.y + 200;
		var x = position.x;
		// assumed max is 3 for hp
		healthCounter = new FlxText(x, y, WIDTH, 'HP: ${player.health}/3', 24);
		y += 50;
		commandText = new FlxText(x, y, WIDTH, 'Commands', 24);

		add(healthCounter);
		add(commandText);
	}

	public function createButtons(position:FlxPoint) {
		var y = position.y + 300;
		var x = position.x;
		x += 35;
		attackButton = new FlxButton(x, y, 'Attack', clickAttack);
		y += 40;
		loveButton = new FlxButton(x, y, 'Love', clickLove);
		y += 40;
		consoleButton = new FlxButton(x, y, 'Console', clickConsole);
		y += 40;
		shameButton = new FlxButton(x, y, 'Shame', clickShame);
		y += 40;
		hateButton = new FlxButton(x, y, 'Hate', clickHate);
		add(attackButton);
		add(loveButton);
		add(consoleButton);
		add(shameButton);
		add(hateButton);
	}

	public function clickAttack() {}

	public function clickLove() {}

	public function clickConsole() {}

	public function clickShame() {}

	public function clickHate() {}

	override public function update(elapsed:Float) {
		super.update(elapsed);
		updatePlayerHealth();
	}

	public function updatePlayerHealth() {
		healthCounter.text = 'HP: ${player.health}/3';
	}
}