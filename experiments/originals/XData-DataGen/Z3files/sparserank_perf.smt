

;------------------------------------------------------------
;MUTATION TYPE: DATASET FOR GENERATING NON EMPTY RESULT 
;------------------------------------------------------------
(set-option :produce-models true)
 (set-option :smt.macro_finder true) 
 (set-option :smt.mbqi true) 

(declare-fun intNullVal () Int)
(assert (= intNullVal (- 99999)))

(declare-fun realNullVal () Real)
(assert (= realNullVal (- 99999.0)))


(declare-datatypes ((DEPT_NAME 0)) (((_DEPT_uNAME__Finance) (_DEPT_uNAME__History) (_DEPT_uNAME__Physics) (_DEPT_uNAME__Music) (_DEPT_uNAME__Comp_d_ubSci_d) (_DEPT_uNAME__Biology) (_DEPT_uNAME__Elec_d_ubEng_d) (_DEPT_uNAME__V8) (_DEPT_uNAME__V9) (_DEPT_uNAME__V10) (_DEPT_uNAME__V11) (_DEPT_uNAME__V12) (_DEPT_uNAME__V13) (_DEPT_uNAME__V14) (_DEPT_uNAME__V15) (_DEPT_uNAME__V16) (_DEPT_uNAME__V17) (_DEPT_uNAME__V18) (_DEPT_uNAME__V19) (_DEPT_uNAME__V20) (NULL_DEPT_NAME_1))))


(declare-fun DEPT_NAMEMap ((DEPT_NAME)) Int)
		(assert (= ( DEPT_NAMEMap _DEPT_uNAME__Biology ) 1 ))
		(assert (= ( DEPT_NAMEMap _DEPT_uNAME__Comp_d_ubSci_d ) 2 ))
		(assert (= ( DEPT_NAMEMap _DEPT_uNAME__Elec_d_ubEng_d ) 3 ))
		(assert (= ( DEPT_NAMEMap _DEPT_uNAME__Finance ) 4 ))
		(assert (= ( DEPT_NAMEMap _DEPT_uNAME__History ) 5 ))
		(assert (= ( DEPT_NAMEMap _DEPT_uNAME__Music ) 6 ))
		(assert (= ( DEPT_NAMEMap _DEPT_uNAME__Physics ) 7 ))
		(assert (= ( DEPT_NAMEMap _DEPT_uNAME__V10 ) 8 ))
		(assert (= ( DEPT_NAMEMap _DEPT_uNAME__V11 ) 9 ))
		(assert (= ( DEPT_NAMEMap _DEPT_uNAME__V12 ) 10 ))
		(assert (= ( DEPT_NAMEMap _DEPT_uNAME__V13 ) 11 ))
		(assert (= ( DEPT_NAMEMap _DEPT_uNAME__V14 ) 12 ))
		(assert (= ( DEPT_NAMEMap _DEPT_uNAME__V15 ) 13 ))
		(assert (= ( DEPT_NAMEMap _DEPT_uNAME__V16 ) 14 ))
		(assert (= ( DEPT_NAMEMap _DEPT_uNAME__V17 ) 15 ))
		(assert (= ( DEPT_NAMEMap _DEPT_uNAME__V18 ) 16 ))
		(assert (= ( DEPT_NAMEMap _DEPT_uNAME__V19 ) 17 ))
		(assert (= ( DEPT_NAMEMap _DEPT_uNAME__V20 ) 18 ))
		(assert (= ( DEPT_NAMEMap _DEPT_uNAME__V8 ) 19 ))
		(assert (= ( DEPT_NAMEMap _DEPT_uNAME__V9 ) 20 ))

		



(declare-fun gtDEPT_NAME ((DEPT_NAME) (DEPT_NAME)) Bool)
(assert (forall  ((x DEPT_NAME) (y DEPT_NAME)) 
		(= (gtDEPT_NAME x y) ( >(DEPT_NAMEMap x)(DEPT_NAMEMap y)))))




(declare-fun ltDEPT_NAME ((DEPT_NAME) (DEPT_NAME)) Bool)
(assert (forall  ((x DEPT_NAME) (y DEPT_NAME)) 
		(= (ltDEPT_NAME x y) ( <(DEPT_NAMEMap x)(DEPT_NAMEMap y)))))


(declare-fun ISNULL_DEPT_NAME (DEPT_NAME) Bool)
(assert (forall ((dept_name DEPT_NAME))
  (= (ISNULL_DEPT_NAME dept_name) (or (= dept_name NULL_DEPT_NAME_1)))))




(declare-fun checkSALARY (Real) Bool)
(assert (forall ((r_SALARY Real))
  (= (checkSALARY r_SALARY)
     (or (and (>= r_SALARY 29001.0) (<= r_SALARY 99999.0))
         (= r_SALARY (- 99999.0))))))

(declare-fun ISNULL_SALARY (Real) Bool)
(assert (forall ((salary Real)) (= (ISNULL_SALARY salary) (or (= salary realNullVal)))))





(declare-datatypes ((BUILDING 0)) (((_BUILDING__Taylor) (_BUILDING__Packard) (_BUILDING__Painter) (_BUILDING__Watson) (_BUILDING__V5) (_BUILDING__V6) (_BUILDING__V7) (_BUILDING__V8) (_BUILDING__V9) (_BUILDING__V10) (_BUILDING__V11) (_BUILDING__V12) (_BUILDING__V13) (_BUILDING__V14) (_BUILDING__V15) (_BUILDING__V16) (_BUILDING__V17) (_BUILDING__V18) (_BUILDING__V19) (_BUILDING__V20) (NULL_BUILDING_1))))


(declare-fun BUILDINGMap ((BUILDING)) Int)
		(assert (= ( BUILDINGMap _BUILDING__Packard ) 1 ))
		(assert (= ( BUILDINGMap _BUILDING__Painter ) 2 ))
		(assert (= ( BUILDINGMap _BUILDING__Taylor ) 3 ))
		(assert (= ( BUILDINGMap _BUILDING__V10 ) 4 ))
		(assert (= ( BUILDINGMap _BUILDING__V11 ) 5 ))
		(assert (= ( BUILDINGMap _BUILDING__V12 ) 6 ))
		(assert (= ( BUILDINGMap _BUILDING__V13 ) 7 ))
		(assert (= ( BUILDINGMap _BUILDING__V14 ) 8 ))
		(assert (= ( BUILDINGMap _BUILDING__V15 ) 9 ))
		(assert (= ( BUILDINGMap _BUILDING__V16 ) 10 ))
		(assert (= ( BUILDINGMap _BUILDING__V17 ) 11 ))
		(assert (= ( BUILDINGMap _BUILDING__V18 ) 12 ))
		(assert (= ( BUILDINGMap _BUILDING__V19 ) 13 ))
		(assert (= ( BUILDINGMap _BUILDING__V20 ) 14 ))
		(assert (= ( BUILDINGMap _BUILDING__V5 ) 15 ))
		(assert (= ( BUILDINGMap _BUILDING__V6 ) 16 ))
		(assert (= ( BUILDINGMap _BUILDING__V7 ) 17 ))
		(assert (= ( BUILDINGMap _BUILDING__V8 ) 18 ))
		(assert (= ( BUILDINGMap _BUILDING__V9 ) 19 ))
		(assert (= ( BUILDINGMap _BUILDING__Watson ) 20 ))

		



