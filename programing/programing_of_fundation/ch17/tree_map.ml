(* あらかじめ sect17_2/tree.ml を読み込んでおく必要あり *)
#use "sect17_2/tree.ml" (* tree_t の定義 *)

(* 木の例 *)
let tree1 = Empty
let tree2 = Leaf (3)
let tree3 = Node (tree1, 4, tree2)

(*目的: int->int型の関数fとtree_tを受け取って、節や葉に対しfを適用してtree_tを返す*)
(* tree_map : (int -> int) -> tree_t -> tree_t *)
let rec tree_map f tree = match tree with
    Empty -> Empty
  | Leaf (n) -> Leaf (f n)
  | Node (t1, n, t2) -> Node (tree_map f t1, f n, tree_map f t2) (* tree_map t1 *) (* tree_map t2 *)

(* テスト *)
let test1 = tree_map (fun x -> x * 2) tree1 = Empty
let test2 = tree_map (fun x -> x * 2) tree2 = Leaf (6)
let test3 = tree_map (fun x -> x * 2) tree3 = Node (Empty, 8, Leaf (6))
let test4 = tree_map (fun x -> x * 2) tree4
              = Node (Leaf (6), 10, Node (Empty, 8, Leaf (6)))
