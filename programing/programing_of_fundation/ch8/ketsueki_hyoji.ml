(* 個人情報（名前、血液型) *)
type person_t = {
  name : string;
  blood: string;
}

(* 目的：フォーマットして血液型を表示する *)
(* person_t -> string*)
let ketsueki_hyoji person = match person with
  {name=n;blood=b} -> n ^ " is "^ b ^ " type"

(* test *)
let test1 = ketsueki_hyoji {name="yamada";blood="A"}="yamada is A type"
let test2 = ketsueki_hyoji {name="suzuki";blood="B"}="suzuki is B type"
