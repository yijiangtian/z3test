(set-option :auto-config true)
(set-logic QF_BV)
(declare-fun v0 () (_ BitVec 11))
(declare-fun v1 () (_ BitVec 9))
(declare-fun v2 () (_ BitVec 7))
(assert (let ((e3(_ bv1 4)))
(let ((e4 (bvashr v0 ((_ sign_extend 7) e3))))
(let ((e5 (bvcomp v1 v1)))
(let ((e6 (ite (distinct ((_ zero_extend 7) e3) v0) (_ bv1 1) (_ bv0 1))))
(let ((e7 (bvashr e4 v0)))
(let ((e8 (ite (bvugt e7 v0) (_ bv1 1) (_ bv0 1))))
(let ((e9 (bvudiv ((_ zero_extend 10) e6) e7)))
(let ((e10 ((_ rotate_left 8) e9)))
(let ((e11 ((_ sign_extend 2) e10)))
(let ((e12 (bvurem ((_ zero_extend 2) v1) e10)))
(let ((e13 (ite (bvule ((_ zero_extend 10) e6) v0) (_ bv1 1) (_ bv0 1))))
(let ((e14 (bvor e3 e3)))
(let ((e15 (bvcomp e7 e12)))
(let ((e16 (bvor ((_ sign_extend 3) e5) e3)))
(let ((e17 (bvsdiv e9 e10)))
(let ((e18 (ite (bvsle e9 ((_ zero_extend 10) e6)) (_ bv1 1) (_ bv0 1))))
(let ((e19 (ite (= ((_ zero_extend 7) e3) e10) (_ bv1 1) (_ bv0 1))))
(let ((e20 (ite (= e14 ((_ zero_extend 3) e18)) (_ bv1 1) (_ bv0 1))))
(let ((e21 (bvor v0 ((_ zero_extend 4) v2))))
(let ((e22 (distinct e9 v0)))
(let ((e23 (bvult e12 ((_ sign_extend 10) e18))))
(let ((e24 (bvuge ((_ zero_extend 10) e19) v0)))
(let ((e25 (distinct e8 e6)))
(let ((e26 (= ((_ sign_extend 4) v1) e11)))
(let ((e27 (bvsge ((_ zero_extend 10) e20) v0)))
(let ((e28 (bvugt ((_ sign_extend 10) e18) v0)))
(let ((e29 (bvugt ((_ sign_extend 2) e7) e11)))
(let ((e30 (bvult e13 e6)))
(let ((e31 (bvsgt e7 ((_ sign_extend 7) e14))))
(let ((e32 (bvsge v0 e9)))
(let ((e33 (bvsgt e17 ((_ zero_extend 10) e18))))
(let ((e34 (bvugt e11 ((_ sign_extend 2) e4))))
(let ((e35 (bvslt v0 e17)))
(let ((e36 (bvsle e4 ((_ sign_extend 4) v2))))
(let ((e37 (bvsge e16 ((_ zero_extend 3) e20))))
(let ((e38 (bvule e4 e9)))
(let ((e39 (bvuge ((_ sign_extend 10) e19) e9)))
(let ((e40 (bvule v0 e17)))
(let ((e41 (bvule e11 ((_ zero_extend 12) e15))))
(let ((e42 (bvuge e4 ((_ sign_extend 10) e15))))
(let ((e43 (bvsge e5 e13)))
(let ((e44 (bvsge e17 e10)))
(let ((e45 (bvslt ((_ sign_extend 10) e8) e10)))
(let ((e46 (bvslt e4 ((_ zero_extend 7) e14))))
(let ((e47 (bvult e21 e4)))
(let ((e48 (bvsle ((_ zero_extend 8) e18) v1)))
(let ((e49 (distinct e15 e6)))
(let ((e50 (distinct e20 e6)))
(let ((e51 (bvuge v0 e7)))
(let ((e52 (bvsle e11 ((_ zero_extend 2) e17))))
(let ((e53 (bvule e4 ((_ sign_extend 10) e20))))
(let ((e54 (bvslt ((_ sign_extend 10) e13) e12)))
(let ((e55 (bvuge v0 ((_ sign_extend 10) e15))))
(let ((e56 (bvslt ((_ zero_extend 10) e18) e10)))
(let ((e57 (bvult v0 ((_ zero_extend 4) v2))))
(let ((e58 (bvuge v1 ((_ sign_extend 8) e6))))
(let ((e59 (bvsge e5 e6)))
(let ((e60 (bvsle ((_ sign_extend 10) e20) e12)))
(let ((e61 (distinct e12 ((_ sign_extend 10) e18))))
(let ((e62 (bvuge e11 ((_ sign_extend 2) e7))))
(let ((e63 (bvsgt e10 e7)))
(let ((e64 (bvsle e18 e18)))
(let ((e65 (bvsgt ((_ zero_extend 6) e8) v2)))
(let ((e66 (bvugt e21 e4)))
(let ((e67 (bvsgt v0 ((_ sign_extend 10) e6))))
(let ((e68 (bvugt e10 e21)))
(let ((e69 (bvsgt e4 ((_ sign_extend 7) e16))))
(let ((e70 (bvule e9 ((_ sign_extend 10) e15))))
(let ((e71 (bvule e11 ((_ sign_extend 2) e10))))
(let ((e72 (bvult ((_ zero_extend 12) e6) e11)))
(let ((e73 (bvsle e21 ((_ zero_extend 2) v1))))
(let ((e74 (bvsle ((_ sign_extend 7) e3) e9)))
(let ((e75 (=> e27 e46)))
(let ((e76 (and e41 e63)))
(let ((e77 (xor e74 e39)))
(let ((e78 (=> e24 e77)))
(let ((e79 (ite e69 e28 e55)))
(let ((e80 (or e76 e33)))
(let ((e81 (not e48)))
(let ((e82 (or e36 e44)))
(let ((e83 (= e47 e59)))
(let ((e84 (not e37)))
(let ((e85 (ite e71 e50 e67)))
(let ((e86 (=> e40 e66)))
(let ((e87 (and e70 e86)))
(let ((e88 (xor e57 e84)))
(let ((e89 (or e52 e52)))
(let ((e90 (=> e30 e75)))
(let ((e91 (or e78 e54)))
(let ((e92 (= e42 e38)))
(let ((e93 (=> e53 e91)))
(let ((e94 (=> e64 e23)))
(let ((e95 (or e80 e81)))
(let ((e96 (=> e83 e62)))
(let ((e97 (xor e26 e94)))
(let ((e98 (= e65 e25)))
(let ((e99 (and e87 e31)))
(let ((e100 (not e61)))
(let ((e101 (=> e90 e88)))
(let ((e102 (xor e101 e68)))
(let ((e103 (or e99 e49)))
(let ((e104 (not e45)))
(let ((e105 (=> e51 e35)))
(let ((e106 (and e72 e92)))
(let ((e107 (= e96 e96)))
(let ((e108 (not e98)))
(let ((e109 (xor e97 e34)))
(let ((e110 (=> e29 e102)))
(let ((e111 (ite e105 e43 e104)))
(let ((e112 (=> e107 e103)))
(let ((e113 (xor e95 e89)))
(let ((e114 (= e100 e56)))
(let ((e115 (=> e73 e85)))
(let ((e116 (ite e111 e93 e113)))
(let ((e117 (or e109 e82)))
(let ((e118 (and e106 e116)))
(let ((e119 (=> e60 e79)))
(let ((e120 (xor e110 e115)))
(let ((e121 (xor e118 e108)))
(let ((e122 (= e119 e121)))
(let ((e123 (= e22 e22)))
(let ((e124 (not e122)))
(let ((e125 (=> e114 e123)))
(let ((e126 (not e120)))
(let ((e127 (=> e112 e125)))
(let ((e128 (=> e124 e117)))
(let ((e129 (=> e126 e32)))
(let ((e130 (=> e58 e58)))
(let ((e131 (not e128)))
(let ((e132 (and e130 e130)))
(let ((e133 (=> e132 e132)))
(let ((e134 (and e133 e129)))
(let ((e135 (=> e131 e127)))
(let ((e136 (and e134 e134)))
(let ((e137 (xor e135 e135)))
(let ((e138 (=> e136 e136)))
(let ((e139 (xor e138 e138)))
(let ((e140 (= e139 e139)))
(let ((e141 (or e140 e140)))
(let ((e142 (and e141 e141)))
(let ((e143 (or e137 e142)))
(let ((e144 (and e143 (not (= e10 (_ bv0 11))))))
(let ((e145 (and e144 (not (= e10 (bvnot (_ bv0 11)))))))
(let ((e146 (and e145 (not (= e7 (_ bv0 11))))))
e146
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))

(check-sat)