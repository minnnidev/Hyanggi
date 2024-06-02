//
//  Reactive+.swift
//  Hyanggi
//
//  Created by 김민 on 5/29/24.
//

import Foundation
import RxSwift
import RxCocoa

extension Reactive where Base: UIViewController {
    var viewDidLoad: ControlEvent<Void> {
        let source = self.methodInvoked(#selector(Base.viewDidLoad)).map { _ in }
        return ControlEvent(events: source)
    }
}

extension Reactive where Base: UIImageView {
    var tapGesture: Observable<UITapGestureRecognizer> {
        return Observable.create { [weak base] observer in
            guard let imageView = base else {
                observer.on(.completed)
                return Disposables.create()
            }

            imageView.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer()
            imageView.addGestureRecognizer(tapGesture)

            let disposable = tapGesture.rx.event
                .bind(to: observer)

            return Disposables.create {
                imageView.removeGestureRecognizer(tapGesture)
                disposable.dispose()
            }
        }
    }
}
