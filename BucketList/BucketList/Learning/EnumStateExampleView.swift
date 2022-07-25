//
//  EnumStateExampleView.swift
//  BucketList
//
//  Created by Andy Kayley on 25/07/2022.
//

import SwiftUI

enum LoadingState {
    case loading, success, failed
}

struct LoadingView: View {
    var body: some View {
        Text("Loading...")
    }
}

struct SuccessView: View {
    var body: some View {
        Text("Success!")
    }
}


struct FailedView: View {
    var body: some View {
        Text("Failed!")
    }
}


struct EnumStateExampleView: View {

    @State private var loadingState = LoadingState.loading

    var body: some View {
        switch loadingState {
            case .loading:
                LoadingView()
            case .success:
                SuccessView()
            case .failed:
                FailedView()
        }
    }
}

struct EnumStateExampleView_Previews: PreviewProvider {
    static var previews: some View {
        EnumStateExampleView()
    }
}
