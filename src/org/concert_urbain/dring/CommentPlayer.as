package org.concert_urbain.dring
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.AntiAliasType
	import flash.geom.Rectangle;
	
	import org.concert_urbain.dring.VO.MessageVO;
	import org.concert_urbain.dring.VO.MessageCommentVO;
	import org.concert_urbain.utils.TextViewer;
	import org.concert_urbain.utils.DisplayUtils;
	

	
	public class CommentPlayer extends Sprite
	{	
		private var playerWidth:Number = 320;
		private var playerHeight:Number = 240;
		private var playerRect:Rectangle;

		public var currentMessageVO:MessageVO;
		public var textFormat:TextFormat;
		
		public function CommentPlayer()
		{
			super();
			
			// Rectangle du player (limite les dimensions des médias)
			playerRect = new Rectangle(0, 0, playerWidth, playerHeight);
		}
				
		public function drawBackground():void
		{
			var g:Graphics = graphics;
			g.beginFill(0xFFAAAA);
			g.drawRect(0, 0, playerWidth, playerHeight);
			g.endFill();
		}

		//
		// Commentaires :
		//
				
		public function displayComments(messageVO:MessageVO):void
		{
			displayCommentsContents(messageVO.getComments());
		}
			
		public function displayCommentsContents(comments:Array):void
		{
			// Suppression des précédents contenus
			DisplayUtils.removeAllChildren(this);
			
			if (comments.length > 0)
			{
				var i:uint;
				var n:uint = comments.length;
				var texte:TextViewer;
				var textField:TextField;
				var commentVO:MessageCommentVO;
				var top:Number = 0;
				
				
				for (i=0; i<n; i++)
				{
					commentVO = comments[i] as MessageCommentVO;
					
					if (commentVO.content.length > 0)
					{
						texte = new TextViewer(commentVO.content, false, playerRect);
						texte.y = top;
						
						textField = texte.textField;
						textField.background = true;
						textField.backgroundColor = getCommentBackgroundColor(commentVO.vote);
						
						texte.fillBackground();
						
						addChild(texte);
						
						top += texte.height;
					}
				}

			}
		}
		
		private function getCommentBackgroundColor(authorVote:Number):Number
		{
			var vote:Number = Number(authorVote);
			if (vote == 1)
			{
				// Vert
				return 0x3CA42B;
			}
			else if (vote == -1)
			{
				// Rouge
				return 0xE3213C;
			}
			else
			{
				// Orange
				return 0xF3971C;
			}
		}
	}
}
