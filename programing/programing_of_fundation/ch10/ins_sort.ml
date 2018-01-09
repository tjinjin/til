(* insertを使う*)
#use "ch10/insert.ml"

(* 目的：整数のリストを昇順に並べ替える *)
(* ins_sort : int list -> int list*)
let rec ins_sort lst = match lst with
    [] -> []
  | first :: rest ->
      insert rest first

(* test *)
let test1 = ins_sort [] = []
let test2 = ins_sort [1 ;2; 3] = [1; 2; 3]
let test3 = ins_sort [3 ;2; 1] = [1; 2; 3]
let test4 = ins_sort [2 ;1; 4; 3] = [1; 2; 3; 4]
let test5 = ins_sort [5; 3; 8; 1; 7; 4] = [1; 3; 4; 5; 7; 8]
