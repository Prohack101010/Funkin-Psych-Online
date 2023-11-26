package mobile.flixel;
#if mobileC
import mobile.flixel.FlxButton;
#else
import flixel.ui.FlxButton;
#end
import flixel.graphics.frames.FlxTileFrames;
import flixel.math.FlxPoint;
import haxe.ds.Map;

/**
 * A gamepad.
 * It's easy to customize the layout.
 *
 * @original author Ka Wing Chin & Mihai Alexandru
 * @modification's author: Karim Akra (UTFan) & Lily (mcagabe19)
 */
class FlxVirtualPad extends FlxSpriteGroup
{
	public var buttonLeft:FlxButton = new FlxButton(0, 0);
	public var buttonUp:FlxButton = new FlxButton(0, 0);
	public var buttonRight:FlxButton = new FlxButton(0, 0);
	public var buttonDown:FlxButton = new FlxButton(0, 0);
	public var buttonLeft2:FlxButton = new FlxButton(0, 0);
	public var buttonUp2:FlxButton = new FlxButton(0, 0);
	public var buttonRight2:FlxButton = new FlxButton(0, 0);
	public var buttonDown2:FlxButton = new FlxButton(0, 0);
	public var buttonA:FlxButton = new FlxButton(0, 0);
	public var buttonB:FlxButton = new FlxButton(0, 0);
	public var buttonC:FlxButton = new FlxButton(0, 0);
	public var buttonD:FlxButton = new FlxButton(0, 0);
	public var buttonE:FlxButton = new FlxButton(0, 0);
    public var buttonF:FlxButton = new FlxButton(0, 0);
    public var buttonG:FlxButton = new FlxButton(0, 0);
    public var buttonS:FlxButton = new FlxButton(0, 0);
	public var buttonV:FlxButton = new FlxButton(0, 0);
	public var buttonX:FlxButton = new FlxButton(0, 0);
	public var buttonY:FlxButton = new FlxButton(0, 0);
	public var buttonZ:FlxButton = new FlxButton(0, 0);
	public var buttonP:FlxButton = new FlxButton(0, 0);

	public var buttonsString:Map<String, FlxButton>;

