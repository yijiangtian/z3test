(set-option :smt.arith.solver 6)
(set-option :trace true)
(set-option :smt.arith.propagate_eqs false)
(set-option :smt.arith.random_initial_value true)
(set-option :smt.arith.eager_eq_axioms false)
(declare-fun a () Real)
(declare-fun b () Real)
(declare-fun c () Real)
(assert (< (* c (div b (+ a 2))) a))
(check-sat)