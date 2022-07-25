//
//  DocumentsDirectoryExampleView.swift
//  BucketList
//
//  Created by Andy Kayley on 25/07/2022.
//

import SwiftUI

struct DocumentsDirectoryExampleView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onTapGesture {
                let str = "Test Message"
                let url = getDocumentsDirectory().appendingPathComponent("message.txt")

                do {
                    try str.write(to: url, atomically: true, encoding: .utf8)

                    let input = try String(contentsOf: url)
                    print(input)
                } catch {
                    print(error.localizedDescription)
                }
            }
    }

    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

struct DocumentsDirectoryExampleView_Previews: PreviewProvider {
    static var previews: some View {
        DocumentsDirectoryExampleView()
    }
}
