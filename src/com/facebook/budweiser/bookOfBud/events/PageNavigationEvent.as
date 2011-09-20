package com.facebook.budweiser.bookOfBud.events {
	
	import flash.events.Event;

	/**
	 * Used to update the flip book whenever a navigation event is called from within a page.
	 * Strictly speaking only the TableOfContents uses this event, but every page has the ability
	 * to dispatch this event. The Page manager is listening for the event in each and every page.
	 * 
	 * @author ghostmonk 02/05/2009
	 * 
	 */
	public class PageNavigationEvent extends Event {
		
		public static const NAVIGATE_TO_PAGE:String = "navigateToPage";
		
		private var _page:int;
		
		/**
		 * retrieve the page value
		 * 
		 * @return 
		 * 
		 */
		public function get page():int {
			return _page;
		}
		
		/**
		 * 
		 * @param type
		 * @param page
		 * @param bubbles
		 * @param cancelable
		 * 
		 */
		public function PageNavigationEvent( type:String, page:int, bubbles:Boolean=false, cancelable:Boolean=false ) {
			
			_page = page;
			super(type, bubbles, cancelable);
			
		}
		
		override public function clone():Event {
			
			return new PageNavigationEvent( type, page, bubbles, cancelable );
			
		}
		
	}
}