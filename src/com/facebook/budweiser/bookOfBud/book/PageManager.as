package com.facebook.budweiser.bookOfBud.book {
	
	import com.facebook.budweiser.bookOfBud.events.PageFlipEvent;
	import com.facebook.budweiser.bookOfBud.events.PageNavigationEvent;
	import com.facebook.budweiser.bookOfBud.pageTypes.IPage;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	
	/**
	 * Controls the flipbook view/playback and provides proper pages as
	 * needed from pagecollection to flipbook. Controls the position in the book
	 * 
	 * @author ghostmonk 02/05/2009
	 * 
	 */
	public class PageManager {
		
		
		
		private var _currentPage:int;
		private var _pageCollection:PageCollection;
		private var _flipBook:FlipBook;
		private var _bookmark:Bookmark;
		
		
		
	
		/**
		 * Listening added to flipbook and IPages in pageCollection
		 * <p>Book is opened to TableOfContents</p>
		 *  
		 * @param flipBook
		 * @param pages
		 * @param bookmark
		 * 
		 */
		public function PageManager( flipBook:FlipBook, pageCollection:PageCollection, bookmark:Bookmark ) {
		
			_currentPage = 0;
			
			_flipBook = flipBook;
			_flipBook.addEventListener( Event.COMPLETE, showContent );
			_flipBook.addEventListener( PageFlipEvent.PAGE_FLIP, onSinglePageFlip );
			_flipBook.addEventListener( PageFlipEvent.PAGE_FLIP_COMPLETE, onPageFlipComplete );
			
			_pageCollection = pageCollection;		
		
			for each( var page:IPage in _pageCollection.list ) {
				
				if( page ) {
					page.view.addEventListener( PageNavigationEvent.NAVIGATE_TO_PAGE, onPageNavigation );
				}
				 
			}
			
			_bookmark = bookmark;
			_bookmark.addEventListener( PageNavigationEvent.NAVIGATE_TO_PAGE, onPageNavigation );
					
		}
		
		
		
		private function onSinglePageFlip( e:PageFlipEvent ):void {
			
			hideContent();
			
			if( e.isForward ) {
				_currentPage+=2;
				_flipBook.flipFwdOne();	
			} 
			else {
				_currentPage-=2;
				_flipBook.flipBckOne();
			}
			
		}
		
		
		
		private function onPageNavigation( e:PageNavigationEvent ):void {
			
			hideContent();
			turnPage( e.page );
			_currentPage = e.page - e.page % 2;
			
		}
		
		
		
		private function hideContent():void {
			
			removePage( _flipBook.leftPage, _currentPage );
			removePage( _flipBook.rightPage, _currentPage + 1);
			_bookmark.hide();
			
		}
		
		
		
		private function removePage( holder:Sprite, index:int ):void {
			
			var page:IPage = _pageCollection.getPage( index );
			
			if( page ) {
				page.buildOut();
			}
			
		}
		
		
		
		private function showContent( e:Event ):void {
			
			addPage( _flipBook.leftPage, _currentPage );
			addPage( _flipBook.rightPage, _currentPage + 1);
			
			if( _currentPage > 1 ) {
				_bookmark.enable();
			}
			
		}
		
		
		
		private function addPage( holder:Sprite, index:int ):void {
			
			var page:IPage = _pageCollection.getPage( index );
			
			if( page ) {
				holder.addChild( page.view );
				page.buildIn();
			}
			
		}
		
		
		
		private function turnPage( destination:int ):void {
			
			var destinationDifference:int = destination - _currentPage;
			
			if( destinationDifference > 0 ) {
				
				if( destinationDifference <= 3 ) {
					_flipBook.flipFwdOne();
				}
				else {
					_flipBook.flipFwdMany();
				}
				
			}
			else {
				
				if( destinationDifference >= -3 ) {
					_flipBook.flipBckOne();
				}
				else {
					_flipBook.flipBckMany();
				}
				
			}
			
		}
		
		
		private function onPageFlipComplete( e:PageFlipEvent ):void {
			
			if( _currentPage == 0 ) {
				_flipBook.enableRight();
				_bookmark.homePage();
			}
			else if( _currentPage >= _pageCollection.list.length - 2 ) {
				_flipBook.enableLeft();
			}
			else {
				_flipBook.enableLeft();
				_flipBook.enableRight();	
			}
			
		}
		

	}
}