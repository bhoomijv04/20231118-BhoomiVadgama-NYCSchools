//
//  SchoolListView.swift
//  NYC-Schools
//
//  Created by Bhoomi Vadgama on 19/11/23.
//

import SwiftUI
import Combine

public struct SchoolListView: View {
    
    @ObservedObject private var viewModel: SchoolListViewModel
    
    public init(viewModel: SchoolListViewModel) {
        self.viewModel = viewModel
    }
    public var body: some View {
        NavigationView {
            switch viewModel.state {
            case .success:
                NYCSchoolList
            case .noContent:
                NYCLoadingView(isAnimating: true) {
                    $0.hidesWhenStopped = false
                    $0.tintColor = UIColor.blue
                }
            case .error:
                NYCErrorView(title:"generic.error.title".localized,
                             subTitle: "generic.error.description".localized,
                             retryBtnText: "generic.retry.title".localized,
                             imageName: "exclamationmark.triangle") {
                    Task {
                        await viewModel.getNYCSchoolList()
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("home.title".localized)
            case .noInternet:
                NYCErrorView(title:"general.network.error".localized,
                             subTitle: "general.network.error.description".localized,
                             retryBtnText: "generic.retry.title".localized,
                             imageName: "wifi.exclamationmark") {
                    Task {
                        await viewModel.getNYCSchoolList()
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("home.title".localized)
            }
        }
        .task {
            await viewModel.getNYCSchoolList()
        }
    }
    
    private var NYCSchoolList: some View {
        List {
            ForEach(viewModel.search(), id: \.id) { item in
                NavigationLink(destination: {
                    viewModel.coordinator.enqueueRoute(with: .goToDetailsView(viewModel: item), animated: true, completion: nil)
                }){
                    SchoolListViewCell(viewModel: item)
                }
            }
        }.searchable(text: $viewModel.searchString)
        .listStyle(.plain)
        .navigationTitle("home.title".localized)
        .navigationBarTitleDisplayMode(.inline)
        .padding([.bottom], 2)
    }
}
