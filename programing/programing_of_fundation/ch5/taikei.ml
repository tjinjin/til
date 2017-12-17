(* 目的：BMI値を出力する *)
let bmi tall size = size /. (tall ** 2.0)

(* 目的：体型のカテゴライズした結果を返す *)
(* float -> float -> string*)
let taikei tall size =
  if (bmi tall size) < 18.5 then "痩せ"
  else if 18.5 <= (bmi tall size) && (bmi tall size) < 25.0 then "普通"
  else if 25.0 < (bmi tall size) && (bmi tall size) < 30.0 then "肥満"
  else "高度肥満"


(* test *)
let test1 = taikei 1.69 40.0 = "痩せ"
let test2 = taikei 1.69 60.0 = "普通"
let test3 = taikei 1.69 75.0 = "肥満"
let test4 = taikei 1.69 90.0 = "高度肥満"
