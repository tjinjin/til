(* 2分探索木を表すモジュール *)
module Tree = struct
  (* 2分探索木を表す型 *)
  type ('a, 'b) t = Empty
                  | Node of ('a, 'b) t * 'a * 'b * ('a, 'b) t

  (* 空の木 *)
  let empty = Empty

  (* 目的：treeにキーがkで値がvを挿入した木を返す *)
  (* insert : ('a, 'b) t -> 'a -> 'b -> ('a, 'b) t*)
  let rec insert tree k v = match tree with
    Empty -> Node (Empty, k, v, Empty)
  | Node (left, key, value, right) ->
      if k = key then Node (left, key, v, right)
      else if k < key
           then Node (insert left k v, key, value, right)
           else Node (left, key, value, insert right k v)

  (* 目的: treeの中のキー k に対応する値を探して返す *)
  (* 見つからなければ例外Not_foundを起こす *)
  (* search : ('a, 'b) t -> 'a -> 'b *)
  let rec search tree k = match tree with
      Empty -> raise Not_found
    | Node (left, key, value, right) ->
        if k = key then value
        else if k < key then search left k
                        else search right k
end
