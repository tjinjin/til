(* 年号を表す型 *)
type nengou_t = Meiji of int   (* 明治 *)
              | Taisho of int  (* 大正 *)
              | Showa of int   (* 昭和 *)
              | Heisei of int  (* 平成 *)

(* 目的：年号を受け取ったら対応する西暦年を返す *)
(* to_seireki : nengou_t -> int *)
let to_seireki nengou = match nengou with
  Meiji (n) -> n + 1867
  | Taisho (n) -> n + 1911
  | Showa (n) -> n + 1925
  | Heisei (n) -> n + 1988

(* 目的: 誕生年と現在の年を受け取り、年齢を返す *)
(* nenrei : nengou_t -> nengou_t -> int *)
let nenrei birth_year current_year =
  to_seireki current_year - to_seireki birth_year

(*test*)
let test1 = to_seireki (Showa (60)) = 1985
let test1 = nenrei (Showa (60)) (Heisei (29)) = 32
let test1 = nenrei (Showa (42)) (Heisei (18)) = 39
let test2 = nenrei (Heisei (11)) (Heisei (18)) = 7
let test3 = nenrei (Meiji (41)) (Heisei (17)) = 97
