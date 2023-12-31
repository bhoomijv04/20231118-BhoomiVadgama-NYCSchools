//
//  SchoolDetailViewCoordinator.swift
//  NYC-Schools
//
//  Created by Bhoomi Vadgama on 19/11/23.
//

import Foundation
import SwiftUI

final class SchoolDetailViewCoordinator: SwiftUIEnqueueCoordinator {
    
    typealias EnqueueContextType = SchoolDetailViewModel.RouteType
    
    weak var rootHostingController: UIHostingController<SchoolDetailView>?
    
    func instantiateView(school: SchoolListCellViewModel) -> SchoolDetailView {
        let viewModel = SchoolDetailViewModel(coordinator: self, schoolModel: school)
        let rootView = SchoolDetailView(viewModel: viewModel)
        return rootView
    }
    
    func enqueueRoute(with context: SchoolDetailViewModel.RouteType, animated: Bool, completion: ((Bool) -> Void)?) -> AnyView? {
        return nil
    }
}
