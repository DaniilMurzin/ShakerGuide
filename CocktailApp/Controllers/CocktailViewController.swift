import UIKit
import SnapKit

class CocktailViewController: UIViewController {

    // MARK: - Properties
    private var cocktails = ["Vodka", "Pivo"]
    private var filteredCocktails = [String]()
    private var isFiltering: Bool {
        searchController.isActive && !searchBarIsNotEmpty
    }
    private var searchBarIsNotEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false}
        return text.isEmpty
    }
    
    // MARK: - UI
    private let searchController = UISearchController(searchResultsController: nil)
    
    private lazy var tableView: UITableView = {
        let element = UITableView()
        element.delegate = self
        element.dataSource = self
        return element
    }()
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
        setupUI()
        setupConstraints()
        setupSearchController()
    }
    
    // MARK: - Private methods
    private func setupUI(){
        view.addSubview(tableView)
        
    }
    private func setupConstraints(){
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - CocktailViewController + UISearchResultsUpdating
extension CocktailViewController: UISearchResultsUpdating {
    
    
    func updateSearchResults(for searchController: UISearchController) {
        filteredContentForSearchText(searchController.searchBar.text!)
    }
    
    private func setupSearchController() {
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation
        = false
        searchController.searchBar.placeholder = "Введите цитату"
        navigationItem.hidesSearchBarWhenScrolling  = false
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func filteredContentForSearchText(_ searchText: String ) {
        
        filteredCocktails = cocktails.filter({ cocktail in
            cocktail.lowercased().contains(searchText.lowercased())
        })
        
        tableView.reloadData()
    }
}

// MARK: - CocktailViewController + UITableViewDelegate
extension CocktailViewController: UITableViewDelegate {
    
}

// MARK: - CocktailViewController + UITableViewDataSource
extension CocktailViewController: UITableViewDataSource {
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        
        if isFiltering {
            return filteredCocktails.count
        }
        return cocktails.count
    }

    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        let cocktail: String
        
        if isFiltering {
            cocktail =  filteredCocktails[indexPath.row]
        } else {
            cocktail = cocktails[indexPath.row]
        }
        
        cell.textLabel?.text = cocktail
        return cell
    }
}


