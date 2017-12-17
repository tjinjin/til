(* person_tを受け取る *)
#use "book-data/ex08_3.ml"

(* test_data *)
let lst1 = [person1; person2; person3]
let lst2 = [person3; person2; person1]

(* 人々の中から最初にA型であった人を返す *)
(* first_A : person_t list -> person_t *)
let rec first_A lst = match lst with
    [] -> None
  | ({name=n;shincho=s;taiju=ta;tsuki=ts;hi=h;ketsueki=k} as first) :: rest ->
      if k = "A" then Some (first) else first_A rest

(* test *)
let test1 = first_A [] = None
let test2 = first_A lst1 = Some (person1)
let test3 = first_A lst2 = Some (person1)
