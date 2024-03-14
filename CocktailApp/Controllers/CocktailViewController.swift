import UIKit
import SnapKit

class CocktailViewController: UIViewController {
    
    // MARK: - UI
    private let searchController = UISearchController(searchResultsController: nil)
    
    private lazy var mainStackView: UIStackView = {
        let element = UIStackView()
        element.axis = .vertical
        element.distribution = .fillEqually
        element.spacing = 10
        element.alignment = .center
        return element
    }()
    
    private lazy var cocktailName: UILabel = {
        let element = UILabel()
        
        element.font = .systemFont(ofSize: 28)
        element.numberOfLines = 0
        return element
    }()
    
    private lazy var ingredients: UILabel = {
        let element = UILabel()
        
        element.font = .systemFont(ofSize: 24)
        element.numberOfLines = 0
        return element
    }()
    
    private lazy var instructions: UILabel = {
        let element = UILabel()
        
        element.font = .systemFont(ofSize: 24)
        element.numberOfLines = 0
        return element
    }()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupUI()
        setupConstraints()
        setupSearchController()
    }
    
    // MARK: - Private methods
    
    private func fetchCocktailData(for cocktailName: String) async {
        
        guard let urlString = "https://api.api-ninjas.com/v1/cocktail?name=\(cocktailName)".addingPercentEncoding(
            withAllowedCharacters: .urlQueryAllowed
        ),
              let url = URL(string: urlString)
        else { return }
        
        do {
            let cocktailData = try await NetworkManager.shared.retrieveData(from: url)
            DispatchQueue.main.async {
                self.cocktailName.text = cocktailData[0].name
                self.updateIngredientsLabel(with: cocktailData[0].ingredients)
                self.instructions.text = cocktailData[0].instructions
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    private func updateIngredientsLabel(with ingredients: [String]) {
        let ingredientsText = ingredients.joined(separator: "\n")
        DispatchQueue.main.async {self.ingredients.text = ingredientsText}
    }

//
//    private func fetchData(_ cocktailName: String) {
//        NetworkManager.shared.fetchData(cocktailName: cocktailName) { [weak self] result in
//            guard let self = self else { return }
//            switch result {
//            case .success(let data):
//                self.dismissLoadingView()
//                DispatchQueue.main.async {
//                    if !data.isEmpty {
//                        self.cocktailName.text = data[0].name
//                        self.updateIngredientsLabel(with: data[0].ingredients)
//                        self.instructions.text = data[0].instructions
//                    }
//                }
//            case .failure(let error):
//                self.dismissLoadingView()
//                print(error.rawValue)
//            }
//        }
//    }
    
    private func setupUI(){
        view.backgroundColor = .white
        view.addSubview(mainStackView)
        [cocktailName, ingredients, instructions].forEach { mainStackView.addArrangedSubview($0)
        }
    }
    private func setupConstraints(){
        
        mainStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
    }
}

// MARK: - CocktailViewController + UISearchResultsUpdating
extension CocktailViewController: UISearchResultsUpdating {
    
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text,
                         !text.isEmpty
        else { return }
        
        Task {
            await fetchCocktailData(for: text)
                }
//        fetchData(text)
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
}