	/**
	 * Create a gamepad.
	 *
	 * @param   DPadMode     The D-Pad mode. `LEFT_FULL` for example.
	 * @param   ActionMode   The action buttons mode. `A_B_C` for example.
	 */
	public function new(DPad:FlxDPadMode, Action:FlxActionMode)
	{
		super();

		// DPad Buttons
		buttonsString = new Map<String, FlxButton>();
		buttonsString.set("buttonUp", buttonUp);
		buttonsString.set("buttonUp2", buttonUp2);
		buttonsString.set("buttonDown", buttonDown);
		buttonsString.set("buttonDown2", buttonDown2);
		buttonsString.set("buttonLeft", buttonLeft);
		buttonsString.set("buttonLeft2", buttonLeft2);
		buttonsString.set("buttonRight", buttonRight);
		buttonsString.set("buttonRight2", buttonRight2);

		// Actions buttons
		buttonsString.set("buttonA", buttonA);
		buttonsString.set("buttonB", buttonB);
		buttonsString.set("buttonC", buttonC);
		buttonsString.set("buttonD", buttonD);
		buttonsString.set("buttonE", buttonE);
		buttonsString.set("buttonV", buttonV);
		buttonsString.set("buttonX", buttonX);
		buttonsString.set("buttonY", buttonY);
		buttonsString.set("buttonZ", buttonZ);
		buttonsString.set("buttonP", buttonP);
		var buttonLeftColor:Array<FlxColor>;
		var buttonDownColor:Array<FlxColor>;
		var buttonUpColor:Array<FlxColor>;
		var buttonRightColor:Array<FlxColor>;

		buttonLeftColor = ClientPrefs.defaultData.arrowRGB[0];
		buttonDownColor = ClientPrefs.defaultData.arrowRGB[1];
		buttonUpColor = ClientPrefs.defaultData.arrowRGB[2];
		buttonRightColor = ClientPrefs.defaultData.arrowRGB[3];

		scrollFactor.set();

		switch (DPad)
		{
			case UP_DOWN:
				add(buttonUp = createButton(0, FlxG.height - 255, 132, 127, 'up', buttonUpColor[0]));
				add(buttonDown = createButton(0, FlxG.height - 135, 132, 127, 'down', buttonDownColor[0]));
			case LEFT_RIGHT:
				add(buttonLeft = createButton(0, FlxG.height - 135, 132, 127, 'left', buttonLeftColor[0]));
				add(buttonRight = createButton(127, FlxG.height - 135, 132, 127, 'right', buttonRightColor[0]));
			case UP_LEFT_RIGHT:
				add(buttonUp = createButton(105, FlxG.height - 243, 132, 127, 'up', buttonUpColor[0]));
				add(buttonLeft = createButton(0, FlxG.height - 135, 132, 127, 'left', buttonLeftColor[0]));
				add(buttonRight = createButton(207, FlxG.height - 135, 132, 127, 'right', buttonRightColor[0]));
			case LEFT_FULL:
				add(buttonUp = createButton(105, FlxG.height - 345, 132, 127, 'up', buttonUpColor[0]));
				add(buttonLeft = createButton(0, FlxG.height - 243, 132, 127, 'left', buttonLeftColor[0]));
				add(buttonRight = createButton(207, FlxG.height - 243, 132, 127, 'right', buttonRightColor[0]));
				add(buttonDown = createButton(105, FlxG.height - 135, 132, 127, 'down', buttonDownColor[0]));
			case RIGHT_FULL:
				add(buttonUp = createButton(FlxG.width - 258, FlxG.height - 408, 132, 127, 'up', buttonUpColor[0]));
				add(buttonLeft = createButton(FlxG.width - 384, FlxG.height - 309, 132, 127, 'left', buttonLeftColor[0]));
				add(buttonRight = createButton(FlxG.width - 132, FlxG.height - 309, 132, 127, 'right', buttonRightColor[0]));
				add(buttonDown = createButton(FlxG.width - 258, FlxG.height - 201, 132, 127, 'down', buttonDownColor[0]));
			case BOTH:
				add(buttonUp = createButton(105, FlxG.height - 345, 132, 127, 'up', buttonUpColor[0]));
				add(buttonLeft = createButton(0, FlxG.height - 243, 132, 127, 'left', buttonLeftColor[0]));
				add(buttonRight = createButton(207, FlxG.height - 243, 132, 127, 'right', buttonRightColor[0]));
				add(buttonDown = createButton(105, FlxG.height - 135, 132, 127, 'down', buttonDownColor[0]));
				add(buttonUp2 = createButton(FlxG.width - 258, FlxG.height - 408, 132, 127, 'up', buttonUpColor[0]));
				add(buttonLeft2 = createButton(FlxG.width - 384, FlxG.height - 309, 132, 127, 'left', buttonLeftColor[0]));
				add(buttonRight2 = createButton(FlxG.width - 132, FlxG.height - 309, 132, 127, 'right', buttonRightColor[0]));
				add(buttonDown2 = createButton(FlxG.width - 258, FlxG.height - 201, 132, 127, 'down', buttonDownColor[0]));
			// PSYCH RELEATED BUTTONS
			case DIALOGUE_PORTRAIT:
				add(buttonUp = createButton(105, FlxG.height - 345, 132, 127, 'up', buttonUpColor[0]));
				add(buttonLeft = createButton(0, FlxG.height - 243, 132, 127, 'left', buttonLeftColor[0]));
				add(buttonRight = createButton(207, FlxG.height - 243, 132, 127, 'right', buttonRightColor[0]));
				add(buttonDown = createButton(105, FlxG.height - 135, 132, 127, 'down', buttonDownColor[0]));
				add(buttonUp2 = createButton(105, 0, 132, 127, 'up', buttonUpColor[0]));
				add(buttonLeft2 = createButton(0, 82, 132, 127, 'left', buttonLeftColor[0]));
				add(buttonRight2 = createButton(207, 82, 132, 127, 'right', buttonRightColor[0]));
				add(buttonDown2 = createButton(105, 190, 132, 127, 'down', buttonDownColor[0]));
			case MENU_CHARACTER:
				add(buttonUp = createButton(105, 0, 132, 127, 'up', buttonUpColor[0]));
				add(buttonLeft = createButton(0, 82, 132, 127, 'left', buttonLeftColor[0]));
				add(buttonRight = createButton(207, 82, 132, 127, 'right', buttonRightColor[0]));
				add(buttonDown = createButton(105, 190, 132, 127, 'down', buttonDownColor[0]));
			case NOTE_SPLASH_DEBUG:
				add(buttonLeft = createButton(0, 0, 132, 127, 'left', buttonLeftColor[0]));
				add(buttonRight = createButton(127, 0, 132, 127, 'right', buttonRightColor[0]));
				add(buttonUp = createButton(0, 125, 132, 127, 'up', buttonUpColor[0]));
				add(buttonDown = createButton(127, 125, 132, 127, 'down', buttonDownColor[0]));
				add(buttonUp2 = createButton(127, 393, 132, 127, 'up', buttonUpColor[0]));
				add(buttonLeft2 = createButton(0, 393, 132, 127, 'left', buttonLeftColor[0]));
				add(buttonRight2 = createButton(1145, 393, 132, 127, 'right', buttonRightColor[0]));
				add(buttonDown2 = createButton(1015, 393, 132, 127, 'down', buttonDownColor[0]));
			case NONE: // do nothing
		}

		switch (Action)
		{
			case A:
				add(buttonA = createButton(FlxG.width - 132, FlxG.height - 135, 132, 127, 'a', 0xFF0000));
			case B:
				add(buttonB = createButton(FlxG.width - 132, FlxG.height - 135, 132, 127, 'b', 0xFFCB00));
			case B_X:
				add(buttonB = createButton(FlxG.width - 258, FlxG.height - 135, 132, 127, 'b', 0xFFCB00));
				add(buttonX = createButton(FlxG.width - 132, FlxG.height - 135, 132, 127, 'x', 0x99062D));
			case A_B:
				add(buttonB = createButton(FlxG.width - 258, FlxG.height - 135, 132, 127, 'b', 0xFFCB00));
				add(buttonA = createButton(FlxG.width - 132, FlxG.height - 135, 132, 127, 'a', 0xFF0000));
			case A_B_C:
				add(buttonC = createButton(FlxG.width - 384, FlxG.height - 135, 132, 127, 'c', 0x44FF00));
				add(buttonB = createButton(FlxG.width - 258, FlxG.height - 135, 132, 127, 'b', 0xFFCB00));
				add(buttonA = createButton(FlxG.width - 132, FlxG.height - 135, 132, 127, 'a', 0xFF0000));
			case A_B_E:
				add(buttonE = createButton(FlxG.width - 384, FlxG.height - 135, 132, 127, 'e', 0xFF7D00));
				add(buttonB = createButton(FlxG.width - 258, FlxG.height - 135, 132, 127, 'b', 0xFFCB00));
				add(buttonA = createButton(FlxG.width - 132, FlxG.height - 135, 132, 127, 'a', 0xFF0000));
			case A_B_X_Y:
				add(buttonX = createButton(FlxG.width - 510, FlxG.height - 135, 132, 127, 'x', 0x99062D));
				add(buttonB = createButton(FlxG.width - 258, FlxG.height - 135, 132, 127, 'b', 0xFFCB00));
				add(buttonY = createButton(FlxG.width - 384, FlxG.height - 135, 132, 127, 'y', 0x4A35B9));
				add(buttonA = createButton(FlxG.width - 132, FlxG.height - 135, 132, 127, 'a', 0xFF0000));
			case A_B_C_X_Y:
				add(buttonC = createButton(FlxG.width - 384, FlxG.height - 135, 132, 127, 'c', 0x44FF00));
				add(buttonX = createButton(FlxG.width - 258, FlxG.height - 255, 132, 127, 'x', 0x99062D));
				add(buttonB = createButton(FlxG.width - 258, FlxG.height - 135, 132, 127, 'b', 0xFFCB00));
				add(buttonY = createButton(FlxG.width - 132, FlxG.height - 255, 132, 127, 'y', 0x4A35B9));
				add(buttonA = createButton(FlxG.width - 132, FlxG.height - 135, 132, 127, 'a', 0xFF0000));
			case A_B_C_X_Y_Z:
				add(buttonX = createButton(FlxG.width - 384, FlxG.height - 255, 132, 127, 'x', 0x99062D));
				add(buttonC = createButton(FlxG.width - 384, FlxG.height - 135, 132, 127, 'c', 0x44FF00));
				add(buttonY = createButton(FlxG.width - 258, FlxG.height - 255, 132, 127, 'y', 0x4A35B9));
				add(buttonB = createButton(FlxG.width - 258, FlxG.height - 135, 132, 127, 'b', 0xFFCB00));
				add(buttonZ = createButton(FlxG.width - 132, FlxG.height - 255, 132, 127, 'z', 0xCCB98E));
				add(buttonA = createButton(FlxG.width - 132, FlxG.height - 135, 132, 127, 'a', 0xFF0000));
			case A_B_C_D_V_X_Y_Z:
				add(buttonV = createButton(FlxG.width - 510, FlxG.height - 255, 132, 127, 'v', 0x49A9B2));
				add(buttonD = createButton(FlxG.width - 510, FlxG.height - 135, 132, 127, 'd', 0x0078FF));
				add(buttonX = createButton(FlxG.width - 384, FlxG.height - 255, 132, 127, 'x', 0x99062D));
				add(buttonC = createButton(FlxG.width - 384, FlxG.height - 135, 132, 127, 'c', 0x44FF00));
				add(buttonY = createButton(FlxG.width - 258, FlxG.height - 255, 132, 127, 'y', 0x4A35B9));
				add(buttonB = createButton(FlxG.width - 258, FlxG.height - 135, 132, 127, 'b', 0xFFCB00));
				add(buttonZ = createButton(FlxG.width - 132, FlxG.height - 255, 132, 127, 'z', 0xCCB98E));
				add(buttonA = createButton(FlxG.width - 132, FlxG.height - 135, 132, 127, 'a', 0xFF0000));
			// PSYCH RELEATED BUTTONS
			case DIALOGUE_PORTRAIT:
				add(buttonX = createButton(FlxG.width - 384, 0, 132, 127, 'x', 0x99062D));
				add(buttonC = createButton(FlxG.width - 384, 125, 132, 127, 'c', 0x44FF00));
				add(buttonY = createButton(FlxG.width - 258, 0, 132, 127, 'y', 0x4A35B9));
				add(buttonB = createButton(FlxG.width - 258, 125, 132, 127, 'b', 0xFFCB00));
				add(buttonZ = createButton(FlxG.width - 132, 0, 132, 127, 'z', 0xCCB98E));
				add(buttonA = createButton(FlxG.width - 132, 125, 132, 127, 'a', 0xFF0000));
			case MENU_CHARACTER:
				add(buttonC = createButton(FlxG.width - 384, 0, 132, 127, 'c', 0x44FF00));
				add(buttonB = createButton(FlxG.width - 258, 0, 132, 127, 'b', 0xFFCB00));
				add(buttonA = createButton(FlxG.width - 132, 0, 132, 127, 'a', 0xFF0000));
			case NOTE_SPLASH_DEBUG:
				add(buttonB = createButton(FlxG.width - 258, FlxG.height - 135, 132, 127, 'b', 0xFFCB00));
				add(buttonE = createButton(FlxG.width - 132, 0, 132, 127, 'e', 0xFF7D00));
				add(buttonX = createButton(FlxG.width - 258, 0, 132, 127, 'x', 0x99062D));
				add(buttonY = createButton(FlxG.width - 132, 250, 132, 127, 'y', 0x4A35B9));
				add(buttonZ = createButton(FlxG.width - 258, 250, 132, 127, 'z', 0xCCB98E));
				add(buttonA = createButton(FlxG.width - 132, FlxG.height - 135, 132, 127, 'a', 0xFF0000));
				add(buttonC = createButton(FlxG.width - 132, 125, 132, 127, 'c', 0x44FF00));
				add(buttonV = createButton(FlxG.width - 258, 125, 132, 127, 'v', 0x49A9B2));
			case P:
				add(buttonP = createButton(FlxG.width - 132, 0, 132, 127, 'x', 0x99062D));
			case B_C:
				add(buttonC = createButton(FlxG.width - 132, FlxG.height - 135, 132, 127, 'c', 0x44FF00));
				add(buttonB = createButton(FlxG.width - 258, FlxG.height - 135, 132, 127, 'b', 0xFFCB00));
			case NONE: // do nothing
		}
	}

