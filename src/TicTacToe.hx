package;

import nme.display.Graphics;
import nme.display.Sprite;
import nme.events.Event;
import nme.events.MouseEvent;
import nme.Lib;

class TicTacToe
{
	var data:Array<Int>;
	var timeToO:Bool;
	var document:Sprite;
	var graphics:Graphics;

	public function new()
	{
		document = Lib.current;
		if(document.stage != null)
			init();
		else
			document.addEventListener(Event.ADDED_TO_STAGE, init);
	}

	public static function main()
	{
		new TicTacToe();
	}

	function init(?e:Event):Void
	{
		if(e != null)
			document.removeEventListener(Event.ADDED_TO_STAGE, init);
		data = [0, 0, 0, 0, 0, 0, 0, 0, 0];
		timeToO = true;
		graphics = document.graphics;
		graphics.clear();
		graphics.lineStyle(1);
		graphics.moveTo(100, 0);
		graphics.lineTo(100, 300);
		graphics.moveTo(200, 0);
		graphics.lineTo(200, 300);
		graphics.moveTo(0, 100);
		graphics.lineTo(300, 100);
		graphics.moveTo(0, 200);
		graphics.lineTo(300, 200);
		graphics.lineStyle(20);
		document.stage.removeEventListener(MouseEvent.MOUSE_DOWN, MOUSE_DOWN);
		document.stage.addEventListener(MouseEvent.MOUSE_DOWN, MOUSE_DOWN);
	}

	function MOUSE_DOWN(e:MouseEvent):Void
	{
		var mouseX = document.mouseX;
		var mouseY = document.mouseY;
		if(mouseX < 0 || mouseX > 300 || mouseY < 0 || mouseY > 300) return;
		var count:Int = 0;
		for(i in 0...9) if(data[i] != 0) ++count;
		if(count == 9) init();
		var index:Int = Std.int(mouseY / 100) * 3 + Std.int(mouseX / 100);
		if(! cast data[index])
		{
			if(timeToO)
			{
				drawO(index);
				timeToO = false;
				data[index] = 1;
			} else {
				drawX(index);
				timeToO = true;
				data[index] = 2;
			}
		}
	}

	function positionX(index:Int):Int
	{
		return (index % 3) * 100 + 50;
	}

	function positionY(index:Int):Int
	{
		return Std.int(index / 3) * 100 + 50;
	}

	function drawO(index:Int):Void
	{
		graphics.drawCircle(positionX(index), positionY(index), 30);
	}

	function drawX(index:Int):Void
	{
		var positionX:Int = positionX(index);
		var positionY:Int = positionY(index);
		graphics.moveTo(-25 + positionX, -25 + positionY);
		graphics.lineTo(25 + positionX, 25 + positionY);
		graphics.moveTo(25 + positionX, -25 + positionY);
		graphics.lineTo(-25 + positionX, 25 + positionY);
	}
}