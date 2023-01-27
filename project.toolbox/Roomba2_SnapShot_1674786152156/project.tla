------------------------------ MODULE project ------------------------------
EXTENDS Sequences

Sigma == {"s", \* Start Clean
          "b", \* Bump
          "l", \* Low battery
          "c", \* Caught
          "o", \* Out of battery
          "t", \* Turn 90*
          "r"} \* Reach home
          

Q == {"charging", "moving", "turning", "stuck", "ret_moving", "ret_turning", "dead"}

VARIABLE qcur, str
CONSTANT init_str

Init == /\ qcur = "charging"
        /\ str = init_str

Delta[q \in Q, c \in Sigma] ==
    IF      <<q,c>> = <<"charging", "s">> THEN "moving"
    ELSE IF <<q,c>> = <<"charging", "b">> THEN "charging"
    ELSE IF <<q,c>> = <<"charging", "l">> THEN "charging"
    ELSE IF <<q,c>> = <<"charging", "c">> THEN "stuck"
    ELSE IF <<q,c>> = <<"charging", "o">> THEN "charging"
    ELSE IF <<q,c>> = <<"charging", "t">> THEN "ret_moving"
    ELSE IF <<q,c>> = <<"charging", "r">> THEN "charging"
    ELSE IF <<q,c>> = <<"moving", "s">> THEN "moving"
    ELSE IF <<q,c>> = <<"moving", "b">> THEN "turning"
    ELSE IF <<q,c>> = <<"moving", "l">> THEN "ret_moving"
    ELSE IF <<q,c>> = <<"moving", "c">> THEN "stuck"
    ELSE IF <<q,c>> = <<"moving", "o">> THEN "dead"
    ELSE IF <<q,c>> = <<"moving", "t">> THEN "moving"
    ELSE IF <<q,c>> = <<"moving", "r">> THEN "turning" \* (Or moving)
    ELSE IF <<q,c>> = <<"turning", "s">> THEN "turning"
    ELSE IF <<q,c>> = <<"turning", "b">> THEN "turning"
    ELSE IF <<q,c>> = <<"turning", "l">> THEN "ret_moving"
    ELSE IF <<q,c>> = <<"turning", "c">> THEN "stuck"
    ELSE IF <<q,c>> = <<"turning", "o">> THEN "dead"
    ELSE IF <<q,c>> = <<"turning", "t">> THEN "moving"
    ELSE IF <<q,c>> = <<"turning", "r">> THEN "turning" \* (Or moving)
    ELSE IF <<q,c>> = <<"ret_moving", "s">> THEN "moving"
    ELSE IF <<q,c>> = <<"ret_moving", "b">> THEN "ret_turning"
    ELSE IF <<q,c>> = <<"ret_moving", "l">> THEN "ret_moving"
    ELSE IF <<q,c>> = <<"ret_moving", "c">> THEN "stuck"
    ELSE IF <<q,c>> = <<"ret_moving", "o">> THEN "dead"
    ELSE IF <<q,c>> = <<"ret_moving", "t">> THEN "ret_moving"
    ELSE IF <<q,c>> = <<"ret_moving", "r">> THEN "charging" \* (Or moving)
    ELSE IF <<q,c>> = <<"ret_turning", "s">> THEN "turning"
    ELSE IF <<q,c>> = <<"ret_turning", "b">> THEN "ret_turning"
    ELSE IF <<q,c>> = <<"ret_turning", "l">> THEN "ret_turning"
    ELSE IF <<q,c>> = <<"ret_turning", "c">> THEN "stuck"
    ELSE IF <<q,c>> = <<"ret_turning", "o">> THEN "dead"
    ELSE IF <<q,c>> = <<"ret_turning", "t">> THEN "ret_moving"
    ELSE IF <<q,c>> = <<"ret_turning", "r">> THEN "charging" \* (Or moving)
    ELSE IF <<q,c>> = <<"stuck", "o">> THEN "dead"
    ELSE IF q = "stuck" THEN "stuck"
    ELSE IF q = "dead" THEN "dead"
    ELSE ""

Accept == {"charging", "moving", "turning", "ret_moving", "ret_turning"}

Next == 
IF str = <<>> THEN
 qcur \in Accept /\ qcur' = qcur /\ str' = str
ELSE 
  /\ qcur' = Delta[qcur,str[1]]
  /\ str'  = Tail(str)

Spec == Init /\ [][Next]_<<qcur,str>>

=============================================================================
\* Modification History
\* Last modified Thu Jan 26 21:22:24 EST 2023 by bcspe
\* Created Thu Jan 19 19:40:26 EST 2023 by michi
