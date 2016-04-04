import Cocoa
/**
 * // :TODO: add an alpha-stepper?
 */
class ColorPanel:Element,IColorPanel{
    static var title:String = "Color"
    static var minSize:CGPoint = CGPoint(180, 232)
    static var maxSize:CGPoint = CGPoint(1200,232)
    static var rgb:String = "RGB"
    static var hsb:String = "HSB"
    static var hls:String = "HLS"
    static var hsv:String = "HSV"
    var color:NSColor
    var colorInput:ColorInput?
    var spinner1:LeverSpinner?
    var spinner2:LeverSpinner?
    var spinner3:LeverSpinner?
    var itemHeight:CGFloat
    var colorTypeSelectGroup:SelectGroup?
    init(_ width:CGFloat = NaN, _ height:CGFloat = NaN, _ itemHeight:CGFloat = NaN, _ color:NSColor = NSColorParser.nsColor("0xFF00FF"), _ title:String = "Color", _ minSize:CGPoint? = nil, _ maxSize:CGPoint? = nil, _ parent:IElement? = nil, _ id:String = "") {
        self.itemHeight = itemHeight
        self.color = color
        super.init(width, height, parent, id)
    }
    override func resolveSkin() {
        super.resolveSkin()
        let rgbBtn = addSubView(RadioButton(NaN,NaN,ColorPanel.rgb,true,self))
        let hsbBtn = addSubView(RadioButton(NaN,NaN,ColorPanel.hsb,false,self))
        let hlsBtn = addSubView(RadioButton(NaN,NaN,ColorPanel.hls,false,self))
        let hsvBtn = addSubView(RadioButton(NaN,NaN,ColorPanel.hsv,false,self))
        colorTypeSelectGroup = SelectGroup([rgbBtn,hsbBtn,hlsBtn,hsvBtn],rgbBtn)
        colorInput = addSubView(ColorInput(width,itemHeight,"Color:",color,self))
        //var rgbObj:Object = ColorParser.rgbByHex(color)/*LeaverStepper instance ->Red (0 - 255) (Read/write)*/
        
        let rb:CGFloat = 255
        let gb:CGFloat = 0
        let bb:CGFloat = 0
        
        spinner1 = addSubView(LeverSpinner(width, itemHeight,"Red:",rb,1,0,255,1,100,200,self))
        spinner2 = addSubView(LeverSpinner(width, itemHeight,"Green:",gb,1,0,255,1,200,200,self))/*LeaverStepper instance ->Green (0 - 255) (Read/write)*/
        spinner3 = addSubView(LeverSpinner(width, itemHeight,"Blue:",bb,1,0,255,1,200,200,self))/*LeaverStepper instance ->Blue (0 - 255) (Read/write)*/
        ColorSync.broadcaster = self
    }
    private func onColorTypeSelectGroupChange(event : SelectGroupEvent) {
        ColorPanelUtils.toggleColorType(self,(event.selectable as! TextButton).getText())
        ColorPanelUtils.applyColor(self,color)
    }
    private func onColorInputChange(event : ColorInputEvent) {
        ColorPanelUtils.applyColor(self,event.color)
        color = event.color
        super.onEvent(event)// :TODO: is thhis needed? cant we just propegate the original event
    }
    private func onSpinnerChange(event : SpinnerEvent) {
        var color:NSColor//<--was UInt
        var colorType:String = (SelectGroupParser.selected(colorTypeSelectGroup!) as! TextButton).getText()// :TODO: just call getColorType
        switch(colorType){
            case ColorPanel.rgb:color = RGB(spinner1!.val, spinner2!.val, spinner3!.val).nsColor;break;
            case ColorPanel.hsb:color = RGBParser.rgbByHsb(spinner1!.val, spinner2!.val/100, spinner3!.val/100);break;
            case ColorPanel.hls:color = RGBParser.rgbValueByHls(spinner1!.val, spinner2!.val, spinner3!.val);break;
            case ColorPanel.hsv:color = RGBParser.rgbValueByHsv(spinner1.val, spinner2.val/240, spinner3.val/240);break;
            default:break;
        }
        colorInput!.setColorValue(color)
        self.color = color
        super.onEvent(ColorInputEvent(ColorInputEvent.change,self))
    }
    override func onEvent(event: Event) {
        super.onEvent(event)
        if(event.type == SelectGroupEvent.change && event.origin === colorTypeSelectGroup){onColorTypeSelectGroupChange(event as! SelectGroupEvent)}
        if(event.type == ColorInputEvent.change && event.origin === colorInput){onColorInputChange(event as! ColorInputEvent)}
        if(event.type == SpinnerEvent.change){onSpinnerChange(event as! SpinnerEvent)}// :TODO: cant we just listen for one event in this.?
//        if(event.type == ColorInputEvent.change){ColorSync.onColorChange(event as! ColorInputEvent)}
    }
    func setColorValue(color:NSColor){
        ColorPanelUtils.applyColor(self,color)
        colorInput!.setColorValue(color)
        self.color = color
    }
    override func setSize(width : CGFloat, _ height : CGFloat)  {
        super.setSize(width, height)
        ElementModifier.refresh(self)
    }
    func getColorType()->String {
        return (SelectGroupParser.selected(colorTypeSelectGroup!) as! RadioButton).getText()
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}