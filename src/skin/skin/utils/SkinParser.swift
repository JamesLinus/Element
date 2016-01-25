import Foundation

class SkinParser {
    /**
     * Returns the position when margin and padding is taken into account
     */
    class func relativePosition(skin:Skin)->CGPoint {
        let margin:Margin = self.margin(skin);
        let border:Border = self.border(skin);
        let padding:Padding = self.padding(skin);
        let offset:CGPoint = self.offset(skin);
        //Swift.print("padding.left: " + padding.left);
        //Swift.print("margin.left: " + margin.left);
        //Swift.print("skin.x: " + skin.x);
        return CGPoint(/*(skin.element as DisplayObject).x*/ margin.left + border.left + padding.left + offset.x, /*(skin.element as DisplayObject).y*/ margin.top + border.top + padding.top + offset.y);
    }
    /**
     *
     */
    class func margin(skin:ISkin)->Margin{// :TODO: possibly rename to relativeMargin
        return StylePropertyParser.margin(skin);
    }
    /**
     *
     */
    class func border(skin:ISkin)->Border {
        let lineOffsetType:OffsetType = StylePropertyParser.lineOffsetType(skin);
        let lineThickness:CGFloat = StylePropertyParser.value(skin, "line-thickness") as! CGFloat
        return Border([lineOffsetType.top == OffsetType.outside ? lineThickness : 0, lineOffsetType.right == OffsetType.outside ? lineThickness : 0,lineOffsetType.bottom == OffsetType.outside ? lineThickness : 0,lineOffsetType.left == OffsetType.outside ? lineThickness : 0]);
    }
    /**
     *
     */
    class func padding(skin:ISkin)->Padding{// :TODO: possibly rename to relativePadding
        return StylePropertyParser.padding(skin)
    }
    /**
     *
     */
    class func offset(skin:ISkin)->CGPoint{// :TODO: possibly rename to relativeOffset
        return StylePropertyParser.offset(skin);
    }
}