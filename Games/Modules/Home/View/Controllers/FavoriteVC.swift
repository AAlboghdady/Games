//
//  FavoriteVC.swift
//  Games
//
//  Created by Abdurrahman Alboghdady on 28/05/2023.
//

import UIKit
import SwipeCellKit

class FavoriteVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel: FavoriteVM!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getGames()
    }
    
    private func setupViews() {
        title = "Favorite"
        viewModel = FavoriteVM(gamesDataSource: self)
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "\(GameCell.self)", bundle: nil), forCellWithReuseIdentifier: "\(GameCell.self)")
    }
}

extension FavoriteVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width = collectionView.frame.width
        if UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight {
            width /= 2.1
        }
        return CGSize(width: width , height: 124)
    }
}

extension FavoriteVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(GameCell.self)", for: indexPath) as! GameCell
        cell.configure(game: viewModel.games[indexPath.item])
        cell.favoriteButton.isHidden = true
        cell.delegate = self
        return cell
    }
}

extension FavoriteVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.games.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "\(GameDetailsVC.self)") as! GameDetailsVC
        vc.gameId = viewModel.games[indexPath.item].id
        vc.isFavorite = viewModel.games[indexPath.item].isFavorite
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension FavoriteVC: SwipeCollectionViewCellDelegate {
    func collectionView(_ collectionView: UICollectionView, editActionsForItemAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right || orientation == .left else { return nil }

        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { [weak self] action, indexPath in
            // handle action by updating model with deletion
            self?.showDeleteAlert(indexPath: indexPath)
        }

        // customize the action appearance
//        deleteAction.image = UIImage(named: "delete")

        return [deleteAction]
    }
    
    func showDeleteAlert(indexPath: IndexPath) {
        let alert = UIAlertController(title: "Alert", message: "Are you sure you want to delete this game from favorite?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { [weak self] action in
            self?.viewModel.deleteGame(at: indexPath.item)
//            self?.viewModel.games.remove(at: indexPath.item)
//            self?.collectionView.reloadItems(at: [indexPath])
        }))
        self.present(alert, animated: true)
    }
}

extension FavoriteVC: GamesDataSource {
    func setGames() {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
}
