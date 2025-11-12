type bop =
  | Add
  | Sub
  | Mult
  | Div
  | Leq
  | Geq
  | Addf
  | Subf
  | Multf
  | Divf

(** [typ] represents the type of an expression. *)
type typ =
  | TInt
  | TFloat
  | TBool

type expr =
| Var of string
| Int of int
| Bool of bool
| Float of float
| Binop of bop * expr * expr
| Let of string * typ * expr * expr
| If of expr * expr * expr
