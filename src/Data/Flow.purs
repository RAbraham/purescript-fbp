module Flow where
-- A Flow application is a Component and its state. A Component has data coming in via named input ports and data flowing out via named output ports. Inside a Component, we can have other Components. Such a high level component is called a Composite. The Composite by itself does not contain any computation. It just connects other components via wires which indicate how the data flows between Components. Ultimately, a Composite breaks down into Leaf Components. A Leaf Component is where the actual computation takes place. These Components connected by wires can also be seen as a tree of Nodes. I may refer to a Component as Node interchangeably.

data Component = Composite | Leaf

-- A Leaf Component is a state machine. Upstream Components notify the Leaf component by sending messages to the leaf's input ports. A message is both the notification of an event happening and data associated with an event. The message i.e the event can cause state transitions within the Leaf.

-- A Leaf is a pure function. If a Leaf needs state, it stores the state with the Flow runtime. When a message arrives, the Flow runtime will pass in the leaf's previous state.


-- The Flow runtime manages the following for each component a) one input queue b) one output queue. Even if a component has multiple input ports, all the messages for these ports are held in one queue. The same for it's output ports.
