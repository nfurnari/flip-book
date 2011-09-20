package com.facebook.budweiser.bookOfBud.components {

	import flash.display.*;
	import flash.events.*;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	
	/**
	 * A movieclip library asset is played back based on totalFrames and bytesLoaded 
	 * onComplete, loaded content is passed back through a callback function 
	 * This class cleans up after itself when loading is complete
	 * 
	 * TODO: Error handling
	 * 
	 * @author nhillier 30/04/2009
	 * 
	 */
	public class AssetLoader {
	
	
		private var _loader:Loader;
		private var _url:URLRequest;
		private var _readyFrame:int;
		private var _callBack:Function;
		private var _view:MovieClip;
		
		
		/**
		 * 
		 * @param url the location of the content to be loaded in
		 * @param callback callback a function expecting loaded content
		 * @param view a preloader MovieClip asset. Load progress is measured as a percentage of total frames
		 * 
		 */
		public function AssetLoader( url:String, callback:Function, view:MovieClip, checkPolicy:Boolean = true ) {
		    
		    _view = view;
		    _view.stop();
		    
		    _url = new URLRequest( url );
					
			_callBack = callback;
		    
		    _loader = new Loader();
			_loader.contentLoaderInfo.addEventListener( ProgressEvent.PROGRESS, onProgress );
			_loader.contentLoaderInfo.addEventListener( Event.COMPLETE, onComplete );
			_loader.load( _url, new LoaderContext( checkPolicy ) );
		                        
		}
		
		
		
		/**
		 * 
		 * @param parentWidth
		 * @param parentHeight
		 * 
		 */
		public function positionToCenter( parentWidth:Number, parentHeight:Number ):void {
			
			_view.x = ( _view.width - parentWidth ) * 0.5;
			_view.y = ( _view.height - parentHeight ) * 0.5;
		
		}
		
		
		private function onProgress( e:ProgressEvent ):void {
		    
			var percent:Number = e.bytesTotal != 0 ? e.bytesLoaded / e.bytesTotal : 0;
			
			var frame:int = Math.max( 1, Math.ceil( percent * _view.totalFrames ) );  
			
			_view.gotoAndStop( frame );
		    
		}
		
		
		
		private function onComplete( e:Event ):void {
		    
		    _callBack( _loader.content );
			_loader.contentLoaderInfo.removeEventListener( ProgressEvent.PROGRESS, onProgress );
			_loader.contentLoaderInfo.removeEventListener( Event.COMPLETE, onComplete );
			_view = null;
			_loader = null;
			null;
			
		}
	            
	}
}
