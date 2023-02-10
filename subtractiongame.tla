---- MODULE subtractiongame ----

EXTENDS Integers

VARIABLES left, right


SubtractionGame(l, r) ==
l >= 0 /\ r >= 0 /\
IF l = 0 /\ r = 0 THEN
l' = 0 /\ r' = 0
ELSE IF l >= r THEN
l' = l - r /\ r' = 0
ELSE
l' = 0 /\ r' = r - l

(* --initial state of the game-- *)
Init ==
left = 10 /\ right = 5

(* --specification of the game-- *)
Spec ==
Init /\ [][SubtractionGame(left, right)]_<<left, right>>

(* --end of the specification-- *)

====================================