import Combine
import CoreData
import Foundation

struct EmployeeService {

    private var mainContext: NSManagedObjectContext {
        CoreDataStack.shared.managedContext
    }

    private var backgroundContext: NSManagedObjectContext {
        CoreDataStack.shared.backgroundContext
    }

    func storeEmployee(employee: Employee) -> Just<Void> {
        backgroundContext.performAndWait {
            let coreEmployee = CoreEmployee(context: backgroundContext)
            coreEmployee.username = employee.name
            coreEmployee.number = Int64(employee.number)
            try? backgroundContext.save()
        }
        return Just(())
    }

    func deleteEmployee(number: Int) -> AnyPublisher<Void, Never> {
        fetchEmployee(number: number)
            .flatMap { employee -> Just<Void> in
                guard let employee = employee else {
                    return Just(())
                }

                return delete(employee: employee)
            }
            .eraseToAnyPublisher()
    }

    func fetchAllEmployees() -> Just<[Employee]?> {
        var employees: [Employee]?
        backgroundContext.performAndWait {
            let fetchRequest = CoreEmployee.fetchRequest()
            employees = try? backgroundContext.fetch(fetchRequest).map(Employee.init)
        }
        return Just(employees)
    }

    func clear() -> Just<Void> {
        backgroundContext.performAndWait {
            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = CoreEmployee.fetchRequest()
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            _ = try? backgroundContext.execute(deleteRequest)
            try? backgroundContext.save()
        }
        return Just(())
    }

    private func fetchEmployee(number: Int) -> Just<CoreEmployee?> {
        var employee: CoreEmployee?
        backgroundContext.performAndWait {
            let fetchRequest = CoreEmployee.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "number == %i", Int64(number))
            employee = try? backgroundContext.fetch(fetchRequest).first
        }
        return Just(employee)
    }

    private func delete(employee: CoreEmployee) -> Just<Void> {
        backgroundContext.performAndWait {
            backgroundContext.delete(employee)
            try? backgroundContext.save()
        }
        return Just(())
    }
}
