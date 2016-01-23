// Swift version of: https://gist.github.com/smileyborg/a5d1355773ad2ba6bb1e
import UIKit

public enum ViewOrientation {
	case Portrait
	case Landscape
}

extension UIView {
	public class func viewOrientationForSize(size:CGSize) -> ViewOrientation {
		return (size.width > size.height) ? .Landscape : .Portrait
	}
	
	public var viewOrientation:ViewOrientation {
		return UIView.viewOrientationForSize(self.bounds.size)
	}
	
	public func isViewOrientationPortrait() -> Bool {
		return self.viewOrientation == .Portrait
	}
			
	public func isViewOrientationLandscape() -> Bool {
		return self.viewOrientation == .Landscape
	}
}
