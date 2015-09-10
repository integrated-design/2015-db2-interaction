package core.reactor
{
	import flash.events.Event;
	import flash.media.Microphone;

	import core.delegate.DelegateCollector;
	import core.util.EnterFrameIntegrator;
	import core.util.Logger;

	/**
	 * @author Yukiya Okuda
	 * @private
	 */
	public class SoundReactor extends BaseReactor
	{

		//----------------------------------------------------------
		//
		//   Constructor 
		//
		//----------------------------------------------------------

		public function SoundReactor(delegate:DelegateCollector):void
		{
			super(delegate);

			if (delegate.soundOn.hasFunction)
			{
				_microphone = Microphone.getEnhancedMicrophone();
				Logger.info("+ Microphone : " + (_microphone ? "[OK]" : "[NG]"));
				Logger.info("+");
				if (_microphone)
				{
					_microphone.gain = 50;
					_microphone.rate = 44;
					_microphone.setSilenceLevel(0, 1000);
					_microphone.setLoopBack(true);
					EnterFrameIntegrator.addEventListener(_enterFrameHandler);
				}
			}
		}

		//----------------------------------------------------------
		//
		//   Property 
		//
		//----------------------------------------------------------

		private var _microphone:Microphone;

		//----------------------------------------------------------
		//
		//   Function 
		//
		//----------------------------------------------------------

		private function _enterFrameHandler(event:Event):void
		{
			var volume:Number = _microphone.activityLevel / 100;
			if (volume > 0)
				delegate.soundOn.execute(volume);
		}
	}
}
