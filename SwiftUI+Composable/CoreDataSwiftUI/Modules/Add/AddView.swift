import ComposableArchitecture
import SwiftUI

struct AddView: View {
    @Environment(\.presentationMode) var presentationMode

    var store: Store<AddState, AddAction>

    init(_ store: Store<AddState, AddAction>) {
        self.store = store
    }

    var body: some View {
        WithViewStore(store) { viewStore in
            NavigationView {
                VStack {
                    TextField(
                        "Name",
                        text: viewStore.binding(
                            get: \.name,
                            send: AddAction.nameChanged
                        )
                    )
                    .textFieldStyle(.roundedBorder)
                    .frame(height: 50)

                    TextField(
                        "Number",
                        text: viewStore.binding(
                            get: \.id,
                            send: AddAction.numberChanged
                        )
                    )
                    .textFieldStyle(.roundedBorder)
                    .frame(height: 50)

                    Button("Add") {
                        viewStore.send(.addButtonTapped)
                    }
                    .frame(height: 50)

                    Spacer()
                }
                .onChange(of: viewStore.isPresented) { isPresented in
                    if !isPresented { presentationMode.wrappedValue.dismiss() }
                }
                .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
                .navigationTitle("Add new user")
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {

    static var previews: some View {
        AddView(
            Store(
                initialState: AddState(),
                reducer: addReducer,
                environment: .live
            )
        )
    }
}
