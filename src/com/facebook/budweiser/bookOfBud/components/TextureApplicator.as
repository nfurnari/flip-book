package com.facebook.budweiser.bookOfBud.components {
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.geom.Point;
	
	/**
	 * Applies a bitmap texture with alpha transparency to a supplied DisplayObjectContainer reference 
	 * 
	 * @author nhillier 04/05/2009
	 * 
	 */
	public class TextureApplicator {
		
		private var _texture:BitmapData;
		
		
		/**
		 * Make sure the supplied bitmapData has alpha transparency. 
		 * The alpha transparency will be used to simulate texture.
		 * 
		 * @param data the bitmap with alpha transparency to be used as a mask
		 * 
		 */
		public function TextureApplicator( data:BitmapData ) {
			
			_texture = data;
	
		}
		
		
		/**
		 * A new bitmap is created from the bitmapData passed to the contstructor, and added
		 * as a mask to the supplied DisplayObjectContainer to create a textured effect from the alpha transparency
		 * 
		 * 
		 * @param view the DisplayObjectContainer to be masked
		 * 
		 */
		public function applyTexture( view:DisplayObjectContainer ):void {
			
			if( view.stage ) {
				texturize( view, new Bitmap( _texture.clone() ) );
			}
			else {
				view.addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			}
			
		}
		
		
		
		private function texturize( view:DisplayObjectContainer, texture:Bitmap ):void {
			
			texture.cacheAsBitmap = true;
			view.cacheAsBitmap = true;
			
			view.addChild( texture );
			view.mask = texture;
			
		}
		
		
		
		private function onAddedToStage( e:Event ):void {
		
			var view:DisplayObjectContainer = e.target as DisplayObjectContainer;
			view.removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );		
			texturize( view, new Bitmap( _texture.clone() ) );
			
		}

	}
}