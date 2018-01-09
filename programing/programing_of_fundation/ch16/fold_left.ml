(* 目的：関数f,初期値init, listを受け取り左に畳み込む*)
(* fold_left: -> ('a -> 'b -> 'a) -> 'a list -> 'd *)
let rec fold_left f init lst = match lst with
      [] -> init
    | first :: rest -> fold_left f (f init first) rest

(* test *)
let test1 = fold_left (+) 0 [1;2;3] = 6
let test1 = fold_left (-) 0 [] = 0
let test2 = fold_left (-) 10 [4; 1; 3] = 2
let test3 = fold_left (fun lst a -> a :: lst) [] [1; 2; 3; 4] = [4; 3; 2; 1]
