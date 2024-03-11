import Foundation

typealias Cocktail = [CocktailElement]

struct CocktailElement: Decodable {
    
    var ingredients: [String]
    var instructions: String
    var name: String
    
    func fethCategories() {
        return 
    }

}
