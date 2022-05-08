import SwiftUI

extension MainView {

    func configureView() -> some View {
        var view = self
        let interactor = MainInteractor()
        let presenter = MainPresenter()
        view.interactor = interactor
        interactor.presenter = presenter
        presenter.view = view

        return view
    }
}
