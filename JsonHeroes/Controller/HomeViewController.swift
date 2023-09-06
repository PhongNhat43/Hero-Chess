//
//  ViewController.swift
//  JsonHeroes
//
//  Created by devsenior on 16/06/2023.
//

import UIKit
import Foundation

class HomeViewController: UIViewController {
    
    // MARK: - Outlet
    @IBOutlet private weak var backgroundImageView: UIImageView!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var heightOfCollectionViewConstraint: NSLayoutConstraint!
    
    // MARK: - Property
    var filteredHeroes: [Hero] = []
    var selectedCollectionViewRace: String?
    var selectedCollectionViewIndexPath: IndexPath?
    var buffData: [Buff] = [Buff]()
    var heroData: [Hero] = [Hero]()
    var selectedTableIndex = -1
    var isCoollapce = false
    var selectedRaceIndex: Int?
    var overlayView: UIView!
    var itemSize: CGSize = .zero
    let numberOfItemsPerRow: CGFloat = 9
    let interitemSpacing: CGFloat = 5
    let lineSpacing: CGFloat = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabelView()
        setupCollectionView()
        fetchDataBuff()
        fetchDataHero()
        setupOverlayView()
        setupNavigation()
        filterHeroesByRace(nil)
        calculateItemSize()
    }
    
    func setupOverlayView() {
        overlayView = UIView(frame: view.bounds)
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        backgroundImageView.addSubview(overlayView)
    }
    
    func setupTabelView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HeroTableViewCell.nib(), forCellReuseIdentifier: HeroTableViewCell.identifier)
        tableView.estimatedRowHeight = 150
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .white
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CollectionViewCell.nib(), forCellWithReuseIdentifier: CollectionViewCell.indentifier)
        collectionView.collectionViewLayout.invalidateLayout()
        collectionView.layoutIfNeeded()
        collectionView.reloadData()
    }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        let height = collectionView.collectionViewLayout.collectionViewContentSize.height
//        heightOfCollectionViewConstraint.constant = height
//    }
    
    // MARK: - Navigation
    func setupNavigation() {
        title = "Heroes"
        let attributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 22)
        ]
        navigationController?.navigationBar.titleTextAttributes = attributes
    }
    
    // MARK: - Parse json
    func fetchDataBuff() {
        guard let fileLocation = Bundle.main.url(forResource: "buff", withExtension: "json") else { return }
        
        do {
            let data = try Data(contentsOf: fileLocation)
            let receivedData = try JSONDecoder().decode([Buff].self, from: data)
            self.buffData = receivedData
            //            print(receivedData)
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        } catch {
            print("Parsing Error")
        }
    }
    
    // MARK: - Parse json
    func fetchDataHero() {
        guard let fileLocation = Bundle.main.url(forResource: "hero", withExtension: "json") else { return }
        
        do {
            let data = try Data(contentsOf: fileLocation)
            let receivedData = try JSONDecoder().decode([Hero].self, from: data)
            self.heroData = receivedData
            //            print(receivedData1)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
            print("Parsing Error")
        }
    }
    
    // MARK: - Filter data
    func filterHeroesByRace(_ race: String?) {
        if let raceValue = race, !raceValue.isEmpty {
            filteredHeroes = heroData.filter { $0.races.contains(raceValue) }
            tableView.reloadData()
            return
        }
        filteredHeroes = heroData
        tableView.reloadData()
    }
    
    // MARK: - Item Size
    func calculateItemSize() {
//        //TH1
        let collectionViewWidth = collectionView.frame.width
        let itemWidth = (collectionViewWidth - (numberOfItemsPerRow - 1) * interitemSpacing) / numberOfItemsPerRow
        let itemHeight = itemWidth
        let totalLines = ceil(CGFloat(collectionView.numberOfItems(inSection: 0)) / numberOfItemsPerRow)
        let totalLineSpacing = lineSpacing * (totalLines - 1)
        let totalHeight = (itemHeight * totalLines) + totalLineSpacing
        heightOfCollectionViewConstraint.constant = totalHeight
        collectionView.layoutIfNeeded()
        itemSize = CGSize(width: itemWidth, height: itemHeight)
        
//        //Th2
//        let itemWidth: CGFloat = 60
//        let collectionViewWidth: CGFloat = collectionView.frame.width
//        let lineSpacing: CGFloat = 10
//        let interitemSpacing: CGFloat = 10
//        let maxItemsPerRow = floor((collectionViewWidth + lineSpacing) / (itemWidth + interitemSpacing))
//        let availableWidth = collectionViewWidth - (interitemSpacing * (maxItemsPerRow - 1))
//        let itemDimension = availableWidth / maxItemsPerRow
//        itemSize = CGSize(width: itemDimension, height: itemDimension)
    }

}

// MARK: - CollectionView DataSource
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return buffData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.indentifier, for: indexPath) as! CollectionViewCell
        let data = buffData[indexPath.item]
        cell.configure(with: data, selectedIndexPath: selectedCollectionViewIndexPath, indexPath: indexPath)
        return cell
    }
   
}

// MARK: - CollectionView Delegate
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard selectedCollectionViewIndexPath == nil || selectedCollectionViewIndexPath == indexPath else { return }
        
        let selectedBuff = buffData[indexPath.item]
        selectedCollectionViewRace = selectedBuff.name
        filterHeroesByRace(selectedBuff.name)
        
        if selectedCollectionViewIndexPath == indexPath {
            selectedCollectionViewIndexPath = indexPath
            selectedCollectionViewIndexPath = nil
            self.selectedCollectionViewRace = nil
            collectionView.reloadData()
            tableView.reloadData()
            return
        }
        
        selectedCollectionViewIndexPath = indexPath
        collectionView.reloadData()
        tableView.reloadData()
    }
}

// MARK: - CollectionView DelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}

// MARK: - TableView DataSource
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedCollectionViewIndexPath != nil ? filteredHeroes.count : heroData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HeroTableViewCell.identifier, for: indexPath) as! HeroTableViewCell
        let data = (selectedCollectionViewIndexPath != nil) ? filteredHeroes[indexPath.row] : heroData[indexPath.row]
        cell.configure(with: data)
        return cell
    }
}

// MARK: - TableView Delegate
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let defaultHeight: CGFloat = 80
        let data = (selectedCollectionViewIndexPath != nil) ? filteredHeroes[indexPath.row] : heroData[indexPath.row]
        let isItemSelected = selectedTableIndex == indexPath.row
        let cellHeight: CGFloat = data.races.count > 2 ? 100 : defaultHeight

        if isCoollapce && isItemSelected {
           return 340
        }

        if isCoollapce {
           return defaultHeight
        }
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if selectedTableIndex == indexPath.row {
            isCoollapce = !isCoollapce
            tableView.reloadRows(at: [indexPath], with: .automatic)
            return
        }
        
        isCoollapce = true
        selectedTableIndex = indexPath.row
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }

}


  

