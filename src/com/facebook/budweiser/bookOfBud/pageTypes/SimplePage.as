package com.facebook.budweiser.bookOfBud.pageTypes {
	
	import caurina.transitions.Equations;
	import caurina.transitions.Tweener;
	
	import com.facebook.budweiser.bookOfBud.components.TextureApplicator;
	
	import flash.display.DisplayObjectContainer;

	/**
	 * The most basic page for the FlipBook. No interaction available, and a very quick and
	 * simple alpha build in and build out implementation.
	 * 
	 * @author ghostmonk
	 * 
	 */
	public class SimplePage implements IPage {
		
		
		
		private var _view:DisplayObjectContainer;
		
		
		
		/**
		 * 
		 * retrieve instance of the view
		 * 
		 * @return 
		 * 
		 */
		public function get view():DisplayObjectContainer {
			
			return _view;
			
		}
		
		
		
		
		/**
		 * 
		 * 
		 * @param view
		 * @param texturizer used to add texture to the view 
		 * 
		 */
		public function SimplePage( view:DisplayObjectContainer, texturizer:TextureApplicator = null ) {
			
			_view = view;
			
			if( texturizer ) {
				
				texturizer.applyTexture( _view );
				
			}
			
			_view.alpha = 0;
			
		}

		
		
		/**
		 * Simple Tweener alpha fade in
		 * 
		 */
		public function buildIn():void {
			
			Tweener.addTween( _view, { alpha:1, time:0.2, transition:Equations.easeNone } );
			
		}
		
		
		
		/**
		 * Simple Tweener alpha fade out on view
		 * view is automatically removed from the display list upon completion
		 * 
		 */
		public function buildOut():void {
			
			Tweener.addTween( 
				_view, { 
					alpha:0, 
					time:0.1, 
					transition:Equations.easeNone, 
					onComplete:_view.parent.removeChild, 
					onCompleteParams:[_view] 
				} 
			);
			
		}
		
		
		
	}
}