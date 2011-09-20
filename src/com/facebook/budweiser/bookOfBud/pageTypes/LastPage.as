package com.facebook.budweiser.bookOfBud.pageTypes {
	
	import com.facebook.budweiser.bookOfBud.components.MovieClipButton;
	
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	
	
	/**
	 * The very final page in the book. 
	 * This class simply adds interactive functionality to the display.  
	 * Extends the FinalPageAsset library item found in Pages.fla.
	 * 
	 * @author ghostmonk
	 * 
	 */
	public class LastPage extends FinalPageAsset {
		
		
		private var _jsCall:String;
		
		
		/**
		 * Implements FinalPageAsset, composing the instance of addRules with
		 * the MovieClipButton.
		 * 
		 * <p>Clicking addRules will cause ExternalInterface to call the jsCall function reference.</p>
		 * 
		 * @param jsCall name of javascript function to be called by ExternalInterface
		 * 
		 */
		public function LastPage( jsCall:String ) {
			
			_jsCall = jsCall;
			
			top.cacheAsBitmap = true;
			bottom.cacheAsBitmap = true;
			
			//new MovieClipButton( addRules, onAddRule );
			
		}
		
		
		private function onAddRule( e:MouseEvent ):void {
			
			ExternalInterface.call( _jsCall );
			
		}
		
	}
}