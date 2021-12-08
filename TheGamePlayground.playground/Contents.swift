
import Foundation
var pattern = [1,2,3,4]
var input = [5,5,5,5]
var close = 0



var dictPatter = [Int:Int]()
for i in pattern{
    dictPatter[i] = (dictPatter[i] ?? 0) + 1
}

//
var dictInput = [Int:Int]()
for i in input{
    dictInput[i] = (dictInput[i] ?? 0) + 1
}

print(dictPatter, dictInput)



for key in dictPatter.keys{

    if dictInput[key] != nil{
        close += min(dictInput[key]!,dictPatter[key]!)
    }
}


print(close)

var exact = Array(zip(pattern,input)).filter{$0.0 == $0.1}.count

print(exact)


print([exact, close-exact])




var lines : [Int] = [
    1,2,3,4
]

var count = 0

func running()->[Int]{
    lines[count] = 0
    count+=1
    return lines

}

running()
running()
running()

print(lines)


func reset()->[Int]{
    count = 0
    lines = [1,2,3,4]
    return lines
}

reset()
//running()


print(lines)
