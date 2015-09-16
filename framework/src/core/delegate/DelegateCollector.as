package core.delegate
{

	/**
	 * @author Yukiya Okuda
	 * @private
	 */
	public class DelegateCollector
	{

		//----------------------------------------------------------
		//
		//   Constructor 
		//
		//----------------------------------------------------------

		public function DelegateCollector(target:Object):void
		{
			_keyDown = new DelegateFunction(target, "keyDown");
			_keyUp = new DelegateFunction(target, "keyUp");
			_loop = new DelegateFunction(target, "loop");
			_mouseClick = new DelegateFunction(target, "mouseClick");
			_mouseDown = new DelegateFunction(target, "mouseDown");
			_mouseDrag = new DelegateFunction(target, "mouseDrag");
			_mouseMove = new DelegateFunction(target, "mouseMove");
			_mouseUp = new DelegateFunction(target, "mouseUp");
			_resize = new DelegateFunction(target, "resize");
			_setup = new DelegateFunction(target, "setup");
			_soundOn = new DelegateFunction(target, "soundOn");
			_cameraAction = new DelegateFunction(target, "cameraAction");
		}

		//----------------------------------------------------------
		//
		//   Property 
		//
		//----------------------------------------------------------

		//--------------------------------------
		// cameraAction 
		//--------------------------------------

		private var _cameraAction:DelegateFunction;

		public function get cameraAction():DelegateFunction
		{
			return _cameraAction;
		}

		//--------------------------------------
		// keyDown 
		//--------------------------------------

		private var _keyDown:DelegateFunction;

		public function get keyDown():DelegateFunction
		{
			return _keyDown;
		}

		//--------------------------------------
		// keyUp 
		//--------------------------------------

		private var _keyUp:DelegateFunction;

		public function get keyUp():DelegateFunction
		{
			return _keyUp;
		}

		//--------------------------------------
		// loop 
		//--------------------------------------

		private var _loop:DelegateFunction;

		public function get loop():DelegateFunction
		{
			return _loop;
		}

		//--------------------------------------
		// mouseClick 
		//--------------------------------------

		private var _mouseClick:DelegateFunction;

		public function get mouseClick():DelegateFunction
		{
			return _mouseClick;
		}

		//--------------------------------------
		// mouseDown 
		//--------------------------------------

		private var _mouseDown:DelegateFunction;

		public function get mouseDown():DelegateFunction
		{
			return _mouseDown;
		}

		//--------------------------------------
		// mouseDrag 
		//--------------------------------------

		private var _mouseDrag:DelegateFunction;

		public function get mouseDrag():DelegateFunction
		{
			return _mouseDrag;
		}

		//--------------------------------------
		// mouseMove 
		//--------------------------------------

		private var _mouseMove:DelegateFunction;

		public function get mouseMove():DelegateFunction
		{
			return _mouseMove;
		}

		//--------------------------------------
		// mouseUp 
		//--------------------------------------

		private var _mouseUp:DelegateFunction;

		public function get mouseUp():DelegateFunction
		{
			return _mouseUp;
		}

		//--------------------------------------
		// resize 
		//--------------------------------------

		private var _resize:DelegateFunction;

		public function get resize():DelegateFunction
		{
			return _resize;
		}

		//--------------------------------------
		// setup 
		//--------------------------------------

		private var _setup:DelegateFunction;

		public function get setup():DelegateFunction
		{
			return _setup;
		}

		//--------------------------------------
		// soundOn 
		//--------------------------------------

		private var _soundOn:DelegateFunction;

		public function get soundOn():DelegateFunction
		{
			return _soundOn;
		}
	}
}
