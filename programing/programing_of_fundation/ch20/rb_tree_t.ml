(* 赤か黒かを示型 *)
type color_t = Red | Black

(* 木を表す型 *)
type ('a, 'b) rb_tree_t =
    Empty
  | Node of ('a, 'b) rb_tree_t * 'a * 'b * color_t * ('a, 'b) rb_tree_t
