//
//  ProductCell.swift
//  ModelViewVeiwModel
//
//  Created by Ahsan Riaz on 09/08/2023.
//

import UIKit


class ProductCell: UITableViewCell {

    static let identifier = String(describing: ProductCell.self)
    
    @IBOutlet weak var imageViewMoviePoster: UIImageView!
    @IBOutlet weak var labelMovieTitle: UILabel!
    @IBOutlet weak var labelMovieOverView: UILabel!
    @IBOutlet weak var labelMoviePopularity: UILabel!
    @IBOutlet weak var labelMovieAvgVotes: UILabel!
    @IBOutlet weak var labelMovieReleaseDate: UILabel!
    
    
    var movie: Movies? {
        didSet {
            configureView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureView() {
        
        guard let movie = movie else {return}

        labelMovieTitle.text = movie.title
        labelMovieOverView.text = movie.overview
        labelMoviePopularity.text = "\(movie.popularity ?? 0.0)"
        labelMovieAvgVotes.text = "\(movie.vote_average ?? 0.0)"
        labelMovieReleaseDate.text = movie.release_date
        imageViewMoviePoster.setImage(with: movie.poster_path ?? "")
        
    }
    
}
