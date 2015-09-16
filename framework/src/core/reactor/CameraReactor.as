package core.reactor
{
	import flash.events.ActivityEvent;
	import flash.events.Event;
	import flash.media.Camera;
	import flash.media.Video;

	import core.delegate.DelegateCollector;
	import core.util.EnterFrameIntegrator;
	import core.util.Logger;

	/**
	 * @author Yukiya Okuda
	 * @private
	 */
	public class CameraReactor extends BaseReactor
	{

		//----------------------------------------------------------
		//
		//   Static Property 
		//
		//----------------------------------------------------------

		private static var _camera:Camera;

		public static function getCamera():Camera
		{
			return _camera || (_camera = Camera.getCamera());
		}

		//----------------------------------------------------------
		//
		//   Constructor 
		//
		//----------------------------------------------------------

		public function CameraReactor(delegate:DelegateCollector):void
		{
			super(delegate);

			if (delegate.cameraAction.hasFunction)
			{
				_camera = getCamera();
				_camera = getCamera();
				Logger.info("+ Camera : " + (Camera ? "[OK]" : "[NG]"));
				Logger.info("+");
				if (_camera)
				{
					_camera.setMotionLevel(50, 2000);
					_camera.addEventListener(ActivityEvent.ACTIVITY, _cameraActivityHandler);
					_video = new Video();
					_video.attachCamera(_camera);
					EnterFrameIntegrator.addEventListener(_enterFrameHandler);
				}
			}
		}

		//----------------------------------------------------------
		//
		//   Property 
		//
		//----------------------------------------------------------

		private var _video:Video;

		//----------------------------------------------------------
		//
		//   Function 
		//
		//----------------------------------------------------------

		private function _enterFrameHandler(event:Event):void
		{
			var activity:Number = _camera.activityLevel / 100;
			if (activity > 0)
				delegate.cameraAction.execute(activity);
		}

		private function _cameraActivityHandler(event:ActivityEvent):void
		{
		}
	}
}
