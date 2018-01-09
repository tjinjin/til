(* 目的：lstの中から n より小さい要素のみを取り出す *)
(* take_less : int -> int list -> int list *)
let rec take_less n lst = match lst with
    [] -> []
  | first :: rest -> if first < n
                     then first :: take_less n rest
                     else take_less n rest

(* 目的：lstの中から n より大きい要素のみを取り出す *)
(* take_less : int -> int list -> int list *)
let rec take_greater n lst = match lst with
    [] -> []
  | first :: rest -> if first > n
                     then first :: take_greater n rest
                     else take_greater n rest

(* 目的：受け取ったlstをクイックソートを使って昇順に整列する *)
(* quick_sort : int list -> int list *)
let rec quick_sort lst = match lst with
    [] -> [] (* 自明に答えが出るケース *)
  | first :: rest -> quick_sort (take_less first rest) (* それ以外のケース *)
                     @ [first]
                     @ quick_sort (take_greater first rest)
  (* quick_sort (take_less first rest) *)
  (* quick_sort (take_greater first rest) *)


(* test *)
let test1 = quick_sort [] = []
let test2 = quick_sort [1] = [1]
let test3 = quick_sort [1; 2] = [1; 2]
let test4 = quick_sort [2; 1] = [1; 2]
let test5 = quick_sort [5; 4; 9; 8; 2; 3;] = [2; 3; 4; 5; 8; 9]
let test5 = quick_sort [0; 0; 9; 8; 2; 3;] = [0; 0; 3; 4; 8; 9]

(*
(* 目的：受け取った lst をクイックソートを使って昇順に整列する *)
(* quick_sort : int list -> int list *)
let rec quick_sort lst =
  (* 目的：lst の中から n より p である要素のみを取り出す *)
  (* take : int -> int list -> (int -> int -> bool) -> int list *)
  let take n lst p = filter (fun item -> p item n) lst

  (* 目的：lst の中から n より小さい要素のみを取り出す *)
  (* take_less : int -> int list -> int list *)
  in let take_less n lst = take n lst (<)

  (* 目的：lst の中から n より大きい要素のみを取り出す *)
  (* take_greater : int -> int list -> int list *)
  in let take_greater n lst = take n lst (>)
  in match lst with
         [] -> []
       | first :: rest -> quick_sort (take_less first rest)
                          @ [first]
                          @ quick_sort (take_greater first rest)
*)
