(set-option :model_validate true)
(declare-fun a () String)
(declare-fun b () Int)
(assert (= b (+ (str.indexof a "x" 0) 1)))
(assert (str.contains (str.substr a b (* (str.len a) b)) "y"))
(assert (str.contains (str.replace (str.substr a 0 1) "x" "") "z"))
(assert (str.contains a "x"))
(check-sat)
