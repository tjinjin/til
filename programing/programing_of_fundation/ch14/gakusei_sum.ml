(* gakusei_tの定義を利用する *)
#use "ch10/gakusei_max.ml"

(* 目的：*)
(* seiseki_sum : gakusei_t型を受け取り、成績を加算する *)
(* seiseki_sum : gakusei_t -> int *)
let seiseki_sum gakusei0 rest_result = match gakusei0 with
  {name=n;score=s;grade=g} -> s + rest_result

(* 目的：学生リストを受け取り、全員の得点の合計を返す *)
(* gakusei_sum : gakusei_t list -> int *)
let gakusei_sum gakuseis = fold_right seiseki_sum gakuseis 0

(* test *)
let test1 = gakusei_sum lst1 = 0
let test2 = gakusei_sum lst2 = 80
let test3 = gakusei_sum lst3 = 145
let test4 = gakusei_sum lst4 = 145
let test5 = gakusei_sum lst5 = 440
