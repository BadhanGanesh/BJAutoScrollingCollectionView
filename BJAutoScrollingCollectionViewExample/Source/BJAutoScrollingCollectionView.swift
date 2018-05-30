//
//  BJAutoScrollingCollectionView
//  Created by Badhan Ganesh on 14-01-2018
//

// This code is distributed under the terms and conditions of the MIT license.

// Copyright © 2018 Badhan Ganesh
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.


import UIKit

enum BJAutoScrollingCollectionViewScrollDirection: String {
    case left = "left"
    case right = "right"
}

/**BJAutoScrollingCollectionView is a simple UICollectionView subclass which will automatically scroll cells of the collection view in specified time intervals. Just make your collection view an instance of BJAutoScrollingCollectionView and call the startScrolling method to start auto-scrolling.
 * Make sure you set your custom collection view cell's frame size equal to your collection view frame size. There should be only one visible cell in your collection view at a time.
 * Paging is enabled by default even if you did not enable it.
 */
class BJAutoScrollingCollectionView: UICollectionView {
    
    ///////////////////////////////////////////////////////////////////
    //MARK:- Properties
    //MARK:-
    
    private var timer = Timer()
    
    /**
     * The time interval between each scroll in collection view. 3 seconds is the default interval.
     */
    var scrollInterval: Int = 3
    
    
    
    ///////////////////////////////////////////////////////////////////
    //MARK:- Methods
    //MARK:-
    
    deinit { stopScrolling() }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.isPagingEnabled = true
    }
    
    fileprivate func setTimer() {
        self.timer = Timer.scheduledTimer(timeInterval: TimeInterval(scrollInterval), target: self, selector: #selector(self.autoScrollImageSlider), userInfo: nil, repeats: true)
        RunLoop.main.add(self.timer, forMode: .commonModes)
    }
    
    /**
     * Starts scrolling the collection view if there is at least one item in the datsource.
     */
    func startScrolling() {
        if !timer.isValid {
            if self.numberOfItems(inSection: 0) != 0 {
                stopScrolling()
                setTimer()
            }
        }
    }
    
    func stopScrolling() { if timer.isValid { self.timer.invalidate() } }
    
    @objc fileprivate func autoScrollImageSlider() {
        DispatchQueue.main.async {
            let firstIndex = 0
            let lastIndex = self.numberOfItems(inSection: 0) - 1
            let visibleCellsIndexes = self.indexPathsForVisibleItems.sorted()
            
            if !visibleCellsIndexes.isEmpty {
                let nextIndex = visibleCellsIndexes[0].row + 1
                let nextIndexPath: IndexPath = IndexPath.init(item: nextIndex, section: 0)
                let firstIndexPath: IndexPath = IndexPath.init(item: firstIndex, section: 0)
                
                (nextIndex > lastIndex) ? (self.scrollToItem(at: firstIndexPath, at: .centeredHorizontally, animated: true)) : (self.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true))
            }
        }
    }
    
    func scrollToPreviousOrNextCell(direction: BJAutoScrollingCollectionViewScrollDirection) {
        DispatchQueue.main.async {
            let firstIndex = 0
            let lastIndex = self.numberOfItems(inSection: 0) - 1
            let visibleCellsIndexes = self.indexPathsForVisibleItems.sorted()
            
            if !visibleCellsIndexes.isEmpty {
                let nextIndex = visibleCellsIndexes[0].row + 1
                let previousIndex = visibleCellsIndexes[0].row - 1
                let nextIndexPath: IndexPath = IndexPath.init(item: nextIndex, section: 0)
                let previousIndexPath: IndexPath = IndexPath.init(item: previousIndex, section: 0)
                
                switch direction {
                case .left:
                    (previousIndex < firstIndex) ? self.doNothing() : self.scrollToItem(at: previousIndexPath, at: .centeredHorizontally, animated: true)
                    break
                case .right:
                    (nextIndex > lastIndex) ? self.doNothing() : self.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true)
                    break
                }
            }
        }
    }
    
    private func doNothing() { }
}
