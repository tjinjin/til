(* person_t型を読み込む*)
#use "book-data/ex08_3.ml"

(*データの例*)
let people = [person1; person2; person3]

(* 目的：person_t型からnamaeをぬきだす*)
(* get_namae: person_t -> string *)
let get_namae person = match person with
    {name=n;shincho=s;taiju=t;tsuki=ts;hi=h;ketsueki=k} -> n

(* 目的: person_t型のリストを受け取ったら、その中に出てくる人の名前のリストを返す *)
(* person_namae : person_t list -> string list *)
let person_namae lst = List.map get_namae people

(*test*)
let test1 = person_namae people = ["浅井";"宮原";"中村"]
