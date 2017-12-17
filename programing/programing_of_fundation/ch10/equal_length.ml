(* 目的: ふたつのリストを受け取り長さが同じか判定する *)
(* equal_length : 'a list -> 'a list -> bool *)
let rec equal_length lst1 lst2 = match (lst1, lst2) with
    ([], []) -> true
  | ([], first2 :: rest2) -> false
  | (first1 :: rest1, []) -> false
  | (first1 :: rest1, first2 :: rest2) ->
      equal_length rest1 rest2

(* test *)
let test1 = equal_length [] [] = true
let test2 = equal_length [] [1] = false
let test3 = equal_length [1] [] = false
let test4 = equal_length [1; 2] [3; 4] = true
let test5 = equal_length [1; 2] [1; 2; 4] = false
let test6 = equal_length ["a"; "b"; "c"; "d"] [1; 3] = false
let test7 = equal_length ["a"; "b"; "c"; "d"] [1; 3; 2; 4] = true
