import Foundation


class GraphicSkin:Skin{
    override init(_ style:IStyle? = nil, _ state:String = "", _ element:IElement? = nil){
        super.init(style, state, element)
        decoratable = GraphicSkinParser.configure(self)/*this call is here because CGContext is only accessible after drawRect is called*/
        /*decoratable = */SkinModifier.align(self,decoratable as! IPositional);
    }
    override func drawRect(dirtyRect: NSRect) {
        //Swift.print("GraphicSkin.drawRect()")
        decoratable.initialize()//runs trough all the different calls and makes the graphic in one go. (optimization)
    }
    /**
     * Required by super class
     */
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func draw(){
        //Swift.print("GraphicSkin.draw()")
        if(hasStateChanged || hasSizeChanged || hasStyleChanged){
            applyProperties(decoratable);
            /*decoratable = */SkinModifier.align(self,decoratable as! IPositional)/* as! IGraphicDecoratable;*/
        }
        super.draw();
    }
    func applyProperties(decoratable:IGraphicDecoratable){
        //Swift.print("GraphicSkin.applyProperties()")
        self.decoratable = GraphicModifier.applyProperties(decoratable, StylePropertyParser.fillStyle(self), StylePropertyParser.lineStyle(self), StylePropertyParser.lineOffsetType(self));/*color or gradient*/
    }
}