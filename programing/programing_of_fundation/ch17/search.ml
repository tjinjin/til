(*木の定義を読み込む*)
#use "ch17/tree_t.ml"


(* 目的：dataが 2分探索本 treeに含まれているか調べる *)
(* search : tree_t -> int -> bool *)
let rec search tree data = match tree with
    Empty -> false
  | Leaf (n) -> n = data
  | Node (t1, n, t2) ->
      if data = n then true
      else if data < n then search t1 data
      else search t2 data

(* 2分探索木 *)
let tree1 = Empty
let tree2 = Leaf (3)
let tree3 = Node (Leaf (1), 2, Leaf (3))
let tree4 = Node (Empty, 7, Leaf (9))
let tree5 = Node (tree3, 6, tree4)

(*test*)
let test1 = search tree1 3 = false
let test2 = search tree2 3 = true
let test3 = search tree3 4 = false
let test4 = search tree5 6 = true
let test5 = search tree5 2 = true
let test6 = search tree5 1 = true
let test7 = search tree5 4 = false
let test8 = search tree5 7 = true
let test9 = search tree5 8 = false
