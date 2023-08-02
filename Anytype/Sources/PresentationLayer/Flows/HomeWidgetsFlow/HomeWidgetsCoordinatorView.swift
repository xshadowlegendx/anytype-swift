import Foundation
import SwiftUI

struct HomeWidgetsCoordinatorView: View {
    
    @StateObject var model: HomeWidgetsCoordinatorViewModel
    
    var body: some View {
        model.homeWidgetsModule()
        .onAppear {
            model.onAppear()
        }
        .sheet(item: $model.showChangeSourceData) { data in
            model.changeSourceModule(data: data)
        }
        .sheet(item: $model.showChangeTypeData) { data in
            model.changeTypeModule(data: data)
        }
        .sheet(item: $model.showSearchData) { data in
            model.searchModule(data: data)
        }
        .sheet(item: $model.createWidgetData) { data in
            model.createWidgetModule(data: data)
        }
    }
}
