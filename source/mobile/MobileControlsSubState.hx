package mobile;

import openfl.sensors.Accelerometer;
#if mobileC
import mobile.flixel.FlxButton;
#else
import flixel.ui.FlxButton;
#end
import flixel.addons.transition.FlxTransitionableState;
import flixel.util.FlxSave;
import flixel.input.touch.FlxTouch;
import openfl.utils.Assets;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.display.FlxBackdrop;



class MobileControlsSubState extends MusicBeatSubstate
{
	var bg:FlxSprite;
	var getColor:Dynamic;
	public var controlsItems:Array<String> = ['Pad-Right', 'Pad-Left', 'Pad-Custom', 'Pad-Duo', 'Hitbox', 'Keyboard', 'Pad-Extras'];
	var virtualPadd:FlxVirtualPad;
	var virtualPaddExtra:FlxVirtualPadExtra;
	var hitbox:FlxHitbox;
	var upPozition:FlxText;
	var downPozition:FlxText;
	var leftPozition:FlxText;
	var rightPozition:FlxText;
	var extraPozition:FlxText;
	var extra1Pozition:FlxText;
	var inputvari:FlxText;
	var funitext:FlxText;
	var leftArrow:FlxSprite;
	var rightArrow:FlxSprite;
	var curSelected:Int = 0;
	var buttonBinded:Bool = false;
	var bindButton:FlxButton;
	var resetButton:FlxButton;
	var padMap:Map<String, FlxExtraActions>;
	var daFunny:FlxText;
	var buttonLeftColor:Array<FlxColor>;
	var buttonDownColor:Array<FlxColor>;
	var buttonUpColor:Array<FlxColor>;
	var buttonRightColor:Array<FlxColor>;

