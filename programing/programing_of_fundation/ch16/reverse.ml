(* 目的：与えられたリストを逆順にして返す *)
(* reverse : 'a list -> 'a list *)
let reverse lst =
  (* 目的：（lstの逆順のリスト) @ resultを返す *)
  (* ここでresultはこれまでの要素を逆順にしたリストを示す *)
  let rec rev lst result = match lst with
      [] -> result
    | first :: rest ->
        rev rest (first :: result)
  in rev lst []

(*test*)
let test1 = reverse [5;4;3;2;1] = [1;2;3;4;5]
