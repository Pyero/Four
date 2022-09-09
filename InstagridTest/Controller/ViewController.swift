import UIKit

class ViewController: UIViewController {

//MARK: Properties & outlets

    //list of frame
    enum whitchSquare: Int {
    case topLeft
    case topRight
    case bottomLeft
    case bottomRigth
    
    }
    
    //list of layout
    enum layoutFormat {
    case rectangleTop
        
    }
    
@IBOutlet var buttonSquareTopLeft: UIButton?
@IBOutlet var buttonSquareTopRigth: UIButton?
@IBOutlet var buttonSquareBottomLeft: UIButton?
@IBOutlet var buttonSquareBottomRigth: UIButton?
    
    //Buttons
  @IBOutlet  var buttonLayoutRectangleTop: UIButton?
  @IBOutlet  var buttonLayoutRectangleBottom: UIButton?
  @IBOutlet  var buttonLayoutSquares: UIButton?
    
    
    //Create an image of the global : To be sent after
    
    

    
    
    //MARK: View life cycle
}

