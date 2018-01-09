(*目的：整数lstと整数nを受け取り、昇順になるように挿入する*)
(* insert : int list -> int -> int list*)
let rec insert lst n = match lst with
    [] -> [n]
  | first :: rest ->
      if first > n then n :: lst
      else first :: (insert rest n)

(*test*)
let test1 = insert [] 0 = [0]
let test2 = insert [0] 1 = [0; 1]
let test3 = insert [0; 2] 1 = [0; 1; 2]
let test4 = insert [1; 3; 4; 7; 8] 5 = [1; 3; 4; 5; 7; 8]
