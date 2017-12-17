(* purpose : 現在の気温から快適度を判定する*)
(* int -> string *)
let kion t =
  if kaiteki t then "comfortable"
               else "normal"

(* test *)
let test1 = kion 7 = "normal"
let test2 = kion 15 = "comfortable"
let test3 = kion 20 = "comfortable"
let test4 = kion 25 = "comfortable"
let test5 = kion 28 = "normal"

(* purpose : 受け取った値が15 <= 25 かチェックする*)
(* kaiteki : int -> bool *)
let kaiteki t =
  15 <= t && t <= 25

(* test *)
let test1 = kaiteki 7  = false
let test2 = kaiteki 15 = true
let test3 = kaiteki 20 = true
let test4 = kaiteki 25 = true
let test5 = kaiteki 28 = false
