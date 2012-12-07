package com.debokeh.anes.utils
{
	import flash.events.EventDispatcher;
	import flash.external.ExtensionContext;

	public class DeviceFileUtil extends EventDispatcher
	{
		private static const _EXTENSION_ID:String = "com.debokeh.anes.utils.DeviceFileUtil";
		
		public static const BUNDLE_DIR:String = "bundle";
		public static const DOCUMENTS_DIR:String = "documents";

		/**
		 * 
		 * Will call open filePath in basePath with registered program.
		 * 
		 * @param filePath
		 * @param basePath
		 * 
		 */
		public static function openWith(filePath:String, basePath:String = DOCUMENTS_DIR):void
		{
			var context:ExtensionContext;
			try
			{
				context = ExtensionContext.createExtensionContext(_EXTENSION_ID, 'openWith');
				context.call('openWith', filePath, basePath);
			}
			catch (error:Error)
			{
				trace(error.message);
			}
			
			if (context)
			{
				context.dispose();
				context = null;
			}
		}
	}
}