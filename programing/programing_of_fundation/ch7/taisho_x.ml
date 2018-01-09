(* 目的 : x, y座標の組を受け取ったら、x軸について対称な座標を返す *)
(* add :(int * int) -> (int * int) *)
let taisho_x pair = match pair with
  (x, y) -> (x, -y)

(* test *)
let test1 = taisho_x (1, 1) = (1, -1)
let test2 = taisho_x (3, 8) = (3, -8)
let test3 = taisho_x (7, -1) = (7, 1)
