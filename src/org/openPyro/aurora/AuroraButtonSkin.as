package org.openPyro.aurora
{
	import org.openPyro.aurora.skinClasses.AbstractButtonSkin;
	import org.openPyro.controls.Button;
	import org.openPyro.controls.events.ButtonEvent;
	import org.openPyro.core.IStateFulClient;
	import org.openPyro.events.PyroEvent;
	import org.openPyro.painters.GradientFillPainter;
	import org.openPyro.painters.Stroke;
	
	public class AuroraButtonSkin extends AbstractButtonSkin implements IStateFulClient
	{
		protected var _cornerRadius:Number = 0
		protected var gradientPainter:GradientFillPainter;
		protected var _stroke:Stroke = new Stroke(1,0x777777,1,true);
		
		public function AuroraButtonSkin()
		{
			this.mouseChildren=false;
		}
		
		override protected function onSkinnedControlPropertyChange(event:PyroEvent):void
		{
			if(skinnedControl is Button)
			{
				updateLabel();
			}
		}
		
		//////////// Colors ///////////////
		
		private var _upColors:Array = [0xdfdfdf, 0xffffff];
		private var _overColors:Array = [0xffffff,0xdfdfdf];
		private var _downColors:Array = [0xdfdfdf,0xdfdfdf];
		
		public function set upColors(clrs:Array):void
		{
			this._upColors = clrs;
			if(this._skinnedControl)
			{
				invalidateDisplayList()	
			}
		}
		
		public function set overColors(clrs:Array):void
		{
			this._overColors = clrs;
			if(this._skinnedControl)
			{
				invalidateDisplayList()	
			}
		}
		
		public function set downColors(clrs:Array):void
		{
			this._downColors = clrs;
			if(this._skinnedControl)
			{
				invalidateDisplayList()	
			}	
		}
		
		/**
		 * Shortcut function for setting colors of all 3 button states
		 * in one pass. Not recommended since there is no feedback to
		 * the user on rollover and rollout states.
		 */ 
		public function set colors(clrs:Array):void
		{
			this._upColors = clrs;
			this._overColors = clrs;
			this._downColors = clrs;
			if(this._skinnedControl)
			{
				invalidateDisplayList()	
			}	
		}
		
		public function set stroke(str:Stroke):void
		{
			_stroke = str;
			this.invalidateDisplayList();	
		}
		
		
		public function set cornerRadius(cr:Number):void
		{
			this._cornerRadius = cr;
			if(this.gradientPainter){
				gradientPainter.cornerRadius = cr;
			}
			if(this._skinnedControl){
				this.invalidateDisplayList();
			}
		}
		
		///////////////// Button Behavior ////////
		
		override public function changeState(fromState:String, toState:String):void
		{
			this.gradientPainter = new GradientFillPainter([0,0])
			if(toState==ButtonEvent.UP)
			{
				gradientPainter.colors = _upColors;
				gradientPainter.stroke = _stroke;
			}
			
			else if(toState==ButtonEvent.OVER)
			{
				gradientPainter.colors = _overColors;
				gradientPainter.stroke = _stroke;
			}
			
			else if(toState == ButtonEvent.DOWN)
			{
				gradientPainter.colors = _downColors;
				// draw the focus stroke
				gradientPainter.stroke = new Stroke(1,0x559DE6);
			}
			else
			{
				gradientPainter.colors = _upColors;
				gradientPainter.stroke = _stroke;
			}
			gradientPainter.cornerRadius = _cornerRadius;
			gradientPainter.rotation = Math.PI/2;
			
			this.backgroundPainter = gradientPainter;
			invalidateDisplayList();
		}
		
		override public function dispose():void
		{
			if(this.parent)
			{
				this.parent.removeChild(this);
			}
		}
		
		override public function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			
			if(label){
				
				label.textField.autoSize = "left";
				label.y = (unscaledHeight-label.height)/2;
				
				if(this._labelAlign == "center"){
					label.x = (unscaledWidth-label.width)/2;
				}
				else if(_labelAlign == "left"){
					label.x = 10;
				}
			}
			
			if(_icon){
				if(!label){
					_icon.x = (unscaledWidth-_icon.width)/2;
					_icon.y = (unscaledHeight-_icon.height)/2;
				}
				else{
					if(_labelAlign == "left"){
						_icon.x = label.x;
						label.x += _icon.width+5;
					}
					else{
						_icon.x = label.x-_icon.width-5;
					}
				}
			}
		}
		
	}
}