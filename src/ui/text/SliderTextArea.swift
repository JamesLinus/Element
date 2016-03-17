/**
 * 13.05.21 15:00 - Added support for mousewheel, and replaced scrollbars with sliders
 * @Note it seems difficult to align the HSlider thumb in a relative but correct way, since offsetting the HSlider it self is difficult when thumb is positioned by absolute values
 * // :TODO: could possible use a setHtmlText function??!?
 * // :TODO: you may need to access gestures to get hold of horzontal mouse delta, when you want to use gestures to scroll horizontally
 * // :TODO: the horizontal scroller isnt thourghouly testes. Make sure you set wordwrap to false to test this, and that the input text has break tags \n or br tags
 * // :TODO: Impliment a failsafe so that the slider.thumb doesnt get smaller than its width, do the same for both sliders
 */
class SliderTextArea{
	static var linesPerScroll:CGFloat = 1/*The number of lines the scroller scrolls at every scroll up or down*/// :TODO: this cant be set higher unless you add code to the eventhandlers that allow it
	var _scrollBarSize:CGFloat
	var _vSlider:VSlider?
	var _hSlider:HSlider?
	var _vSliderInterval:Int
	var _hInterval:Int
	 
	init(_ width:CGFloat,_ height:CGFloat, _ text:String = "defaultText", _ scrollBarSize:CGFloat = 24, _ parent:IElement? = nil, _ id:String? = nil){
		self.scrollBarSize = scrollBarSize
		super.init(width,height,text,parent,id,classId)
		//addEventListeners()
	}
	/**
	 * // :TODO: Refactor this method
	 */
	override func resolveSkin() {
		super.resolveSkin()
		vSliderInterval = Utils.vSliderinterval(text.getTextField())
		vSlider = addSubView(VSlider(24/*_scrollBarSize*/,height,24,0,self))
		var vSliderThumbHeight:CGFloat = Utils.vSliderThumbHeight(text.getTextField(), vSlider, linesPerScroll)
		vSlider.setThumbHeight(vSliderThumbHeight)
		//vSlider.thumb.visible = SliderParser.assertSliderVisibility(vSliderThumbHeight/text.height)/*isVSliderVisible*/
		hInterval = Utils.hScrollBarInterpolation(text.getTextField())
		hSlider = addSubView(HSlider(width/*_scrollBarSize*/,24,24,0,self))
		var hSliderThumbWidth:CGFloat = Utils.hSliderThumbWidth(text.getTextField(), hSlider)
		hSlider.setThumbWidth(hSliderThumbWidth)
		//hSlider.thumb.visible = SliderParser.assertSliderVisibility(hSliderThumbWidth/text.width)/*isHSliderVisible*/
	}
	/**
	 * Updates the sizes of the h and v sliders
	 * // :TODO: can be further refactored
	 */
	func updateScrollBarThumbSizes() {
		var hSliderThumbWidth:CGFloat = Utils.hSliderThumbWidth(text.getTextField(), hSlider)
		hSlider.setThumbWidth(hSliderThumbWidth)
		hInterval = Utils.hScrollBarInterpolation(text.getTextField())
		var verticalThumbSize:CGFloat =  Utils.vSliderThumbHeight(text.getTextField(), vSlider, LINES_PER_SCROLL)
		vSlider.setThumbHeight(verticalThumbSize)
		vSliderInterval = Utils.vSliderinterval(text.getTextField())
	}	
	func onSliderChange(event:SliderEvent):void{
		if(event.currentTarget == _vSlider) {TextFieldModifier.vScrollTo(text.getTextField(), event.progress)}
		else {TextFieldModifier.hScrollTo(text.getTextField(), event.progress)}
	}
	func onMouseWheel(event:MouseEvent) {
		var scrollAmount:CGFloat = event.delta/_vSliderInterval/*_scrollBar.interval*/;
		var currentScroll:CGFloat = _vSlider.progress - scrollAmount/*the minus sign makes sure the scroll works like in OSX LION*/
		currentScroll = NumberParser.minMax(currentScroll, 0, 1)
		vSlider.setProgress(currentScroll)
		TextFieldModifier.vScrollTo(text.getTextField(), currentScroll) /*Sets the target item to correct y, according to the current scrollBar progress*/
	}	
	override func onEvent(event:Event){
		if(event.name == SliderEvent.change || event.origin === vSlider){}
		else if(event.name == SliderEvent.change || event.origin === hSlider){}
		/*also listen for mouseWheel events*/
	}
}