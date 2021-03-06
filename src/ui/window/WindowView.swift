import Cocoa
/**
 * NOTE: WindowView needs the interactiveView so that Element has, so that events can propegate to it
 * TODO: WindowView should have a background element to target. check legacy code to confirm theory
 */
class WindowView:Element{
    var background:IElement?
    /**
     * Draws the graphics
     */
    override func resolveSkin() {
        super.resolveSkin()
        //TODO:adding a background is probably not needed after you fix the inheritage problem
        //background = addSubView(Element(width,height,self,"background"))
    }
    /**
     * Returns the class type of the Class instance
     */
    override func getClassType()->String{
        return String(Window)//Window can be targeted via the id so we use Window for all Window subclasses, although this can be overriden in said subclasses
    }
    override func setSize(width: CGFloat, _ height: CGFloat) {
        super.setSize(width, height)
        background?.setSize(width, height)
    }
}