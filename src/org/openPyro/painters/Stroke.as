package org.openPyro.painters
{
	import flash.display.Graphics;
	
	/**
	 * Defines a stroke that can be applied to a Graphics context or
	 * be used by one of the painters
	 */ 
	public class Stroke
	{
		public var thickness:Number = NaN; 
		public var color:uint = 0;
		public var alpha:Number = 1.0;
		public var pixelHinting:Boolean = false;
		public var scaleMode:String = "normal";
		public var caps:String = null;
		public var joints:String = null;
		public var miterLimit:Number = 3
		
		public function Stroke(thickness:Number=1, color:uint=0x000000,alpha:Number = 1, pixelHinting:Boolean=false)
		{
			this.thickness = thickness;
			this.color = color;
			this.alpha = alpha;
			this.pixelHinting = pixelHinting;
		}
		
		/**
		 * Applies the Stroke to a Graphics context
		 */ 
		public function apply(gr:Graphics):void
		{
			gr.lineStyle(thickness, color, alpha, pixelHinting,
					scaleMode, caps, joints, miterLimit);	
		}
	}
}