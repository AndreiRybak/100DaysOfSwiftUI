//
//  EditView.swift
//  BucketList
//
//  Created by Andrei Rybak on 28.07.22.
//

import SwiftUI

struct EditView: View {

    @StateObject private var viewModel: EditView.ViewModel
    
    @Environment(\.dismiss) var dismiss
    var onSave: (Location) -> Void
    
    @State private var name: String
    @State private var description: String
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Place name", text: $name)
                    TextField("Description", text: $description)
                }
                
                Section("Nearby...") {
                    switch viewModel.loadingState {
                    case .loading:
                        Text("Loading...")
                    case .loaded:
                        ForEach(viewModel.pages, id: \.pageid) { page in
                            Text(page.title)
                                .font(.headline)
                            + Text(": ")
                            + Text(page.description)
                                .italic()
                        }
                    case .failed:
                        Text("Please try again later.")
                    }
                }
            }
            .navigationTitle("Place details")
            .toolbar {
                Button("Save") {
                    var newLocation = viewModel.location
                    newLocation.id = UUID()
                    newLocation.name = name
                    newLocation.description = description
                    onSave(newLocation)
                    dismiss()
                }
            }
            .task {
                await viewModel.fetchNearbyPlaces()
            }
        }
    }
    
    init(viewModel: EditView.ViewModel, onSave: @escaping (Location) -> Void) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.onSave = onSave
        _name = State(initialValue: viewModel.location.name)
        _description = State(initialValue: viewModel.location.description)
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(viewModel: EditView.ViewModel(location: Location.example)) { _ in }
    }
}
