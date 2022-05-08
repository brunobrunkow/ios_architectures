import Combine
import ComposableArchitecture
import SwiftUI

struct MainView: View {

    var store: Store<MainState, MainAction>

    init(_ store: Store<MainState, MainAction>) {
        self.store = store
    }

    var body: some View {
        NavigationView {
            WithViewStore(store) { viewStore in
                ZStack {
                    List {
                        ForEach(viewStore.employees) { employee in
                            Text(employee.name)
                        }
                        .onDelete(perform: { indexSet in
                            for index in indexSet {
                                viewStore.send(.deleteEmployee(viewStore.employees[index]))
                            }
                        })
                    }
                }
                .onAppear { viewStore.send(.onAppear) }
                .navigationTitle("Employees")
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarLeading) {
                        Button("Clear") {
                            viewStore.send(.clearButtonTapped)
                        }
                        .tint(Color.black)
                    }
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        Button {
                            viewStore.send(.plusButtonTapped)
                        } label: {
                            Image(systemName: "plus")
                        }
                        .tint(Color.black)
                    }
                }
                .sheet(
                    isPresented: viewStore
                        .binding(
                            get: { $0.presentAddView },
                            send: .addViewDismissed
                        )
                ) {
                    AddView(
                        Store(
                            initialState: AddState(),
                            reducer: addReducer,
                            environment: AddEnvironment.live
                        )
                    )
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct MainView_Previews: PreviewProvider {

    static var previews: some View {
        MainView(
            Store(
                initialState: MainState(),
                reducer: mainReducer,
                environment: .preview
            )
        )
    }
}

extension Array where Element == Employee {

    static func mocks(count: Int) -> Array {
        (1...count).map {
            Employee(id: $0, name: "Employee \($0)")
        }
    }
}
