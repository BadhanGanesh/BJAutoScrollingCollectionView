# BJAutoScrollingCollectionView
A very simple UICollectionView subclass which auto scrolls cells with single line of code

![Auto Scroll Demo](https://media.giphy.com/media/xULW8tb7b1ncOjf1Ju/giphy.gif)


## Usage

- Drag and Drop the **BJAutoScrollingCollectionView.swift** file (Located inside the Source folder) into your Xcode project.

- Make your collection view an instance of `BJAutoScrollingCollectionView`

```swift
@IBOutlet weak var collectionView: BJAutoScrollingCollectionView!
```


- Set the desired `scrollInterval` property. (Default is 3 seconds)

```swift
self.collectionView.scrollInterval = 2
```


- Whenever you are ready, call `startScrolling` method to start the auto-scrolling:

```swift
@IBAction func startScrollingButtonTapped(_ sender: Any) {
    self.collectionView.startScrolling()
}
```


- You can also scroll to previous or next cell by calling `scrollToPreviousOrNextCell` method by supplying a direction parameter (**Left** or **Right**):

```swift
@IBAction func nextButtonTapped(_ sender: Any) {
    self.collectionView.scrollToPreviousOrNextCell(direction: .right)
}
```

## License

This code is distributed under the terms and conditions of the [MIT license](LICENSE).
