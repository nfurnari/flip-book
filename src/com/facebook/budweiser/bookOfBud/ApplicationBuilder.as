package com.facebook.budweiser.bookOfBud {
	
	import com.facebook.budweiser.bookOfBud.components.TextureApplicator;
	import com.facebook.budweiser.bookOfBud.pageTypes.ImageLoaderPage;
	import com.facebook.budweiser.bookOfBud.pageTypes.LastPage;
	import com.facebook.budweiser.bookOfBud.pageTypes.SimplePage;
	import com.facebook.budweiser.bookOfBud.pageTypes.TableOfContents;
	
	
	/**
	 * Object provider/builder for the application
	 * All pages are created and ordered in the constructor
	 * 
	 * @author nhillier 30/04/2009
	 * 
	 */
	public class ApplicationBuilder {
		
		
		private var _pages:Array;
		
		
		/**
		 * Retrieve an array of every page in the application
		 * @return 
		 * 
		 */
		public function get pages():Array {
		
			return _pages;
		
		}
		
		
		
		/**
		 * All page creation is initiated in this object 
		 * <p>Pages are stacked in pairs, first for the left-hand side, and the second for the right-hand side</p>
		 * <p>A null value will create a blank page.</p>
		 * <p>All new pages must implement the IPage interface</p>
		 */
		public function ApplicationBuilder() {
			
			var chapterIndexes:Array = [ 2, 8, 14 ];
			var grungeTexture:TextureApplicator = new TextureApplicator( new GrungeTexture() ); 
			
			
			_pages = [
				
				
				//Table Of Contents
				new SimplePage( new TOCLeft() ),
				new SimplePage( new TableOfContents( chapterIndexes ), grungeTexture ),
				
				
				//Chapter 01
				new ImageLoaderPage( "assets/page02.jpg", new LoadMeterAsset() ),
				new SimplePage( new Page03(), grungeTexture ),
				
				new ImageLoaderPage( "assets/page04.jpg", new LoadMeterAsset() ),
				new SimplePage( new Page05(), grungeTexture ),
				
				new ImageLoaderPage( "assets/page06.jpg", new LoadMeterAsset() ),
				new SimplePage( new Page07(), grungeTexture ),
				
				//Last Page
				null,
				new SimplePage( new LastPage( "addContest" ), grungeTexture )
				
			]
			
			
			
		}
		
		
		
	}
}