	/*
	 * Clean up memory.
	 */
	override public function destroy():Void
	{
		super.destroy();

		buttonLeft = FlxDestroyUtil.destroy(buttonLeft);
		buttonUp = FlxDestroyUtil.destroy(buttonUp);
		buttonDown = FlxDestroyUtil.destroy(buttonDown);
		buttonRight = FlxDestroyUtil.destroy(buttonRight);
		buttonLeft2 = FlxDestroyUtil.destroy(buttonLeft2);
		buttonUp2 = FlxDestroyUtil.destroy(buttonUp2);
		buttonDown2 = FlxDestroyUtil.destroy(buttonDown2);
		buttonRight2 = FlxDestroyUtil.destroy(buttonRight2);
		buttonA = FlxDestroyUtil.destroy(buttonA);
		buttonB = FlxDestroyUtil.destroy(buttonB);
		buttonC = FlxDestroyUtil.destroy(buttonC);
		buttonD = FlxDestroyUtil.destroy(buttonD);
		buttonE = FlxDestroyUtil.destroy(buttonE);
        buttonF = FlxDestroyUtil.destroy(buttonF);
        buttonG = FlxDestroyUtil.destroy(buttonG);
        buttonS = FlxDestroyUtil.destroy(buttonS);
		buttonV = FlxDestroyUtil.destroy(buttonV);
		buttonX = FlxDestroyUtil.destroy(buttonX);
		buttonY = FlxDestroyUtil.destroy(buttonY);
		buttonZ = FlxDestroyUtil.destroy(buttonZ);
		buttonP = FlxDestroyUtil.destroy(buttonP);
	}

