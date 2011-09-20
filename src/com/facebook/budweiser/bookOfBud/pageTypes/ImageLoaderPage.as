package com.facebook.budweiser.bookOfBud.pageTypes {
	
	import caurina.transitions.Equations;
	import caurina.transitions.Tweener;
	
	import com.facebook.budweiser.bookOfBud.components.AssetLoader;
	
	import flash.display.Bitmap;
	import flash.display.BlendMode;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;

	/**
	 * Loads in a a specified network resource and adds to the display
	 * 
	 * @author ghostmonk 04/05/2009
	 * 
	 */
	public class ImageLoaderPage extends Sprite implements IPage {
		
		private var _isImageLoaded:Boolean;
		private var _imageLoader:AssetLoader;
		private var _image:Bitmap;
		
		
		
		/**
		 * retrieve this instance
		 * <p>This accessor is used by the IPage interface, and so must be implemented like this</p>
		 * 
		 * @return 
		 * 
		 */
		public function get view():DisplayObjectContainer {
			
			return this;
			
		}
		
		
		
		
		/**
		 * Creates new image loader and loads in supplied network resource.
		 * <p>Loader cleans up after itsef</p>
		 * <p>All images load immediately, but in the unlikely case that one should not be fully
		 * loaded when displayed, a progress loader will be added to the display in its place</p>
		 * <p>By default the Image starts at an alpha of 0. Use buildIn method to reveal complete image</p>
		 * 
		 * @param url network location of an image (jpg, png or gif)
		 * @param loadMeter progress is measured by percentage loaded multiplied by total number of frames 
		 * @param blend add a blend mode to the picture if desired
		 * 
		 */
		public function ImageLoaderPage( url:String, loadMeter:MovieClip, blend:String = "multiply" ) {
			
			_isImageLoaded = false;
			_imageLoader = new AssetLoader( url, onComplete, loadMeter );
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			
			blendMode = blend;
			
			alpha = 0;
			
		}
		
		
		
		/**
		 * Simple alpha Tween to full alpha
		 * 
		 */
		public function buildIn():void {
			
			Tweener.addTween( this, { alpha:1, time:0.3, transition:Equations.easeNone } );
			
		}
		
		
		
		/**
		 * Simple alpha Tween to zero alpha
		 * 
		 */
		public function buildOut():void {
			
			Tweener.addTween( this, { alpha:0, time:0.3, transition:Equations.easeNone } );
			
		}
		
		
		
		private function onAddedToStage( e:Event ):void {
			
			if( _image ) {
				position( _image );
			}
			
			if( _imageLoader ) {
				
				_imageLoader.positionToCenter( parent.width, parent.height ); 
				
			}
			
		}
		
		
		
		private function onComplete( display:Bitmap ):void {
			
			_imageLoader = null;
			
			addChild( display );
		 	_image = display;
		 	
		 	_image.alpha = 0;
		 	
		 	Tweener.addTween( _image, { alpha:1, time:0.3, transition:Equations.easeNone } );
		 	
		 	if( stage ) {
		 		position( _image );
		 	}
			
		}
		
		
		private function position( asset:DisplayObject ):void {
			
			asset.x = ( parent.width - asset.width ) * 0.5;
			asset.y = ( parent.height - asset.height ) * 0.5;
			
		}
		
		
	}
}