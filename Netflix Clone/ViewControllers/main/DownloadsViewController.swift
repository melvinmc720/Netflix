//
//  DownloadsViewController.swift
//  Netflix Clone
//
//  Created by Milad Marandi on 5/24/24.
//

import UIKit

class DownloadsViewController: UIViewController {

    
    let TableView:UITableView = UITableView(frame: .zero, style: .plain)
    
    var WatchListMovies = [MyWatchlistMovieViewModel]()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Downloads"
        overrideUserInterfaceStyle = .dark
        NotificationCenter.default.addObserver(self, selector: #selector(UpdateView), name: NSNotification.Name("UpdateView"), object: nil)
        TableView.delegate = self
        TableView.dataSource = self
        TableView.showsVerticalScrollIndicator = false
        TableView.register(DownloadsTableViewcell.self, forCellReuseIdentifier: DownloadsTableViewcell.identifier)
        view.addSubview(TableView)
        fetchingMyWatchingList()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        TableView.frame = view.bounds
    }
    
    private func fetchingMyWatchingList(){
        APIcaller.shared.GetWatchListMovies(completion: {result in
            switch result{
            case .success(let MyWatchlist):
                self.WatchListMovies = MyWatchlist.results.compactMap({
                    MyWatchlistMovieViewModel(poster: $0.poster_path, original_title: $0.original_title, Overview: $0.overview, ID: $0.id)
                })
                DispatchQueue.main.async{
                    self.TableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        })
    }
    
    @objc public func UpdateView(){
        
        APIcaller.shared.GetWatchListMovies { result in
            switch result{
                
            case .success(let MyWatchlist):
                DispatchQueue.main.async{
                    self.WatchListMovies = MyWatchlist.results.compactMap({
                        MyWatchlistMovieViewModel(poster: $0.poster_path, original_title: $0.original_title, Overview: $0.overview, ID: $0.id)
                    })
                    self.TableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    

}

extension DownloadsViewController:UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.WatchListMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DownloadsTableViewcell.identifier, for: indexPath) as? DownloadsTableViewcell else {
            return UITableViewCell()
        }
        let movie = WatchListMovies[indexPath.row]
        cell.configure(MovieTitle: movie.original_title, Image: movie.poster)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let movie = WatchListMovies[indexPath.row]
        let MovieDetail = MoviePreViewViewController(MovieName: movie.original_title, MovieURL:nil , MovieOverview: movie.Overview, MovieBanner: movie.poster, Movie_Id: movie.ID)
        navigationController?.pushViewController(MovieDetail, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            tableView.beginUpdates()
            self.WatchListMovies.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
    
    
    
}
