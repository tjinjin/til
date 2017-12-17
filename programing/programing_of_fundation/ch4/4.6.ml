(* １匹あたりの足の数 *)
let tsuru_ashi = 2

(* 目的：鶴の数xをうけとり、足の数を返す *)
(* tsuru_no_ashi : int -> int *)
let tsuru_no_ashi x = x * tsuru_ashi

(* test *)
let test1 = tsuru_no_ashi 1 = 2
let test2 = tsuru_no_ashi 10 = 20
let test3 = tsuru_no_ashi 100 = 200
