package com.facebook.budweiser.bookOfBud.pageTypes {
	
	import com.facebook.budweiser.bookOfBud.events.PageNavigationEvent;
	
	import flash.display.DisplayObjectContainer;
	
	/**
	 * All new pages added to the FlipBook must implement this interface and are added to 
	 * the application in ApplicationBuilder
	 * 
	 * <p>Main method of page construction is to build full pages in the Flash IDE
	 * export them for actionscript as a visual class and add them to 
	 * untyped classes that implement IPage. SimplePage is the basic example.</p>
	 * <p>ex: new SimplePage( new LibraryAsset() );<p>
	 * 
	 * @author ghostmonk
	 * 
	 */
	public interface IPage {
		
		/**
		 * Retrieve instance of the view. The view must be a subtype of DisplayObjectContainer
		 * 
		 * @return 
		 * 
		 */
		function get view():DisplayObjectContainer;
		
		/**
		 * Used to build in content to the page after a page flip. Should be quick.
		 * 
		 */
		function buildIn():void;
		
		/**
		 * Used to build out content to the page before a page flip. Should be VERY quick, almost instant.
		 */
		function buildOut():void;
		
	}
}