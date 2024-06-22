//
//  TopSearchesViewController.swift
//  Netflix Clone
//
//  Created by Milad Marandi on 5/24/24.
//

import UIKit

class TopSearchesViewController: UIViewController , UISearchBarDelegate , UISearchControllerDelegate , UISearchResultsUpdating , SearchResultViewControllerDelegate {
    
    
    var SearchController:UISearchController!
    let TableView:UITableView = UITableView(frame: .zero, style: .plain)
    
    private var TopSearchMovies = [TopSearchMovieViewModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Top Searches"
        overrideUserInterfaceStyle = .dark
        
        SearchController = UISearchController(searchResultsController: SearchResultViewController())
        navigationItem.searchController = SearchController
        SearchController.delegate = self
        SearchController.searchBar.delegate = self
        SearchController.searchResultsUpdater = self
        
        TableView.delegate = self
        TableView.dataSource = self
        TableView.showsVerticalScrollIndicator = false
        TableView.register(TopSearchesViewCell.self, forCellReuseIdentifier: TopSearchesViewCell.identifier)
        view.addSubview(TableView)
        
        DispatchQueue.global().async {
            APIcaller.shared.fetchMostDiscoverMovie { result in

                switch result{
                case .success(let Movies):
                    self.TopSearchMovies = Movies.results.compactMap({ movie in
                        TopSearchMovieViewModel(poster: movie.poster_path, original_title: movie.original_title , overview: movie.overview , Id: movie.id)
                    })
                    DispatchQueue.main.async {
                        self.TableView.reloadData()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    
                }
            }

        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        TableView.frame = view.bounds
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let MovieTitle = searchBar.text , !MovieTitle.trimmingCharacters(in: .whitespaces).isEmpty else {
            print("you have error here")
            return
        }
        
        APIcaller.shared.SearchMovie(movie: MovieTitle) { result in
            switch result{
            case .success(let movies):
                break
            case .failure(let error):
                print(error.localizedDescription)
                
            }
        }
    }
    
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let MovieTitle = searchController.searchBar.text , !MovieTitle.trimmingCharacters(in: .whitespaces).isEmpty , let resultViewController = searchController.searchResultsController as? SearchResultViewController else {
            print("you have error here")
            return
        }
        
        APIcaller.shared.SearchMovie(movie: MovieTitle) { result in
            switch result{
            case .success(let movies):
                resultViewController.delegate  = self
                
                resultViewController.Movies = movies.results.compactMap({
                    SearchResultViewModel(Title: $0.original_title, Overview: $0.overview, Poster: $0.poster_path, Id: $0.id)
                })
                DispatchQueue.main.async{
                    resultViewController.CollectionView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
                
            }
        }
    }
    
    
    func ShowingMoviePreviewVC(_ HomePageViewCell: SearchResultViewController, MovieName: String, MovieURL: URL?, MovieOverview: String, MovieBanner: String, Movie_Id: Int) {
        
        let vc = MoviePreViewViewController(MovieName: MovieName, MovieURL: MovieURL, MovieOverview: MovieOverview, MovieBanner: MovieBanner, Movie_Id: Movie_Id)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    

}

extension TopSearchesViewController:UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TopSearchMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TopSearchesViewCell.identifier, for: indexPath) as? TopSearchesViewCell else {
            return UITableViewCell()
        }
        let movie = self.TopSearchMovies[indexPath.row]
        cell.configure(movie.poster, movie.original_title)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let movie = TopSearchMovies[indexPath.row]
        
        let MoviePreviewVc = MoviePreViewViewController(MovieName: movie.original_title, MovieURL: nil, MovieOverview: movie.overview, MovieBanner: movie.poster, Movie_Id: movie.Id)
        
        self.navigationController?.pushViewController(MoviePreviewVc, animated: true)
    }
    
    
}
