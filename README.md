# iTunesExamApp
A master-detail application that displays the lists of iTunes tracks from iTunes search API with the specified URL params.

# Chosen dependency for the third-party libraries
Carthage

# Chosen data persistence
NSKeyArchiver
- chose ff. data to persists (for they were the important and usable data in the lifecyle of the app according to the exam's requirements) --> trackId, trackName, trackPrice, currency, artwork, genre, long description, advisory rating (added this as additional info to display)

# Chosen design pattern
MVC
#
Advantage:
- beneficial for apps with simpler user interfaces, controllers need to handle less responsibility
- multiple simultaneous views of the same model
- easy to test as encapsulated by model
- easy to make changes that only affects the user interface
#
Disadvantage:
- Changes to model will require changes to view & controller
- View and Controller are closely coupled
- Possibility of controller to handle bigger responsibility for bigger apps
  


  


