import UIKit

class GenreUICollectionViewCell: UICollectionViewCell {

    // MARK: Properties
    @IBOutlet weak var genreNameLabel: UILabel!
    
    // MARK: Function
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func prepareForReuse() {
      super.prepareForReuse()
    }
    func loadComponent(genre: Genre) -> GenreUICollectionViewCell {
        genreNameLabel.text = genre.name
        return self
    }
}
