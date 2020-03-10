import UIKit



class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: Properties
    var fakeBDD: [Movie] = []
    var currentCat: Genre = Genre(id: -1, name: "Uncknonw")
    var pagination: Int = 1
    
    @IBOutlet var movieTableView: UITableView!
    
    // MARK: Init
    
    /// Executed function when the view is loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.movieTableView.register(UINib(nibName: "UIMovieTableViewCell", bundle: nil), forCellReuseIdentifier: Env.movieCellReuseId)
        self.movieTableView.dataSource = self
        self.movieTableView.delegate = self
        self.movieTableView.isPagingEnabled = true
        
        loadData()
    }
    
    // MARK: Fonction
    /// Get data from API
    /// - Parameter nbPage: The current page to search (Default: 1)
    func loadData(nbPage: Int = 1) -> Void {
        
        API.APIRequest(type: API.typeRequest.discover, arg:
            [
                API.optionalArgument.genre: String(currentCat.id!),
                API.optionalArgument.page: String(nbPage)
            ])
        { data in
            if let data = data, let result = try?
                JSONDecoder().decode(MovieListResponse.self, from: data)
                {
                   DispatchQueue.main.async()
                    {
                        self.fakeBDD = (self.fakeBDD.count > 0) ? self.fakeBDD + MovieResponse.transformToMovieArray(result: result.results) :  MovieResponse.transformToMovieArray(result: result.results)
                        self.movieTableView.reloadData()
                    }
                }
        }
        
    }
    
    // MARK: - Navigation
    /// Prepare the navigation destination
    /// - Parameters:
    ///   - segue: the navigation element
    ///   - sender: the genre to pass at the CollectionViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)  {
        if segue.identifier == "ShowDetailNavigation",  let ViewController = segue.destination as? ViewController {
            ViewController.currentMovie = (sender as! Movie).id
        }
    }
    /// Delegate for add the navigation at element click event
    /// - Parameters:
    ///   - tableView: The current collectionView
    ///   - indexPath: The index of current element displayed
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "ShowDetailNavigation", sender: fakeBDD[ movieTableView.dataSourceSectionIndex(forPresentationSectionIndex: indexPath.item)])
        tableView.deselectRow(at: indexPath, animated: true)
    }

    // MARK: - Delegate
    
    /// Delegate to get the count of element in collection
    /// - Parameters:
    ///   - tableView: The current CollectionViewController
    ///   - section: The number of item in current section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fakeBDD.count ;
    }
    /// Get the current cell
    /// - Parameters:
    ///   - tableView: The current CollectionViewController
    ///   - indexPath: The index of current cell in section collection
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.item > fakeBDD.count - 3){
            loadData(nbPage: pagination + 1)
            pagination += 1
        }
        return (tableView.dequeueReusableCell(withIdentifier: Env.movieCellReuseId) as! UIMovieTableViewCell).loadComponent(movie: fakeBDD[indexPath.item])
    }
    
}
