(* 定義を利用する *)
#use "book-data/sect09_6/count_A.ml"

(* 目的：成績がAか判定する *)
let is_A gakusei = match gakusei with
    {namae=n;tensuu=t;seiseki=s} ->
      s = "A"

(*目的：学生リストのうち成績Aの人の数を返す*)
(* filter_count_A: gakusei_t list -> int *)
let filter_count_A lst = List.length (List.filter is_A lst)

(* テスト *)
let test1 = filter_count_A lst1 = 0
let test2 = filter_count_A lst2 = 0
let test3 = filter_count_A lst3 = 1
let test4 = filter_count_A lst4 = 2
