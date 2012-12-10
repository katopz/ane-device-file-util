package
{
	import com.debokeh.anes.utils.DeviceFileUtil;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;

	public class Main extends Sprite
	{
		public function Main()
		{
			// for determine ready state
			var tf:TextField;
			addChild(tf = new TextField);
			tf.autoSize = TextFieldAutoSize.LEFT;
			tf.text = "click me!";
			
			// wait for click
			stage.addEventListener(MouseEvent.CLICK, function():void
			{
				// Example #1 : You will need foo.pdf in document directory
				DeviceFileUtil.openWith("foo.pdf");
				
				// Example #2 : You will need foo.pdf in document directory
				// DeviceFileUtil.openWith("foo.pdf", DeviceFileUtil.DOCUMENTS_DIR);
				
				// Example #3 : You will need foo.pdf in application directory
				// DeviceFileUtil.openWith("foo.pdf", DeviceFileUtil.BUNDLE_DIR);
			});
		}
	}
}