(declare-fun gtBUILDING ((BUILDING) (BUILDING)) Bool)
(assert (forall  ((x BUILDING) (y BUILDING)) 
		(= (gtBUILDING x y) ( >(BUILDINGMap x)(BUILDINGMap y)))))




(declare-fun ltBUILDING ((BUILDING) (BUILDING)) Bool)
(assert (forall  ((x BUILDING) (y BUILDING)) 
		(= (ltBUILDING x y) ( <(BUILDINGMap x)(BUILDINGMap y)))))


(declare-fun ISNULL_BUILDING (BUILDING) Bool)
(assert (forall ((building BUILDING))
  (= (ISNULL_BUILDING building) (or (= building NULL_BUILDING_1)))))




(declare-fun checkBUDGET (Real) Bool)
(assert (forall ((r_BUDGET Real))
  (= (checkBUDGET r_BUDGET)
     (or (and (>= r_BUDGET 1.0) (<= r_BUDGET 99999.0)) (= r_BUDGET (- 99999.0))))))

(declare-fun ISNULL_BUDGET (Real) Bool)
(assert (forall ((budget Real)) (= (ISNULL_BUDGET budget) (or (= budget realNullVal)))))





(declare-datatypes ((ID 0)) (((_ID__10101) (_ID__12121) (_ID__15151) (_ID__22222) (_ID__32343) (_ID__33456) (_ID__45565) (_ID__58583) (_ID__76543) (_ID__76766) (_ID__83821) (_ID__98345) (_ID__V13) (_ID__V14) (_ID__V15) (_ID__V16) (_ID__V17) (_ID__V18) (_ID__V19) (_ID__V20) (NULL_ID_1))))


(declare-fun IDMap ((ID)) Int)
		(assert (= ( IDMap _ID__10101 ) 1 ))
		(assert (= ( IDMap _ID__12121 ) 2 ))
		(assert (= ( IDMap _ID__15151 ) 3 ))
		(assert (= ( IDMap _ID__22222 ) 4 ))
		(assert (= ( IDMap _ID__32343 ) 5 ))
		(assert (= ( IDMap _ID__33456 ) 6 ))
		(assert (= ( IDMap _ID__45565 ) 7 ))
		(assert (= ( IDMap _ID__58583 ) 8 ))
		(assert (= ( IDMap _ID__76543 ) 9 ))
		(assert (= ( IDMap _ID__76766 ) 10 ))
		(assert (= ( IDMap _ID__83821 ) 11 ))
		(assert (= ( IDMap _ID__98345 ) 12 ))
		(assert (= ( IDMap _ID__V13 ) 13 ))
		(assert (= ( IDMap _ID__V14 ) 14 ))
		(assert (= ( IDMap _ID__V15 ) 15 ))
		(assert (= ( IDMap _ID__V16 ) 16 ))
		(assert (= ( IDMap _ID__V17 ) 17 ))
		(assert (= ( IDMap _ID__V18 ) 18 ))
		(assert (= ( IDMap _ID__V19 ) 19 ))
		(assert (= ( IDMap _ID__V20 ) 20 ))

		



(declare-fun gtID ((ID) (ID)) Bool)
(assert (forall  ((x ID) (y ID)) 
		(= (gtID x y) ( >(IDMap x)(IDMap y)))))




(declare-fun ltID ((ID) (ID)) Bool)
(assert (forall  ((x ID) (y ID)) 
		(= (ltID x y) ( <(IDMap x)(IDMap y)))))


(declare-fun ISNULL_ID (ID) Bool)
(assert (forall ((id ID)) (= (ISNULL_ID id) (or (= id NULL_ID_1)))))




(declare-datatypes ((NAME 0)) (((_NAME__Einstein) (_NAME__Katz) (_NAME__Singh) (_NAME__Kim) (_NAME__Brandt) (_NAME__El_ubSaid) (_NAME__Wu) (_NAME__Srinivasan) (_NAME__Crick) (_NAME__Gold) (_NAME__Califieri) (_NAME__Mozart) (_NAME__V13) (_NAME__V14) (_NAME__V15) (_NAME__V16) (_NAME__V17) (_NAME__V18) (_NAME__V19) (_NAME__V20) (NULL_NAME_1))))


(declare-fun NAMEMap ((NAME)) Int)
		(assert (= ( NAMEMap _NAME__Brandt ) 1 ))
		(assert (= ( NAMEMap _NAME__Califieri ) 2 ))
		(assert (= ( NAMEMap _NAME__Crick ) 3 ))
		(assert (= ( NAMEMap _NAME__Einstein ) 4 ))
		(assert (= ( NAMEMap _NAME__El_ubSaid ) 5 ))
		(assert (= ( NAMEMap _NAME__Gold ) 6 ))
		(assert (= ( NAMEMap _NAME__Katz ) 7 ))
		(assert (= ( NAMEMap _NAME__Kim ) 8 ))
		(assert (= ( NAMEMap _NAME__Mozart ) 9 ))
		(assert (= ( NAMEMap _NAME__Singh ) 10 ))
		(assert (= ( NAMEMap _NAME__Srinivasan ) 11 ))
		(assert (= ( NAMEMap _NAME__V13 ) 12 ))
		(assert (= ( NAMEMap _NAME__V14 ) 13 ))
		(assert (= ( NAMEMap _NAME__V15 ) 14 ))
		(assert (= ( NAMEMap _NAME__V16 ) 15 ))
		(assert (= ( NAMEMap _NAME__V17 ) 16 ))
		(assert (= ( NAMEMap _NAME__V18 ) 17 ))
		(assert (= ( NAMEMap _NAME__V19 ) 18 ))
		(assert (= ( NAMEMap _NAME__V20 ) 19 ))
		(assert (= ( NAMEMap _NAME__Wu ) 20 ))

		



(declare-fun gtNAME ((NAME) (NAME)) Bool)
(assert (forall  ((x NAME) (y NAME)) 
		(= (gtNAME x y) ( >(NAMEMap x)(NAMEMap y)))))




(declare-fun ltNAME ((NAME) (NAME)) Bool)
(assert (forall  ((x NAME) (y NAME)) 
		(= (ltNAME x y) ( <(NAMEMap x)(NAMEMap y)))))


(declare-fun ISNULL_NAME (NAME) Bool)
(assert (forall ((name NAME)) (= (ISNULL_NAME name) (or (= name NULL_NAME_1)))))






;------------------------------------------------------------
; Tuple Types for Relations
 
;------------------------------------------------------------
(declare-datatypes ((department_TupleType 0)) (((department_TupleType (department_DEPT_NAME0 DEPT_NAME) (department_BUILDING1 BUILDING) (department_BUDGET2 Real) (department_XDATA_CNT3 Int)))))

(declare-datatypes ((instructor_TupleType 0)) (((instructor_TupleType (instructor_ID0 ID) (instructor_NAME1 NAME) (instructor_DEPT_NAME2 DEPT_NAME) (instructor_SALARY3 Real) (instructor_XDATA_CNT4 Int)))))

