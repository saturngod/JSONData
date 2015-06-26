Only for NSDictionary , NSArray

```swift
var response:NSDictionary = ["Hello" : ["World" : "Data"]]
println(JSONData(response).get("Hello.World"))

response = ["Hello" : [["A":"B"],["C":"D"]]]
println(JSONData(response).get("Hello.0.A"))

var sampleArr:NSArray = [["A":"B"],["C":"D"]]
var json = JSONData(sampleArr)
println(json.get("0"))
println(json.get("1.C"))

```

**if Key name include dot (.) , it will not working**