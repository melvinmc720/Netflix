//
//  ComingSoonViewController.swift
//  Netflix Clone
//
//  Created by Milad Marandi on 5/24/24.
//

import UIKit

class ComingSoonViewController: UIViewController {
    
    let TableView:UITableView = UITableView(frame: .zero, style: .plain)
    private var UpcomingMovies = [ComingSoonViewModel]()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Coming Soon"
        overrideUserInterfaceStyle = .dark
        TableView.delegate = self
        TableView.dataSource = self
        TableView.showsVerticalScrollIndicator = false
        TableView.register(ComingSoonViewCell.self, forCellReuseIdentifier: ComingSoonViewCell.identifier)
        view.addSubview(TableView)
        
        
        
        DispatchQueue.global().async {
            APIcaller.shared.YoutubeVideo("harry potter trailer", completion: {
                print("done")
            })
        }
        
        
        DispatchQueue.global().async {
            APIcaller.shared.FetchUpcomingMovie{ result in
                switch result{
                    
                case .success(let data):
                    
                    self.UpcomingMovies = data.results.compactMap({ movie in
                        ComingSoonViewModel(image: movie.poster_path, title: movie.original_title)
                    })
                    DispatchQueue.main.async{
                        self.TableView.reloadData()
                    }
                    
                case .failure(let error ):
                    print(error.localizedDescription)
                }
                
            }
        }
        
        
        
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        TableView.frame = view.bounds
    }

    

}

extension ComingSoonViewController:UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UpcomingMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ComingSoonViewCell.identifier, for: indexPath) as? ComingSoonViewCell else {
            return UITableViewCell()
        }
        
        var movie = (poster:self.UpcomingMovies[indexPath.row].image , name:self.UpcomingMovies[indexPath.row].title)
        
        cell.configure(name: movie.name ?? "not found", poster: movie.poster ?? "person")
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