	private function createButton(X:Float, Y:Float, Width:Int, Height:Int, Graphic:String, ?Color:Int = 0xFFFFFF):FlxButton
	{
		var button:FlxButton = new FlxButton(X, Y);
		button.frames = FlxTileFrames.fromFrame(Paths.getSparrowAtlas('mobile/virtualpad').getByName(Graphic), FlxPoint.get(Width, Height));
		button.resetSizeFromFrame();
		button.solid = false;
		button.immovable = true;
		button.moves = false;
		button.scrollFactor.set();
		button.color = Color;
		#if FLX_DEBUG
		button.ignoreDrawDebug = true;
		#end
		return button;
	}

	/**
	* Checks if the virtualpad button is pressed, if yes returns true.
	*/
	public function mobileControlsPressed(buttonID:FlxMobileInputID):Bool
		{
			switch (buttonID)
			{
				case FlxMobileInputID.LEFT:
					return buttonLeft.pressed;
				case FlxMobileInputID.UP:
					return buttonUp.pressed;
				case FlxMobileInputID.RIGHT:
					return buttonRight.pressed;
				case FlxMobileInputID.DOWN:
					return buttonDown.pressed;
				case FlxMobileInputID.LEFT2:
					return buttonLeft2.pressed;
				case FlxMobileInputID.UP2:
					return buttonUp2.pressed;
				case FlxMobileInputID.RIGHT2:
					return buttonRight2.pressed;
				case FlxMobileInputID.DOWN2:
					return buttonDown2.pressed;
				case FlxMobileInputID.A:
					return buttonA.pressed;
				case FlxMobileInputID.B:
					return buttonB.pressed;
				case FlxMobileInputID.C:
					return buttonC.pressed;
				case FlxMobileInputID.D:
					return buttonD.pressed;
				case FlxMobileInputID.E:
					return buttonE.pressed;
                                case FlxMobileInputID.F:
                                        return buttonF.pressed;
                                case FlxMobileInputID.G:
                                        return buttonG.pressed;
                                case FlxMobileInputID.S:
                                        return buttonS.pressed;
				case FlxMobileInputID.P:
					return buttonP.pressed;
				case FlxMobileInputID.V:
					return buttonV.pressed;
				case FlxMobileInputID.X:
					return buttonX.pressed;
				case FlxMobileInputID.Y:
					return buttonY.pressed;
				case FlxMobileInputID.Z:
					return buttonZ.pressed;
				case FlxMobileInputID.noteLEFT:
					return buttonLeft.pressed;
				case FlxMobileInputID.noteUP:
					return buttonUp.pressed;
				case FlxMobileInputID.noteRIGHT:
					return buttonRight.pressed;
				case FlxMobileInputID.noteDOWN:
					return buttonDown.pressed;
				case FlxMobileInputID.NONE:
					return false;
				default:
					return false;
			}
		}

