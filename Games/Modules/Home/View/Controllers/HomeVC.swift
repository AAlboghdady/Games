//
//  HomeVC.swift
//  Games
//
//  Created by Abdurrahman Alboghdady on 28/05/2023.
//

import UIKit

class HomeVC: BaseVC {

    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel: HomeVM!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        viewModel.loadGamesFromAPI()
    }
    
    private func setupViews() {
        title = "Home"
        viewModel = HomeVM(service: GamesRequest(), gamesDataSource: self, loadingDelegate: self)
        setupSearchTextField()
        setupCollectionView()
    }
    
    private func setupSearchTextField() {
        searchTF.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "\(GameCell.self)", bundle: nil), forCellWithReuseIdentifier: "\(GameCell.self)")
    }
    
    private func loadMore() {
        viewModel.loadGamesFromAPI(searchText: searchTF.text!.count > 3 ? searchTF.text : nil, isLoadingMore: true)
    }
    
    deinit {
        viewModel.cancelRequest()
    }
}

extension HomeVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width = collectionView.frame.width
        if UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight {
            width /= 2.1
        }
        return CGSize(width: width , height: 124)
    }
}

extension HomeVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(GameCell.self)", for: indexPath) as! GameCell
        cell.configure(game: viewModel.games[indexPath.item])
        cell.favoriteButton.onTap { [weak self] in
            guard let self = self else { return }
            self.viewModel.games[indexPath.item].isFavorite = !(self.viewModel.games[indexPath.item].isFavorite ?? false)
            if (self.viewModel.games[indexPath.item].isFavorite ?? false) {
                cell.favoriteButton.setTitle(Constants.FavoritedText, for: .normal)
                self.viewModel.saveGame(at: indexPath.item)
            } else {
                cell.favoriteButton.setTitle(Constants.FavoriteText, for: .normal)
            }
        }
        if viewModel.games[indexPath.item].isOpened ?? false {
            cell.gameImageView.superview?.backgroundColor = .lightGray
        } else {
            cell.gameImageView.superview?.backgroundColor = .clear
        }
        return cell
    }
}

extension HomeVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.games.count
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        print("items \(viewModel.games.count) index \(indexPath.row)")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            guard let self = self else { return }
            if indexPath.row == self.viewModel.games.count - 1,
               collectionView.visibleCells.contains(cell),
               !self.isLoading {
                self.loadMore()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.games[indexPath.item].isOpened = true
        collectionView.reloadItems(at: [indexPath])
        let vc = storyboard?.instantiateViewController(withIdentifier: "\(GameDetailsVC.self)") as! GameDetailsVC
        vc.gameId = viewModel.games[indexPath.item].id
        vc.isFavorite = viewModel.games[indexPath.item].isFavorite
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeVC {
    @objc func textFieldDidChange(_ textField: UITextField) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(searchRepositories), object: nil)
        perform(#selector(searchRepositories), with: nil, afterDelay: 0.5)
    }
    
    @objc func searchRepositories() {
        viewModel.validateSearch(text: searchTF.text!)
    }
}

extension HomeVC: LoadingDelegate {
    func showLoading(_ isLoading: Bool) {
        self.isLoading = isLoading
    }
}

extension HomeVC: GamesDataSource {
    func setGames() {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
}
