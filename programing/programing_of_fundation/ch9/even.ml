(* 目的 : 整数のリストを受け取り偶数のみを抽出する *)
(* even : int list -> int list *)
let rec even lst = match lst with
    [] -> []
  | first :: rest ->
      if first mod 2 == 0
      then first :: even rest
      else even rest

(* test *)
let test1 = even [] = []
let test2 = even [1] = []
let test3 = even [1; 2; 3] = [2]
let test4 = even [1; 2; 3; 4] = [2; 4]
let test5 = even [2; 1; 6; 4; 7] = [2; 6; 4]
