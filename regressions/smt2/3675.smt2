(set-option :sat.prob_search true)
(declare-fun a () Bool)
(declare-fun b () Bool)
(assert a)
(assert b)
(check-sat)