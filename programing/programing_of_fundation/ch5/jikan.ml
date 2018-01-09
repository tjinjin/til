(* 目的：時間を受け取ったら午前か午後かを返す *)
(* jikan : int -> str *)
let jikan x =
  if x < 12 then "AM" else "PM"

(* test *)
let test1 = jikan 0 = "AM"
let test2 = jikan 11 = "AM"
let test3 = jikan 12 = "PM"
