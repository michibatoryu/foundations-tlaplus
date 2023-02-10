---- MODULE subtractiongame ----

EXTENDS Integers

VARIABLES
left, right


SubtractionGame(left, right) ==
left >= 0 /\ right >= 0 /\
IF left = 0 /\ right = 0 THEN
left' = 0 /\ right' = 0
ELSE IF left >= right THEN
left' = left - right /\ right' = 0
ELSE
left' = 0 /\ right' = right - left

(* --initial state of the game-- *)
Init ==
left = 10 /\ right = 5

(* --specification of the game-- *)
Spec ==
Init /\ [][SubtractionGame(left, right)]_<<left, right>>

(* --end of the specification-- *)

END subtractiongame