//
//  GameCell.swift
//  Games
//
//  Created by Abdurrahman Alboghdady on 28/05/2023.
//

import UIKit
import Nuke
import SwipeCellKit

class GameCell: SwipeCollectionViewCell {

    @IBOutlet weak var gameImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var metacriticLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func configure(game: Game) {
        Nuke.loadImage(with: game.background_image ?? "", into: gameImageView)
        nameLabel.text = game.name
//        genreLabel.text = game.genres?.reduce("", { $0 + ($1.name ?? "") + ", " }).dropLast(2)
        var genres = ""
        let count = game.genres?.count ?? 0
        for i in 0..<count {
            genres += game.genres![i].name ?? ""
            if i < (count - 1) {
                // not the last genre
                genres += ", "
            }
        }
        genreLabel.text = genres
        metacriticLabel.text = "\(game.metacritic ?? 0)"
        if (game.isFavorite ?? false) {
            favoriteButton.setTitle(Constants.FavoritedText, for: .normal)
        } else {
            favoriteButton.setTitle(Constants.FavoriteText, for: .normal)
        }
        
        // make corner raduis rounds
        gameImageView.superview?.addBorder()
        gameImageView.superview?.round(8)
        gameImageView.round(8)
        metacriticLabel.round(8)
    }
}
