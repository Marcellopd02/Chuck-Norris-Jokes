//
//  DetailViewController.swift
//  Chuck Norris
//
//  Created by Marcello Pontes Domingos on 24/01/20
//

import UIKit
import SnapKit

@objc class DetailViewController: UIViewController {
    
    
    //MARK: - Var`s and Let`s
    @objc public var selectedCategory = ""
    var image: UIImageView!
    var label: UILabel!
    var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        image = ConfigImage()
        label = ConfigLabel()
        button = ConfigButton()
        jsonParser()
    }
    
    func ConfigImage() -> UIImageView{
        
        let imageName = "chucknorris"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        imageView.contentMode = .scaleAspectFill
        imageView.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        self.view.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(110)
            make.trailing.equalTo(-70)
            make.leading.equalTo(70)
            make.height.equalTo(130)
        }
        return imageView
    }
    
    func ConfigLabel() -> UILabel{
        
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        self.view.addSubview(label)
        label.text = ""
        label.textAlignment = NSTextAlignment.center
        label.numberOfLines = 0
        label.snp.makeConstraints { (make) in
            make.top.equalTo(self.image.snp.bottom).offset(40)
            make.trailing.equalTo(-20)
            make.leading.equalTo(20)
        }
        return label
    }
    
    func ConfigButton() -> UIButton{
        
        let button = UIButton(type: UIButton.ButtonType.system) as UIButton
        button.frame = CGRect(x:0, y:0, width:0, height:0)
        button.backgroundColor = UIColor.orange
        button.setTitle("Tap me", for: UIControl.State.normal)
        button.tintColor = UIColor.white
        button.addTarget(self, action: #selector(DetailViewController().buttonAction(_:)), for: .touchUpInside)
        self.view.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.height.equalTo(60)
            make.trailing.equalTo(-40)
            make.leading.equalTo(40)
            make.bottom.equalTo(-40)
        }
        return button
    }

    @objc func buttonAction(_ sender:UIButton!){
        
        jsonParser()
        animateImage()
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 6, options: [], animations: {
            sender.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
            sender.transform = .identity
        }) { finished in
        }
    }
    
    func animateImage() {
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 6, options: [], animations: {
            self.image.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            self.image.transform = .identity
        }) { finished in
        }
    }
    
    func jsonParser() {
        
        let urlString = "https://api.chucknorris.io/jokes/random?category=\(selectedCategory)"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            
            guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else { return }
            let joke = Joke(json: json)
            DispatchQueue.main.async {
                self.label.text = joke.value
                
            }
        }.resume()
    }
}



