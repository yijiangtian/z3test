(set-option :model_validate true)
(set-option :smt.arith.random_initial_value true)
(set-option :smt.arith.solver 2)
(declare-const v1 Bool)
(declare-const v8 Bool)
(declare-const v9 Bool)
(declare-const v18 Bool)
(declare-const i3 Int)
(declare-const i9 Int)
(declare-const Str0 String)
(declare-const Str3 String)
(declare-const Str4 String)
(declare-const Str5 String)
(declare-const Str10 String)
(declare-const Str12 String)
(declare-const Str14 String)
(declare-const Str17 String)
(declare-const v20 Bool)
(declare-const v22 Bool)
(declare-const v25 Bool)
(declare-const i15 Int)
(assert (>= (str.len Str4) i3))
(assert-soft (or (= Str12 (str.++ Str17 Str3) Str4 (str.++ Str10 (int.to.str 27) Str0) (str.++ Str3 Str5 Str14 Str5)) (or (distinct 82 i9) v20 v9 (> i15 (- 270 i9 26)) (=> v22 v25) v8 v18 v1 (= Str12 (str.++ Str17 Str3) Str4 (str.++ Str10 (int.to.str 27) Str0) (str.++ Str3 Str5 Str14 Str5)))))
(assert-soft (or (= Str12 (str.++ Str17 Str3) Str4 (str.++ Str10 (int.to.str 27) Str0) (str.++ Str3 Str5 Str14 Str5))))
(check-sat)