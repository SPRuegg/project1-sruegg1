type bop =
  | Add
  | Sub
  | Mult
  | Div
  | Leq

(** [typ] represents the type of an expression. *)
type typ =
  | TInt
  | TBool

type expr =
| Var of string
| Int of int
| Bool of bool
| Float of float
| Binop of bop * expr * expr
| Let of string * typ * expr * expr
| If of expr * expr * expr
