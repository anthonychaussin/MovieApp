import UIKit

class ViewController: UIViewController {

    // MARK: Properties
    
    public var currentMovie: Int = 0
    public var currentMovieDisplayed: Movie?
    
    @IBOutlet weak var MovieTitle: UILabel!
    @IBOutlet weak var SubTitle: UILabel!
    @IBOutlet weak var Poster: UIImageView!
    @IBOutlet weak var OutDate: UILabel!
    @IBOutlet weak var Duration: UILabel!
    @IBOutlet weak var Resum: UITextView!
    @IBOutlet weak var Cat: UILabel!
    @IBOutlet weak var VerticalStack: UIStackView!
    @IBOutlet weak var Player: UIButton!
    @IBOutlet var MainView: UIView!
    
    // MARK: Event
    
    @IBAction func PlayerClicked(_ sender: UIButton) {
        guard let urlVideo = currentMovieDisplayed?.urlVideo, let url = URL(string: urlVideo) else { return }
        UIApplication.shared.open(url)
    }
    
    // MARK: Function
    
    /// Executed function when the view is loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    /// Exucuted function when the view gonna be show
    /// - Parameter animated: Define if the appearation is animated
    override func viewWillAppear(_ animated: Bool) {
        if Env.prod
        {
            loadData()
        }
        else{ loadComponents(movie: Movie.getFakeData())}
    }
    /// Load data from API
    func loadData() -> Void {
        API.APIRequest(type: API.typeRequest.movie, option: "detail", arg: [API.optionalArgument.id: String(currentMovie)])
        { data in
            if let data = data, let result = try?
                JSONDecoder().decode(MovieResponse.self, from: data)
                {
                    guard let movie = try? Movie(data: result) else { return }
                    DispatchQueue.main.async()
                    {
                        self.currentMovieDisplayed = movie
                        self.loadComponents(movie: movie)
                   }
                }
        }
    }
    // MARK: Utilities
    
    /// Load all components of view
    /// - Parameter movie: The Movie struct to display
    func loadComponents(movie: Movie) -> Void {
        Cat.text = ""
        MovieTitle.text = movie.movieTitle
        SubTitle.text = movie.subTitle
        Poster.imageFromServerURL(urlString: movie.backdropPath )
        Resum.text = movie.resum
        OutDate.text = movie.outDate
        let duration: Int = Int(movie.duration )
        Duration.text = "\(duration/60) h \(duration - (duration/60)*60) min"
        for cat: Genre in movie.cat ?? [Genre(id: 0, name: "Unknown")]{
            Cat.text! += " \(String(describing: cat.name!)) "
        }
        Player.sendSubviewToBack(Poster)
        MainView.reloadInputViews()
    }
}
