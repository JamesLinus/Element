import Foundation

class GradientPanel:Element{
    var gradientSlider : GradientSlider?
    var itemHeight:CGFloat
    var gradient:IGradient
    var gradientTypeSelectGroup:SelectGroup?
    init(_ width:CGFloat = NaN, _ height:CGFloat = NaN, _ itemHeight:CGFloat = NaN, _ gradient:IGradient? = nil, _ parent:IElement? = nil, _ id:String = "") {
        self.itemHeight = itemHeight
        self.gradient = gradient!
        super.init(width, height, parent, id)
    }
    override func resolveSkin() {
        super.resolveSkin()
        let linearRadioButton = addSubView(RadioButton(NaN,NaN,"Linear",true,self))
        let radialRadioButton = addSubView(RadioButton(NaN,NaN,"Radial",false,self))
        gradientTypeSelectGroup = SelectGroup([linearRadioButton,radialRadioButton],linearRadioButton)
        gradientSlider = addSubView(GradientSlider(width,12/*<--this should be NaN*/,20/*<--this should be NaN*/,gradient,0,1,self))
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}