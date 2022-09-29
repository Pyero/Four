import UIKit

final class ViewController: UIViewController {
    
    /*
     reflex:
     
    1. Outlet Collection: UIButton en remplacement de chaque connexion (properties & outlets)
     =>  @IBOutlet var buttonArray: [UIButton]!
     
     
     2. suivre les boutons préssé / 4 boutons, 4 tag 0 à 3
     => private var ButtonTag = Int()
    chaque IBAction a son tag
     
     
    3. dans return image picker
 
}
     
     créer 2 lazy var de type swipegesture
     1 pour top gesture
     1 pour left gesture
     
     trouver comment ecouter la closure de la gesture
     // gérer l'animation du swipe
     a l'exec de la closure, faire une action (ouvrir le shareviewcontroller)
    
    */
    
    //MARK: Properties & outlets
    
    @IBOutlet weak var topRightButton: UIButton!
    @IBOutlet weak var bottomRightButton: UIButton!
    @IBOutlet weak var topLeftButton: UIButton!
    @IBOutlet weak var bottomLeftButton: UIButton!
    
    private lazy var imagePicker: UIImagePickerController = {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        return imagePicker
    }()
    
    private var ButtonTag = Int()
    private enum ButtonType {
        case topLeft
        case topRight
        case bottomLeft
        case bottomRight
    }
    private var selectedButton: ButtonType?
    
    @IBAction func didPressTopLeftButton(_ sender: UIButton) {
        // Ouvrir la bibliotheque de photo
    
        ButtonTag = 0
        selectedButton = .topLeft
        openGallary()
    
    }
    
    @IBAction func didPressTopRigthButton(_ sender: Any) {
        openGallary()
        
    }
    
    @IBAction func didPressBottomLeftButtom(_ sender: Any) {
        openGallary()
    }
    
    @IBAction func didPressBottomRightButton(_ sender: Any) {
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
    
  
}

// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            set(image)
        }
        imagePicker.dismiss(animated: true)
    }
    
    private func set(_ image: UIImage) {
        let imageView = UIImageView(image: image)
        switch selectedButton {
        case .topLeft:
            topLeftButton.removeAllSubviews()
            imageView.frame = topLeftButton.bounds
            topLeftButton.addSubview(imageView)
        case .topRight: topRightButton.setImage(image, for: .normal)
        case .bottomLeft: bottomRightButton.setImage(image, for: .normal)
        case .bottomRight: bottomLeftButton.setImage(image, for: .normal)
        default: break
        }
    }
    
    private func openGallary() {
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
}

extension UIView {
    func removeAllSubviews() {
        self.subviews.forEach { subView in
            subView.removeFromSuperview()
        }
    }
}
