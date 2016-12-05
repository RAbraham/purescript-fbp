# purescript-flow
Functional Event Driven Flow Based Programming

`purescript-flow` is an attempt to understand Bare Metal Flow Based Programming([bmfbp](https://bittarvydas.wordpress.com/)) and build a functional variant of it.

`FBP` is a visual/textual dataflow variant where each process is represented by a box. A `Composite` Box can be composed of more `Composite`boxes and ultimately at the end, we have our `Unit` boxes where we write code to get work done.

Boxes talk to each other by input and output ports connected by wires(implemented by queues)

The benefits of FBP are:
* `Architecture`. FBP is a great way of architecting your application. It's visual and compositional.
* `Components`: Each component can only get data from it's input port and send data on it's output port. It has no clue about where the data comes from and goes to. This makes a component reusable(Ah, the promise of OOP)
* `Concurrency`: No Futures, Promises etc. Concurrency is inbuilt in FBP. Every process can be run in parallel. You just write the code to take data in and write data out.

## bmFBP
`bmFBP` is an event driven variant of `FBP`. The leaf process nodes i.e. the `Unit` are actually state machines. When an event is fired, the `Unit` has to respond according to its state machine.

A constraint of `bmFBP` is no long running processes. This simplifies the scheduler. If a node wants iteration, send a message back to itself.

## purescript-flow
Currently in `bmfbp`, the boxes in the application can have side effects. `purescript-flow` is an attempt to push side effects out of the application, as directives to the interpreter. In this way, we can:
* perform easy unit testing. By having `global` ports where requests for effects are sent, one can direct the interpreter to send back fake data and hence we can test our application. This is an alternative to mock objects.

* By making the effects the responsibility of the interpreter, the hope is that the application is environment independent i.e. it can be just dropped into any environment that supports those effects(e.g browser, server, embedded chips). Each environment has it's own interpreter.

* Stateless `Unit` boxes: Unlike `bmFBP`, where the `Unit` stores its state internally, in `purescript-flow`, `Unit`s have no state. Every Unit will get it's state along with the message fired to it's input port and if it has updated it's state, it has to send it's state along when it finishes execution which it will get back during the next event fired. The interpreter manages state. The idea behind this design is that `Unit`s can be swapped dynamically by the FBP runtime without worrying about lost state and this kind of constraint allows us to run the application possibly on serverless environments like AWS Lambda(which are based on stateless functions)

## Implementation
* Currently, the scheduler will be sequential as I figure out bmFBP.

## References
* [Classical Flow Based Programming](http://jpaulmorrison.com/fbp/). This is different from `bmfbp`.
* [Functional Kahn Process Networks](https://awelonblue.wordpress.com/2016/09/29/kpns-as-an-effects-model/)(Inspiration for the side effects design)
