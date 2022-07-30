//
//  CatDisplayView.swift
//  Catet
//
//  Created by Ryan Vieri Kwa on 27/07/22.
//

import SwiftUI

struct CatDisplayView: View {
    var catGalleryData: CatGalleryEntity
    @StateObject var imageLoader: ImageLoader
    var body: some View {
        VStack{
            if imageLoader.isLoadingImage{
                ProgressView()
            }
            else {
                if let imageLoader = imageLoader.image {
                    Image(uiImage: imageLoader)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 120, height: 120, alignment: .center)
                        .clipped()
                    Text("\(catGalleryData.wrappedGoalCompleted)")
                        .font(.system(size: 20))
                        .bold()
                        .padding(.vertical, 2)
                    Text("\(Helper.dateToString(date: catGalleryData.wrappedDateFinished, format: "dd/MM/yyyy"))")
                }
            }
        }
    }
}

struct CatDisplayView_Previews: PreviewProvider {
    static var previews: some View {
        CatDisplayView(catGalleryData: CatGalleryEntity(), imageLoader: ImageLoader(url: "")).previewLayout(.fixed(width: 200, height: 200))
    }
}
