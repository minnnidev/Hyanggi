//
//  ComposeViewModel.swift
//  Hyanggi
//
//  Created by 김민 on 5/14/24.
//

import Foundation
import RxSwift
import RxCocoa

final class ComposeViewModel: ViewModelType {
    private var perfume: Perfume?
    let storage: PerfumeStorageType

    let updatedPerfume = PublishSubject<Perfume>()
    private let disposeBag = DisposeBag()

    init(perfume: Perfume? = nil,
         storage: PerfumeStorageType) {
        self.perfume = perfume
        self.storage = storage
    }

    struct Input {
        let dateText: Observable<String>
        let brandNameText: Observable<String>
        let perfumeNameText: Observable<String>
        let contentText: Observable<String>
        let sentenceText: Observable<String>
        let dismissButtonTap: ControlEvent<Void>
        let completeButtonTap: ControlEvent<Void>
        let selectImage: Observable<UIImage?>
    }

    struct Output {
        let isFormValid: Observable<Bool>
        let dismissToPrevious: Observable<Void>
        let initialPerfume: Observable<Perfume?>
        let selectedImage: Observable<UIImage?>
    }

    func transform(input: Input) -> Output {
        let initialPerfume = Observable.just(perfume)

        let isFormValid = Observable
            .combineLatest(input.brandNameText,
                           input.perfumeNameText,
                           input.sentenceText)
            .map { !$0.isEmpty && !$1.isEmpty && !$2.isEmpty }

        let dismissToPrevious = Observable
            .merge(input.dismissButtonTap.asObservable(), input.completeButtonTap.asObservable())

        let completeHandler = input.completeButtonTap
            .withLatestFrom(Observable.combineLatest(input.dateText,
                                                     input.brandNameText,
                                                     input.perfumeNameText,
                                                     input.contentText,
                                                     input.sentenceText,
                                                     input.selectImage.startWith(nil)))
            .map { [weak self] date, brandName, perfumeName, content, sentence, selectedImage in
                var imagePath: String? = nil

                if let perfume = self?.perfume {
                    if let image = selectedImage {
                        let imageName = "\(perfume.id.uuidString)"
                        ImageFileManager.shared.saveImage(image: image, imageName: imageName)
                        imagePath = imageName
                    }

                    return Perfume(id: perfume.id,
                                   photoId: imagePath,
                                   date: date.isEmpty ? perfume.date : date,
                                   brandName: brandName.isEmpty ? perfume.brandName : brandName,
                                   perfumeName: perfumeName.isEmpty ? perfume.perfumeName : perfumeName,
                                   content: content.isEmpty ? perfume.content : content,
                                   sentence: sentence.isEmpty ? perfume.sentence : sentence
                                   ,
                                   isLiked: perfume.isLiked)
                } else {
                    let id = UUID()
                    if let image = selectedImage {
                        let imageName = "\(id.uuidString)"
                        ImageFileManager.shared.saveImage(image: image, imageName: "\(id.uuidString)")
                        imagePath = imageName
                    }

                    return Perfume(id: id,
                                   photoId: imagePath,
                                   date: date,
                                   brandName: brandName,
                                   perfumeName: perfumeName,
                                   content: content,
                                   sentence: sentence,
                                   isLiked: false)
                }
            }

        completeHandler
            .withUnretained(self)
            .subscribe(onNext: { vm, composedPerfume in
                if vm.perfume != nil {
                    vm.updatePerfume(composedPerfume)
                } else {
                    vm.createPerfume(composedPerfume)
                }
            })
            .disposed(by: disposeBag)

        let selectImage = input.selectImage

        return Output(
            isFormValid: isFormValid,
            dismissToPrevious: dismissToPrevious, 
            initialPerfume: initialPerfume,
            selectedImage: selectImage
        )
    }

    func createPerfume(_ perfume: Perfume) {
        _ = storage
            .createPerfume(perfume)
    }

    func updatePerfume(_ perfume: Perfume) {
        _ = storage
            .updatePerfume(perfume.id, perfume)
            .bind(to: updatedPerfume)
    }
}