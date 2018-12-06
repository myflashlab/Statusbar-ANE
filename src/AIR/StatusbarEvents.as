package com.myflashlab.air.extensions.statusbar
{
	import flash.events.Event;
	
	/**
	 * 
	 * @author Hadi Tavakoli - 10/26/2016 7:00 PM
	 */
	public class StatusbarEvents extends Event
	{
		public static const FRAME_CHANGED:String = "onFrameChanged";
		
		/**
		 * @private
		 * @param	$type
		 */
		public function StatusbarEvents($type:String):void
		{
			super($type, false, false);
		}
	}
}