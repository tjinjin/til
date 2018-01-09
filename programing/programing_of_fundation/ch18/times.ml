(* 0が見つかったことを示例外 *)
exception Zero

(* 目的：lst 中の整数をすべてかけ合わせる *)
(* times : int list -> int *)
let times lst =
  let rec hojo lst = match lst with
    [] -> 1
  | first :: rest ->
      if first = 0 then raise Zero
                   else first * hojo rest
  in try
        hojo lst
    with Zero -> 0

(*test*)
let test1 = times [1;2;3;4] = 24
let test2 = times [0;2;3;4] = 0
