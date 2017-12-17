(* あらかじめ ex08_3.ml を読み込んでおく必要あり *)
#use "ex08_3.ml"
;;

(* person_t -> string *)
fun person -> match person with
  {name = n; shincho = s; taiju = t; tsuki = ts; hi = h; ketsueki = k} -> n
;;

(* または *)

(* person_t -> string *)
fun {name = n; shincho = s; taiju = t; tsuki = ts; hi = h; ketsueki = k} -> n
