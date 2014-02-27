package org.bigbluebutton.modules.present.model
{
  import flash.events.Event;
  import flash.net.URLLoader;
  import flash.net.URLLoaderDataFormat;
  import flash.net.URLRequest;
  import flash.utils.ByteArray;

  public class Page {
    private var _id: String;
    private var _num: int;
    private var _current: Boolean;
    private var _swfUri: String;
    private var _txtUri: String;
    private var _pngUri: String;
    private var _thumbUri: String;
    private var _xOffset: Number;
    private var _yOffset: Number;
    private var _widthRatio: Number;
    private var _heightRatio: Number
    
    private var _swfLoader:URLLoader;
    private var _swfLoaded:Boolean = false;
    private var _swfLoadedListener:Function;
    
    private var _txtLoader:URLLoader;
    private var _txtLoaded:Boolean = false;
    private var _txtLoadedListener:Function;
    
    public function Page(id: String, num: int, current: Boolean,
                swfUri: String, thumbUri: String, txtUri: String,
                pngUri: String, x: Number, y: Number,
                width: Number, height: Number) {
       _id = id;
       _num = num;
       _current = current;
       _swfUri = swfUri;
       _thumbUri = thumbUri;
       _txtUri = txtUri;
       _pngUri = pngUri;
       _xOffset = x;
       _yOffset = y;
       _widthRatio = width;
       _heightRatio = height;
       
       _swfLoader = new URLLoader();
       _swfLoader.addEventListener(Event.COMPLETE, handleSwfLoadingComplete);	
       _swfLoader.dataFormat = URLLoaderDataFormat.BINARY;
       
       _txtLoader = new URLLoader();
       _txtLoader.addEventListener(Event.COMPLETE, handleTextLoadingComplete);	
       _txtLoader.dataFormat = URLLoaderDataFormat.TEXT;	
    }
    
    public function get id():String {
      return _id;
    }
    
    public function get num():int {
      return _num;
    }
    
    public function get current():Boolean {
      return _current;
    }
    
    public function get xOffset():Number {
      return _xOffset;
    }
    
    public function set xOffset(x: Number):void {
      _xOffset = x;
    }
    
    public function get yOffset():Number {
      return _yOffset;
    }
    
    public function set yOffset(y: Number):void {
      _yOffset = y;
    }
    
    public function get widthRatio():Number {
      return _widthRatio;
    }
    
    public function set widthRatio(width:Number):void {
      _widthRatio = width;  
    }
    
    public function get swfUri():String {
      return _swfUri;
    }
    
    public function get thumbUri():String {
      return _thumbUri;
    }
    
    public function get txtUri():String {
      return _txtUri;
    }
    
    public function get swfData():ByteArray {
      if (_swfLoaded) return _swfLoader.data;
      return null;
    }
    
    public function loadSwf(swfLoadedListener:Function):void {
      if (_swfLoaded) {
        swfLoadedListener(_id);
      } else {
        _swfLoadedListener = swfLoadedListener;
        _swfLoader.load(new URLRequest(_swfUri));
      }
    }
    
    private function handleSwfLoadingComplete(e:Event):void{
      _swfLoaded = true;
      if (_swfLoadedListener != null) {
        _swfLoadedListener(_id);
      }		
    }

    public function get txtData():String {
      if (_txtLoaded) {
        return _txtLoader.data;
      }
      return null;
    }
    
    public function loadTxt(txtLoadedListener:Function):void {
      if (_txtLoaded) {
        txtLoadedListener(_id);
      } else {
        _txtLoadedListener = txtLoadedListener;
        _txtLoader.load(new URLRequest(_txtUri));
      }
    }
    
    private function handleTextLoadingComplete(e:Event):void{
      _txtLoaded = true;
      if (_txtLoadedListener != null) {
        _txtLoadedListener(_id);
      }		
    }    
    
  }
}