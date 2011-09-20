package com.facebook.budweiser.bookOfBud.events {
	
	import flash.events.Event;

	/**
	 * Used to notify interested objects about a pageflip either forward or backward
	 * 
	 * @author ghostmonk 02/05/2009
	 * 
	 */
	public class PageFlipEvent extends Event {
		
		public static const PAGE_FLIP:String = "pageFlip";
		public static const PAGE_FLIP_COMPLETE:String = "pageFlipComplete";
		
		private var _isForward:Boolean;
		
		
		
		/**
		 * Whether or not the book is being flipped forward if true or backward if false
		 * 
		 * @return 
		 * 
		 */
		public function get isForward():Boolean {
			
			return _isForward;
			
		}
		
		
		
		/**
		 * 
		 * @param type
		 * @param isForward
		 * @param bubbles
		 * @param cancelable
		 * 
		 */
		public function PageFlipEvent(type:String, isForward:Boolean = false, bubbles:Boolean=false, cancelable:Boolean=false) {
			
			_isForward = isForward;
			
			super(type, bubbles, cancelable);
			
		}
		
		
		
		override public function clone():Event {
			
			return new PageFlipEvent( type, isForward, bubbles, cancelable );
			
		}
		
		
		
	}
}