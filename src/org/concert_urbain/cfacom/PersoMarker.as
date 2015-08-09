package org.concert_urbain.cfacom{	import com.google.maps.LatLng;	import com.google.maps.MapMouseEvent;	import com.google.maps.overlays.Marker;	import com.google.maps.overlays.MarkerOptions;		import flash.display.MovieClip;	import flash.display.Sprite;	import flash.filters.BitmapFilterQuality;	import flash.filters.GlowFilter;		import gs.*;	import gs.easing.*;		import org.concert_urbain.touratour.api.vos.*;	import org.concert_urbain.utils.PersoGraphicTools;
	import org.concert_urbain.utils.ColorUtils;			public class PersoMarker extends Marker	{			protected var symbol:MovieClip;		protected var percentRollEffect:Number = 0;		//protected var bdColor:uint = 0x666666;		protected var bdColor:uint = 0xDDDDDD;				protected var _vo:Item;		protected var iconePerso:MovieClip;		protected var graphicContainer:MovieClip;		protected var mySun:Sprite;		protected var title:PersoTitle;				public function PersoMarker(latlng:LatLng, icone:MovieClip)		{			graphicContainer = new MovieClip();			symbol = graphicContainer;						icone.x = -icone.width/2;			icone.y = -icone.height/2;						graphicContainer.addChild(icone);						super(latlng, new MarkerOptions({icon:symbol, hasShadow:false}));						addEventListener(MapMouseEvent.ROLL_OVER, rollOver, false, 0, true);			addEventListener(MapMouseEvent.ROLL_OUT, rollOut, false, 0, true);						// PERSO			iconePerso = icone;						//GET SUN			mySun = PersoGraphicTools.createSun();			graphicContainer.addChild(mySun);						//GET TITLE			title = new PersoTitle();			graphicContainer.addChild(title);						toggleFeedback(false);						//symbol.x = -symbol.width / 2;			//symbol.y = -symbol.height / 2;		}				public function get vo():Item		{			return _vo;		}				public function set vo(itemVO:Item):void		{			_vo = itemVO;						if (itemVO) title.setTitle(itemVO.title);		}				public function getTitle():PersoTitle{	return title;	}				public function toggleFeedback(flag:Boolean):void{			mySun.visible = title.visible = flag;		}				public function rollOver(e:MapMouseEvent):void		{			toggleFeedback(true);			/*			rollPercent = 0;			TweenLite.killTweensOf (this, false);			TweenLite.to(this, .50, {rollPercent:1, ease:Cubic.easeOut});			*/		}				public function rollOut(e:MapMouseEvent):void		{			toggleFeedback(false);			/*			TweenLite.killTweensOf (this, false);			TweenLite.to(this, .40, {rollPercent:0, ease:Cubic.easeOut});			*/		}				//		// Couleurs		//				public function set borderColor(c:uint):void		{			bdColor = c;		}		public function setVoteColor(percentAbs:Number):void{			drawBackground(PersoSprite.getVoteColor(percentAbs));		}				protected function drawBackground(color:Number):void{			if (iconePerso)	ColorUtils.setColorTransform(iconePerso, color);		}				//		// Animation glow au rollOver		//				public function get rollPercent():Number{	return percentRollEffect;	}						public function set rollPercent(p:Number):void		{			percentRollEffect = p;						var glow:GlowFilter;			if (symbol.filters.length > 0)			{				glow = symbol.filters[0];			}			else			{				glow = new GlowFilter();				glow.quality = BitmapFilterQuality.HIGH				glow.alpha = 0.8;				glow.color = bdColor;				glow.strength = 5;				symbol.filters = [glow];			}						glow.blurX = glow.blurY = 5 * percentRollEffect;			symbol.filters = [glow];		}			}}