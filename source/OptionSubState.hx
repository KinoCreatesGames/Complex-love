import flixel.util.FlxAxes;

class OptionSubState extends FlxSubState {
	override public function create() {
		var optionText = new FlxText(0, 50, 250, 'Options', 32);
		optionText.screenCenter(FlxAxes.X);
		add(optionText);
		super.create();
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
		this.updateExit();
	}

	public function updateExit() {
		if (FlxG.keys.anyJustPressed([ESCAPE])) {
			close();
		}
	}
}