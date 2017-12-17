(* 目的：整数のリストを受け取ったらリストの長さを返す *)
(* length : int list -> int *)
let rec length lst = match lst with
    [] -> 0
  | first :: rest -> 1 + length rest (* length rest*)

(* test *)
let test1 = length [] = 0
let test2 = length [1] = 1
let test3 = length [1;2;3] = 3
let test4 = length [1;4;3;2;6;8;9;7] = 8
