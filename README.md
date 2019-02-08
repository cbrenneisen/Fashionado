# Overview
This is a single scene application. There is a View Controller with a scroll view inside of it, which in turn contains multiple embedded View Controllers (which correspond to the endpoints given). The user can swipe between these to look at Table Views of different data.

## Architecture
The containing View Controller (the one with the scroll view) uses MVVM. The View Model tracks what page the user is currently looking at. This View controller will pass the desired content types (Articles and Search Items) into the Scroll View, which will in turn load the appropriate View Controllers.
The embedded View Controllers (the ones inside the scroll view) use a derivation of VIPER. There is a Content Service which acts as a worker object and does the fetching and parsing from the API. This is owned by the Interactor which keeps track of whether the Content Service is currently loading and whether there are additional pages of information to fetch. This in turn is owned by a Presenter, which formats the data from the Interactor. Lastly, the presenter is owned by the View Controller, which binds the Table View to the data in the presenter. All of these components employ generics for maximum reusability - they require a specific kind of data object to be declared.

## Testing
Currently there is only one test case, but it serves as an example of how I would do further testing. This case involves injecting a mock service class (which never returns any data) and testing the Content Interactor appropriately. More robust testing would have service objects with significant fake data.

## Libraries

#### RXSWIFT / RXCOCOA
For data binding, speed of development, and other nice functions. I find that this complements both MVVM and VIPER quite nicely
#### KINGFISHER
For image downloading. There are a few edge cases to consider when displaying images in a Table View or Collection View... While I have worked on this problem in the past I chose to focus on the rest of the architecture.
