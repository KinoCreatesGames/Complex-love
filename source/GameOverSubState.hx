class GameOverSubState extends FlxSubState {
	override public function create() {
		super.create();
		createTitle();
		createReturnToTitle();
	}

	public function createTitle() {
		var text = new FlxText(0, 0, 250, 'Game Over', 32);
		text.screenCenter();
		text.color = FlxColor.RED;
		add(text);
	}

	public function createReturnToTitle() {
		var button = new FlxButton(0, 0, 'Return To Title', clickReturnToTitle);
		button.screenCenter();
		button.x -= 25;
		button.y += 60;
		add(button);
	}

	public function clickReturnToTitle() {
		FlxG.switchState(new TitleState());
	}
}