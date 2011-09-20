package {
	
	import com.facebook.budweiser.bookOfBud.components.AssetLoader;
	
	import flash.display.Sprite;

	[SWF(width="760", height="608", pageTitle="Book Of Bud", frameRate=30, backgroundColor=0x000000)]

	/**
	 * The central point of the application, responsible for instantiating a preloader and 
	 * loading in the application content
	 * 
	 * @author nhillier 02/05/2009
	 * 
	 */
	public class Main extends Sprite {
		
		private const APPLICATION_URL:String = "Application.swf";
		
		/**
		 * adds a preloader to the stage and passes in the location of the application swf
		 * The onComplete callback expects the loaded content as a parameter. The assetloader is
		 * responsible for cleaning up after itself 
		 * 
		 */
		public function Main() {
			
			var _preloader:PreloaderAsset = new PreloaderAsset();
			_preloader.x = ( stage.stageWidth - _preloader.width ) * 0.5;
			_preloader.y = ( stage.stageHeight - _preloader.height ) * 0.5;
			addChild( _preloader );
			
			new AssetLoader( APPLICATION_URL, onComplete, _preloader );
			
		}
		
		
		
		private function onComplete( app:Sprite ):void {
			
			addChild( app );
			
		}
		
		
	}
}
