import Foundation

class PositionalGraphic:GraphicDecoratable {
    /*var position:CGPoint*/
    init(_ position:CGPoint,_ decoratable: IGraphicDecoratable) {
        super.init(decoratable)
        super.position = position
    }
    override func setPosition(position: CGPoint) {
        //Swift.print("PositionalGraphic.setPosition()")
        self.position = position
    }
    override func getPosition() -> CGPoint {
        return position
    }
}


class PositionalDecorator:GraphicDecoratable,IPositional{
    //var position:CGPoint{get{(decoratable as! IPositional).position} set{(decoratable as! IPositional).position = newValue}}
    
    func test(){
        if let decoratable as IPositional{
            decoratable.position = CGPoint()
        }
    }
}