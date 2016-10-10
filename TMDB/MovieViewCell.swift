//
//  MovieViewCell.swift
//  TMDB
//
//  Created by Георгий Кажуро on 08.09.16.
//  Copyright © 2016 Георгий Кажуро. All rights reserved.
//

import UIKit

class MovieViewCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var overview: UILabel!
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var voteAverage: RateLabel!
    @IBOutlet weak var genreLabelPosition: UILabel!
    @IBOutlet weak var favoriteView: UIView!
    @IBOutlet weak var favoriteViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var favoriteLabelConstraint: NSLayoutConstraint!
    @IBOutlet weak var favoriteImageConstraint: NSLayoutConstraint!
    


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(_ movie: Movie) {
        layoutIfNeeded()
        title.text = movie.title
        overview.text = movie.overview
        voteAverage.text = "\(movie.voteAverage.format(1))"
        voteAverage.setColor()
        createGenreLabels(genresArr: movie.genreStrings)
        favoriteViewWidthConstraint.constant = 0
        favoriteLabelConstraint.constant = 0
        favoriteImageConstraint.constant = 0
    }
    
    func showFavoriteView() {
        contentView.bringSubview(toFront: favoriteView)
        let viewWidth = self.frame.maxX - poster.frame.maxX
        favoriteViewWidthConstraint.constant = viewWidth
        favoriteLabelConstraint.constant = 141
        favoriteImageConstraint.constant = 41
        UIView.animate(withDuration: 0.75) {
            self.layoutIfNeeded()
        }
    }
    
    func hideFavoriteView() {
        favoriteViewWidthConstraint.constant = 0
        favoriteLabelConstraint.constant = 0
        favoriteImageConstraint.constant = 0
        UIView.animate(withDuration: 0.75) {
            self.layoutIfNeeded()
        }
    }
    
    func createGenreLabels(genresArr: [String]) {
        
        for subview in self.contentView.subviews {
            if (subview.tag == 100) {
                subview.removeFromSuperview()
            }
        }
        
        var labelPos = genreLabelPosition.frame.origin
        var genreLabelsWidth: CGFloat = 0
        let maxGenresWidth = self.frame.maxX - genreLabelPosition.frame.minX
        for genre in genresArr {
            let newLabel = configureGenreLabel(genre: genre, position: labelPos)
            if let label = newLabel {
                genreLabelsWidth += (label.frame.width + 4)
                if (genreLabelsWidth < maxGenresWidth) {
                    label.tag = 100
                    self.contentView.addSubview(label)
                    labelPos.x += (label.frame.width + 4)
                } else {
                    break
                }
            }
        }
    }
    
    func configureGenreLabel(genre: String, position: CGPoint) -> UILabel! {
        let newLabel = UILabel()
        newLabel.text = genre
        newLabel.font = UIFont.systemFont(ofSize: 11)
        let maxSize = CGSize(width: 200.0, height: 200.0)
        let size = newLabel.sizeThatFits(maxSize)
        newLabel.frame = CGRect(x: position.x, y: position.y, width: size.width + 10, height: size.height + 5)
        newLabel.frame.origin = position
        let backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.075)
        newLabel.backgroundColor = backgroundColor
        newLabel.textAlignment = .center
        newLabel.textColor = UIColor.lightGray
        
        newLabel.layer.cornerRadius = 7.5
        newLabel.clipsToBounds = true
        return newLabel
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