(declare-fun O_instructor () (Array Int instructor_TupleType))

(declare-fun O_department () (Array Int department_TupleType))

;------------------------------------------------------------
;FOREIGN KEY CONSTRAINTS
;------------------------------------------------------------
(assert (let ((a!1 (or (ISNULL_DEPT_NAME (instructor_DEPT_NAME2 (select O_instructor 1)))
               (= (instructor_DEPT_NAME2 (select O_instructor 1))
                  (department_DEPT_NAME0 (select O_department 1)))))
      (a!3 (or (ISNULL_DEPT_NAME (instructor_DEPT_NAME2 (select O_instructor 1)))
               (= (instructor_DEPT_NAME2 (select O_instructor 1))
                  (department_DEPT_NAME0 (select O_department 2)))))
      (a!5 (or (ISNULL_DEPT_NAME (instructor_DEPT_NAME2 (select O_instructor 1)))
               (= (instructor_DEPT_NAME2 (select O_instructor 1))
                  (department_DEPT_NAME0 (select O_department 3)))))
      (a!7 (or (ISNULL_DEPT_NAME (instructor_DEPT_NAME2 (select O_instructor 1)))
               (= (instructor_DEPT_NAME2 (select O_instructor 1))
                  (department_DEPT_NAME0 (select O_department 4)))))
      (a!9 (or (ISNULL_DEPT_NAME (instructor_DEPT_NAME2 (select O_instructor 1)))
               (= (instructor_DEPT_NAME2 (select O_instructor 1))
                  (department_DEPT_NAME0 (select O_department 5))))))
(let ((a!2 (and a!1 (> (department_XDATA_CNT3 (select O_department 1)) 0)))
      (a!4 (and a!3 (> (department_XDATA_CNT3 (select O_department 2)) 0)))
      (a!6 (and a!5 (> (department_XDATA_CNT3 (select O_department 3)) 0)))
      (a!8 (and a!7 (> (department_XDATA_CNT3 (select O_department 4)) 0)))
      (a!10 (and a!9 (> (department_XDATA_CNT3 (select O_department 5)) 0))))
  (or a!2
      a!4
      a!6
      a!8
      a!10
      (= (instructor_XDATA_CNT4 (select O_instructor 1)) 0)))))

(assert (let ((a!1 (or (ISNULL_DEPT_NAME (instructor_DEPT_NAME2 (select O_instructor 2)))
               (= (instructor_DEPT_NAME2 (select O_instructor 2))
                  (department_DEPT_NAME0 (select O_department 1)))))
      (a!3 (or (ISNULL_DEPT_NAME (instructor_DEPT_NAME2 (select O_instructor 2)))
               (= (instructor_DEPT_NAME2 (select O_instructor 2))
                  (department_DEPT_NAME0 (select O_department 2)))))
      (a!5 (or (ISNULL_DEPT_NAME (instructor_DEPT_NAME2 (select O_instructor 2)))
               (= (instructor_DEPT_NAME2 (select O_instructor 2))
                  (department_DEPT_NAME0 (select O_department 3)))))
      (a!7 (or (ISNULL_DEPT_NAME (instructor_DEPT_NAME2 (select O_instructor 2)))
               (= (instructor_DEPT_NAME2 (select O_instructor 2))
                  (department_DEPT_NAME0 (select O_department 4)))))
      (a!9 (or (ISNULL_DEPT_NAME (instructor_DEPT_NAME2 (select O_instructor 2)))
               (= (instructor_DEPT_NAME2 (select O_instructor 2))
                  (department_DEPT_NAME0 (select O_department 5))))))
(let ((a!2 (and a!1 (> (department_XDATA_CNT3 (select O_department 1)) 0)))
      (a!4 (and a!3 (> (department_XDATA_CNT3 (select O_department 2)) 0)))
      (a!6 (and a!5 (> (department_XDATA_CNT3 (select O_department 3)) 0)))
      (a!8 (and a!7 (> (department_XDATA_CNT3 (select O_department 4)) 0)))
      (a!10 (and a!9 (> (department_XDATA_CNT3 (select O_department 5)) 0))))
  (or a!2
      a!4
      a!6
      a!8
      a!10
      (= (instructor_XDATA_CNT4 (select O_instructor 2)) 0)))))

(assert (let ((a!1 (or (ISNULL_DEPT_NAME (instructor_DEPT_NAME2 (select O_instructor 3)))
               (= (instructor_DEPT_NAME2 (select O_instructor 3))
                  (department_DEPT_NAME0 (select O_department 1)))))
      (a!3 (or (ISNULL_DEPT_NAME (instructor_DEPT_NAME2 (select O_instructor 3)))
               (= (instructor_DEPT_NAME2 (select O_instructor 3))
                  (department_DEPT_NAME0 (select O_department 2)))))
      (a!5 (or (ISNULL_DEPT_NAME (instructor_DEPT_NAME2 (select O_instructor 3)))
               (= (instructor_DEPT_NAME2 (select O_instructor 3))
                  (department_DEPT_NAME0 (select O_department 3)))))
      (a!7 (or (ISNULL_DEPT_NAME (instructor_DEPT_NAME2 (select O_instructor 3)))
               (= (instructor_DEPT_NAME2 (select O_instructor 3))
                  (department_DEPT_NAME0 (select O_department 4)))))
      (a!9 (or (ISNULL_DEPT_NAME (instructor_DEPT_NAME2 (select O_instructor 3)))
               (= (instructor_DEPT_NAME2 (select O_instructor 3))
                  (department_DEPT_NAME0 (select O_department 5))))))
(let ((a!2 (and a!1 (> (department_XDATA_CNT3 (select O_department 1)) 0)))
      (a!4 (and a!3 (> (department_XDATA_CNT3 (select O_department 2)) 0)))
      (a!6 (and a!5 (> (department_XDATA_CNT3 (select O_department 3)) 0)))
      (a!8 (and a!7 (> (department_XDATA_CNT3 (select O_department 4)) 0)))
      (a!10 (and a!9 (> (department_XDATA_CNT3 (select O_department 5)) 0))))
  (or a!2
      a!4
      a!6
      a!8
      a!10
      (= (instructor_XDATA_CNT4 (select O_instructor 3)) 0)))))

