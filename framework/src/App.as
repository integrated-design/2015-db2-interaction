package
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.ColorTransform;
	import flash.ui.Mouse;
	import flash.utils.getTimer;

	import core.delegate.DelegateCollector;
	import core.reactor.KeyboardReactor;
	import core.reactor.MouseReactor;
	import core.reactor.ResizeReactor;
	import core.reactor.SoundReactor;
	import core.util.EnterFrameIntegrator;
	import core.util.Logger;

	/**
	 * 多摩美術大学統合デザイン学科 デザインベーシックⅡ インタラクション
	 * @author Yukiya Okuda
	 */
	public class App extends Sprite
	{

		//----------------------------------------------------------
		//
		//   Static Property 
		//
		//----------------------------------------------------------

		public static const PI:Number = Math.PI;

		/**
		 * バージョン情報
		 * @private
		 */
		public static const VERSION:String = "0.1.0";

		//----------------------------------------------------------
		//
		//   Constructor 
		//
		//----------------------------------------------------------

		/**
		 * ドキュメントクラスに設定もしくは明示的にインスタンス化して使用する
		 * @param stage ステージへの参照
		 * @param target 諸々の機能を委譲する先のオブジェクト
		 * @private
		 */
		public function App(stage:Stage = null, target:Object = null):void
		{
			_stage = stage;
			_target = target || this;

			if (_stage && _target)
				_initialize();
			else
				addEventListener(Event.ADDED_TO_STAGE, _addedToStageHandler);
		}

		//----------------------------------------------------------
		//
		//   Property 
		//
		//----------------------------------------------------------

		//--------------------------------------
		// frameCount 
		//--------------------------------------

		private var _frameCount:int;

		/**
		 * プログラムを起動してから経過したフレーム数
		 */
		public function get frameCount():int
		{
			return _frameCount;
		}

		//--------------------------------------
		// frameRate 
		//--------------------------------------

		/**
		 * フレームレートを取得 / 設定する
		 */
		public function get frameRate():Number
		{
			return _stage.frameRate;
		}

		public function set frameRate(frameRate:Number):void
		{
			_stage.frameRate = frameRate;
		}

		/**
		 * ステージ全体の高さを取得する
		 * @private
		 */
		override public function get height():Number
		{
			return _resizeReactor.stageHeight;
		}

		/**
		 * 現在マウスのボタンが押されているかどうかを取得する
		 */
		public function get isMouseDown():Boolean
		{
			return _mouseReactor.isMouseDown;
		}

		/**
		 * 現在マウスがドラッグされているかどうかを取得する
		 */
		public function get isMouseDragging():Boolean
		{
			return _mouseReactor.isMouseDragging;
		}

		//--------------------------------------
		// milliSeconds 
		//--------------------------------------

		private var _milliSeconds:int;

		/**
		 * プログラムを起動してから経過したミリ秒数を取得する
		 */
		public function get milliSeconds():int
		{
			return _milliSeconds;
		}
		//--------------------------------------
		// mouseCursor State
		//--------------------------------------

		private var _mouseCursorState:Boolean;

		/**
		 * マウスカーソルの状態(trueの場合は現在表示されている)を取得 / 設定する
		 */
		public function get mouseCursorState():Boolean
		{
			return _mouseCursorState;
		}

		public function set mouseCursorState(value:Boolean):void
		{
			if (value == _mouseCursorState)
				return;
			_mouseCursorState = value;
			_mouseCursorState ? Mouse.show() : Mouse.hide();
		}

		/**
		 * マウスの現在のx座標を取得する
		 */
		override public function get mouseX():Number
		{
			return _mouseReactor.mouseX;
		}

		/**
		 * マウスの現在のy座標を取得する
		 */
		override public function get mouseY():Number
		{
			return _mouseReactor.mouseY;
		}

		/**
		 * マウスの直前のx座標を取得する
		 */
		public function get pmouseX():Number
		{
			return _mouseReactor.pmouseX;
		}

		/**
		 * マウスの直前のy座標を取得する
		 */
		public function get pmouseY():Number
		{
			return _mouseReactor.pmouseY;
		}

		//--------------------------------------
		// stage 
		//--------------------------------------

		private var _stage:Stage;

		/**
		 * @private
		 */
		override public function get stage():Stage
		{
			return _stage;
		}

		/**
		 * ステージ全体の高さを取得する
		 */
		public function get stageHeight():Number
		{
			return _resizeReactor.stageHeight;
		}

		/**
		 * ステージ全体の幅を取得する
		 */
		public function get stageWidth():Number
		{
			return _resizeReactor.stageWidth;
		}

		/**
		 * マウスのx軸方向の移動速度を取得する
		 */
		public function get vmouseX():Number
		{
			return _mouseReactor.vmouseX;
		}

		/**
		 * マウスのy軸方向の移動速度を取得する
		 */
		public function get vmouseY():Number
		{
			return _mouseReactor.vmouseY;
		}

		/**
		 * ステージ全体の幅を取得する
		 * @private
		 */
		override public function get width():Number
		{
			return _resizeReactor.stageWidth;
		}

		private var _delegate:DelegateCollector;
		private var _keyboardReactor:KeyboardReactor;
		private var _mouseReactor:MouseReactor;
		private var _resizeReactor:ResizeReactor;
		private var _soundReactor:SoundReactor;
		private var _target:Object;

		//----------------------------------------------------------
		//
		//   Function 
		//
		//----------------------------------------------------------

		/**
		 * フレームスクリプトの記述を許容するが実行はしない
		 * @private
		 */
		public function addFrameScript(... args):void
		{
		}

		/**
		 * ランダムな小数値を生成する
		 * @param min ランダムの下限値
		 * @param max ランダムの上限値
		 * @return 生成されたランダムの値
		 * @example 以下の例では、5から10までのランダムな数字を生成して出力します。
		 * <listing version="3.0">
		 * function setup() {
		 *     var n = ramdom(5, 10);
		 *     trace(n);
		 * }
		 * </listing>
		 */
		public function random(min:Number, max:Number):Number
		{
			return min + Math.random() * (max - min);
		}

		/**
		 * 複数の数値の中から最小値を見つける
		 * @param number 複数の数値
		 * @return 見つかった最小値
		 */
		public function min(... number):Number
		{
			return number.length == 1 ? number[0] : Math.min.apply(null, number);
		}

		/**
		 * 複数の数値の中から最大値を見つける
		 * @param number 複数の数値
		 * @return 見つかった最大値
		 */
		public function max(... number):Number
		{
			return number.length == 1 ? number[0] : Math.max.apply(null, number);
		}

		/**
		 * 小数部分を切り捨てて整数に変換する
		 * @param number 変換前の小数値
		 * @return 変換後の整数
		 */
		public function floor(number:Number):Number
		{
			return Math.floor(number);
		}

		/**
		 * 小数部分を切り上げて整数に変換する
		 * @param number 変換前の小数値
		 * @return 変換後の整数
		 */
		public function ceil(number:Number):Number
		{
			return Math.ceil(number);
		}

		/**
		 * 小数部分を四捨五入して整数に変換する
		 * @param number 変換前の小数値
		 * @return 変換後の整数
		 */
		public function round(number:Number):Number
		{
			return Math.round(number);
		}

		/**
		 * サイン関数を計算する
		 * @param angle 入力するラジアン角度
		 * @return 計算結果
		 */
		public function sin(angle:Number):Number
		{
			return Math.sin(angle);
		}

		/**
		 * コサイン関数を計算する
		 * @param angle 入力するラジアン角度
		 * @return 計算結果
		 */
		public function cos(angle:Number):Number
		{
			return Math.cos(angle);
		}

		/**
		 * タンジェント関数を計算する
		 * @param angle 入力するラジアン角度
		 * @return 計算結果
		 */
		public function tan(angle:Number):Number
		{
			return Math.tan(angle);
		}

		/**
		 * アークサイン関数を計算する
		 * @param sin 入力するサイン値
		 * @return 計算結果
		 */
		public function asin(sin:Number):Number
		{
			return Math.asin(sin);
		}

		/**
		 * アークコサイン関数を計算する
		 * @param sin 入力するコサイン値
		 * @return 計算結果
		 */
		public function acos(cos:Number):Number
		{
			return Math.acos(cos);
		}

		/**
		 * アークタンジェント関数を計算する
		 * @param x 入力するx値
		 * @param y 入力するy値
		 * @return 計算結果
		 */
		public function atan(x:Number, y:Number):Number
		{
			return Math.atan2(y, x);
		}

		/**
		 * 平方根を計算する
		 * @param value 数値
		 * @return valueの平方根
		 */
		public function sqrt(number:Number):Number
		{
			return Math.sqrt(number);
		}

		/**
		 * 累乗を計算する
		 * @param base 元の値
		 * @param pow 累乗する値
		 * @return baseの数値をpowの数値で累乗した値
		 */
		public function pow(base:Number, pow:Number):Number
		{
			return Math.pow(base, pow);
		}

		/**
		 * オブジェクトの色を16進数で指定して変更する
		 * @param target カラー変更対象の表示オブジェクト
		 * @param hex 16進数カラー（0xRRGGBB）
		 * @example 以下の例では、ステージに配置してあるballオブジェクトをカラーコード#FF3366に着色します。
		 * <listing version="3.0">
		 * function setup() {
		 *     setColorHEX(ball, 0xFF3366);
		 * }
		 * </listing>
		 */
		public function setColorHEX(target:DisplayObject, hex:uint):void
		{
			var colorTransform:ColorTransform = target.transform.colorTransform;
			colorTransform.color = hex;
			target.transform.colorTransform = colorTransform;
		}

		/**
		 * オブジェクトの色をRGB値で指定して変更する
		 * @param target カラー変更対象の表示オブジェクト
		 * @param r 赤（0〜255）
		 * @param g 緑（0〜255）
		 * @param b 青（0〜255）
		 * @example 以下の例では、ステージに配置してあるballオブジェクトを赤100、緑56、青255に着色します。
		 * <listing version="3.0">
		 * function setup() {
		 *     setColorRGB(ball, 100, 56, 255);
		 * }
		 * </listing>
		 */
		public function setColorRGB(target:DisplayObject, r:uint, g:uint, b:uint):void
		{
			setColorHEX(target, (r << 16) | (g << 8) | b);
		}

		/**
		 * オブジェクトの色をHSV値で指定して変更する
		 * @param target カラー変更対象の表示オブジェクト
		 * @param h 色相（0〜360）
		 * @param s 彩度（0〜1）
		 * @param v 明度（0〜1）
		 * @example 以下の例では、ステージに配置してあるballオブジェクトを色相210、彩度0.5、明度0.8に着色します。
		 * <listing version="3.0">
		 * function setup() {
		 *     setColorHSV(ball, 210, 0.5, 0.8);
		 * }
		 * </listing>
		 */
		public function setColorHSV(target:DisplayObject, h:Number, s:Number, v:Number):void
		{
			if (s == 0)
			{
				var gray:uint = v * 255;
				setColorRGB(target, gray, gray, gray);
			}
			else
			{
				var hIndex:int = (h / 60) >> 0;
				var f:Number = (h / 60 - hIndex);
				var p:Number = v * (1 - s);
				var q:Number = v * (1 - f * s);
				var t:Number = v * (1 - (1 - f) * s);
				if (hIndex == 0)
					setColorRGB(target, v * 255, t * 255, p * 255);
				else if (hIndex == 1)
					setColorRGB(target, q * 255, v * 255, p * 255);
				else if (hIndex == 2)
					setColorRGB(target, p * 255, v * 255, t * 255);
				else if (hIndex == 3)
					setColorRGB(target, p * 255, q * 255, v * 255);
				else if (hIndex == 4)
					setColorRGB(target, t * 255, p * 255, v * 255);
				else if (hIndex == 5)
					setColorRGB(target, v * 255, p * 255, q * 255);
			}
		}

		/**
		 * マウスカーソルがオブジェクトに重なっているかどうかを判定する
		 * @param target 判定対象の表示オブジェクト
		 * @return マウスカーソルがtargetに重なっている場合はtrueを返す
		 * @example 以下の例では、ステージに配置してあるballオブジェクトに対してマウスの重なりを判定します。
		 * <listing version="3.0">
		 * function loop() {
		 *     var result = checkMouseOver(ball);
		 *     trace(result);
		 * }
		 * </listing>
		 */
		public function checkMouseOver(target:DisplayObject):Boolean
		{
			return target.hitTestPoint(mouseX, mouseY, true);
		}

		private function _initialize():void
		{
			Logger.level = Logger.LEVEL_INFO;
			Logger.info("+--------------------------------------------------");
			Logger.info("+");
			Logger.info("+ Interaction Framework, VERSION " + VERSION);
			Logger.info("+");

			//
			_stage = _stage || super.stage;
			_stage.align = StageAlign.TOP_LEFT;
			_stage.scaleMode = StageScaleMode.NO_SCALE;

			//
			_delegate = new DelegateCollector(_target);

			//
			_milliSeconds = 0;
			_frameCount = 0;
			_mouseCursorState = true;

			//
			_mouseReactor = new MouseReactor(_delegate, _stage);
			_keyboardReactor = new KeyboardReactor(_delegate, _stage);
			_soundReactor = new SoundReactor(_delegate);
			_resizeReactor = new ResizeReactor(_delegate, _stage);

			//
			//_camera = Camera.getCamera();
			//Logger.info("+ Camera : " + (_camera ? "[OK]" : "[NG]"));

			//
			EnterFrameIntegrator.addEventListener(_enterFrameHandler);

			//
			Logger.info("+--------------------------------------------------");
			Logger.info("");

			//
			_delegate.setup.execute();
		}

		private function _addedToStageHandler(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, _addedToStageHandler);
			_initialize();
		}

		private function _enterFrameHandler(event:Event):void
		{
			++_frameCount;
			_milliSeconds = getTimer();
			_delegate.loop.execute();
		}
	}
}
