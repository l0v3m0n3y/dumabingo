# dumabingo
web-api for dumabingo.org Интерактивная карта лоббистских возможностей депутатов Государственной Думы РФ 8 созыва: лоббистские группы, законопроекты и персоналии.
# main
```swift
import Foundation
import dumabingo

let duma = dumaBingo()
let lawInfo = try await duma.getLawById(lawId: 391)
print(lawInfo)
```

# Launch (your script)
```
swift run
```
