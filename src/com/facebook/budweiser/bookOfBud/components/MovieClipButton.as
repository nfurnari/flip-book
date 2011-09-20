package com.facebook.budweiser.bookOfBud.components {
	
	import caurina.transitions.Equations;
	import caurina.transitions.Tweener;
	import caurina.transitions.properties.DisplayShortcuts;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	
	/**
	 * A non-display class that composits interactive button functionality to a MovieClip
	 *   
	 * @author ghostmonk
	 * 
	 */
	public class MovieClipButton {
		
		
		
		private var _view:MovieClip;
		private var _clickCallBack:Function;
		
		
		
		/**
		 * retrieve instance of target MovieClip passed to the constructor
		 * 
		 * @return 
		 * 
		 */
		public function get view():MovieClip {
			
			return _view;
			
		}
		
		
		
		/**
		 * 
		 * @param view object used for user interaction
		 * @param clickCallBack function called when view is clicked, clone of MouseEvent.CLICK is passed to the constructor
		 * 
		 */
		public function MovieClipButton( view:MovieClip, clickCallBack:Function ) {
			
			DisplayShortcuts.init();
			
			_view = view;
			_view.stop();
			_view.mouseChildren = false;
			
			_clickCallBack = clickCallBack;
			
			enable();
		}
		
		
		
		/**
		 * Turns the view into an interactive button
		 * 
		 */
		public function enable():void {
			
			testMouse();
			_view.buttonMode = true;
			_view.addEventListener( MouseEvent.CLICK, onClick );
			_view.addEventListener( MouseEvent.ROLL_OVER, onRollOver );
			_view.addEventListener( MouseEvent.ROLL_OUT, onRollOut );
			
		}
		
		
		
		/**
		 * Removes interactivity from the view
		 * 
		 */
		public function disable():void {
			
			_view.gotoAndStop( 1 );
			_view.buttonMode = false;
			_view.removeEventListener( MouseEvent.CLICK, onClick );
			_view.removeEventListener( MouseEvent.ROLL_OVER, onRollOver );
			_view.removeEventListener( MouseEvent.ROLL_OUT, onRollOut );
			
		}
		
		
		
		private function onClick( e:MouseEvent ):void {
		
			_clickCallBack( e );
			
		}
		
		
		
		private function onRollOver( e:MouseEvent ):void {
		
			Tweener.addTween(
				_view, {
					_frame:_view.totalFrames, 
					time:( _view.totalFrames - _view.currentFrame ) / _view.stage.frameRate,
					transition:Equations.easeNone 
				}
			);
			
		}



		private function onRollOut( e:MouseEvent ):void {
		
			if( _view.stage ) {
				Tweener.addTween(
					_view, {
						_frame:1, 
						time: _view.currentFrame / _view.stage.frameRate,
						transition:Equations.easeNone 
					}
				);
			}
			else {
				_view.gotoAndStop( 1 );
			}
			
		}
		
		
		private function testMouse():void {
			
			if( _view.stage ) {
				
				if( _view.hitTestPoint( _view.parent.mouseX, _view.parent.mouseY ) ) {
					onRollOver( null );
				}
					
			}
			
		}
		
		
	}
}