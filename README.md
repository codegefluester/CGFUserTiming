CGFUserTiming
===
A small and handy library to meassure how long it takes your users to complete certain tasks

## Example

```objc
// Start a new timing session
[[CGFUserTiming sharedInstance] startTimingForAction:@"compose_message" userInfo:nil];

// ... user is doing stuff ...

// User finished the task
[[CGFUserTiming sharedInstance] stopTimingForAction:@"compose_message"];

```

## Dispatching timings
For simplicity I did not add any code that posts the recorded timings to an URL or writes them to a file, I totally leave this to you. Simply create a subclass of `CGFUserTiming` and overwrite the `dispatchTimings` method to suit your needs.
