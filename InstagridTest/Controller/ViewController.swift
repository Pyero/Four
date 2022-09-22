import UIKit

final class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private lazy var imagePicker: UIImagePickerController = {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        return imagePicker
    }()

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            print(image.description)
            topRightButton.setImage(image, for: .normal)
        }
        imagePicker.dismiss(animated: true)
    }
    
    var toto = true
    //MARK: Properties & outlets
    
    @IBOutlet weak var topRightButton: UIButton!
    @IBOutlet weak var bottomRightButton: UIButton!
    @IBOutlet weak var topLeftButton: UIButton!
    @IBOutlet weak var bottomLeftButton: UIButton!
    //list of frame
    /*
     enum whitchSquare: Int {
     case topLeft
     case topRight
     case bottomLeft
     case bottomRigth
     }
     */
    //list of layout
    enum layoutFormat {
        case rectangleTop
        
    }
    
    //MARK: View life cycle
    
    
    
    // MARK: - Inputs
    
    @IBAction func didPressTopLeftButton(_ sender: Any) {
        // Ouvrir la bibliotheque de photo
        
        openGallary()
    }
    
    @IBAction func didPressTopRigthButton(_ sender: Any) {
        openGallary()
    }
    
    @IBAction func didPressLayoutOneButton(_ sender: Any) {
        // Configurer l'affichage ou non des bouton de la grid
        topRightButton.isHidden = true
        bottomRightButton.isHidden = false
    }
    
    @IBAction func didPressLayoutTwoButton(_ sender: Any) {
        bottomRightButton.isHidden = true
        topRightButton.isHidden = false
    }
    @IBAction func didPressLayoutThreeButton(_ sender: Any) {
        topRightButton.isHidden = false
        bottomRightButton.isHidden = false
    }
    
    func openGallary() {
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.allowsEditing = true
        //imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
    }
}

