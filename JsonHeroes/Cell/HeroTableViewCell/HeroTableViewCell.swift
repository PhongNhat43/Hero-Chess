//
//  HeroTableViewCell.swift
//  JsonHeroes
//
//  Created by devsenior on 16/06/2023.
//

import UIKit

class HeroTableViewCell: UITableViewCell {
    
    // MARK: - Outlet
    @IBOutlet private weak var firstView: UIView!
    @IBOutlet private weak var detailView: UIView!
    var separatorView: UIView!
    var separatorView1: UIView!
    @IBOutlet weak var heroNameLabel: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var raceLabel: UILabel!
    @IBOutlet weak var classHeroLabel: UILabel!
    @IBOutlet weak var abilitiyImageView: UIImageView!
    @IBOutlet weak var priceHeroLabel: UILabel!
    @IBOutlet private weak var hpHeroLabel: UILabel!
    @IBOutlet private weak var armorHeroLabel: UILabel!
    @IBOutlet private weak var magicHeroLabel: UILabel!
    @IBOutlet private weak var damageHeroLabel: UILabel!
    @IBOutlet private weak var attackRateLabel: UILabel!
    @IBOutlet private weak var avangeHeroLabel: UILabel!
    @IBOutlet var secondClassHeroLabel: UILabel!
    @IBOutlet weak var secondView: UIView!
    
    static let identifier = "HeroTableViewCell"
       
    static func nib() -> UINib {
          return UINib(nibName: "HeroTableViewCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        detailView.layer.cornerRadius = 15
        detailView.layer.borderWidth = 2.0
        detailView.layer.borderColor = UIColor.white.cgColor
        
        // Create the separatorView
        separatorView = UIView()
        separatorView.backgroundColor = UIColor.white // Set the color of the separatorView
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(separatorView)

        separatorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        separatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        separatorView.topAnchor.constraint(equalTo: secondClassHeroLabel.bottomAnchor, constant: 12).isActive = true
        separatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
     func configure(with dataHero: Hero){
         let lightGray = UIColor(red: 203/255, green: 206/255, blue: 206/255, alpha: 1.0)
         let pink = UIColor(red: 240/255, green: 216/255, blue: 232/255, alpha: 1.0)
         let purple = UIColor(red: 160/255, green: 100/255, blue: 200/255, alpha: 1.0)

         switch dataHero.cost {
            case "$ 1":
                heroNameLabel.textColor = UIColor.white
            case "$ 2":
                heroNameLabel.textColor = lightGray
            case "$ 3":
                heroNameLabel.textColor = purple
            case "$ 4":
                heroNameLabel.textColor = pink
            case "$ 5":
                heroNameLabel.textColor = UIColor.yellow
            default:
                break
         }
        
        heroNameLabel.text = dataHero.name
        abilitiyImageView.image = UIImage(named: dataHero.ability.image)
        avatarImage.image = UIImage(named: dataHero.avatar)
        priceHeroLabel.text = dataHero.cost
        raceLabel.text = dataHero.races[0]
        classHeroLabel.text = dataHero.races[1]
            
        let hpValues = dataHero.statsMap.hp
        let hpText = hpValues.joined(separator: "/")
        let hpAttributedString = NSMutableAttributedString(string: "HP:  \(hpText)")
        hpAttributedString.addAttribute(.foregroundColor, value: UIColor.white, range: NSRange(location: 0, length: 3))
        hpHeroLabel.attributedText = hpAttributedString
                               
        let armorValues = dataHero.statsMap.armor
        let armorText = armorValues.joined(separator: "/")
        let armorAttributedString = NSMutableAttributedString(string: "Armor:  \(armorText)")
        armorAttributedString.addAttribute(.foregroundColor, value: UIColor.white, range: NSRange(location: 0, length: 6))
        armorHeroLabel.attributedText = armorAttributedString

        let magicAttributedString = NSMutableAttributedString(string: "Magic Resistance: ")
        magicAttributedString.addAttribute(.foregroundColor, value: UIColor.white, range: NSRange(location: 0, length: 17))
        magicHeroLabel.attributedText = magicAttributedString

        let damageValues = dataHero.statsMap.damage
        let damageText = damageValues.joined(separator: "/")
        let damageAttributedString = NSMutableAttributedString(string: "Damage:  \(damageText)")
        damageAttributedString.addAttribute(.foregroundColor, value: UIColor.white, range: NSRange(location: 0, length: 7))
        damageHeroLabel.attributedText = damageAttributedString
                
        let attackValues = dataHero.statsMap.attackRate
        let attackText = attackValues.joined(separator: "/")
        let attackAttributedString = NSMutableAttributedString(string: "Attack Rate:  \(attackText)")
        attackAttributedString.addAttribute(.foregroundColor, value: UIColor.white, range: NSRange(location: 0, length: 11))
        attackRateLabel.attributedText = attackAttributedString

       let averageValues = dataHero.statsMap.averageDPS
       let averageText = averageValues.joined(separator: "/")
       let averageAttributedString = NSMutableAttributedString(string: "Average DPS:  \(averageText)")
       averageAttributedString.addAttribute(.foregroundColor, value: UIColor.white, range: NSRange(location: 0, length: 11))
       avangeHeroLabel.attributedText = averageAttributedString
        
       if dataHero.races.count < 3 {
           secondClassHeroLabel.text = ""
           return
       }
                
       if dataHero.races.count > 2 {
//          avatarImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
//          heroNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
//          abilitiyImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
//          priceHeroLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
//          separatorView.bottomAnchor.constraint(equalTo: firstView.bottomAnchor, constant: 30).isActive = true
          secondClassHeroLabel.text = dataHero.races[2]
          return
       }
                
    }
}

