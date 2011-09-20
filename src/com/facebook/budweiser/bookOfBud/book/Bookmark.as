package com.facebook.budweiser.bookOfBud.book {
	
	import caurina.transitions.Equations;
	import caurina.transitions.Tweener;
	
	import com.facebook.budweiser.bookOfBud.events.PageNavigationEvent;
	
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	

	
	[Event (name="navigateToPage", type="com.facebook.budweiser.bookOfBud.events.PageNavigationEvent")]
	
	/**
	 * Visual indicator to return to the TableOfContents from any place in the book
	 * <p>Use constants to set up interactive frame destinations</p>
	 * 
	 * @author nhillier
	 * 
	 */
	public class Bookmark extends EventDispatcher {
		
		private const HOME:String = "home";
		private const HIDE:String = "hide";
		private const RETURN:String = "return";
		
		private var _view:BookmarkAsset;
		
		private var _home:int;
		private var _hide:int;
		private var _return:int;
		
		
		/**
		 * Retrieve an instance of the asset making up the view.
		 * BookmarkAsset can be found in book.fla.
		 * 
		 * @return 
		 * 
		 */
		public function get view():BookmarkAsset {
			
			return _view;
			
		}
		
		
		
		/**
		 * 
		 * @param view
		 * 
		 */
		public function Bookmark( view:BookmarkAsset ) {
				
			_view = view;
			_view.rtocArrow.mouseEnabled = false;
			_view.rtocLabel.mouseEnabled = false;
			_view.mouseChildren = false;
			
			_home = setFrame( HOME );
			_hide = setFrame( HIDE );
			_return = setFrame( RETURN );
			
		}
		
		
		
		/**
		 * Full bookmark will be displayed on the inner edge of the right hand page.
		 * <p>Used to indicate the book mark is set at the TableOfContents</p> 
		 * 
		 */
		public function homePage():void {
			
			disable();	
			tweenTo( _home );
		}
		
		
		
		/**
		 * Hides the bookmark from view. 
		 * <p>Useful when transitioning between pages.</p>
		 * 
		 */
		public function hide():void {
			
			tweenTo( _hide );
			
		}
		
		
		/**
		 * Displays the bottom part of the bookmark on the inner edge of the 
		 * left-hand page, giving the semblance of a marked section.
		 * 
		 * <p>Clicking the bookmark will send out an event to cause the page manager
		 * to flip back to the TableOfContents</p> 
		 * 
		 */
		public function enable():void {
			
			tweenTo( _return,  enableButton );
			
		}
		
		
		private function enableButton():void {
			
			_view.buttonMode = true;
			_view.addEventListener( MouseEvent.CLICK, onClick );
			_view.addEventListener( MouseEvent.ROLL_OVER, onRollOver );
			_view.addEventListener( MouseEvent.ROLL_OUT, onRollOut );
			
		}
		
		
		
		private function disable():void {
			
			_view.buttonMode = false;
			_view.removeEventListener( MouseEvent.CLICK, onClick );
			_view.removeEventListener( MouseEvent.ROLL_OVER, onRollOver );
			_view.removeEventListener( MouseEvent.ROLL_OUT, onRollOut );
			
		}
		
		
		
		private function onClick( e:MouseEvent ):void {
			
			disable();
			_view.gotoAndStop( _return );
			dispatchEvent( new PageNavigationEvent( PageNavigationEvent.NAVIGATE_TO_PAGE, 0 ) );
			
		}
		
		
		
		
		private function tweenTo( frameNum:int, completeCall:Function = null, isQuick:Boolean = false ):void {
			
			var tweenTime:Number = isQuick ? 0.3 : Math.abs( ( frameNum - _view.currentFrame ) ) / _view.stage.frameRate;
			
			Tweener.addTween( 
				_view, { 
					_frame:frameNum, 
					time: tweenTime,
					transition:Equations.easeNone,
					onComplete: completeCall
				} 
			);
			
		}
		
		
		
		private function setFrame( label:String ):int {
			
			var frame:int;
			_view.gotoAndStop( label );
			frame = _view.currentFrame;
			_view.gotoAndStop( 1 );
			
			return frame;
			
		}
		
		
		
		private function onRollOver( e:MouseEvent ):void {
		
			tweenTo( _view.totalFrames );
			
		}
		
		
		private function onRollOut( e:MouseEvent ):void {
			
			tweenTo( _return );
			
		}
		
		
	}
}