(assert (let ((a!1 (or (ISNULL_DEPT_NAME (instructor_DEPT_NAME2 (select O_instructor 4)))
               (= (instructor_DEPT_NAME2 (select O_instructor 4))
                  (department_DEPT_NAME0 (select O_department 1)))))
      (a!3 (or (ISNULL_DEPT_NAME (instructor_DEPT_NAME2 (select O_instructor 4)))
               (= (instructor_DEPT_NAME2 (select O_instructor 4))
                  (department_DEPT_NAME0 (select O_department 2)))))
      (a!5 (or (ISNULL_DEPT_NAME (instructor_DEPT_NAME2 (select O_instructor 4)))
               (= (instructor_DEPT_NAME2 (select O_instructor 4))
                  (department_DEPT_NAME0 (select O_department 3)))))
      (a!7 (or (ISNULL_DEPT_NAME (instructor_DEPT_NAME2 (select O_instructor 4)))
               (= (instructor_DEPT_NAME2 (select O_instructor 4))
                  (department_DEPT_NAME0 (select O_department 4)))))
      (a!9 (or (ISNULL_DEPT_NAME (instructor_DEPT_NAME2 (select O_instructor 4)))
               (= (instructor_DEPT_NAME2 (select O_instructor 4))
                  (department_DEPT_NAME0 (select O_department 5))))))
(let ((a!2 (and a!1 (> (department_XDATA_CNT3 (select O_department 1)) 0)))
      (a!4 (and a!3 (> (department_XDATA_CNT3 (select O_department 2)) 0)))
      (a!6 (and a!5 (> (department_XDATA_CNT3 (select O_department 3)) 0)))
      (a!8 (and a!7 (> (department_XDATA_CNT3 (select O_department 4)) 0)))
      (a!10 (and a!9 (> (department_XDATA_CNT3 (select O_department 5)) 0))))
  (or a!2
      a!4
      a!6
      a!8
      a!10
      (= (instructor_XDATA_CNT4 (select O_instructor 4)) 0)))))

(assert (let ((a!1 (or (ISNULL_DEPT_NAME (instructor_DEPT_NAME2 (select O_instructor 5)))
               (= (instructor_DEPT_NAME2 (select O_instructor 5))
                  (department_DEPT_NAME0 (select O_department 1)))))
      (a!3 (or (ISNULL_DEPT_NAME (instructor_DEPT_NAME2 (select O_instructor 5)))
               (= (instructor_DEPT_NAME2 (select O_instructor 5))
                  (department_DEPT_NAME0 (select O_department 2)))))
      (a!5 (or (ISNULL_DEPT_NAME (instructor_DEPT_NAME2 (select O_instructor 5)))
               (= (instructor_DEPT_NAME2 (select O_instructor 5))
                  (department_DEPT_NAME0 (select O_department 3)))))
      (a!7 (or (ISNULL_DEPT_NAME (instructor_DEPT_NAME2 (select O_instructor 5)))
               (= (instructor_DEPT_NAME2 (select O_instructor 5))
                  (department_DEPT_NAME0 (select O_department 4)))))
      (a!9 (or (ISNULL_DEPT_NAME (instructor_DEPT_NAME2 (select O_instructor 5)))
               (= (instructor_DEPT_NAME2 (select O_instructor 5))
                  (department_DEPT_NAME0 (select O_department 5))))))
(let ((a!2 (and a!1 (> (department_XDATA_CNT3 (select O_department 1)) 0)))
      (a!4 (and a!3 (> (department_XDATA_CNT3 (select O_department 2)) 0)))
      (a!6 (and a!5 (> (department_XDATA_CNT3 (select O_department 3)) 0)))
      (a!8 (and a!7 (> (department_XDATA_CNT3 (select O_department 4)) 0)))
      (a!10 (and a!9 (> (department_XDATA_CNT3 (select O_department 5)) 0))))
  (or a!2
      a!4
      a!6
      a!8
      a!10
      (= (instructor_XDATA_CNT4 (select O_instructor 5)) 0)))))


;------------------------------------------------------------
;END OF FOREIGN  KEY CONSTRAINTS
;------------------------------------------------------------


;------------------------------------------------------------
;DOMAIN CONSTRAINTS
;------------------------------------------------------------
(assert (forall ((i Int))
  (let ((a!1 (or (checkSALARY (instructor_SALARY3 (select O_instructor i)))
                 (ISNULL_SALARY (instructor_SALARY3 (select O_instructor i))))))
    (=> (and (<= 1 i) (<= i 5)) (and a!1)))))

(assert (forall ((i Int))
  (let ((a!1 (or (checkBUDGET (department_BUDGET2 (select O_department i)))
                 (ISNULL_BUDGET (department_BUDGET2 (select O_department i))))))
    (=> (and (<= 1 i) (<= i 5)) (and a!1)))))

;------------------------------------------------------------
;END OF DOMAIN CONSTRAINTS
;------------------------------------------------------------

(declare-fun CHECKALL_NULLReal (Real) Bool)
(assert (forall ((Realcol Real))
  (= (CHECKALL_NULLReal Realcol) (= Realcol realNullVal))))

(declare-fun CHECKALL_NULLInt (Int) Bool)
(assert (forall ((Intcol Int)) (= (CHECKALL_NULLInt Intcol) (= Intcol intNullVal))))


