﻿package org.concert_urbain.cfacom{	import flash.display.CapsStyle;	import flash.display.Graphics;	import flash.display.JointStyle;	import flash.display.LineScaleMode;	import flash.display.MovieClip;	import flash.geom.ColorTransform;		import gs.*;	import gs.easing.*;		import org.concert_urbain.touratour.TitleMessageSprite;	import org.concert_urbain.utils.ColorUtils;
		public class PersoSprite extends TitleMessageSprite {				private var symbol:MovieClip; // Recoit l'image du perso				public function PersoSprite(){						super();						mouseChildren = false;			buttonMode = true;			randomX = Math.random()/80;			randomY = Math.random()/20;						//addEventListener(MouseEvent.ROLL_OVER, rollOver, false, 1, true);			//addEventListener(MouseEvent.ROLL_OUT, rollOut, false, 1, true);		}				public function addSymbol(mc:MovieClip):void{			symbol = mc;						addChild(symbol);						symbol.mouseEnabled = false;			//symbol.x = - symbol.width/2;			//symbol.y = - symbol.height/2;						updateSelection();		}				override public function select(bool:Boolean):void{						super.select(bool);			updateSelection();		}				public function updateSelection():void{			if (isVisited == true)			{				var selectColor:uint = isSelected ? 0xFFFFFF : 0x666666;				var g:Graphics = border.graphics;				g.clear();				g.lineStyle(1, selectColor, 1, true, LineScaleMode.NORMAL, CapsStyle.SQUARE, JointStyle.MITER);				g.drawRect(symbol.width/4, symbol.height + 1, symbol.width/2, 1);			}		}				override public function set borderColor(c:uint):void{			bdColor = c;		}				override public function set backgroundColor(c:uint):void{			bgColor = c;			drawBackground(c);		}				override protected function drawBorder(color:Number):void {		}				static public function getVoteColor(percentAbs:Number):uint{			var r:Number = 255 * percentAbs;			if(r > 255)	r = 255;			var g:Number = 255 - r;			return new ColorTransform(0,0,0,255,r,g,0).color;		}				public function setVoteColor(percentAbs:Number):void{			drawBackground(PersoSprite.getVoteColor(percentAbs));		}				override protected function drawBackground(color:Number):void{			if (symbol)	ColorUtils.setColorTransform(symbol, color);		}				static public function changeColor(obj:MovieClip, color:uint):void{			if (obj)	ColorUtils.setColorTransform(obj, color);		}	}}