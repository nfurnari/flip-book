package {
	
	import com.facebook.budweiser.bookOfBud.ApplicationBuilder;
	import com.facebook.budweiser.bookOfBud.book.Bookmark;
	import com.facebook.budweiser.bookOfBud.book.FlipBook;
	import com.facebook.budweiser.bookOfBud.book.PageManager;
	import com.facebook.budweiser.bookOfBud.book.PageCollection;
	import com.facebook.budweiser.bookOfBud.pageTypes.IPage;
	
	import flash.display.Sprite;

	/**
	 * Initializes the entire application
	 * 
	 * @author nhillier 30/04/2009
	 * 
	 */
	public class Application extends Sprite {
		
	
		/**
		 * The entire application and the various dependencies are initialized here
		 * 
		 */
		public function Application() {
			
			
			var appBuilder:ApplicationBuilder = new ApplicationBuilder();
			
			var pages:PageCollection = new PageCollection();
			
			for each( var page:IPage in appBuilder.pages ) {
				pages.addPage( page );
			}
			
			
			var book:FlipBook = new FlipBook();
			addChild( book );
			book.open();
			
			var bookmark:Bookmark = new Bookmark( book.bookmark );
			var manager:PageManager = new PageManager( book, pages, bookmark );
			
		}
		
		
	}
}