;------------------------------------------------------------
;PRIMARY KEY CONSTRAINTS
;------------------------------------------------------------
(assert
 (let ((a!1 (or (distinct (instructor_ID0 (select O_instructor 1))
                         (instructor_ID0 (select O_instructor 2)))
               (= (instructor_XDATA_CNT4 (select O_instructor 1)) 0)
               (= (instructor_XDATA_CNT4 (select O_instructor 2)) 0)))
      (a!2 (or (distinct (instructor_ID0 (select O_instructor 1))
                         (instructor_ID0 (select O_instructor 3)))
               (= (instructor_XDATA_CNT4 (select O_instructor 1)) 0)
               (= (instructor_XDATA_CNT4 (select O_instructor 3)) 0)))
      (a!3 (or (distinct (instructor_ID0 (select O_instructor 1))
                         (instructor_ID0 (select O_instructor 4)))
               (= (instructor_XDATA_CNT4 (select O_instructor 1)) 0)
               (= (instructor_XDATA_CNT4 (select O_instructor 4)) 0)))
      (a!4 (or (distinct (instructor_ID0 (select O_instructor 1))
                         (instructor_ID0 (select O_instructor 5)))
               (= (instructor_XDATA_CNT4 (select O_instructor 1)) 0)
               (= (instructor_XDATA_CNT4 (select O_instructor 5)) 0)))
      (a!5 (or (distinct (instructor_ID0 (select O_instructor 2))
                         (instructor_ID0 (select O_instructor 3)))
               (= (instructor_XDATA_CNT4 (select O_instructor 2)) 0)
               (= (instructor_XDATA_CNT4 (select O_instructor 3)) 0)))
      (a!6 (or (distinct (instructor_ID0 (select O_instructor 2))
                         (instructor_ID0 (select O_instructor 4)))
               (= (instructor_XDATA_CNT4 (select O_instructor 2)) 0)
               (= (instructor_XDATA_CNT4 (select O_instructor 4)) 0)))
      (a!7 (or (distinct (instructor_ID0 (select O_instructor 2))
                         (instructor_ID0 (select O_instructor 5)))
               (= (instructor_XDATA_CNT4 (select O_instructor 2)) 0)
               (= (instructor_XDATA_CNT4 (select O_instructor 5)) 0)))
      (a!8 (or (distinct (instructor_ID0 (select O_instructor 3))
                         (instructor_ID0 (select O_instructor 4)))
               (= (instructor_XDATA_CNT4 (select O_instructor 3)) 0)
               (= (instructor_XDATA_CNT4 (select O_instructor 4)) 0)))
      (a!9 (or (distinct (instructor_ID0 (select O_instructor 3))
                         (instructor_ID0 (select O_instructor 5)))
               (= (instructor_XDATA_CNT4 (select O_instructor 3)) 0)
               (= (instructor_XDATA_CNT4 (select O_instructor 5)) 0)))
      (a!10 (or (distinct (instructor_ID0 (select O_instructor 4))
                          (instructor_ID0 (select O_instructor 5)))
                (= (instructor_XDATA_CNT4 (select O_instructor 4)) 0)
                (= (instructor_XDATA_CNT4 (select O_instructor 5)) 0))))
  (and a!1 a!2 a!3 a!4 a!5 a!6 a!7 a!8 a!9 a!10))
)
(assert
 (let ((a!1 (or (distinct (department_DEPT_NAME0 (select O_department 1))
                         (department_DEPT_NAME0 (select O_department 2)))
               (= (department_XDATA_CNT3 (select O_department 1)) 0)
               (= (department_XDATA_CNT3 (select O_department 2)) 0)))
      (a!2 (or (distinct (department_DEPT_NAME0 (select O_department 1))
                         (department_DEPT_NAME0 (select O_department 3)))
               (= (department_XDATA_CNT3 (select O_department 1)) 0)
               (= (department_XDATA_CNT3 (select O_department 3)) 0)))
      (a!3 (or (distinct (department_DEPT_NAME0 (select O_department 1))
                         (department_DEPT_NAME0 (select O_department 4)))
               (= (department_XDATA_CNT3 (select O_department 1)) 0)
               (= (department_XDATA_CNT3 (select O_department 4)) 0)))
      (a!4 (or (distinct (department_DEPT_NAME0 (select O_department 1))
                         (department_DEPT_NAME0 (select O_department 5)))
               (= (department_XDATA_CNT3 (select O_department 1)) 0)
               (= (department_XDATA_CNT3 (select O_department 5)) 0)))
      (a!5 (or (distinct (department_DEPT_NAME0 (select O_department 2))
                         (department_DEPT_NAME0 (select O_department 3)))
               (= (department_XDATA_CNT3 (select O_department 2)) 0)
               (= (department_XDATA_CNT3 (select O_department 3)) 0)))
      (a!6 (or (distinct (department_DEPT_NAME0 (select O_department 2))
                         (department_DEPT_NAME0 (select O_department 4)))
               (= (department_XDATA_CNT3 (select O_department 2)) 0)
               (= (department_XDATA_CNT3 (select O_department 4)) 0)))
      (a!7 (or (distinct (department_DEPT_NAME0 (select O_department 2))
                         (department_DEPT_NAME0 (select O_department 5)))
               (= (department_XDATA_CNT3 (select O_department 2)) 0)
               (= (department_XDATA_CNT3 (select O_department 5)) 0)))
      (a!8 (or (distinct (department_DEPT_NAME0 (select O_department 3))
                         (department_DEPT_NAME0 (select O_department 4)))
               (= (department_XDATA_CNT3 (select O_department 3)) 0)
               (= (department_XDATA_CNT3 (select O_department 4)) 0)))
      (a!9 (or (distinct (department_DEPT_NAME0 (select O_department 3))
                         (department_DEPT_NAME0 (select O_department 5)))
               (= (department_XDATA_CNT3 (select O_department 3)) 0)
               (= (department_XDATA_CNT3 (select O_department 5)) 0)))
      (a!10 (or (distinct (department_DEPT_NAME0 (select O_department 4))
                          (department_DEPT_NAME0 (select O_department 5)))
                (= (department_XDATA_CNT3 (select O_department 4)) 0)
                (= (department_XDATA_CNT3 (select O_department 5)) 0))))
  (and a!1 a!2 a!3 a!4 a!5 a!6 a!7 a!8 a!9 a!10))
)


;------------------------------------------------------------
;END OF PRIMARY KEY CONSTRAINTS
;------------------------------------------------------------


;------------------------------------------------------------
;UPPER BOUND LOWER BOUND CONSTRAINTS
;------------------------------------------------------------

(assert (and (>= (instructor_XDATA_CNT4 (select O_instructor 1)) 0)
     (<= (instructor_XDATA_CNT4 (select O_instructor 1)) 1)
     (>= (instructor_XDATA_CNT4 (select O_instructor 2)) 0)
     (<= (instructor_XDATA_CNT4 (select O_instructor 2)) 1)
     (>= (instructor_XDATA_CNT4 (select O_instructor 3)) 0)
     (<= (instructor_XDATA_CNT4 (select O_instructor 3)) 1)
     (>= (instructor_XDATA_CNT4 (select O_instructor 4)) 0)
     (<= (instructor_XDATA_CNT4 (select O_instructor 4)) 1)
     (>= (instructor_XDATA_CNT4 (select O_instructor 5)) 0)
     (<= (instructor_XDATA_CNT4 (select O_instructor 5)) 1)))

(assert (and (>= (department_XDATA_CNT3 (select O_department 1)) 0)
     (<= (department_XDATA_CNT3 (select O_department 1)) 1)
     (>= (department_XDATA_CNT3 (select O_department 2)) 0)
     (<= (department_XDATA_CNT3 (select O_department 2)) 1)
     (>= (department_XDATA_CNT3 (select O_department 3)) 0)
     (<= (department_XDATA_CNT3 (select O_department 3)) 1)
     (>= (department_XDATA_CNT3 (select O_department 4)) 0)
     (<= (department_XDATA_CNT3 (select O_department 4)) 1)
     (>= (department_XDATA_CNT3 (select O_department 5)) 0)
     (<= (department_XDATA_CNT3 (select O_department 5)) 1)))

(assert (> (+ (instructor_XDATA_CNT4 (select O_instructor 1))
      (instructor_XDATA_CNT4 (select O_instructor 2))
      (instructor_XDATA_CNT4 (select O_instructor 3))
      (instructor_XDATA_CNT4 (select O_instructor 4))
      (instructor_XDATA_CNT4 (select O_instructor 5)))
   0) )

(assert (<= (+ (instructor_XDATA_CNT4 (select O_instructor 1))
       (instructor_XDATA_CNT4 (select O_instructor 2))
       (instructor_XDATA_CNT4 (select O_instructor 3))
       (instructor_XDATA_CNT4 (select O_instructor 4))
       (instructor_XDATA_CNT4 (select O_instructor 5)))
    5) )

(assert (> (+ (department_XDATA_CNT3 (select O_department 1))
      (department_XDATA_CNT3 (select O_department 2))
      (department_XDATA_CNT3 (select O_department 3))
      (department_XDATA_CNT3 (select O_department 4))
      (department_XDATA_CNT3 (select O_department 5)))
   0) )

(assert (<= (+ (department_XDATA_CNT3 (select O_department 1))
       (department_XDATA_CNT3 (select O_department 2))
       (department_XDATA_CNT3 (select O_department 3))
       (department_XDATA_CNT3 (select O_department 4))
       (department_XDATA_CNT3 (select O_department 5)))
    5) )


;------------------------------------------------------------
;END OF UPPER BOUND LOWER BOUND CONSTRAINTS
;------------------------------------------------------------


