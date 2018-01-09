
(* 目的 : 整数のリストを受け取り偶数のみを抽出する *)
(* filter_even : int list -> int list *)
let filter_even lst =
  (* 目的：数字が偶数であるか判定する *)
  (* is_even : int -> bool *)
  let is_even n = n mod 2 == 0
  in List.filter is_even lst

(* test *)
let test1 = filter_even [] = []
let test2 = filter_even [1] = []
let test3 = filter_even [1; 2; 3] = [2]
let test4 = filter_even [1; 2; 3; 4] = [2; 4]
