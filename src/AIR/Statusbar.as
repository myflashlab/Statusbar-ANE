package com.myflashlab.air.extensions.statusbar
{
	import flash.events.EventDispatcher;
	import flash.external.ExtensionContext;
	import flash.events.StatusEvent;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;

	/**
	 * 
	 * 
	 * @author Hadi Tavakoli - 10/26/2016 2:05 PM
	 */
	public class Statusbar
	{
		private static const DEMO_ANE:Boolean = true;
		
		public static const ANIMATION_NONE:int = 0;
		public static const ANIMATION_FADE:int = 1;
		public static const ANIMATION_SLIDE:int = 2;
		
		public static const BAR_STYLE_DEFAULT:int = 1;
		public static const BAR_STYLE_LIGHT:int = 2;
		
		public static const EXTENSION_ID:String = "com.myflashlab.air.extensions.statusbar";
		public static const VERSION:String = "1.1.1";
		private var _context:ExtensionContext;
		
		private static var _ex:Statusbar;
		private static var _listener:EventDispatcher;
		
		private var OverrideClass:Class;
		
		/** @private */
		public function Statusbar():void
		{
			OverrideClass = getDefinitionByName("com.myflashlab.air.extensions.dependency.OverrideAir") as Class;
		
			// Tell Override ANE to read the ANE-LAB ID from the manifest. This must happen on Android and iOS.
			// Pass id/version of this ANE to Override ANE so it can check its validity.
			OverrideClass["applyToAneLab"](getQualifiedClassName(this));
			
			
			_listener = new EventDispatcher();
			
			_context = ExtensionContext.createExtensionContext(EXTENSION_ID, null);
			_context.addEventListener(StatusEvent.STATUS, onStatus);
			
			if(DEMO_ANE) _context.call("command", "isTestVersion");
		}
		
		private function onStatus(e:StatusEvent):void
		{
			switch (e.code) 
			{
				case StatusbarEvents.FRAME_CHANGED:
					
					_listener.dispatchEvent(new StatusbarEvents(StatusbarEvents.FRAME_CHANGED));
					
				break;
				default:
			}
		}
		
// ------------------------------------------------------------------------------------------------------------------------------------ methods

		public static function init():void
		{
			if (_ex) return;
			
			_ex = new Statusbar();
		}
		
		/**
		 * Indicates the current height of the Statusbar.
		 */
		public static function get height():Number
		{
			var h:Number = _ex._context.call("command", "getStatusbarHeight") as Number;
			return h * 96 / 72;
		}
		
		/**
		 * Hide the statusbar with the animation type of your choice.
		 * @param	$animationType
		 */
		public static function hideStatusbar($animationType:int):void
		{
			_ex._context.call("command", "hideStatusbar", true, $animationType);
		}
		
		/**
		 * Show the Statusbar with the animation type of your choise.
		 * @param	$animationType
		 */
		public static function showStatusbar($animationType:int):void
		{
			_ex._context.call("command", "hideStatusbar", false, $animationType);
		}
		
		/**
		 * Change the Statusbar style with or without animation.
		 * 
		 * @param	$style
		 * @param	$haveAnimation
		 */
		public static function changeStatusbarStyle($style:int, $haveAnimation:Boolean=true):void
		{
			_ex._context.call("command", "changeStatusbarStyle", $style, $haveAnimation);
		}
		
		/**
		 * <p>
		 * allows the HomeIndicator to automatically hide. This will not guarantee that it will be always hidden. Read
		 * iOS docs for moer information: https://developer.apple.com/documentation/uikit/uiviewcontroller/2887510-prefershomeindicatorautohidden?language=objc
		 * </p>
		 *
		 * <p>
		 * <b>Notice:</b> You can call this method only once in your app lifetime. Other calls will be simply ignored.
		 * </p>
		 */
		public static function allowHomeIndicatorAutoHide():void
		{
			_ex._context.call("command", "allowHomeIndicatorAutoHide");
		}
		
		/**
		 * Call this method to remove the native listener on watching the statusbar change frames 
		 * and dispose the ANE.
		 */
		public static function dispose():void
		{
			_ex._context.call("command", "dispose");
			_ex._context.removeEventListener(StatusEvent.STATUS, _ex.onStatus);
			_ex._context.dispose();
			_ex._context = null;
			_ex = null;
		}
		
		public static function get listener():EventDispatcher
		{
			return _listener;
		}
	}
}