# GiphySearch

GiphySearch is an iOS application built using Swift 5 on XCode 12.2 for all devices running on iOS 13.0 or higher.

MVVM architecture is used to develop "GiphySearch".

The purpose of this the application is retrieving and displaying gifs in a table view and on marking as favorite displaying in the collection view while keeping the CoreData DB and the data displayed correclty synced using a 'CoreDataManager' wrapper to insert, update and remove data.

Libraries used :
- Alamofire : Used for request calling and retrieving data from backend's side using Giphy's API
- FLAnimatedImage : Used for creating an image view that supports GIFs
- SDWebImageFLPlugin : Used for loading GIFs inside 'FLAnimatedImage'

Some test cases were added to check the favorite/unfavorite flow and the API calls responsiveness and results.

In order to run the application just clone the repository and run it on any simulator or device.
