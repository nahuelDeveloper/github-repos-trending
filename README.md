# github-repos-trending
A single screen app that displays the latest trending repos from Github.

## Description

The app was developed using SwiftUI and Combine. I chose these frameworks because i think they work great together, and are a valid option for MVPs and small apps. I haven't used them in medium or larger projects, so i can't say if they are appropiate options for those cases.

For the app architecture, i chose MVVM. I thinks this architecture works great for MVPs, it allows to have a clear separation of concerns between the View and the business logic, which is encapsulated inside the ViewModel. This makes it easier to write clear, testable and mantainable code.

For networking i chose to implement a Service layer, and encapsulate networking logic in another class called NetworkManager. In my experience this approach works good with MVVM, because we can use Dependency Injection to pass the Service to the ViewModel. I also created a Servicing Protocol that allowed me to have both a MockService with local mock data and an actual Service that fetches data from the API. This allows the ViewModel to be testable, and also to use the app with mock data, which is quite useful while developing or debugging.

I used SPM for third party libraries. It was the first time that i use it, all my work life i have used Cocoapods, and i think it's great. No need for a Podfile, a .xcworkspace, everything is handled via Xcode. I only had an issue while debugging the issue with CoreData, y removed the DerivedData for the project and the libraries disappeared as well. I had to reset package caches to fix it.

## Retro

I didn't have as much time as i would have liked to develop the app, but i think it was enough to have a working app to present and discuss about.

I implemented a test using XCTest, the Skeleton View, and the Lottie animation. There is no way for the user to manually force the API call to fail so the retry screen appears, unless the connectivy is off. Or if the error is forced inside the code.

The code inside the RepoView is a bit larger than i would like. I'm still experimenting with SwiftUI, so i don't have a preference over which way is better to handle complex UIs. I used a RepoRowView, maybe i could have created a RetryView as well, but again, time was short and i didn't want to overcomplicate things.

I was very close, but couldn't implement CoreData persistance. I had all the code ready, but an compiler error appeared and i didn't have enough time to find the solution, so i left that code in a separate branch. I really enjoyed trying to develop this feature, because i got the chance to work with ChatGPT, and it was a very interesting experience. I hadn't used it that much, and i believe that it's a tool that has a lot of potential, both for assisting during development and for learning. I will leave the link with my interactions, just in case: https://chat.openai.com/share/7be74cc3-9a04-4fd4-899a-ebc1c15f43a6.
I used ChatGPT because i'm still learning Combine, and i hadn't used CoreData in a while. It felt like a good opportunity to use it.

Regarding Swift Concurrency, i didn't implement it because i chose to use Combine.

I also didn't implement Dark Mode support due to lack of time, and because i prioritized developing other features.
