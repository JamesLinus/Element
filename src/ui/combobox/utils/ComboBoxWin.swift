import Foundation

class ComboBoxWin:Window{
    required init(_ width: CGFloat, _ height: CGFloat) {
        super.init(width,height)
        WinModifier.align(self, Alignment.centerCenter, Alignment.centerCenter)
    }
    override func resolveSkin() {
        super.resolveSkin()
        self.contentView = PopupView(frame.width,frame.height,nil,"special")/*Sets the mainview of the window*/
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
class ComboBoxView:PopupView{
    override func resolveSkin() {
        super.resolveSkin()
        list = /*addSubView*/(SliderList(width, height, itemHeight, dataProvider, self))
        ListModifier.selectAt(list!, initSelected)
        
    }
}

//IMPORTANT: try to open the popover window when the origin window is in fullscreen mode (works)
//Figure out how to listen to mouseEvents outside and inside NSWindow (maybe use local and global monitors)

//1. on click outside of the popup window needs to be recorded (done)
//2. click a button in popupWin sends an event and then closes it self (done)
//3. the popupWindow needs to be stored somewhere, maybe in a static variable or somewhere else in the Element framework (done)
//4. Make an universal alignment method for aligning windows, you can probably use the regular Align method here with a zeroSize and CGPoint and TopCenter as the alignment type
//5. try to animate the popup effect
//6. the popupwin must have an init with size and position,
//7. populate the window with a List/SliderList
//8. hock up the List event
//9. create the ComboBoxPopUpWindow
//10. you need a method that checks avilable space for the popup to be shown in (mesure screen vs origin-pos vs popup-size) <--do some doodeling etc
