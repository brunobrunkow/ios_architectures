import Foundation

enum Main {
    
    struct DisplayedEmployee {
        var id: String
        var name: String
    }

    enum LoadEmployees {

        struct Request {}

        struct Response {
            var employees: [Employee]
        }

        struct ViewModel {
            var displayedEmployees: [DisplayedEmployee]
        }
    }
    
    enum DeleteEmployee {
        struct Request {
            let id: String
        }
        
        struct Response {
            var employees: [Employee]
        }
        
        struct ViewModel {
            var displayedEmployees: [DisplayedEmployee]
        }
    }
}