	/**
	* Checks if the virtualpad button justPressed, if yes returns true.
	*/
	public function mobileControlsJustPressed(buttonID:FlxMobileInputID):Bool
		{
			switch (buttonID)
			{
			case FlxMobileInputID.LEFT:
				return buttonLeft.justPressed;
			case FlxMobileInputID.UP:
				return buttonUp.justPressed;
			case FlxMobileInputID.RIGHT:
				return buttonRight.justPressed;
			case FlxMobileInputID.DOWN:
				return buttonDown.justPressed;
			case FlxMobileInputID.LEFT2:
				return buttonLeft2.justPressed;
			case FlxMobileInputID.UP2:
				return buttonUp2.justPressed;
			case FlxMobileInputID.RIGHT2:
				return buttonRight2.justPressed;
			case FlxMobileInputID.DOWN2:
				return buttonDown2.justPressed;
			case FlxMobileInputID.A:
				return buttonA.justPressed;
			case FlxMobileInputID.B:
				return buttonB.justPressed;
			case FlxMobileInputID.C:
				return buttonC.justPressed;
			case FlxMobileInputID.D:
				return buttonD.justPressed;
			case FlxMobileInputID.E:
				return buttonE.justPressed;
                                case FlxMobileInputID.F:
                                        return buttonF.justPressed;
                                case FlxMobileInputID.G:
                                        return buttonG.justPressed;
                                case FlxMobileInputID.S:
                                        return buttonS.justPressed;
			case FlxMobileInputID.P:
				return buttonP.justPressed;
			case FlxMobileInputID.V:
				return buttonV.justPressed;
			case FlxMobileInputID.X:
				return buttonX.justPressed;
			case FlxMobileInputID.Y:
				return buttonY.justPressed;
			case FlxMobileInputID.Z:
				return buttonZ.justPressed;
			case FlxMobileInputID.noteLEFT:
				return buttonLeft.justPressed;
			case FlxMobileInputID.noteUP:
				return buttonUp.justPressed;
			case FlxMobileInputID.noteRIGHT:
				return buttonRight.justPressed;
			case FlxMobileInputID.noteDOWN:
				return buttonDown.justPressed;
			case FlxMobileInputID.NONE:
				return false;
			default:
				return false;
			}
		}

