(* person型の定義を呼び出す *)
#use "book-data/ex08_3.ml"

(*person リストの例*)
let person_list_ex = [
  {name = "浅井"; shincho = 1.72; taiju = 58.5; tsuki = 9; hi = 17;ketsueki = "A"};
  {name = "宮原"; shincho = 1.63; taiju = 55.; tsuki = 6; hi = 30;ketsueki = "B"};
  {name = "中村"; shincho = 1.68; taiju = 63.; tsuki = 6; hi = 6;ketsueki = "O"}
]
(*目的: 人のリストと血液型を受け取り、その血液型の人数を数える*)
(* count_blood: person_t list -> string -> int*)
let rec count_blood person_list blood = match person_list with
    [] -> 0
  | {name=n;shincho=s;taiju=t;tsuki=ts;ketsueki=k} :: rest ->
      let counta = count_blood rest blood in
      if k = blood then 1 + counta
      else counta

(*test*)
let test1 = count_blood person_list_ex "A" = 1
let test2 = count_blood person_list_ex "B" = 1
let test3 = count_blood person_list_ex "O" = 1
let test4 = count_blood person_list_ex "AB" = 0
let test5 = count_blood [] "A" = 0
