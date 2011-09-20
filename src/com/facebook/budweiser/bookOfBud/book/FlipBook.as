package com.facebook.budweiser.bookOfBud.book 
{	
	import com.facebook.budweiser.bookOfBud.components.MovieClipButton;
	import com.facebook.budweiser.bookOfBud.events.PageFlipEvent;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	
	[Event ( name="pageFlip", type="com.facebook.budweiser.bookOfBud.events.PageFlipEvent" ) ]
	[Event ( name="pageFlipComplete", type="com.facebook.budweiser.bookOfBud.events.PageFlipEvent" ) ]
	
	/**
	 * Extends a MovieClip library asset, and controls clicking behaviour that allows user to 
	 * move forward and backward through the book
	 * 
	 * <p>Use private constants to reference framelabels</p>
	 *  
	 * @author nhillier 29/04/2009
	 * 
	 */
	public class FlipBook extends BookAsset 
	{		
		private const FORWARD_MANY:String = "forwardMany";
		private const FORWARD_ONE:String = "forwardOne";
		private const BACK_MANY:String = "backMany";
		private const BACK_ONE:String = "backOne";
		private const OPEN:String = "bookOpen";
		
		private var _flipFwdOne:int;
		private var _flipFwdMany:int;
		private var _flipBckOne:int;
		private var _flipBckMany:int;
		private var _bookOpen:int;
		
		private var _sideLinkForward:MovieClipButton;
		private var _sideLinkBack:MovieClipButton;
		
		/**
		 * Sets up all the destination points in the file, event listening and interactivity
		 * 
		 */
		public function FlipBook( ) 
		{	
			stop();
			
			_flipFwdOne = setFrame( FORWARD_ONE ); 
			_flipFwdMany = setFrame( FORWARD_MANY );
			
			_flipBckOne = setFrame( BACK_ONE );
			_flipBckMany = setFrame( BACK_MANY );
			
			_bookOpen = setFrame( OPEN );
			
			_sideLinkForward = new MovieClipButton( sideLinkForward, pageTurn );
			_sideLinkBack = new MovieClipButton( sideLinkBack, pageTurn ); 
			disable();
			
			gotoAndPlay( 1 );
			
			addEventListener( Event.COMPLETE, onComplete );
			
		}
		
		
		
		/**
		 * Enables only the right side of the book for page turning.
		 * <p>Use this function in combination with enableLeft and disable to 
		 * create appropriate functionality based on curret pages.</p>
		 * 
		 */
		public function enableRight():void { 
		
			_sideLinkForward.enable(); 
			
		}
		
		
		
		/**
		 * Enables only the left side of the book for page turning.
		 * <p>Use this function in combination with enableRight and disable to 
		 * create appropriate functionality based on curret pages.</p>
		 */
		public function enableLeft():void {	
		
			_sideLinkBack.enable(); 
		
		}
		
		
		
		/**
		 * Plays the starting animation to open the book to the TableOfContents 
		 * 
		 */
		public function open():void {
			
			gotoAndPlay( 1 );
			
		}
		
		
		
		/**
		 * Plays the animation to flip one page forward
		 */
		public function flipFwdOne():void {
			
			disable();
			gotoAndPlay( _flipFwdOne );
			
		}
		
		
		
		/**
		 * Plays the animation to flip many pages forward
		 */
		public function flipFwdMany():void {
			
			disable();
			gotoAndPlay( _flipFwdMany );
				
		}
		
		
		
		/**
		 * Plays the animation to flip one page backward
		 */
		public function flipBckOne():void {
			
			disable();
			gotoAndPlay( _flipBckOne );
			
		}
		
		
		
		/**
		 * Plays the animation to flip many pages backward
		 */
		public function flipBckMany():void {
			
			
			gotoAndPlay( _flipBckMany );
			
		}
		
		
		
		private function disable():void {
		
			_sideLinkForward.disable();
			_sideLinkBack.disable();
			
		}
		
		
		
		private function setFrame( label:String ):int {
			
			gotoAndStop( label );
			return currentFrame;
			
		}
		
		
		
		private function onComplete( e:Event ):void {

			gotoAndStop( _bookOpen );
			dispatchEvent( new PageFlipEvent( PageFlipEvent.PAGE_FLIP_COMPLETE ) );				
			
		}
		
		
		private function pageTurn( e:MouseEvent ):void {
			
			var isForward:Boolean = e.target == _sideLinkForward.view ? true : false ;
			dispatchEvent( new PageFlipEvent( PageFlipEvent.PAGE_FLIP, isForward ) );
			
		}
		
		
	}
}