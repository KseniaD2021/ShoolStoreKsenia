// HxH School iOS Pass
// Copyright © 2021 Heads and Hands. All rights reserved.
//

import UIKit
import AutoLayoutSugar
import Kingfisher

class ProfileVC: UIViewController {
    
    // MARK: Lifecycle

    @IBOutlet weak var ProfileView: ProfileView!
    
    @IBOutlet weak var OrdersBtn: UIButton!
    
    @IBOutlet weak var SettingsBtn: UIButton!
    
    @IBOutlet weak var ExitBtn: UIButton!
    
    private var profile: Profile?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.selectedItem?.title = L10n.Profile.title
        
        authService?.getProfile(completion: {
            (result: Result<Profile, Error>) in
            switch result {
            case let .success(pr):
                self.profile = pr
            case let .failure(error):
                print(error)
            }
        })
        
        guard let nameP = profile?.name,
              let surname = profile?.surname,
              let occupation = profile?.occupation
        else {
            return
        }
        
        if let preview = profile?.avatarUrl, let previewUrl = URL(string: preview) {
            let contentImageResource = ImageResource(downloadURL: previewUrl, cacheKey: preview)
            photoProfile.kf.setImage(
                with: contentImageResource,
                placeholder: Asset.itemPlaceholder.image,
                options: [
                    .transition(.fade(0.2)),
                    .forceTransition,
                    .cacheOriginalImage,
                    .keepCurrentImageWhileLoading,
                ]
            )
        } else {
            photoProfile.image = Asset.itemPlaceholder.image
        }
        
        OrdersBtn.addSubview(toHistoryBtn)
        SettingsBtn.addSubview(settingsBtnLabel)
        ExitBtn.addSubview(exitBtnLabel)
        ProfileView.addSubview(nameLabel)
        ProfileView.addSubview(photoProfile)
        ProfileView.addSubview(speciality)
        photoProfile.layer.cornerRadius = 45
        photoProfile.clipsToBounds = true
        
        nameLabel.text = nameP + " " + surname
        speciality.text = occupation

        setup()
 
    }
    // MARK: Internal

    @IBAction func historyPage(_ sender: Any) {
        self.tabBarController?.selectedIndex = 1
    }
    

    private lazy var photoProfile: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .white
        image.height(90).width(90)

        return image
    }()
    
    private lazy var nameLabel: UILabel = {
        let txt = UILabel()
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.font = .systemFont(ofSize: 24, weight: .medium)
        txt.textColor = .white
        return txt
    }()
    
    private lazy var speciality: UILabel = {
        let txt = UILabel()
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.font = .systemFont(ofSize: 14, weight: .medium)
        txt.textColor = .white
        return txt
    }()
    
    private lazy var toHistoryBtn: UILabel = {
        let txt = UILabel()
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.text = L10n.History.title
        txt.font = .systemFont(ofSize: 14, weight: .medium)
        txt.textColor = .white
        return txt
    }()
    private lazy var settingsBtnLabel: UILabel = {
        let txt = UILabel()
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.text = L10n.Editing.settings
        txt.font = .systemFont(ofSize: 14, weight: .medium)
        txt.textColor = .white
        return txt
    }()
    
    private lazy var exitBtnLabel: UILabel = {
        let txt = UILabel()
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.text = L10n.Actions.exitAction
        txt.font = .systemFont(ofSize: 14, weight: .medium)
        txt.textColor = .white
        return txt
    }()
    
    @objc
    func specializationDidTap(_ sender: UIButton) {
        if sender.titleLabel?.text == "Другое" {
           
        } else {
            speciality.text = sender.titleLabel?.text
        }
    }

    @IBAction func EditProfilePressed(_ sender: Any) {
        guard let profile = self.profile else {
            return
        }
        self.navigationController?.pushViewController(VCFactory.buildEtidPage(with: profile), animated: true)
    }
    
    // MARK: Internal
    
    @IBAction func logoutPressedButton(_ sender: Any) {
        let alert = UIAlertController(title: L10n.Actions.exit, message: L10n.Questions.exit, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: L10n.Actions.exitAction, style: .default) { (sender: UIAlertAction) -> Void in
            
            UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.rootViewController = VCFactory.buildAuthVC()
            self.dataService?.appState.accessToken = nil
        })
        alert.addAction(UIAlertAction(title: L10n.Actions.cancel, style: .cancel){ (sender: UIAlertAction) -> Void in
        })
        self.present(alert, animated: true, completion: nil)

    }
    
    func setup() {
        photoProfile.centerX()
        nameLabel.centerX().top(to: .bottom(16), of: photoProfile)
        speciality.centerX().top(to: .bottom(0), of: nameLabel)
        toHistoryBtn.centerX().top(50)
        settingsBtnLabel.centerX().top(50)
        exitBtnLabel.centerX().top(50)
    }
    
    func setup(with authService: AuthService,  dataService: DataService) {
        self.authService = authService
        self.dataService = dataService
    }
    
    private var authService: AuthService?
    
    var dataService: DataService?
}

