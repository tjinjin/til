(* 目的: 自然数 m ,nの最大公約数を求める*)
(* int -> int -> int *)
let rec gcd m n =
  if n = 0
  then m
  else gcd n (m mod n)


(* test *)
let test1 = gcd 1649 221 = 17