;------------------------------------------------------------
;UNIQUE CONSTRAINTS FOR PRIMARY KEY TO SATISFY CONSTRAINED AGGREGATION
;------------------------------------------------------------


;------------------------------------------------------------
;END OF UNIQUE CONSTRAINTS  FOR PRIMARY KEY TO SATISFY CONSTRAINED AGGREGATION
;------------------------------------------------------------





;------------------------------------------------------------
; CONSTRAINTS OF THIS BLOCK 
;------------------------------------------------------------


;------------------------------------------------------------
; FROM CLAUSE SUBQUERY BLOCK 
;------------------------------------------------------------


;------------------------------------------------------------
; END OF FROM CLAUSE SUBQUERY BLOCK 
;------------------------------------------------------------


;------------------------------------------------------------
; CONSTRAINTS FOR THIS CONJUNCT 
;------------------------------------------------------------


;------------------------------------------------------------
; WHERE CLAUSE SUBQUERY BLOCK CONSTRAINTS 
;------------------------------------------------------------


;------------------------------------------------------------
; END OF WHERE CLAUSE SUBQUERY BLOCK CONSTRAINTS 
;------------------------------------------------------------


;------------------------------------------------------------
;PARAMETERIZED CLAUSE CONSTRAINTS 
;------------------------------------------------------------


;------------------------------------------------------------
;END OF PARAMETERIZED CLAUSE CONSTRAINTS 
;------------------------------------------------------------


;------------------------------------------------------------
;APPLICATION CONSTRAINTS 
;------------------------------------------------------------


;------------------------------------------------------------
;END OF APPLICATION CONSTRAINTS 
;------------------------------------------------------------


;------------------------------------------------------------
; UNIQUE  KEY CONSTRAINTS 
;------------------------------------------------------------


;------------------------------------------------------------
;END OF UNIQUE  KEY CONSTRAINTS 
;------------------------------------------------------------


;------------------------------------------------------------
; WHERE CLAUSE SUBQUERY BLOCK 
;------------------------------------------------------------


;------------------------------------------------------------
; END OF WHERE CLAUSE SUBQUERY BLOCK 
;------------------------------------------------------------


;------------------------------------------------------------
; OUTER QUERY AS SUBQUERY BLOCK 
;------------------------------------------------------------
(declare-datatypes ((JSQ0_TupleType 0)) (((JSQ0_TupleType (JSQ0_instructor__ID0 ID) (JSQ0_instructor__NAME1 NAME) (JSQ0_instructor__DEPT_NAME2 DEPT_NAME) (JSQ0_instructor__SALARY3 Real) (JSQ0_instructor__XDATA_CNT4 Int) (JSQ0__XDATA_CNT Int)))))
(declare-fun O_JSQ0 () (Array Int JSQ0_TupleType))

(define-fun JSQ0_map_instructor((x!0 Int) (x!1 Int)) Bool
(and 
(= (instructor_ID0 (select O_instructor x!0))
   (JSQ0_instructor__ID0 (select O_JSQ0 x!1)))
(= (instructor_NAME1 (select O_instructor x!0))
   (JSQ0_instructor__NAME1 (select O_JSQ0 x!1)))
(= (instructor_DEPT_NAME2 (select O_instructor x!0))
   (JSQ0_instructor__DEPT_NAME2 (select O_JSQ0 x!1)))
(= (instructor_SALARY3 (select O_instructor x!0))
   (JSQ0_instructor__SALARY3 (select O_JSQ0 x!1)))
(= (instructor_XDATA_CNT4 (select O_instructor x!0))
   (JSQ0_instructor__XDATA_CNT4 (select O_JSQ0 x!1)))
)
)

(assert (forall ((i1 Int)) 
	(let ((a!1 (= (JSQ0__XDATA_CNT (select O_JSQ0 i1))
              (* (JSQ0_instructor__XDATA_CNT4 (select O_JSQ0 i1))))))
(let ((a!2 (or a!1 (= (JSQ0__XDATA_CNT (select O_JSQ0 i1)) 0))))
  (and (>= (JSQ0__XDATA_CNT (select O_JSQ0 i1)) 0)
       (<= (JSQ0__XDATA_CNT (select O_JSQ0 i1)) 5)
       a!2)))))

(assert (forall ((i1 Int) (j1 Int)) 
	 (=> 
	(and (= (JSQ0_instructor__ID0 (select O_JSQ0 i1))
        (JSQ0_instructor__ID0 (select O_JSQ0 j1)))
     (not (= i1 j1)))
		(or (= (JSQ0__XDATA_CNT (select O_JSQ0 i1)) 0)
    (= (JSQ0__XDATA_CNT (select O_JSQ0 j1)) 0)))))


(assert
	(and 
		(> (JSQ0__XDATA_CNT (select O_JSQ0 1)) 0)
		(> (JSQ0__XDATA_CNT (select O_JSQ0 2)) 0)
		(> (JSQ0__XDATA_CNT (select O_JSQ0 3)) 0)
		(> (JSQ0__XDATA_CNT (select O_JSQ0 4)) 0)
		(> (JSQ0__XDATA_CNT (select O_JSQ0 5)) 0)	))

