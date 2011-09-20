package com.facebook.budweiser.bookOfBud.pageTypes {
	
	import com.facebook.budweiser.bookOfBud.components.MovieClipButton;
	import com.facebook.budweiser.bookOfBud.events.PageNavigationEvent;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	
	/**
	 * 
	 * @author ghostmonk 02/05/2009
	 * 
	 */
	public class TableOfContents extends TOCAsset {
		
		
		
		/**
		 * Compose all named links on TOCAsset with MovieClipButtonAsset
		 * 
		 * @param chapterIndexes an array of page destinations
		 * 
		 */
		public function TableOfContents( chapterIndexes:Array ) {
			
			chapter01Link.page = chapterIndexes[0];
			new MovieClipButton( chapter01Link, navigate );
			
			/*chapter02Link.page = chapterIndexes[1];
			new MovieClipButton( chapter02Link, navigate );
			
			chapter03Link.page = chapterIndexes[2];
			new MovieClipButton( chapter03Link, navigate );*/
			
		}
		
		
		
		private function navigate( e:MouseEvent ):void {
			
			dispatchEvent( 
				new PageNavigationEvent( 
					PageNavigationEvent.NAVIGATE_TO_PAGE, 
					MovieClip( e.target ).page 
				) 
			);
			
		}
		
	}
}