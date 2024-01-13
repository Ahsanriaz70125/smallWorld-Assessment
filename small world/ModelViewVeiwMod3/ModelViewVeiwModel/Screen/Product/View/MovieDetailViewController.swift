//
//  MovieDetailViewController.swift
//  ModelViewVeiwModel
//
//  Created by Abdul Sami Sultan on 12/01/2024.
//

import UIKit

class MovieDetailViewController: UIViewController {

    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var detailStackView: UIStackView!
    
    
    @IBOutlet weak var poster: UIImageView!
    
    
    @IBOutlet weak var labelTitle: UILabel!
    
    @IBOutlet weak var labelOverView: UILabel!
    
    @IBOutlet weak var labelPopularity: UILabel!
    
    
    @IBOutlet weak var labelVotes: UILabel!
    
    @IBOutlet weak var labelBudget: UILabel!
    @IBOutlet weak var labelRuntime: UILabel!
    
    
    
    
    
    var movieId = 0
    private var viewModel = MovieDetialsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configuration()
        detailStackView.isHidden = true
        activityIndicator.startAnimating()
    }
    
}
extension MovieDetailViewController{
    func configuration() {
        observeEvent()
        initViewModel()
    }
    
    func initViewModel() {
        viewModel.fetchMovieDetials(movieId: movieId)
    }
    
    // data binding event observe karega - communication
    func observeEvent() {
        
        viewModel.eventHandler = { [weak self] event in
            
            guard let self = self else { return }
            
            switch event {
                
            case .loading:
                print("Products loading")
            case .stopLoading:
                print("Stop Loading")
            case .dataLoaded:
                print("Data Loaded")
                DispatchQueue.main.async {
                    self.updateLabels()
                }
                
            case .error(let error):
                print(error ?? "")
            }
            
        }
    }
    func updateLabels(){
        if let details = viewModel.movieDetail{
            activityIndicator.isHidden = true
            
            detailStackView.isHidden = false
            poster.setImage(with: details.poster_path ?? "")
            labelTitle.text = details.title
            labelOverView.text = details.overview
            labelPopularity.text = "\(details.popularity ?? 0.0)"
            labelVotes.text = "\(details.vote_average ?? 0.0)"
            labelBudget.text = "$\(details.budget ?? 0)"
            labelRuntime.text = "\(details.runtime ?? 0) mins"
        }
    }
}