	override function create()
	{
        controls.isInSubstate = true;
		if (ClientPrefs.data.dynamicColors){
			buttonLeftColor = ClientPrefs.data.arrowRGB[0];
			buttonDownColor = ClientPrefs.data.arrowRGB[1];
			buttonUpColor = ClientPrefs.data.arrowRGB[2];
			buttonRightColor = ClientPrefs.data.arrowRGB[3];
		} else{
			buttonLeftColor = ClientPrefs.defaultData.arrowRGB[0];
			buttonDownColor = ClientPrefs.defaultData.arrowRGB[1];
			buttonUpColor = ClientPrefs.defaultData.arrowRGB[2];
			buttonRightColor = ClientPrefs.defaultData.arrowRGB[3];
		}
		if (ClientPrefs.data.extraButtons == 'NONE')
			controlsItems = ['Pad-Right', 'Pad-Left', 'Pad-Custom', 'Pad-Duo', 'Hitbox', 'Keyboard'];
		curSelected = MobileControls.getMode();

        bg = new FlxSprite(0, 0).makeGraphic(FlxG.width, FlxG.height, FlxColor.fromRGB(FlxG.random.int(0, 255), FlxG.random.int(0, 255), FlxG.random.int(0, 255), 153));
		bg.alpha = 0;
		FlxTween.tween(bg,
			{alpha: 0.6},
			0.8,
			{ease: FlxEase.circInOut,
				onComplete: function(tween:FlxTween){
					colorT();
				}
			});
		add(bg);
		var exitButton:FlxButton = new FlxButton(FlxG.width - 200, 50, 'Exit', function()
			{
				if (curSelected == 6 && ClientPrefs.data.extraButtons != 'NONE'){
					if (daFunny.alpha == 0 ){
					daFunny.alpha = 1;
					FlxTween.tween(daFunny, {alpha: 0}, 2.5, {ease: FlxEase.circInOut});
				}
	
				} else {
					MobileControls.setMode(curSelected);
	
				if (controlsItems[Math.floor(curSelected)] == 'Pad-Custom')
					MobileControls.setCustomMode(virtualPadd);
	
					MobileControls.setExtraCustomMode(virtualPaddExtra); // allways save on exit
	
				controls.isInSubstate = false;
							close();
							FlxG.sound.play(Paths.sound('cancelMenu'));
			}
	
			});
			exitButton.setGraphicSize(Std.int(exitButton.width) * 3);
			exitButton.label.setFormat(Assets.getFont('assets/fonts/vcr.ttf').fontName, 21, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, true);
			exitButton.color = FlxColor.LIME;
			add(exitButton);
		resetButton = new FlxButton(FlxG.width - 200, 150, 'Reset', function()
		{
			if (resetButton.visible)
			{
				if (curSelected == 6)
					{
				virtualPaddExtra.buttonExtra.x = 0;
				virtualPaddExtra.buttonExtra.y = FlxG.height - 135;

				virtualPaddExtra.buttonExtra1.x = FlxG.width - 132;
				virtualPaddExtra.buttonExtra1.y = FlxG.height - 135;
			} else {
				virtualPadd.buttonUp.x = FlxG.width - 258;
				virtualPadd.buttonUp.y = FlxG.height - 408;
				virtualPadd.buttonDown.x = FlxG.width - 258;
				virtualPadd.buttonDown.y = FlxG.height - 201;
				virtualPadd.buttonRight.x = FlxG.width - 132;
				virtualPadd.buttonRight.y = FlxG.height - 309;
				virtualPadd.buttonLeft.x = FlxG.width - 384;
				virtualPadd.buttonLeft.y = FlxG.height - 309;
			}
		}
	});
		resetButton.setGraphicSize(Std.int(resetButton.width) * 3);
		resetButton.label.setFormat(Assets.getFont('assets/fonts/vcr.ttf').fontName, 21, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, true);
		resetButton.color = FlxColor.RED;
		resetButton.visible = false;
		add(resetButton);

		var hitboxMap:Map<String, Modes> = new Map<String, Modes>();
		hitboxMap = new Map<String, Modes>();
		hitboxMap.set("NONE", DEFAULT);
		hitboxMap.set("ONE", SINGLE);
		hitboxMap.set("TWO", DOUBLE);
		padMap = new Map<String, FlxExtraActions>();
		padMap.set("NONE", NONE);
		padMap.set("ONE", SINGLE);
		padMap.set("TWO", DOUBLE);
	
		virtualPadd = new FlxVirtualPad(NONE, NONE);
		virtualPadd.visible = false;
		add(virtualPadd);



		hitbox = new FlxHitbox(hitboxMap.get(ClientPrefs.data.extraButtons));

		hitbox.alpha = 0.6;
		hitbox.visible = false;
		add(hitbox);

		funitext = new FlxText(0, 50, 0, 'No Mobile Controls!', 32);
		funitext.setFormat('VCR OSD Mono', 32, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		funitext.borderSize = 2.4;
		funitext.screenCenter();
		funitext.visible = false;
		add(funitext);

		inputvari = new FlxText(0, 100, 0, '', 32);
		inputvari.setFormat('VCR OSD Mono', 32, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		inputvari.borderSize = 2.4;
		inputvari.screenCenter(X);
		add(inputvari);

		leftArrow = new FlxSprite(inputvari.x - 60, inputvari.y - 25);
		leftArrow.frames = Paths.getSparrowAtlas('campaign_menu_UI_assets');
		leftArrow.animation.addByPrefix('idle', 'arrow left');
		leftArrow.animation.addByPrefix('press', "arrow push left");
		leftArrow.animation.play('idle');
		add(leftArrow);

		rightArrow = new FlxSprite(inputvari.x + inputvari.width + 10, inputvari.y - 25);
		rightArrow.frames = Paths.getSparrowAtlas('campaign_menu_UI_assets');
		rightArrow.animation.addByPrefix('idle', 'arrow right');
		rightArrow.animation.addByPrefix('press', "arrow push right", 24, false);
		rightArrow.animation.play('idle');
		add(rightArrow);

		rightPozition = new FlxText(10, FlxG.height - 44, 0, '', 16);
		rightPozition.setFormat('VCR OSD Mono', 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		rightPozition.borderSize = 2.4;
		add(rightPozition);

		leftPozition = new FlxText(10, FlxG.height - 64, 0, '', 16);
		leftPozition.setFormat('VCR OSD Mono', 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		leftPozition.borderSize = 2.4;
		add(leftPozition);

		downPozition = new FlxText(10, FlxG.height - 84, 0, '', 16);
		downPozition.setFormat('VCR OSD Mono', 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		downPozition.borderSize = 2.4;
		add(downPozition);

		upPozition = new FlxText(10, FlxG.height - 104, 0, '', 16);
		upPozition.setFormat('VCR OSD Mono', 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		upPozition.borderSize = 2.4;
		add(upPozition);

		extraPozition = new FlxText(10, FlxG.height - 44, 0, '', 16);
		extraPozition.setFormat('VCR OSD Mono', 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		extraPozition.borderSize = 2.4;
		add(extraPozition);

		extra1Pozition = new FlxText(10, FlxG.height - 64, 0, '', 16);
		extra1Pozition.setFormat('VCR OSD Mono', 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		extra1Pozition.borderSize = 2.4;
		add(extra1Pozition);

		virtualPaddExtra = MobileControls.getExtraCustomMode(new FlxVirtualPadExtra(padMap.get(ClientPrefs.data.extraButtons)));
		virtualPaddExtra.visible = false;
		add(virtualPaddExtra);
		changeSelection();

		daFunny = new FlxText(0, 75, 0, 'Pad-Extras is not a control mode\nPlease selecte a valid mode such as hitbox, Pad-Left...', 35);
		daFunny.setFormat('VCR OSD Mono', 35, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		daFunny.screenCenter();
		daFunny.borderSize = 2.4;
		add(daFunny);
		daFunny.alpha = 0;
		super.create();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		getColor = bg.color;
		if(controls.BACK #if android || FlxG.android.justReleased.BACK #end){
			if (curSelected == 6 && ClientPrefs.data.extraButtons != 'NONE'){
			if (daFunny.alpha == 0 ){
				daFunny.alpha = 1;
				FlxTween.tween(daFunny, {alpha: 0}, 2.5, {ease: FlxEase.circInOut});
			}
			} else {
			MobileControls.setMode(curSelected);
			if (controlsItems[Math.floor(curSelected)] == 'Pad-Custom')
			MobileControls.setCustomMode(virtualPadd);
			MobileControls.setExtraCustomMode(virtualPaddExtra); // allways save on exit
			controls.isInSubstate = false;
            close();
            FlxG.sound.play(Paths.sound('cancelMenu'));
		}
		}

		inputvari.screenCenter(X);
		leftArrow.x = inputvari.x - 60;
		rightArrow.x = inputvari.x + inputvari.width + 10;

		for (touch in FlxG.touches.list)
		{
			if (touch.overlaps(leftArrow) && touch.pressed)
				leftArrow.animation.play('press');
			else
				leftArrow.animation.play('idle');

			if (touch.overlaps(rightArrow) && touch.pressed)
				rightArrow.animation.play('press')
			else
				rightArrow.animation.play('idle');

			if ((touch.overlaps(leftArrow) && touch.justPressed) #if desktop || controls.UI_LEFT_P #end)
				changeSelection(-1);
			else if ((touch.overlaps(rightArrow) && touch.justPressed)#if desktop || controls.UI_RIGHT_P #end)
				changeSelection(1);

			if(controls.RESET){
				if (resetButton.visible)
					{
						if (curSelected == 6)
							{
						virtualPaddExtra.buttonExtra.x = 0;
						virtualPaddExtra.buttonExtra.y = FlxG.height - 135;
		
						virtualPaddExtra.buttonExtra1.x = FlxG.width - 132;
						virtualPaddExtra.buttonExtra1.y = FlxG.height - 135;
					} else {
						virtualPadd.buttonUp.x = FlxG.width - 258;
						virtualPadd.buttonUp.y = FlxG.height - 408;
						virtualPadd.buttonDown.x = FlxG.width - 258;
						virtualPadd.buttonDown.y = FlxG.height - 201;
						virtualPadd.buttonRight.x = FlxG.width - 132;
						virtualPadd.buttonRight.y = FlxG.height - 309;
						virtualPadd.buttonLeft.x = FlxG.width - 384;
						virtualPadd.buttonLeft.y = FlxG.height - 309;
					}
				}
			}

			if (controlsItems[Math.floor(curSelected)] == 'Pad-Custom')
			{
				if (buttonBinded)
				{
					if (touch.justReleased)
					{
						bindButton = null;
						buttonBinded = false;
					}
					else
						moveButton(touch, bindButton);
				}
				else
				{
					if (virtualPadd.buttonUp.justPressed)
						moveButton(touch, virtualPadd.buttonUp);

					if (virtualPadd.buttonDown.justPressed)
						moveButton(touch, virtualPadd.buttonDown);

					if (virtualPadd.buttonRight.justPressed)
						moveButton(touch, virtualPadd.buttonRight);

					if (virtualPadd.buttonLeft.justPressed)
						moveButton(touch, virtualPadd.buttonLeft);
				}
			}
			if (controlsItems[Math.floor(curSelected)] == 'Pad-Extras')
				{
					if (buttonBinded)
					{
						if (touch.justReleased)
						{
							bindButton = null;
							buttonBinded = false;
						}
						else
							moveButton(touch, bindButton);
					}
					else
					{
						if (virtualPaddExtra.buttonExtra.justPressed)
							moveButton(touch, virtualPaddExtra.buttonExtra);
	
						if (virtualPaddExtra.buttonExtra1.justPressed)
							moveButton(touch, virtualPaddExtra.buttonExtra1);
					}
				}
		}

		if (virtualPadd != null)
		{
			if (virtualPadd.buttonUp != null)
				upPozition.text = 'Button Up X:' + virtualPadd.buttonUp.x + ' Y:' + virtualPadd.buttonUp.y;

			if (virtualPadd.buttonDown != null)
				downPozition.text = 'Button Down X:' + virtualPadd.buttonDown.x + ' Y:' + virtualPadd.buttonDown.y;

			if (virtualPadd.buttonLeft != null)
				leftPozition.text = 'Button Left X:' + virtualPadd.buttonLeft.x + ' Y:' + virtualPadd.buttonLeft.y;

			if (virtualPadd.buttonRight != null)
				rightPozition.text = 'Button Right X:' + virtualPadd.buttonRight.x + ' Y:' + virtualPadd.buttonRight.y;

			if (virtualPaddExtra != null)
				{
					if (virtualPaddExtra.buttonExtra != null)
						extraPozition.text = 'First Extra X:' + virtualPaddExtra.buttonExtra.x + ' Y:' + virtualPaddExtra.buttonExtra.y;
		
					if (virtualPaddExtra.buttonExtra1 != null)
						extra1Pozition.text = 'Second Extra X:' + virtualPaddExtra.buttonExtra1.x + ' Y:' + virtualPaddExtra.buttonExtra1.y;
		}
	}
}
function changeSelection(change:Int = 0):Void
	{
		curSelected += change;

		if (curSelected < 0)
			curSelected = controlsItems.length - 1;
		if (curSelected >= controlsItems.length)
			curSelected = 0;

		inputvari.text = controlsItems[curSelected];

		var daChoice:String = controlsItems[Math.floor(curSelected)];

		switch (daChoice)
		{
			case 'Pad-Right':
				hitbox.visible = false;
				virtualPaddExtra.visible = true;
				virtualPaddExtra.alpha = ClientPrefs.data.controlsAlpha;
				virtualPadd.destroy();
				virtualPadd = new FlxVirtualPad(RIGHT_FULL, NONE);
				virtualPadd.alpha = ClientPrefs.data.controlsAlpha;
				add(virtualPadd);
				virtualPadd.buttonLeft.color =  buttonLeftColor[0];
				virtualPadd.buttonDown.color =  buttonDownColor[0];
				virtualPadd.buttonUp.color =  buttonUpColor[0];
				virtualPadd.buttonRight.color =  buttonRightColor[0];
			case 'Pad-Left':
				hitbox.visible = false;
				virtualPaddExtra.visible = true;
				virtualPaddExtra.alpha = ClientPrefs.data.controlsAlpha;
				virtualPadd.destroy();
				virtualPadd = new FlxVirtualPad(LEFT_FULL, NONE);
				virtualPadd.alpha = ClientPrefs.data.controlsAlpha;
				add(virtualPadd);
				virtualPadd.buttonLeft.color =  buttonLeftColor[0];
				virtualPadd.buttonDown.color =  buttonDownColor[0];
				virtualPadd.buttonUp.color =  buttonUpColor[0];
				virtualPadd.buttonRight.color =  buttonRightColor[0];
			case 'Pad-Custom':
				hitbox.visible = false;
				virtualPaddExtra.visible = true;
				virtualPaddExtra.alpha = ClientPrefs.data.controlsAlpha;
				virtualPadd.destroy();
				virtualPadd = MobileControls.getCustomMode(new FlxVirtualPad(RIGHT_FULL, NONE));
				virtualPadd.alpha = ClientPrefs.data.controlsAlpha;
				add(virtualPadd);
				virtualPadd.buttonLeft.color =  buttonLeftColor[0];
				virtualPadd.buttonDown.color =  buttonDownColor[0];
				virtualPadd.buttonUp.color =  buttonUpColor[0];
				virtualPadd.buttonRight.color =  buttonRightColor[0];
			case 'Pad-Duo':
				hitbox.visible = false;
				virtualPaddExtra.visible = true;
				virtualPaddExtra.alpha = ClientPrefs.data.controlsAlpha;
				virtualPadd.destroy();
				virtualPadd = new FlxVirtualPad(BOTH, NONE);
				virtualPadd.alpha = ClientPrefs.data.controlsAlpha;
				add(virtualPadd);
				virtualPadd.buttonLeft.color =  buttonLeftColor[0];
				virtualPadd.buttonDown.color =  buttonDownColor[0];
				virtualPadd.buttonUp.color =  buttonUpColor[0];
				virtualPadd.buttonRight.color =  buttonRightColor[0];
				virtualPadd.buttonLeft2.color =  buttonLeftColor[0];
				virtualPadd.buttonDown2.color =  buttonDownColor[0];
				virtualPadd.buttonUp2.color =  buttonUpColor[0];
				virtualPadd.buttonRight2.color =  buttonRightColor[0];
			case 'Pad-Extras':
				hitbox.visible = false;
				virtualPadd.visible = false; // idfk it looks better like this
				virtualPaddExtra.visible = true;
				virtualPaddExtra.alpha = ClientPrefs.data.controlsAlpha;
			case 'Hitbox':
				hitbox.visible = true;
				virtualPadd.visible = false;
				virtualPaddExtra.visible = false;
				hitbox.alpha = ClientPrefs.data.controlsAlpha;
			case 'Keyboard':
				hitbox.visible = false;
				virtualPadd.visible = false;
				virtualPaddExtra.visible = false;
		}

		funitext.visible = daChoice == 'Keyboard';
		if (daChoice == 'Pad-Custom' || daChoice == 'Pad-Extras')
		resetButton.visible = true;
		else resetButton.visible = false;

		upPozition.visible = daChoice == 'Pad-Custom';
		downPozition.visible = daChoice == 'Pad-Custom';
		leftPozition.visible = daChoice == 'Pad-Custom';
		rightPozition.visible = daChoice == 'Pad-Custom';
		extraPozition.visible = daChoice == 'Pad-Extras';
		extra1Pozition.visible = daChoice == 'Pad-Extras';
	}

	function moveButton(touch:FlxTouch, button:FlxButton):Void
	{
		bindButton = button;
		bindButton.x = touch.x - Std.int(bindButton.width / 2);
		bindButton.y = touch.y - Std.int(bindButton.height / 2);
		buttonBinded = true;
	}

	function colorT() {
    	FlxTween.color(bg,
			6,
			getColor,
			FlxColor.fromRGB(FlxG.random.int(0, 255),
			FlxG.random.int(0, 255),
			FlxG.random.int(0, 255),
			153),
			{onComplete: function(tween:FlxTween) {
        	    colorT();
        	}
    	});
	}
}
