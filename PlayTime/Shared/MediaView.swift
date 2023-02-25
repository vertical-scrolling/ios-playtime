//
//  MediaView.swift
//  PlayTime
//
//  Created by Martín Sande on 24/2/23.
//

import PTClient
import Kingfisher
import UIKit

public final class MediaView: UIImageView {
    public var media: Media?

    public func fetch(size: CGSize? = nil,
                      completionHandler: @escaping ((Result<RetrieveImageResult, KingfisherError>) -> Void)) -> DownloadTask? {
        guard let media = media,
              let url = URL(string: media.url) else {
            completionHandler(.failure(KingfisherError.imageSettingError(reason: .emptySource)))
            return nil
        }
        let processor = DownsamplingImageProcessor(size: size ?? bounds.size)
        kf.indicatorType = .activity
        return kf.setImage(
            with: url,
            placeholder: UIImage(named: "medialoadingplaceholder"),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ]) { result in
                completionHandler(result)
        }
    }
}
