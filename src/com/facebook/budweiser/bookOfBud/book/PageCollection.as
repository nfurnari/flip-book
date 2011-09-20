package com.facebook.budweiser.bookOfBud.book {
	
	import com.facebook.budweiser.bookOfBud.pageTypes.IPage;
	
	/**
	 * Simple collection forcing all pages to be of type IPage
	 * 
	 * @author ghostmonk 02/05/2009
	 * 
	 */
	public class PageCollection {
		
		
		
		private var _pages:Array;
		
		
		
		/**
		 * retrieve entire array
		 * 
		 * @return 
		 * 
		 */
		public function get list():Array {
			
			return _pages;
			
		}
		
		
		
		/**
		 * creates new array to hold an instance collection of IPage
		 * 
		 */
		public function PageCollection( ) {
			
			_pages = [];
			
		}
		
		
		
		/**
		 * Add an instance of IPage to collection
		 * 
		 * @param page
		 * 
		 */
		public function addPage( page:IPage ):void {
			
			_pages.push( page );
			
		}
		
		
		
		/**
		 * Retrieve an instance of IPage by index
		 * 
		 * @param index
		 * @return 
		 * 
		 */
		public function getPage( index:int ):IPage {
			
			return IPage( _pages[ index ] );
			
		}



	}
}