// 下标(Subscript)

//subscript(index: Int) -> Int {
//    get {
//        return 1;
//    }
//    
//    set {
//        
//    }
//}

struct TimeTable {
    let multiplier: Int
    subscript(index: Int) -> Int {
        return multiplier * index;
    }
}

let threeTimesTable = TimeTable(multiplier: 3)
print("six times thress is \(threeTimesTable[6])")


var numberOfLegs = ["spider" : 8, "ant" : 6, "cat" : 4]
numberOfLegs["bird"] = 2
print(numberOfLegs)

struct Matrix {
    let rows: Int, columns: Int
    var grid: [Double]
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(count: rows * columns, repeatedValue: 0.0)
    }
    func indexIsValidForRow(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    subscript(row: Int, column: Int) -> Double {
        get {
            assert(indexIsValidForRow(row, column: column), "Index out of range")
            return grid[(row * columns) + column]
        }
        set {
            assert(indexIsValidForRow(row, column: column), "Index out of range")
            grid[(row * columns) + column] = newValue
        }
    }
}

var matrix = Matrix(rows: 2, columns: 2)

matrix[0,1] = 1.5
matrix[1,1] = 2

print(matrix)