(assert	 
(=> (and 
(> (instructor_XDATA_CNT4 (select O_instructor 1)) 0)		)
(or
	(and 
			(> (JSQ0__XDATA_CNT (select O_JSQ0 1)) 0)
		(JSQ0_map_instructor 1 1)
	)
	(and 
			(> (JSQ0__XDATA_CNT (select O_JSQ0 2)) 0)
		(JSQ0_map_instructor 1 2)
	)
	(and 
			(> (JSQ0__XDATA_CNT (select O_JSQ0 3)) 0)
		(JSQ0_map_instructor 1 3)
	)
	(and 
			(> (JSQ0__XDATA_CNT (select O_JSQ0 4)) 0)
		(JSQ0_map_instructor 1 4)
	)
	(and 
			(> (JSQ0__XDATA_CNT (select O_JSQ0 5)) 0)
		(JSQ0_map_instructor 1 5)
	)))
)
(assert	 
(=> (and 
(> (instructor_XDATA_CNT4 (select O_instructor 2)) 0)		)
(or
	(and 
			(> (JSQ0__XDATA_CNT (select O_JSQ0 1)) 0)
		(JSQ0_map_instructor 2 1)
	)
	(and 
			(> (JSQ0__XDATA_CNT (select O_JSQ0 2)) 0)
		(JSQ0_map_instructor 2 2)
	)
	(and 
			(> (JSQ0__XDATA_CNT (select O_JSQ0 3)) 0)
		(JSQ0_map_instructor 2 3)
	)
	(and 
			(> (JSQ0__XDATA_CNT (select O_JSQ0 4)) 0)
		(JSQ0_map_instructor 2 4)
	)
	(and 
			(> (JSQ0__XDATA_CNT (select O_JSQ0 5)) 0)
		(JSQ0_map_instructor 2 5)
	)))
)
(assert	 
(=> (and 
(> (instructor_XDATA_CNT4 (select O_instructor 3)) 0)		)
(or
	(and 
			(> (JSQ0__XDATA_CNT (select O_JSQ0 1)) 0)
		(JSQ0_map_instructor 3 1)
	)
	(and 
			(> (JSQ0__XDATA_CNT (select O_JSQ0 2)) 0)
		(JSQ0_map_instructor 3 2)
	)
	(and 
			(> (JSQ0__XDATA_CNT (select O_JSQ0 3)) 0)
		(JSQ0_map_instructor 3 3)
	)
	(and 
			(> (JSQ0__XDATA_CNT (select O_JSQ0 4)) 0)
		(JSQ0_map_instructor 3 4)
	)
	(and 
			(> (JSQ0__XDATA_CNT (select O_JSQ0 5)) 0)
		(JSQ0_map_instructor 3 5)
	)))
)
(assert	 
(=> (and 
(> (instructor_XDATA_CNT4 (select O_instructor 4)) 0)		)
(or
	(and 
			(> (JSQ0__XDATA_CNT (select O_JSQ0 1)) 0)
		(JSQ0_map_instructor 4 1)
	)
	(and 
			(> (JSQ0__XDATA_CNT (select O_JSQ0 2)) 0)
		(JSQ0_map_instructor 4 2)
	)
	(and 
			(> (JSQ0__XDATA_CNT (select O_JSQ0 3)) 0)
		(JSQ0_map_instructor 4 3)
	)
	(and 
			(> (JSQ0__XDATA_CNT (select O_JSQ0 4)) 0)
		(JSQ0_map_instructor 4 4)
	)
	(and 
			(> (JSQ0__XDATA_CNT (select O_JSQ0 5)) 0)
		(JSQ0_map_instructor 4 5)
	)))
)
(assert	 
(=> (and 
(> (instructor_XDATA_CNT4 (select O_instructor 5)) 0)		)
(or
	(and 
			(> (JSQ0__XDATA_CNT (select O_JSQ0 1)) 0)
		(JSQ0_map_instructor 5 1)
	)
	(and 
			(> (JSQ0__XDATA_CNT (select O_JSQ0 2)) 0)
		(JSQ0_map_instructor 5 2)
	)
	(and 
			(> (JSQ0__XDATA_CNT (select O_JSQ0 3)) 0)
		(JSQ0_map_instructor 5 3)
	)
	(and 
			(> (JSQ0__XDATA_CNT (select O_JSQ0 4)) 0)
		(JSQ0_map_instructor 5 4)
	)
	(and 
			(> (JSQ0__XDATA_CNT (select O_JSQ0 5)) 0)
		(JSQ0_map_instructor 5 5)
	)))
)
(assert (forall ((i1 Int)) 
 (=> (> (JSQ0__XDATA_CNT (select O_JSQ0 i1)) 0)
(and 
	(> i1 0)
(<= i1 5)


	
	
	(or 		(JSQ0_map_instructor 	1	i1)
		(JSQ0_map_instructor 	2	i1)
		(JSQ0_map_instructor 	3	i1)
		(JSQ0_map_instructor 	4	i1)
		(JSQ0_map_instructor 	5	i1)

	)
   )
  
 )
))

;------------------------------------------------------------
;END OF CONSTRAINTS FOR HAVING CLAUSE SUBQUERY: JOIN SUBQUERY TABLE 
;------------------------------------------------------------

(assert
(and
	( =  (JSQ0_instructor__SALARY3 (select O_JSQ0 1)) 35000 )
	( =  (JSQ0_instructor__SALARY3 (select O_JSQ0 2)) 35000 )
	( =  (JSQ0_instructor__SALARY3 (select O_JSQ0 3)) 40000 )
	( =  (JSQ0_instructor__SALARY3 (select O_JSQ0 4)) 40000)
	( =  (JSQ0_instructor__SALARY3 (select O_JSQ0 5)) 45000 )
)
)


;------------------------------------------------------------
; CONSTRAINTS FOR HAVING CLAUSE SUBQUERY: GROUPBY SUBQUERY TABLE 
;------------------------------------------------------------


(declare-datatypes ((DSQ0_TupleType 0)) (((DSQ0_TupleType (DSQ0_instructor__SALARY Real) (DSQ0_instructor__DEPT_NAME DEPT_NAME) (DSQ0_instructor__ID ID) (DSQ0_COUNTinstructor__ID Int) (DSQ0_XDATA_CNT Int)))))
(declare-fun O_DSQ0 () (Array Int DSQ0_TupleType))

(assert
(and
	( =  (DSQ0_instructor__DEPT_NAME (select O_DSQ0 1)) (JSQ0_instructor__DEPT_NAME2 (select O_JSQ0 1)) )
	( =  (DSQ0_instructor__DEPT_NAME (select O_DSQ0 2)) (JSQ0_instructor__DEPT_NAME2 (select O_JSQ0 2)) )
	( =  (DSQ0_instructor__DEPT_NAME (select O_DSQ0 3)) (JSQ0_instructor__DEPT_NAME2 (select O_JSQ0 3)) )
	( =  (DSQ0_instructor__DEPT_NAME (select O_DSQ0 4)) (JSQ0_instructor__DEPT_NAME2 (select O_JSQ0 4)) )
	( =  (DSQ0_instructor__DEPT_NAME (select O_DSQ0 5)) (JSQ0_instructor__DEPT_NAME2 (select O_JSQ0 5)) )
)
)

(assert
(and
	( =  (DSQ0_instructor__SALARY (select O_DSQ0 1)) (JSQ0_instructor__SALARY3 (select O_JSQ0 1)) )
	( =  (DSQ0_instructor__SALARY (select O_DSQ0 2)) (JSQ0_instructor__SALARY3 (select O_JSQ0 2)) )
	( =  (DSQ0_instructor__SALARY (select O_DSQ0 3)) (JSQ0_instructor__SALARY3 (select O_JSQ0 3)) )
	( =  (DSQ0_instructor__SALARY (select O_DSQ0 4)) (JSQ0_instructor__SALARY3 (select O_JSQ0 4)) )
	( =  (DSQ0_instructor__SALARY (select O_DSQ0 5)) (JSQ0_instructor__SALARY3 (select O_JSQ0 5)) )
)
)

(assert
(and
	( =  (DSQ0_XDATA_CNT (select O_DSQ0 1)) 1 )
	( =  (DSQ0_XDATA_CNT (select O_DSQ0 2)) 1 )
	( =  (DSQ0_XDATA_CNT (select O_DSQ0 3)) 1 )
	( =  (DSQ0_XDATA_CNT (select O_DSQ0 4)) 1 )
	( =  (DSQ0_XDATA_CNT (select O_DSQ0 5)) 1 )
)
)


;------------------------------------------------------------
;END OF CONSTRAINTS FOR HAVING CLAUSE SUBQUERY: GROUPBY SUBQUERY TABLE 
;------------------------------------------------------------


;------------------------------------------------------------
; END OF HAVING CLAUSE SUBQUERY BLOCK 
;------------------------------------------------------------


;------------------------------------------------------------
; END OF OUTER QUERY AS SUBQUERY BLOCK 
;------------------------------------------------------------


;------------------------------------------------------------
; RANK QUERY CONSTRAINTS 
;------------------------------------------------------------


