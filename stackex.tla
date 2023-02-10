---- MODULE stackex ----

EXTENDS Integers, Sequences, TLC
VARIABLES seq

vars == {"x", "y"}
Stack == INSTANCE stack WITH stack <- seq, StackType <- vars
Range(f) == {f[x] : x \in DOMAIN f}

Init == seq = <<>>

Next ==
  \/ /\ seq # <<>>
     /\ Stack!Pop
  \/ \E w \in vars:
     /\ w \notin Range(seq)
     /\ Stack!Push(w)
  
Spec == Init /\ [][Next]_seq

Refinement == Stack!Spec
====