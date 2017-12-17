(* 目的：名前と成績を受け取って整形して出力する *)
(* (string * int) -> string*)
let seiseki pair = match pair with
  (a, b) -> a ^ "の得点は" ^ b ^ "点だ"

(* test *)
let test1 = seiseki("山田", "50") = "山田の得点は50点だ"