;------------------------------------------------------------
; DEFINE THE RELATION FOR WINDOW FUNCTION
;------------------------------------------------------------
(declare-datatypes ((X_WINDOW0_TupleType 0)) (((X_WINDOW0_TupleType (X_WINDOW0_ID0 ID) (X_WINDOW0_DEPT_NAME1 DEPT_NAME) (X_WINDOW0_ANALYTICAL_SALARY2 Real) (X_WINDOW0rank Int) (X_WINDOW0__XDATA_CNT Int)))))
(declare-fun O_X_WINDOW0 () (Array Int X_WINDOW0_TupleType))


;------------------------------------------------------------
; END DEFINE THE RELATION FOR THE WINDOW FUNCTION
;------------------------------------------------------------


;------------------------------------------------------------
; BEGIN MAPPING FOR WINDOW FUNCTION
;------------------------------------------------------------

(define-fun X_WINDOW0_map_DSQ0((x!0 Int) (x!1 Int)) Bool
(and 
(= (DSQ0_instructor__ID (select O_DSQ0 x!0))
   (X_WINDOW0_ID0 (select O_X_WINDOW0 x!1)))
(= (DSQ0_instructor__DEPT_NAME (select O_DSQ0 x!0))
   (X_WINDOW0_DEPT_NAME1 (select O_X_WINDOW0 x!1)))
(= (DSQ0_instructor__SALARY (select O_DSQ0 x!0))
   (X_WINDOW0_ANALYTICAL_SALARY2 (select O_X_WINDOW0 x!1)))
(= (DSQ0_XDATA_CNT (select O_DSQ0 x!0))
   (X_WINDOW0__XDATA_CNT (select O_X_WINDOW0 x!1)))
)
)


;------------------------------------------------------------
; END MAPPING FOR WINDOW FUNCTION
;------------------------------------------------------------


;------------------------------------------------------------
; BEGIN CONSTRAINTS FOR WINDOW FWD PASS
;------------------------------------------------------------
(assert (forall ((i1 Int))
(=>(and (> (DSQ0_XDATA_CNT (select O_DSQ0 i1)) 0) (>= i1 1) (<= i1 5 )) 
  (or
	(X_WINDOW0_map_DSQ0 i1 1)

	(X_WINDOW0_map_DSQ0 i1 2)

	(X_WINDOW0_map_DSQ0 i1 3)

	(X_WINDOW0_map_DSQ0 i1 4)

	(X_WINDOW0_map_DSQ0 i1 5)


)
)))


;------------------------------------------------------------
; END CONSTRAINTS FOR WINDOW FWD PASS
;------------------------------------------------------------


;------------------------------------------------------------
; BEGIN CONSTRAINTS FOR WINDOW BWD PASS
;------------------------------------------------------------
(assert (forall ((u Int))
(=> (and (> (X_WINDOW0__XDATA_CNT (select O_X_WINDOW0 u)) 0)(>= u 1) (<= u 5))
	
	(or
	(X_WINDOW0_map_DSQ0 1 u)
	
	(X_WINDOW0_map_DSQ0 2 u)
	
	(X_WINDOW0_map_DSQ0 3 u)
	
	(X_WINDOW0_map_DSQ0 4 u)
	
	(X_WINDOW0_map_DSQ0 5 u)
	
))))

;------------------------------------------------------------
; END CONSTRAINTS FOR WINDOW BWD PASS 
;------------------------------------------------------------


;------------------------------------------------------------
; ADD FINAL WINDOW CONSTRAINTS
;------------------------------------------------------------
(assert
(forall( (i Int))
(=> (and (>= i 1) (<= i 5))
(=(X_WINDOW0rank (select O_X_WINDOW0 i))
( + 
(ite ( and (not (ISNULL_SALARY(X_WINDOW0_ANALYTICAL_SALARY2 (select O_X_WINDOW0 1)))) (> (X_WINDOW0__XDATA_CNT (select O_X_WINDOW0 1)) 0)  (or (= i 1 )  (> (X_WINDOW0_ANALYTICAL_SALARY2 (select O_X_WINDOW0 i)) (X_WINDOW0_ANALYTICAL_SALARY2 (select O_X_WINDOW0 1)))))1 0)

(ite ( and (not (ISNULL_SALARY(X_WINDOW0_ANALYTICAL_SALARY2 (select O_X_WINDOW0 2)))) (> (X_WINDOW0__XDATA_CNT (select O_X_WINDOW0 2)) 0)  (or (= i 2 )  (> (X_WINDOW0_ANALYTICAL_SALARY2 (select O_X_WINDOW0 i)) (X_WINDOW0_ANALYTICAL_SALARY2 (select O_X_WINDOW0 2)))))1 0)

(ite ( and (not (ISNULL_SALARY(X_WINDOW0_ANALYTICAL_SALARY2 (select O_X_WINDOW0 3)))) (> (X_WINDOW0__XDATA_CNT (select O_X_WINDOW0 3)) 0)  (or (= i 3 )  (> (X_WINDOW0_ANALYTICAL_SALARY2 (select O_X_WINDOW0 i)) (X_WINDOW0_ANALYTICAL_SALARY2 (select O_X_WINDOW0 3)))))1 0)

(ite ( and (not (ISNULL_SALARY(X_WINDOW0_ANALYTICAL_SALARY2 (select O_X_WINDOW0 4)))) (> (X_WINDOW0__XDATA_CNT (select O_X_WINDOW0 4)) 0)  (or (= i 4 )  (> (X_WINDOW0_ANALYTICAL_SALARY2 (select O_X_WINDOW0 i)) (X_WINDOW0_ANALYTICAL_SALARY2 (select O_X_WINDOW0 4)))))1 0)

(ite ( and (not (ISNULL_SALARY(X_WINDOW0_ANALYTICAL_SALARY2 (select O_X_WINDOW0 5)))) (> (X_WINDOW0__XDATA_CNT (select O_X_WINDOW0 5)) 0)  (or (= i 5 )  (> (X_WINDOW0_ANALYTICAL_SALARY2 (select O_X_WINDOW0 i)) (X_WINDOW0_ANALYTICAL_SALARY2 (select O_X_WINDOW0 5)))))1 0)
 )
))))


;------------------------------------------------------------
; END FINAL WINDOW CONSTRAINTS
;------------------------------------------------------------


;------------------------------------------------------------
; END OF RANK QUERY CONSTRAINTS
;------------------------------------------------------------



;------------------------------------------------------------
;NOT NULL CONSTRAINTS


;------------------------------------------------------------

(assert (forall ((ipk0 Int)) 
 (and 
	(not ( ISNULL_ID(instructor_ID0 (select O_instructor ipk0))) )
	(not ( ISNULL_NAME(instructor_NAME1 (select O_instructor ipk0))) )
 )
))

(assert (forall ((ipk0 Int)) 
 (and 
	(not ( ISNULL_DEPT_NAME(department_DEPT_NAME0 (select O_department ipk0))) )
 )
))


;------------------------------------------------------------
;END OF NOT NULL CONSTRAINTS


;------------------------------------------------------------


(check-sat)
(get-model)
