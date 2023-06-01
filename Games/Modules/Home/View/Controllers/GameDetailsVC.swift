//
//  GameDetailsVC.swift
//  Games
//
//  Created by Abdurrahman Alboghdady on 01/06/2023.
//

import UIKit
import Nuke

class GameDetailsVC: BaseVC {

    @IBOutlet weak var gameImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var developerLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var viewModel: GameDetailsVM!
    var gameId: Int64!
    var isFavorite: Bool?
    var game: GameDetails!
    var favoriteButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        viewModel.loadGameFromAPI(id: gameId)
    }
    
    private func setupViews() {
        title = "Game Details"
        viewModel = GameDetailsVM(service: GamesRequest(), gameDataSource: self, loadingDelegate: self)
        setupNavigationButtons()
    }
    
    func setupNavigationButtons() {
        let favoriteButtonTitle = (isFavorite ?? false) ? Constants.FavoritedText : Constants.FavoriteText
        favoriteButton = UIBarButtonItem(title: favoriteButtonTitle, style: .plain, target: self, action: #selector(favoriteButtonPressed))
        navigationItem.rightBarButtonItem = favoriteButton
    }
    
    @objc func favoriteButtonPressed() {
        if isFavorite ?? false {
            viewModel.deleteGame(id: gameId)
            favoriteButton.title = Constants.FavoriteText
        } else {
            viewModel.save(game: game)
            favoriteButton.title = Constants.FavoritedText
        }
    }
    
    @IBAction func readMore(_ sender: UIButton) {
        if descriptionLabel.numberOfLines == 0 {
            descriptionLabel.numberOfLines = 4
            sender.setTitle(Constants.ReadMore, for: .normal)
        } else {
            descriptionLabel.numberOfLines = 0
            sender.setTitle(Constants.ReadLess, for: .normal)
        }
    }
    
    @IBAction func visitWebsite(_ sender: Any) {
        open(url: game.website ?? "")
    }
    
    @IBAction func visitReddit(_ sender: Any) {
        open(url: game.reddit_url ?? "")
    }
    
    func open(url: String) {
        guard let url = URL(string: url) else { return }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    deinit {
        viewModel.cancelRequest()
    }
}

extension GameDetailsVC: LoadingDelegate {
    func showLoading(_ isLoading: Bool) {
        self.isLoading = isLoading
    }
}

extension GameDetailsVC: GameDataSource {
    func set(game: GameDetails) {
        self.game = game
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            Nuke.loadImage(with: game.background_image ?? "", into: gameImageView)
            self.nameLabel.text = game.name
            self.releaseDateLabel.text = game.released
            self.descriptionLabel.attributedText = game.description?.convertHtmlToAttributedStringWithCSS(font: UIFont.systemFont(ofSize: 15))
            
            var developers = ""
            let developersCount = game.developers!.count
            for i in 0..<developersCount {
                developers += game.developers?[i]?.name ?? ""
                if i < (developersCount - 1) {
                    // not the last genre
                    developers += ", "
                }
            }
            self.developerLabel.text = developers
            var genres = ""
            let genresCount = game.genres!.count
            for i in 0..<genresCount {
                genres += game.genres?[i]?.name ?? ""
                if i < (genresCount - 1) {
                    // not the last genre
                    genres += ", "
                }
            }
            self.genresLabel.text = genres
        }
    }
}
