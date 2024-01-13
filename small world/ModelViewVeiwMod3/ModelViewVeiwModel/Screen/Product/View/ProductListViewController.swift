//
//  ProductListViewController.swift
//  ModelViewVeiwModel
//
//  Created by Ahsan Riaz on 08/08/2023.
//

import UIKit

class ProductListViewController: UIViewController {

    @IBOutlet weak var tableViewProduct: UITableView!
    
    @IBOutlet weak var textfieldSearchBar: UISearchBar!
    
    private var viewModel = MovieViewModel()
    
    private var viewModelDisplay = MovieViewModel() {
        didSet {
            self.tableViewProduct.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
        // Do any additional setup after loading the view.
    }


}


extension ProductListViewController {
    
    func configuration() {
       
        tableViewProduct.register(UINib(nibName: ProductCell.identifier, bundle: nil), forCellReuseIdentifier: ProductCell.identifier)
        initViewModel()
        observeEvent()
    }
    
    func initViewModel() {
        
        viewModel.fatchProduct()
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
                    self.tableViewProduct.reloadData()
                }
                self.viewModelDisplay.movieList = self.viewModel.movieList
                print("move list Display: ", self.viewModelDisplay.movieList)
                print("move list: ", self.viewModel.movieList)

            case .error(let error):
                print(error ?? "")
            }
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails"{
            if let vc = segue.destination as? MovieDetailViewController{
                vc.movieId = viewModelDisplay.selectedId
            }
        }
    }
}

extension ProductListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        textfieldSearchBar.resignFirstResponder()
        filter(with: textfieldSearchBar.text?.trimWhiteSpaces() ?? "")
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filter(with: textfieldSearchBar.text?.trimWhiteSpaces() ?? "")
    }
    
    private func filter(with text: String) {
        guard !viewModel.movieList.isEmpty else { return }
        guard !text.isEmpty else {
            viewModelDisplay.movieList = viewModel.movieList
            DispatchQueue.main.async {
                self.tableViewProduct.reloadData()
            }
            return
        }
        
        viewModelDisplay.movieList = viewModel.movieList.filter { (category: Movies) -> Bool in
            return (category.title?.contains(text))!
        }

        print("move view Display: ", self.viewModelDisplay.movieList)
        
        DispatchQueue.main.async {
            self.tableViewProduct.reloadData()
        }
    }
}

extension ProductListViewController : UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        print("list count: ", viewModel.movieList.count)
        return viewModelDisplay.movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let productCell = tableViewProduct.dequeueReusableCell(withIdentifier: ProductCell.identifier) as? ProductCell else { return ProductCell() }
        
        productCell.movie = viewModelDisplay.movieList[indexPath.row]
        return productCell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModelDisplay.selectId(at: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "showDetails", sender: nil)
    }
}