	/**
	* Checks if the virtualpad button is justReleased, if yes returns true.
	*/
	public function mobileControlsJustReleased(buttonID:FlxMobileInputID):Bool
		{
			switch (buttonID)
			{
				case FlxMobileInputID.LEFT:
					return buttonLeft.justReleased;
				case FlxMobileInputID.UP:
					return buttonUp.justReleased;
				case FlxMobileInputID.RIGHT:
					return buttonRight.justReleased;
				case FlxMobileInputID.DOWN:
					return buttonDown.justReleased;
				case FlxMobileInputID.LEFT2:
					return buttonLeft2.justReleased;
				case FlxMobileInputID.UP2:
					return buttonUp2.justReleased;
				case FlxMobileInputID.RIGHT2:
					return buttonRight2.justReleased;
				case FlxMobileInputID.DOWN2:
					return buttonDown2.justReleased;
				case FlxMobileInputID.A:
					return buttonA.justReleased;
				case FlxMobileInputID.B:
					return buttonB.justReleased;
				case FlxMobileInputID.C:
					return buttonC.justReleased;
				case FlxMobileInputID.D:
					return buttonD.justReleased;
				case FlxMobileInputID.E:
					return buttonE.justReleased;
                                case FlxMobileInputID.F:
                                        return buttonF.justReleased;
                                case FlxMobileInputID.G:
                                        return buttonG.justReleased;
                                case FlxMobileInputID.S:
                                        return buttonS.justReleased;
				case FlxMobileInputID.P:
					return buttonP.justReleased;
				case FlxMobileInputID.V:
					return buttonV.justReleased;
				case FlxMobileInputID.X:
					return buttonX.justReleased;
				case FlxMobileInputID.Y:
					return buttonY.justReleased;
				case FlxMobileInputID.Z:
					return buttonZ.justReleased;
				case FlxMobileInputID.noteLEFT:
					return buttonLeft.justReleased;
				case FlxMobileInputID.noteUP:
					return buttonUp.justReleased;
				case FlxMobileInputID.noteRIGHT:
					return buttonRight.justReleased;
				case FlxMobileInputID.noteDOWN:
					return buttonDown.justReleased;
				case FlxMobileInputID.NONE:
					return false;
				default:
					return false;
				}
			}

