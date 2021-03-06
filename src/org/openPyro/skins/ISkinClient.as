package org.openPyro.skins{
	
	/**
	 * Defines the interface that all OpenPyro controls
	 * that can have skins applied to them must implement
	 */ 
	public interface ISkinClient
	{
		function set skin(skinImpl:ISkin):void;
		function get styleName():String;
	}
}