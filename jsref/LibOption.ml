
(** val option_compare :
    ('a1 -> 'a1 -> bool) -> 'a1 option -> 'a1 option -> bool **)

let option_compare h o1 o2 =
  match o1 with
  | Some v1 ->
    (match o2 with
     | Some v2 -> h v1 v2
     | None -> false)
  | None ->
    (match o2 with
     | Some a -> false
     | None -> true)

(** val unsome_default : 'a1 -> 'a1 option -> 'a1 **)

let unsome_default d o = match o with
| Some x -> x
| None -> d

(** val map : ('a1 -> 'a2) -> 'a1 option -> 'a2 option **)

let map f o = match o with
| Some x -> Some (f x)
| None -> None

let is_some o = match o with
| Some x -> true
| None   -> false

let is_none o = not (is_some o)

(** Compares two Some values, failing if either are None *)
let some_compare h o1 o2 =
match o1 with
| Some v1 ->
  (match o2 with
   | Some v2 -> h v1 v2
   | None -> failwith "some_compare with None")
| None -> failwith "some_compare with None"

let unsome_error o = match o with
| Some x -> x
| None -> failwith "unsome_error with None"
