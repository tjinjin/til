(* １匹あたりの鶴の足の数 *)
let tsuru_ashi = 2

(* １匹あたりの亀の足の数 *)
let kame_ashi = 4

(* 目的：鶴の数xをうけとり、足の数を返す *)
(* tsurukame_no_ashi : int -> int -> int *)
let tsurukame_no_ashi x y = (tsuru_ashi * x) + (kame_ashi * y)

(* test *)
let test1 = tsurukame_no_ashi 1 1 = 6
let test2 = tsurukame_no_ashi 3 8 = 38
let test3 = tsurukame_no_ashi 17 3 = 46