		/**
		* Checks the `this` virtualpad button's status.
		* @param button			The button you want to check if it's pressed as a string.
		* @param type 			The type that should be checked, can be `"justPressed"`, `"pressed"` or `"justReleased"`.
		*/
		public function checkButtonPressByString(button:String, type:String):Bool
			{
				if(buttonsString.get(button) == null)
					return false;

				var check:Bool = false;
				switch(type){
					case "justPressed":
						check = buttonsString.get(button).justPressed;
					case "pressed":
						check = buttonsString.get(button).pressed;
					case "justReleased":
						check = buttonsString.get(button).justReleased;
				}
				return check;
			}
		
}

enum FlxDPadMode
{
	UP_DOWN;
	LEFT_RIGHT;
	UP_LEFT_RIGHT;
	LEFT_FULL;
	RIGHT_FULL;
	BOTH;
	DIALOGUE_PORTRAIT;
	MENU_CHARACTER;
	NOTE_SPLASH_DEBUG;
	NONE;
}

enum FlxActionMode
{
	A;
	B;
	B_X;
	A_B;
	A_B_C;
	A_B_E;
	A_B_X_Y;
	A_B_C_X_Y;
	A_B_C_X_Y_Z;
	A_B_C_D_V_X_Y_Z;
	DIALOGUE_PORTRAIT;
	MENU_CHARACTER;
	NOTE_SPLASH_DEBUG;
	P;
	B_C;
	NONE;
}
