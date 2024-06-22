//
//  HomePageViewController.swift
//  Netflix Clone
//
//  Created by Milad Marandi on 5/24/24.
//

import UIKit
import SDWebImage

enum Section:String, CaseIterable{
    case TopRated
    case Populare
    case NowPlaying
    case Upcoming
}


class HomePageViewController: UIViewController , HomePageViewCellDelegate {
    
    
    private let TableView = UITableView(frame: .zero, style: .grouped)
    private let netflixIcon = NetflixIconView()
    
    private var topRatedMovie = [HomePageMovieViewModel]()
    private var PopulareMovie = [HomePageMovieViewModel]()
    private var NowPlayingMovie = [HomePageMovieViewModel]()
    private var UpcomingMovie = [HomePageMovieViewModel]()
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .dark
        
        
        
        
        DispatchQueue.global(qos: .userInitiated).async {
            APIcaller.shared.createRequest(url: URL(string: "https://api.themoviedb.org/3/authentication"), METHOD: .GET, completion: { request in
                
                let task = URLSession.shared.dataTask(with: request) { data, response, error in
                    
                    guard let data = data , error == nil else {
                        print("You got an error here milad")
                        return
                    }
                    
                    do{
                        _ = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)

                        print("success")
                    }
                    catch{
                        print("failed")
                    }
                }
                
                task.resume()
                
            })
        }
        
        DispatchQueue.global().async {
            APIcaller.shared.FetchTopRatedMovie { result in
                switch result{
                    
                case .success(let data):
                    self.topRatedMovie = data.results.compactMap({ movie in
                        HomePageMovieViewModel(image:movie.poster_path, title: movie.original_title, overview: movie.overview, section: .TopRated, Movie_Id: movie.id)
                    })
                    DispatchQueue.main.async{
                        self.TableView.reloadData()
                    }
                case .failure(let error ):
                    print(error.localizedDescription)
                }
                
            }
        }
        
        DispatchQueue.global().async {
            APIcaller.shared.FetchPopularMovie{ result in
                switch result{
                    
                case .success(let data):
                    self.PopulareMovie = data.results.compactMap({ movie in
                        HomePageMovieViewModel(image:movie.poster_path, title: movie.original_title, overview: movie.overview, section: .TopRated, Movie_Id: movie.id)
                    })
                    DispatchQueue.main.async{
                        self.TableView.reloadData()
                    }
                case .failure(let error ):
                    print(error.localizedDescription)
                }
                
            }
        }
        
        DispatchQueue.global().async {
            APIcaller.shared.FetchUpcomingMovie{ result in
                switch result{
                    
                case .success(let data):
                    self.UpcomingMovie = data.results.compactMap({ movie in
                        HomePageMovieViewModel(image:movie.poster_path, title: movie.original_title, overview: movie.overview, section: .TopRated, Movie_Id: movie.id)
                    })
                    DispatchQueue.main.async{
                        self.TableView.reloadData()
                    }
                    
                case .failure(let error ):
                    print(error.localizedDescription)
                }
                
            }
        }
        
        
        
        DispatchQueue.global().async {
            APIcaller.shared.FetchNowplayingMovie{ result in
                switch result{
                    
                case .success(let data):
                    self.NowPlayingMovie = data.results.compactMap({ movie in
                        HomePageMovieViewModel(image:movie.poster_path, title: movie.original_title, overview: movie.overview, section: .TopRated, Movie_Id: movie.id)
                    })
                    DispatchQueue.main.async{
                        self.TableView.reloadData()
                    }
                    
                case .failure(let error ):
                    print(error.localizedDescription)
                }
                
            }
        }
        
        
        
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
            
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil),
            
        ]
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: netflixIcon)
        
        // -MARK: TABLE VIEW SETTING
        TableView.delegate = self
        TableView.dataSource = self
        TableView.register(HomePageViewCell.self, forCellReuseIdentifier: HomePageViewCell.identifier)
        TableView.register(HomePageHeaderView.self, forHeaderFooterViewReuseIdentifier: HomePageHeaderView.identifier)
        TableView.register(HomePageSectionTitleHeaderView.self, forHeaderFooterViewReuseIdentifier: HomePageSectionTitleHeaderView.identifier)
        TableView.allowsSelection = false
        TableView.showsVerticalScrollIndicator = false
        
        view.addSubview(TableView)
        
    

        
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        TableView.frame = view.bounds
        netflixIcon.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultoffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultoffset
        navigationController?.navigationBar.transform = .init(translationX: 0, y:min(0 , -offset))
    }
    
    func ShowingMoviePreviewVC(_ HomePageViewCell:HomePageViewCell, MovieName:String , MovieURL:URL , MovieOverview:String ,MovieBanner:String , Movie_Id:Int) {
        
        
        let MoviePreviewVc = MoviePreViewViewController(MovieName: MovieName, MovieURL: MovieURL, MovieOverview: MovieOverview, MovieBanner: MovieBanner, Movie_Id: Movie_Id)
        
        MoviePreviewVc.modalPresentationStyle = .pageSheet
        self.navigationController?.show(UINavigationController(rootViewController: MoviePreviewVc), sender: self)
        
    }
    
    


}


extension HomePageViewController:UITableViewDelegate , UITableViewDataSource {

    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
            //TopRatedMovie
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HomePageViewCell.identifier, for: indexPath) as? HomePageViewCell else{
                return UITableViewCell()
            }
            cell.configure(with:self.topRatedMovie)
            cell.delegate = self
            return cell
            
            //Populare
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HomePageViewCell.identifier, for: indexPath) as? HomePageViewCell else{
                return UITableViewCell()
            }
            
            cell.configure(with:self.PopulareMovie)
      
            cell.delegate = self
            return cell
            
            //NowPlaying
        case 2:
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HomePageViewCell.identifier, for: indexPath) as? HomePageViewCell else{
                return UITableViewCell()
            }
            
            cell.configure(with:self.NowPlayingMovie)
            cell.delegate = self
            return cell
            
            
            //Upcoming
        case 3:
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HomePageViewCell.identifier, for: indexPath) as? HomePageViewCell else{
                return UITableViewCell()
            }
            
            cell.configure(with:self.UpcomingMovie)
            cell.delegate = self
            return cell
            
            
        default:
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HomePageHeaderView.identifier) as? HomePageHeaderView  , section == 0 else {
            
            switch section{
            case 1:
                let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HomePageSectionTitleHeaderView.identifier) as? HomePageSectionTitleHeaderView
                header?.Title(with: "Top Rated Movies")
                return header
            case 2:
                let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HomePageSectionTitleHeaderView.identifier) as? HomePageSectionTitleHeaderView
                header?.Title(with: "Populare Movies")
                return header
            case 3:
                let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HomePageSectionTitleHeaderView.identifier) as? HomePageSectionTitleHeaderView
                header?.Title(with: "Upcoming Movies")
                return header
            default:
                return nil
            }
        }
        return header
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? self.view.frame.width - 60 : 30
    }
    
    
    
}
