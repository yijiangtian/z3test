
(set-option :model_validate true)
(set-option :model_validate true)
(declare-const Str2 String)
(declare-const Str18 String)
(assert (distinct Str18 Str2))
(check-sat)
(exit)

(declare-const Str0 String)
(declare-const Str2 String)
(declare-const Str4 String)
(declare-const Str12 String)
(assert (not (= Str4 Str12 Str2 Str0 Str2)))
(check-sat)