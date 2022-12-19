import UIKit

final class ViewController: UIViewController {
    
    /*
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
    @IBOutlet weak var imageView: UIButton!
    @IBOutlet weak var allFourView: UIStackView!
    
    @IBOutlet weak var layout3Button: UIButton!
    
    private lazy var leftSwipeGestureRecognizer: UISwipeGestureRecognizer = {
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(executeSwipeAction(_:)))
        swipeUp.direction = .up
        return swipeUp
    }()
    
    private lazy var upSwipeGestureRecognizer: UISwipeGestureRecognizer = {
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(executeSwipeAction(_:)))
        swipeUp.direction = .left
        return swipeUp
    }()
    
    private lazy var imagePicker: UIImagePickerController = {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        return imagePicker
    }()
    
    //private var ButtonTag = Int()
    
    private enum ButtonType {
        case topLeft
        case topRight
        case bottomLeft
        case bottomRight
        case imageView
        //case Layout3
        
    }
    
    private var selectedButton: ButtonType?
    
    @IBAction func didPressTopLeftButton(_ sender: UIButton) {
        selectedButton = .topLeft
        openGallary()
        
    }
    
    @IBAction func didPressTopRigthButton(_ sender: Any) {
        selectedButton = .topRight
        openGallary()
    }
    
    @IBAction func didPressBottomLeftButtom(_ sender: Any) {
        selectedButton = .bottomLeft
        openGallary()
    }
    
    @IBAction func didPressBottomRightButton(_ sender: Any) {
        selectedButton = .bottomRight
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
        bottomLeftButton.removeAllSubviews()
    }
    
    @IBAction func didPressLayoutThreeButton(_ sender: Any) {
        topRightButton.isHidden = false
        bottomRightButton.isHidden = false

         
        setSelected(button: layout3Button)
    }
    
    @IBAction func didPressSwipeUp(_ sender: Any) {
        selectedButton = .imageView
        //executeSwipeAction(<#T##sender: UISwipeGestureRecognizer##UISwipeGestureRecognizer#>)
    }

    private func setSelected(button: UIButton) {
        removeSelectedViews()
        let image = UIImage(named: "Selected")
        let imageView = UIImageView(image: image)
        imageView.frame = button.bounds
        button.addSubview(imageView)
    }

    private func removeSelectedViews() {
        if layout3Button.subviews.count > 1 {
            layout3Button.subviews.last?.removeFromSuperview()
        }
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
        case .topRight:
            topRightButton.removeAllSubviews()
            imageView.frame = topRightButton.bounds
            topRightButton.addSubview(imageView)
        case .bottomLeft:
            bottomLeftButton.removeAllSubviews()
            imageView.frame = bottomLeftButton.bounds
            bottomLeftButton.addSubview(imageView)
        case .bottomRight:
            bottomRightButton.removeAllSubviews()
            imageView.frame = bottomRightButton.bounds
            bottomRightButton.addSubview(imageView)
        default: break
        }
    }
    
    private func openGallary() {
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func setImageSelected(_ image: UIImage?,for state: UIControl.State ) {
        _ = UIImage(named: "Selected")
        
    }
    
    
    // MARK: - ANIMATION
    
    @objc func executeSwipeAction(_ sender: UISwipeGestureRecognizer) {
        UIView.transition(with: imageView,
                          duration: 0.5,
                          options: sender.direction == .left ? [.transitionFlipFromLeft] : [.transitionCurlUp],
                          animations: {},
                          completion: { [weak self] _ in self?.sharePicture() })
    }
    
    private func sharePicture() {
        UIGraphicsBeginImageContext (imageView.frame.size)
        imageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        let activityVC = UIActivityViewController(activityItems: [image!], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC, animated: true, completion: nil)
    }
    
    
}

extension UIView {
    func removeAllSubviews() {
        self.subviews.forEach { subView in
            subView.removeFromSuperview()
        }
    }
}
