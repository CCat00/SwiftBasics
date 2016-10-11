/**
 Type Casting(类型转换)
 */

// 定义一个类层次作为例子

class MediaItem {
    var name: String
    init(name: String) {
        self.name = name;
    }
}

class Movie: MediaItem {
    var director: String
    init(director: String, name: String) {
        self.director = director;
        super.init(name: name)
    }
}

class Song: MediaItem {
    var artist : String
    init(artist: String, name: String) {
        self.artist = artist
        super.init(name: name)
    }
}

let library = [
    Movie.init(director: "史泰龙", name: "第一滴血"),
    Song.init(artist: "张杰", name: "天下"),
    Song.init(artist: "林俊杰", name: "关键词"),
    Song.init(artist: "JJ", name: "杀手"),
]

// 检查类型（Checking Type）`is`

var moviecount = 0;
var songcount = 0;

for item in library {
    if item is Movie {
        moviecount += 1
    } else if item is Song {
        songcount += 1
    }
}

// 向下转型 (Downcasting) `as?` `as!`

for item in library {
    if let item = item as? Movie {
        print("this is a movie. It's name is \(item.name), director is \(item.director)")
    } else if let item = item as? Song {
        print("this is a song. It's name is \(item.name), artist is \(item.artist)")
    }
}

// Any 和 AnyObject
// AnyObject 表示任何实例
// Any表示任何类型，包括函数类型

let someObjects: [AnyObject] = [
    Movie.init(director: "2", name: "2")
]

for object in someObjects {
    let obj = object as! Movie
    print("obf \(obj.director)")
}

for obj in someObjects as! [Movie] {
    print("obj \(obj.director)")
}


var things = [Any]()

let errorCode: (Int, String)
errorCode = (404, "Not found")

print(errorCode.0, errorCode.1)

things.append((403, "error"))
things.append(0)
things.append(0.0)
things.append(42)
things.append(3.14159)
things.append("hello")
things.append((3.0, 5.0))
things.append(Movie.init(director: "23", name: "3"))
things.append({
    (name: String) -> String in
        return "hello, \(name)"
})
print(things)

for thing in things {
    switch thing {
    case 0 as Int:
        print("zero as an Int")
    case 0 as Double:
        print("zero as a Double")
    case let someInt as Int:
        print("an integer value of \(someInt)")
    case let someDouble as Double where someDouble > 0:
        print("a positive double value of \(someDouble)")
    case is Double:
        print("some other double value that I don't want to print")
    case let someString as String:
        print("a string value of \"\(someString)\"")
    case let (x, y) as (Double, Double):
        print("an (x, y) point at \(x), \(y)")
    case let movie as Movie:
        print("a movie called '\(movie.name)', dir. \(movie.director)")
    case let stringConverter as (String) -> String:
        print(stringConverter("Michael"))
    default:
        print("something else")
    }
}

