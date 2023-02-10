---- MODULE stack ----

LOCAL INSTANCE Sequences
LOCAL INSTANCE Integers
CONSTANT StackType
VARIABLE stack

Init == stack \in Seq(StackType)

Push(x) == 
  stack' = Append(stack, x)

Pop == 
  stack' = SubSeq(stack, 1, Len(stack)-1)
 
Next == 
  \/ Pop
  \/ \E x \in StackType:
     Push(x)

Spec == Init /\ [][Next]_stack  

===================