import UIKit

/// View controller of collectionView. It's the entry point
class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout{

    // MARK: Properties
    
    private let itemsPerRow: CGFloat = 2
    private let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    private var cats: [Genre] = []
    
    /// The view is loaded
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView.register(UINib(nibName: "GenreUICollectionViewCell", bundle: nil), forCellWithReuseIdentifier: Env.genreCellReuseId)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        loadData()
    }
    /// Load Data from API
    private func loadData() -> Void{
        API.APIRequest(type: API.typeRequest.genre, option: "movie") { data in
            if let data = data, let result = try?
                JSONDecoder().decode(GenreList.self, from: data)
                {
                   DispatchQueue.main.async() {
                        self.cats = result.genres ?? [Genre(id: 0, name: "Uncknown")]
                        self.collectionView.reloadData()
                    }
                }
        }
    }
    // MARK: - Navigation
    
    /// Prepare the navigation destination
    /// - Parameters:
    ///   - segue:  the navigation element
    ///   - sender: the genre to pass at the CollectionViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowGenredMovieSegue",  let ListViewController = segue.destination as? ListViewController {
            ListViewController.currentCat = (sender as! Genre)
        }
    }
    /// Delegate for add the navigation at element click event
    /// - Parameters:
    ///   - collectionView: The current collectionView
    ///   - indexPath: The index of current element displayed
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "ShowGenredMovieSegue", sender: cats[ self.collectionView.dataSourceSectionIndex(forPresentationSectionIndex: indexPath.item)])
        self.collectionView.deselectItem(at: indexPath, animated: true)
    }

    // MARK: Functions
    
    /// Delegate to get the count of element in collection
    /// - Parameters:
    ///   - collectionView: The current CollectionViewController
    ///   - section: The number of item in current section
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cats.count
    }
    /// Get the current cell
    /// - Parameters:
    ///   - collectionView: The current CollectionViewController
    ///   - indexPath: The index of current cell in section collection
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return (collectionView.dequeueReusableCell(withReuseIdentifier: Env.genreCellReuseId, for: indexPath) as! GenreUICollectionViewCell).loadComponent(genre: cats[indexPath.item] )
    }
    
    // MARK: Delegate
    
    /// Comput the size of item element
    /// - Parameters:
    ///   - collectionView: The current CollectionViewController
    ///   - collectionViewLayout: The current layout CollectionViewController
    ///   - indexPath: The index of current cell in section collection
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      let widthPerItem = (view.frame.width - sectionInsets.left * (itemsPerRow + 1)) / itemsPerRow
      return CGSize(width: widthPerItem, height: widthPerItem)
    }
    /// Something used for compute the element size
    /// - Parameters:
    ///   - collectionView: The current CollectionViewController
    ///   - collectionViewLayout: The current layout CollectionViewController
    ///   - section: The number of item in current section
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
      return sectionInsets
    }
    /// Something used for compute the element size to
    /// - Parameters:
    ///   - collectionView: The current CollectionViewController
    ///   - collectionViewLayout: The current layout CollectionViewController
    ///   - section: The number of item in current section
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
      return sectionInsets.left
    }
}
