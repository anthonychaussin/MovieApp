import UIKit

class UIMovieTableViewCell: UITableViewCell{
    
    // MARK: Properties
    @IBOutlet weak var ImagePreview: UIImageView!
    @IBOutlet weak var MovieTitle: UILabel!
    @IBOutlet weak var OutDate: UILabel!
    @IBOutlet weak var Resum: UILabel!
    
    // MARK: Function
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: true)
    }
    override func prepareForReuse() {
      super.prepareForReuse()
    }
    func loadComponent(movie: Movie) -> UIMovieTableViewCell {
        
        ImagePreview.imageFromServerURL(urlString: movie.poster)
        MovieTitle.text = movie.movieTitle
        Resum.text = movie.resum
        OutDate.text = movie.outDate
        
        return self
    }
    
}
