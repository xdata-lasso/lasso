

;------------------------------------------------------------
;MUTATION TYPE: DATASET FOR GENERATING NON EMPTY RESULT 
;------------------------------------------------------------
(set-option :produce-models true)
 (set-option :smt.macro_finder true) 

(declare-fun intNullVal () Int)
(assert (= intNullVal (- 99996)))

(declare-fun realNullVal () Real)
(assert (= realNullVal (- 99996.0)))

(declare-datatypes ((ID 0)) (((_ID__10101) (_ID__12121) (_ID__15151) (_ID__22222) (_ID__32343) (_ID__33456) (_ID__45565) (_ID__58583) (_ID__76543) (_ID__76766) (_ID__83821) (_ID__98345) (_ID__V13) (_ID__V14) (_ID__V15) (_ID__V16) (_ID__V17) (_ID__V18) (_ID__V19) (_ID__V20) (NULL_ID_1))))

(declare-fun ISNULL_ID (ID) Bool)
(assert (forall ((id ID)) (= (ISNULL_ID id) (or (= id NULL_ID_1)))))




(declare-datatypes ((NAME 0)) (((_NAME__Einstein) (_NAME__Katz) (_NAME__Singh) (_NAME__Kim) (_NAME__Brandt) (_NAME__El_ubSaid) (_NAME__Wu) (_NAME__Srinivasan) (_NAME__Crick) (_NAME__Gold) (_NAME__Califieri) (_NAME__Mozart) (_NAME__V13) (_NAME__V14) (_NAME__V15) (_NAME__V16) (_NAME__V17) (_NAME__V18) (_NAME__V19) (_NAME__V20) (NULL_NAME_1))))

(declare-fun ISNULL_NAME (NAME) Bool)
(assert (forall ((name NAME)) (= (ISNULL_NAME name) (or (= name NULL_NAME_1)))))




(declare-datatypes ((DEPT_NAME 0)) (((_DEPT_uNAME__Finance) (_DEPT_uNAME__History) (_DEPT_uNAME__Physics) (_DEPT_uNAME__Music) (_DEPT_uNAME__Comp_d_ubSci_d) (_DEPT_uNAME__Biology) (_DEPT_uNAME__Elec_d_ubEng_d) (_DEPT_uNAME__V8) (_DEPT_uNAME__V9) (_DEPT_uNAME__V10) (_DEPT_uNAME__V11) (_DEPT_uNAME__V12) (_DEPT_uNAME__V13) (_DEPT_uNAME__V14) (_DEPT_uNAME__V15) (_DEPT_uNAME__V16) (_DEPT_uNAME__V17) (_DEPT_uNAME__V18) (_DEPT_uNAME__V19) (_DEPT_uNAME__V20) (NULL_DEPT_NAME_1))))

(declare-fun ISNULL_DEPT_NAME (DEPT_NAME) Bool)
(assert (forall ((dept_name DEPT_NAME))
  (= (ISNULL_DEPT_NAME dept_name) (or (= dept_name NULL_DEPT_NAME_1)))))




(declare-fun checkSALARY (Real) Bool)
(assert (forall ((r_SALARY Real))
  (= (checkSALARY r_SALARY)
     (or (and (>= r_SALARY 40000.0) (<= r_SALARY 95000.0))
         (= r_SALARY (- 99996.0))))))

(declare-fun ISNULL_SALARY (Real) Bool)
(assert (forall ((salary Real)) (= (ISNULL_SALARY salary) (or (= salary realNullVal)))))





(declare-datatypes ((COURSE_ID 0)) (((_COURSE_uID__BIO_m301) (_COURSE_uID__CS_m347) (_COURSE_uID__FIN_m201) (_COURSE_uID__CS_m315) (_COURSE_uID__EE_m181) (_COURSE_uID__BIO_m101) (_COURSE_uID__MU_m199) (_COURSE_uID__HIS_m351) (_COURSE_uID__PHY_m101) (_COURSE_uID__CS_m319) (_COURSE_uID__CS_m101) (_COURSE_uID__CS_m190) (_COURSE_uID__V13) (_COURSE_uID__V14) (_COURSE_uID__V15) (_COURSE_uID__V16) (_COURSE_uID__V17) (_COURSE_uID__V18) (_COURSE_uID__V19) (_COURSE_uID__V20) (NULL_COURSE_ID_1))))

(declare-fun ISNULL_COURSE_ID (COURSE_ID) Bool)
(assert (forall ((course_id COURSE_ID))
  (= (ISNULL_COURSE_ID course_id) (or (= course_id NULL_COURSE_ID_1)))))




(declare-datatypes ((SEC_ID 0)) (((_SEC_uID__2) (_SEC_uID__1) (_SEC_uID__V3) (_SEC_uID__V4) (_SEC_uID__V5) (_SEC_uID__V6) (_SEC_uID__V7) (_SEC_uID__V8) (_SEC_uID__V9) (_SEC_uID__V10) (_SEC_uID__V11) (_SEC_uID__V12) (_SEC_uID__V13) (_SEC_uID__V14) (_SEC_uID__V15) (_SEC_uID__V16) (_SEC_uID__V17) (_SEC_uID__V18) (_SEC_uID__V19) (_SEC_uID__V20) (NULL_SEC_ID_1))))

(declare-fun ISNULL_SEC_ID (SEC_ID) Bool)
(assert (forall ((sec_id SEC_ID))
  (= (ISNULL_SEC_ID sec_id) (or (= sec_id NULL_SEC_ID_1)))))




(declare-datatypes ((SEMESTER 0)) (((_SEMESTER__Summer) (_SEMESTER__Spring) (_SEMESTER__Fall) (_SEMESTER__V4) (_SEMESTER__V5) (_SEMESTER__V6) (_SEMESTER__V7) (_SEMESTER__V8) (_SEMESTER__V9) (_SEMESTER__V10) (_SEMESTER__V11) (_SEMESTER__V12) (_SEMESTER__V13) (_SEMESTER__V14) (_SEMESTER__V15) (_SEMESTER__V16) (_SEMESTER__V17) (_SEMESTER__V18) (_SEMESTER__V19) (_SEMESTER__V20) (NULL_SEMESTER_1))))

(declare-fun ISNULL_SEMESTER (SEMESTER) Bool)
(assert (forall ((semester SEMESTER))
  (= (ISNULL_SEMESTER semester) (or (= semester NULL_SEMESTER_1)))))




(declare-fun checkYEAR (Int) Bool)
(assert (forall ((i_YEAR Int))
  (= (checkYEAR i_YEAR)
     (or (and (> i_YEAR 2008) (< i_YEAR 2011)) (= i_YEAR (- 99996))))))

(declare-fun ISNULL_YEAR (Int) Bool)
(assert (forall ((year Int)) (= (ISNULL_YEAR year) (or (= year intNullVal)))))





(declare-datatypes ((BUILDING 0)) (((_BUILDING__Taylor) (_BUILDING__Packard) (_BUILDING__Painter) (_BUILDING__Watson) (_BUILDING__V5) (_BUILDING__V6) (_BUILDING__V7) (_BUILDING__V8) (_BUILDING__V9) (_BUILDING__V10) (_BUILDING__V11) (_BUILDING__V12) (_BUILDING__V13) (_BUILDING__V14) (_BUILDING__V15) (_BUILDING__V16) (_BUILDING__V17) (_BUILDING__V18) (_BUILDING__V19) (_BUILDING__V20) (NULL_BUILDING_1))))

(declare-fun ISNULL_BUILDING (BUILDING) Bool)
(assert (forall ((building BUILDING))
  (= (ISNULL_BUILDING building) (or (= building NULL_BUILDING_1)))))




(declare-fun checkBUDGET (Real) Bool)
(assert (forall ((r_BUDGET Real))
  (= (checkBUDGET r_BUDGET)
     (or (and (>= r_BUDGET 50000.0) (<= r_BUDGET 120000.0))
         (= r_BUDGET (- 99996.0))))))

(declare-fun ISNULL_BUDGET (Real) Bool)
(assert (forall ((budget Real)) (= (ISNULL_BUDGET budget) (or (= budget realNullVal)))))





(declare-datatypes ((ROOM_NUMBER 0)) (((_ROOM_uNUMBER__3128) (_ROOM_uNUMBER__120) (_ROOM_uNUMBER__100) (_ROOM_uNUMBER__101) (_ROOM_uNUMBER__514) (_ROOM_uNUMBER__V6) (_ROOM_uNUMBER__V7) (_ROOM_uNUMBER__V8) (_ROOM_uNUMBER__V9) (_ROOM_uNUMBER__V10) (_ROOM_uNUMBER__V11) (_ROOM_uNUMBER__V12) (_ROOM_uNUMBER__V13) (_ROOM_uNUMBER__V14) (_ROOM_uNUMBER__V15) (_ROOM_uNUMBER__V16) (_ROOM_uNUMBER__V17) (_ROOM_uNUMBER__V18) (_ROOM_uNUMBER__V19) (_ROOM_uNUMBER__V20) (NULL_ROOM_NUMBER_1))))

(declare-fun ISNULL_ROOM_NUMBER (ROOM_NUMBER) Bool)
(assert (forall ((room_number ROOM_NUMBER))
  (= (ISNULL_ROOM_NUMBER room_number) (or (= room_number NULL_ROOM_NUMBER_1)))))




(declare-datatypes ((TIME_SLOT_ID 0)) (((_TIME_uSLOT_uID__B) (_TIME_uSLOT_uID__C) (_TIME_uSLOT_uID__H) (_TIME_uSLOT_uID__D) (_TIME_uSLOT_uID__E) (_TIME_uSLOT_uID__F) (_TIME_uSLOT_uID__A) (_TIME_uSLOT_uID__V8) (_TIME_uSLOT_uID__V9) (_TIME_uSLOT_uID__V10) (_TIME_uSLOT_uID__V11) (_TIME_uSLOT_uID__V12) (_TIME_uSLOT_uID__V13) (_TIME_uSLOT_uID__V14) (_TIME_uSLOT_uID__V15) (_TIME_uSLOT_uID__V16) (_TIME_uSLOT_uID__V17) (_TIME_uSLOT_uID__V18) (_TIME_uSLOT_uID__V19) (_TIME_uSLOT_uID__V20) (NULL_TIME_SLOT_ID_1))))

(declare-fun ISNULL_TIME_SLOT_ID (TIME_SLOT_ID) Bool)
(assert (forall ((time_slot_id TIME_SLOT_ID))
  (= (ISNULL_TIME_SLOT_ID time_slot_id)
     (or (= time_slot_id NULL_TIME_SLOT_ID_1)))))




(declare-datatypes ((TITLE 0)) (((_TITLE__Music_ubVideo_ubProduction) (_TITLE__Robotics) (_TITLE__Game_ubDesign) (_TITLE__Intro_d_ubto_ubComputer_ubScience) (_TITLE__Database_ubSystem_ubConcepts) (_TITLE__Computational_ubBiology) (_TITLE__Genetics) (_TITLE__Intro_d_ubto_ubBiology) (_TITLE__World_ubHistory) (_TITLE__Intro_d_ubto_ubDigital_ubSystems) (_TITLE__Physical_ubPrinciples) (_TITLE__Investment_ubBanking) (_TITLE__Image_ubProcessing) (_TITLE__V14) (_TITLE__V15) (_TITLE__V16) (_TITLE__V17) (_TITLE__V18) (_TITLE__V19) (_TITLE__V20) (NULL_TITLE_1))))

(declare-fun ISNULL_TITLE (TITLE) Bool)
(assert (forall ((title TITLE)) (= (ISNULL_TITLE title) (or (= title NULL_TITLE_1)))))




(declare-fun checkCREDITS (Int) Bool)
(assert (forall ((i_CREDITS Int))
  (= (checkCREDITS i_CREDITS)
     (or (and (> i_CREDITS 2) (< i_CREDITS 5)) (= i_CREDITS (- 99996))))))

(declare-fun ISNULL_CREDITS (Int) Bool)
(assert (forall ((credits Int))
  (= (ISNULL_CREDITS credits) (or (= credits intNullVal)))))





(declare-fun checkCAPACITY (Int) Bool)
(assert (forall ((i_CAPACITY Int))
  (= (checkCAPACITY i_CAPACITY)
     (or (and (> i_CAPACITY 9) (< i_CAPACITY 501)) (= i_CAPACITY (- 99996))))))

(declare-fun ISNULL_CAPACITY (Int) Bool)
(assert (forall ((capacity Int))
  (= (ISNULL_CAPACITY capacity) (or (= capacity intNullVal)))))







;------------------------------------------------------------
; Tuple Types for Relations
 
;------------------------------------------------------------
(declare-datatypes ((instructor_TupleType 0)) (((instructor_TupleType (instructor_ID0 ID) (instructor_NAME1 NAME) (instructor_DEPT_NAME2 DEPT_NAME) (instructor_SALARY3 Real) (instructor_CNT4 Int)))))

(declare-datatypes ((teaches_TupleType 0)) (((teaches_TupleType (teaches_ID0 ID) (teaches_COURSE_ID1 COURSE_ID) (teaches_SEC_ID2 SEC_ID) (teaches_SEMESTER3 SEMESTER) (teaches_YEAR4 Int) (teaches_CNT5 Int)))))

(declare-datatypes ((section_TupleType 0)) (((section_TupleType (section_COURSE_ID0 COURSE_ID) (section_SEC_ID1 SEC_ID) (section_SEMESTER2 SEMESTER) (section_YEAR3 Int) (section_BUILDING4 BUILDING) (section_ROOM_NUMBER5 ROOM_NUMBER) (section_TIME_SLOT_ID6 TIME_SLOT_ID) (section_CNT7 Int)))))

(declare-datatypes ((course_TupleType 0)) (((course_TupleType (course_COURSE_ID0 COURSE_ID) (course_TITLE1 TITLE) (course_DEPT_NAME2 DEPT_NAME) (course_CREDITS3 Int) (course_CNT4 Int)))))

(declare-datatypes ((department_TupleType 0)) (((department_TupleType (department_DEPT_NAME0 DEPT_NAME) (department_BUILDING1 BUILDING) (department_BUDGET2 Real) (department_CNT3 Int)))))

(declare-datatypes ((classroom_TupleType 0)) (((classroom_TupleType (classroom_BUILDING0 BUILDING) (classroom_ROOM_NUMBER1 ROOM_NUMBER) (classroom_CAPACITY2 Int) (classroom_CNT3 Int)))))

(declare-fun O_instructor () (Array Int instructor_TupleType))

(declare-fun O_teaches () (Array Int teaches_TupleType))

(declare-fun O_department () (Array Int department_TupleType))

(declare-fun O_section () (Array Int section_TupleType))

(declare-fun O_course () (Array Int course_TupleType))

(declare-fun O_classroom () (Array Int classroom_TupleType))

;------------------------------------------------------------
;FOREIGN KEY CONSTRAINTS
;------------------------------------------------------------
(assert (or 
	 ( ISNULL_ID(teaches_ID0 (select O_teaches 1))) 

	(let ((a!1 (and (= (teaches_ID0 (select O_teaches 1))
                   (instructor_ID0 (select O_instructor 1)))
                (> (instructor_CNT4 (select O_instructor 1)) 0)))
      (a!2 (and (= (teaches_ID0 (select O_teaches 1))
                   (instructor_ID0 (select O_instructor 2)))
                (> (instructor_CNT4 (select O_instructor 2)) 0)))
      (a!3 (and (= (teaches_ID0 (select O_teaches 1))
                   (instructor_ID0 (select O_instructor 3)))
                (> (instructor_CNT4 (select O_instructor 3)) 0))))
  (or a!1 a!2 a!3 (= (teaches_CNT5 (select O_teaches 1)) 0))))
)

(assert (or 
	 ( ISNULL_ID(teaches_ID0 (select O_teaches 2))) 

	(let ((a!1 (and (= (teaches_ID0 (select O_teaches 2))
                   (instructor_ID0 (select O_instructor 1)))
                (> (instructor_CNT4 (select O_instructor 1)) 0)))
      (a!2 (and (= (teaches_ID0 (select O_teaches 2))
                   (instructor_ID0 (select O_instructor 2)))
                (> (instructor_CNT4 (select O_instructor 2)) 0)))
      (a!3 (and (= (teaches_ID0 (select O_teaches 2))
                   (instructor_ID0 (select O_instructor 3)))
                (> (instructor_CNT4 (select O_instructor 3)) 0))))
  (or a!1 a!2 a!3 (= (teaches_CNT5 (select O_teaches 2)) 0))))
)
(assert (or 
	 ( ISNULL_YEAR(teaches_YEAR4 (select O_teaches 1))) 

	(let ((a!1 (and (= (teaches_COURSE_ID1 (select O_teaches 1))
                   (section_COURSE_ID0 (select O_section 1)))
                (= (teaches_SEC_ID2 (select O_teaches 1))
                   (section_SEC_ID1 (select O_section 1)))
                (= (teaches_SEMESTER3 (select O_teaches 1))
                   (section_SEMESTER2 (select O_section 1)))
                (= (teaches_YEAR4 (select O_teaches 1))
                   (section_YEAR3 (select O_section 1)))
                (> (section_CNT7 (select O_section 1)) 0)))
      (a!2 (and (= (teaches_COURSE_ID1 (select O_teaches 1))
                   (section_COURSE_ID0 (select O_section 2)))
                (= (teaches_SEC_ID2 (select O_teaches 1))
                   (section_SEC_ID1 (select O_section 2)))
                (= (teaches_SEMESTER3 (select O_teaches 1))
                   (section_SEMESTER2 (select O_section 2)))
                (= (teaches_YEAR4 (select O_teaches 1))
                   (section_YEAR3 (select O_section 2)))
                (> (section_CNT7 (select O_section 2)) 0)))
      (a!3 (and (= (teaches_COURSE_ID1 (select O_teaches 1))
                   (section_COURSE_ID0 (select O_section 3)))
                (= (teaches_SEC_ID2 (select O_teaches 1))
                   (section_SEC_ID1 (select O_section 3)))
                (= (teaches_SEMESTER3 (select O_teaches 1))
                   (section_SEMESTER2 (select O_section 3)))
                (= (teaches_YEAR4 (select O_teaches 1))
                   (section_YEAR3 (select O_section 3)))
                (> (section_CNT7 (select O_section 3)) 0))))
  (or a!1 a!2 a!3 (= (teaches_CNT5 (select O_teaches 1)) 0))))
)

(assert (or 
	 ( ISNULL_YEAR(teaches_YEAR4 (select O_teaches 2))) 

	(let ((a!1 (and (= (teaches_COURSE_ID1 (select O_teaches 2))
                   (section_COURSE_ID0 (select O_section 1)))
                (= (teaches_SEC_ID2 (select O_teaches 2))
                   (section_SEC_ID1 (select O_section 1)))
                (= (teaches_SEMESTER3 (select O_teaches 2))
                   (section_SEMESTER2 (select O_section 1)))
                (= (teaches_YEAR4 (select O_teaches 2))
                   (section_YEAR3 (select O_section 1)))
                (> (section_CNT7 (select O_section 1)) 0)))
      (a!2 (and (= (teaches_COURSE_ID1 (select O_teaches 2))
                   (section_COURSE_ID0 (select O_section 2)))
                (= (teaches_SEC_ID2 (select O_teaches 2))
                   (section_SEC_ID1 (select O_section 2)))
                (= (teaches_SEMESTER3 (select O_teaches 2))
                   (section_SEMESTER2 (select O_section 2)))
                (= (teaches_YEAR4 (select O_teaches 2))
                   (section_YEAR3 (select O_section 2)))
                (> (section_CNT7 (select O_section 2)) 0)))
      (a!3 (and (= (teaches_COURSE_ID1 (select O_teaches 2))
                   (section_COURSE_ID0 (select O_section 3)))
                (= (teaches_SEC_ID2 (select O_teaches 2))
                   (section_SEC_ID1 (select O_section 3)))
                (= (teaches_SEMESTER3 (select O_teaches 2))
                   (section_SEMESTER2 (select O_section 3)))
                (= (teaches_YEAR4 (select O_teaches 2))
                   (section_YEAR3 (select O_section 3)))
                (> (section_CNT7 (select O_section 3)) 0))))
  (or a!1 a!2 a!3 (= (teaches_CNT5 (select O_teaches 2)) 0))))
)
(assert (or 
	 ( ISNULL_COURSE_ID(teaches_COURSE_ID1 (select O_teaches 1))) 

	(let ((a!1 (and (= (teaches_COURSE_ID1 (select O_teaches 1))
                   (course_COURSE_ID0 (select O_course 1)))
                (> (course_CNT4 (select O_course 1)) 0)))
      (a!2 (and (= (teaches_COURSE_ID1 (select O_teaches 1))
                   (course_COURSE_ID0 (select O_course 2)))
                (> (course_CNT4 (select O_course 2)) 0)))
      (a!3 (and (= (teaches_COURSE_ID1 (select O_teaches 1))
                   (course_COURSE_ID0 (select O_course 3)))
                (> (course_CNT4 (select O_course 3)) 0))))
  (or a!1 a!2 a!3 (= (teaches_CNT5 (select O_teaches 1)) 0))))
)

(assert (or 
	 ( ISNULL_COURSE_ID(teaches_COURSE_ID1 (select O_teaches 2))) 

	(let ((a!1 (and (= (teaches_COURSE_ID1 (select O_teaches 2))
                   (course_COURSE_ID0 (select O_course 1)))
                (> (course_CNT4 (select O_course 1)) 0)))
      (a!2 (and (= (teaches_COURSE_ID1 (select O_teaches 2))
                   (course_COURSE_ID0 (select O_course 2)))
                (> (course_CNT4 (select O_course 2)) 0)))
      (a!3 (and (= (teaches_COURSE_ID1 (select O_teaches 2))
                   (course_COURSE_ID0 (select O_course 3)))
                (> (course_CNT4 (select O_course 3)) 0))))
  (or a!1 a!2 a!3 (= (teaches_CNT5 (select O_teaches 2)) 0))))
)
(assert (or 
	 ( ISNULL_ROOM_NUMBER(section_ROOM_NUMBER5 (select O_section 1))) 

	(let ((a!1 (and (= (section_BUILDING4 (select O_section 1))
                   (classroom_BUILDING0 (select O_classroom 1)))
                (= (section_ROOM_NUMBER5 (select O_section 1))
                   (classroom_ROOM_NUMBER1 (select O_classroom 1)))
                (> (classroom_CNT3 (select O_classroom 1)) 0)))
      (a!2 (and (= (section_BUILDING4 (select O_section 1))
                   (classroom_BUILDING0 (select O_classroom 2)))
                (= (section_ROOM_NUMBER5 (select O_section 1))
                   (classroom_ROOM_NUMBER1 (select O_classroom 2)))
                (> (classroom_CNT3 (select O_classroom 2)) 0)))
      (a!3 (and (= (section_BUILDING4 (select O_section 1))
                   (classroom_BUILDING0 (select O_classroom 3)))
                (= (section_ROOM_NUMBER5 (select O_section 1))
                   (classroom_ROOM_NUMBER1 (select O_classroom 3)))
                (> (classroom_CNT3 (select O_classroom 3)) 0))))
  (or a!1 a!2 a!3 (= (section_CNT7 (select O_section 1)) 0))))
)

(assert (or 
	 ( ISNULL_ROOM_NUMBER(section_ROOM_NUMBER5 (select O_section 2))) 

	(let ((a!1 (and (= (section_BUILDING4 (select O_section 2))
                   (classroom_BUILDING0 (select O_classroom 1)))
                (= (section_ROOM_NUMBER5 (select O_section 2))
                   (classroom_ROOM_NUMBER1 (select O_classroom 1)))
                (> (classroom_CNT3 (select O_classroom 1)) 0)))
      (a!2 (and (= (section_BUILDING4 (select O_section 2))
                   (classroom_BUILDING0 (select O_classroom 2)))
                (= (section_ROOM_NUMBER5 (select O_section 2))
                   (classroom_ROOM_NUMBER1 (select O_classroom 2)))
                (> (classroom_CNT3 (select O_classroom 2)) 0)))
      (a!3 (and (= (section_BUILDING4 (select O_section 2))
                   (classroom_BUILDING0 (select O_classroom 3)))
                (= (section_ROOM_NUMBER5 (select O_section 2))
                   (classroom_ROOM_NUMBER1 (select O_classroom 3)))
                (> (classroom_CNT3 (select O_classroom 3)) 0))))
  (or a!1 a!2 a!3 (= (section_CNT7 (select O_section 2)) 0))))
)

(assert (or 
	 ( ISNULL_ROOM_NUMBER(section_ROOM_NUMBER5 (select O_section 3))) 

	(let ((a!1 (and (= (section_BUILDING4 (select O_section 3))
                   (classroom_BUILDING0 (select O_classroom 1)))
                (= (section_ROOM_NUMBER5 (select O_section 3))
                   (classroom_ROOM_NUMBER1 (select O_classroom 1)))
                (> (classroom_CNT3 (select O_classroom 1)) 0)))
      (a!2 (and (= (section_BUILDING4 (select O_section 3))
                   (classroom_BUILDING0 (select O_classroom 2)))
                (= (section_ROOM_NUMBER5 (select O_section 3))
                   (classroom_ROOM_NUMBER1 (select O_classroom 2)))
                (> (classroom_CNT3 (select O_classroom 2)) 0)))
      (a!3 (and (= (section_BUILDING4 (select O_section 3))
                   (classroom_BUILDING0 (select O_classroom 3)))
                (= (section_ROOM_NUMBER5 (select O_section 3))
                   (classroom_ROOM_NUMBER1 (select O_classroom 3)))
                (> (classroom_CNT3 (select O_classroom 3)) 0))))
  (or a!1 a!2 a!3 (= (section_CNT7 (select O_section 3)) 0))))
)
(assert (or 
	 ( ISNULL_COURSE_ID(section_COURSE_ID0 (select O_section 1))) 

	(let ((a!1 (and (= (section_COURSE_ID0 (select O_section 1))
                   (course_COURSE_ID0 (select O_course 1)))
                (> (course_CNT4 (select O_course 1)) 0)))
      (a!2 (and (= (section_COURSE_ID0 (select O_section 1))
                   (course_COURSE_ID0 (select O_course 2)))
                (> (course_CNT4 (select O_course 2)) 0)))
      (a!3 (and (= (section_COURSE_ID0 (select O_section 1))
                   (course_COURSE_ID0 (select O_course 3)))
                (> (course_CNT4 (select O_course 3)) 0)))
      (a!4 (and (= (section_COURSE_ID0 (select O_section 1))
                   (course_COURSE_ID0 (select O_course 4)))
                (> (course_CNT4 (select O_course 4)) 0)))
      (a!5 (and (= (section_COURSE_ID0 (select O_section 1))
                   (course_COURSE_ID0 (select O_course 5)))
                (> (course_CNT4 (select O_course 5)) 0)))
      (a!6 (and (= (section_COURSE_ID0 (select O_section 1))
                   (course_COURSE_ID0 (select O_course 6)))
                (> (course_CNT4 (select O_course 6)) 0))))
  (or a!1 a!2 a!3 a!4 a!5 a!6 (= (section_CNT7 (select O_section 1)) 0))))
)

(assert (or 
	 ( ISNULL_COURSE_ID(section_COURSE_ID0 (select O_section 2))) 

	(let ((a!1 (and (= (section_COURSE_ID0 (select O_section 2))
                   (course_COURSE_ID0 (select O_course 1)))
                (> (course_CNT4 (select O_course 1)) 0)))
      (a!2 (and (= (section_COURSE_ID0 (select O_section 2))
                   (course_COURSE_ID0 (select O_course 2)))
                (> (course_CNT4 (select O_course 2)) 0)))
      (a!3 (and (= (section_COURSE_ID0 (select O_section 2))
                   (course_COURSE_ID0 (select O_course 3)))
                (> (course_CNT4 (select O_course 3)) 0)))
      (a!4 (and (= (section_COURSE_ID0 (select O_section 2))
                   (course_COURSE_ID0 (select O_course 4)))
                (> (course_CNT4 (select O_course 4)) 0)))
      (a!5 (and (= (section_COURSE_ID0 (select O_section 2))
                   (course_COURSE_ID0 (select O_course 5)))
                (> (course_CNT4 (select O_course 5)) 0)))
      (a!6 (and (= (section_COURSE_ID0 (select O_section 2))
                   (course_COURSE_ID0 (select O_course 6)))
                (> (course_CNT4 (select O_course 6)) 0))))
  (or a!1 a!2 a!3 a!4 a!5 a!6 (= (section_CNT7 (select O_section 2)) 0))))
)

(assert (or 
	 ( ISNULL_COURSE_ID(section_COURSE_ID0 (select O_section 3))) 

	(let ((a!1 (and (= (section_COURSE_ID0 (select O_section 3))
                   (course_COURSE_ID0 (select O_course 1)))
                (> (course_CNT4 (select O_course 1)) 0)))
      (a!2 (and (= (section_COURSE_ID0 (select O_section 3))
                   (course_COURSE_ID0 (select O_course 2)))
                (> (course_CNT4 (select O_course 2)) 0)))
      (a!3 (and (= (section_COURSE_ID0 (select O_section 3))
                   (course_COURSE_ID0 (select O_course 3)))
                (> (course_CNT4 (select O_course 3)) 0)))
      (a!4 (and (= (section_COURSE_ID0 (select O_section 3))
                   (course_COURSE_ID0 (select O_course 4)))
                (> (course_CNT4 (select O_course 4)) 0)))
      (a!5 (and (= (section_COURSE_ID0 (select O_section 3))
                   (course_COURSE_ID0 (select O_course 5)))
                (> (course_CNT4 (select O_course 5)) 0)))
      (a!6 (and (= (section_COURSE_ID0 (select O_section 3))
                   (course_COURSE_ID0 (select O_course 6)))
                (> (course_CNT4 (select O_course 6)) 0))))
  (or a!1 a!2 a!3 a!4 a!5 a!6 (= (section_CNT7 (select O_section 3)) 0))))
)
(assert (or 
	 ( ISNULL_DEPT_NAME(course_DEPT_NAME2 (select O_course 1))) 

	(let ((a!1 (and (= (course_DEPT_NAME2 (select O_course 1))
                   (department_DEPT_NAME0 (select O_department 1)))
                (> (department_CNT3 (select O_department 1)) 0)))
      (a!2 (and (= (course_DEPT_NAME2 (select O_course 1))
                   (department_DEPT_NAME0 (select O_department 2)))
                (> (department_CNT3 (select O_department 2)) 0)))
      (a!3 (and (= (course_DEPT_NAME2 (select O_course 1))
                   (department_DEPT_NAME0 (select O_department 3)))
                (> (department_CNT3 (select O_department 3)) 0)))
      (a!4 (and (= (course_DEPT_NAME2 (select O_course 1))
                   (department_DEPT_NAME0 (select O_department 4)))
                (> (department_CNT3 (select O_department 4)) 0)))
      (a!5 (and (= (course_DEPT_NAME2 (select O_course 1))
                   (department_DEPT_NAME0 (select O_department 5)))
                (> (department_CNT3 (select O_department 5)) 0)))
      (a!6 (and (= (course_DEPT_NAME2 (select O_course 1))
                   (department_DEPT_NAME0 (select O_department 6)))
                (> (department_CNT3 (select O_department 6)) 0)))
      (a!7 (and (= (course_DEPT_NAME2 (select O_course 1))
                   (department_DEPT_NAME0 (select O_department 7)))
                (> (department_CNT3 (select O_department 7)) 0))))
  (or a!1 a!2 a!3 a!4 a!5 a!6 a!7 (= (course_CNT4 (select O_course 1)) 0))))
)

(assert (or 
	 ( ISNULL_DEPT_NAME(course_DEPT_NAME2 (select O_course 2))) 

	(let ((a!1 (and (= (course_DEPT_NAME2 (select O_course 2))
                   (department_DEPT_NAME0 (select O_department 1)))
                (> (department_CNT3 (select O_department 1)) 0)))
      (a!2 (and (= (course_DEPT_NAME2 (select O_course 2))
                   (department_DEPT_NAME0 (select O_department 2)))
                (> (department_CNT3 (select O_department 2)) 0)))
      (a!3 (and (= (course_DEPT_NAME2 (select O_course 2))
                   (department_DEPT_NAME0 (select O_department 3)))
                (> (department_CNT3 (select O_department 3)) 0)))
      (a!4 (and (= (course_DEPT_NAME2 (select O_course 2))
                   (department_DEPT_NAME0 (select O_department 4)))
                (> (department_CNT3 (select O_department 4)) 0)))
      (a!5 (and (= (course_DEPT_NAME2 (select O_course 2))
                   (department_DEPT_NAME0 (select O_department 5)))
                (> (department_CNT3 (select O_department 5)) 0)))
      (a!6 (and (= (course_DEPT_NAME2 (select O_course 2))
                   (department_DEPT_NAME0 (select O_department 6)))
                (> (department_CNT3 (select O_department 6)) 0)))
      (a!7 (and (= (course_DEPT_NAME2 (select O_course 2))
                   (department_DEPT_NAME0 (select O_department 7)))
                (> (department_CNT3 (select O_department 7)) 0))))
  (or a!1 a!2 a!3 a!4 a!5 a!6 a!7 (= (course_CNT4 (select O_course 2)) 0))))
)

(assert (or 
	 ( ISNULL_DEPT_NAME(course_DEPT_NAME2 (select O_course 3))) 

	(let ((a!1 (and (= (course_DEPT_NAME2 (select O_course 3))
                   (department_DEPT_NAME0 (select O_department 1)))
                (> (department_CNT3 (select O_department 1)) 0)))
      (a!2 (and (= (course_DEPT_NAME2 (select O_course 3))
                   (department_DEPT_NAME0 (select O_department 2)))
                (> (department_CNT3 (select O_department 2)) 0)))
      (a!3 (and (= (course_DEPT_NAME2 (select O_course 3))
                   (department_DEPT_NAME0 (select O_department 3)))
                (> (department_CNT3 (select O_department 3)) 0)))
      (a!4 (and (= (course_DEPT_NAME2 (select O_course 3))
                   (department_DEPT_NAME0 (select O_department 4)))
                (> (department_CNT3 (select O_department 4)) 0)))
      (a!5 (and (= (course_DEPT_NAME2 (select O_course 3))
                   (department_DEPT_NAME0 (select O_department 5)))
                (> (department_CNT3 (select O_department 5)) 0)))
      (a!6 (and (= (course_DEPT_NAME2 (select O_course 3))
                   (department_DEPT_NAME0 (select O_department 6)))
                (> (department_CNT3 (select O_department 6)) 0)))
      (a!7 (and (= (course_DEPT_NAME2 (select O_course 3))
                   (department_DEPT_NAME0 (select O_department 7)))
                (> (department_CNT3 (select O_department 7)) 0))))
  (or a!1 a!2 a!3 a!4 a!5 a!6 a!7 (= (course_CNT4 (select O_course 3)) 0))))
)

(assert (or 
	 ( ISNULL_DEPT_NAME(course_DEPT_NAME2 (select O_course 4))) 

	(let ((a!1 (and (= (course_DEPT_NAME2 (select O_course 4))
                   (department_DEPT_NAME0 (select O_department 1)))
                (> (department_CNT3 (select O_department 1)) 0)))
      (a!2 (and (= (course_DEPT_NAME2 (select O_course 4))
                   (department_DEPT_NAME0 (select O_department 2)))
                (> (department_CNT3 (select O_department 2)) 0)))
      (a!3 (and (= (course_DEPT_NAME2 (select O_course 4))
                   (department_DEPT_NAME0 (select O_department 3)))
                (> (department_CNT3 (select O_department 3)) 0)))
      (a!4 (and (= (course_DEPT_NAME2 (select O_course 4))
                   (department_DEPT_NAME0 (select O_department 4)))
                (> (department_CNT3 (select O_department 4)) 0)))
      (a!5 (and (= (course_DEPT_NAME2 (select O_course 4))
                   (department_DEPT_NAME0 (select O_department 5)))
                (> (department_CNT3 (select O_department 5)) 0)))
      (a!6 (and (= (course_DEPT_NAME2 (select O_course 4))
                   (department_DEPT_NAME0 (select O_department 6)))
                (> (department_CNT3 (select O_department 6)) 0)))
      (a!7 (and (= (course_DEPT_NAME2 (select O_course 4))
                   (department_DEPT_NAME0 (select O_department 7)))
                (> (department_CNT3 (select O_department 7)) 0))))
  (or a!1 a!2 a!3 a!4 a!5 a!6 a!7 (= (course_CNT4 (select O_course 4)) 0))))
)

(assert (or 
	 ( ISNULL_DEPT_NAME(course_DEPT_NAME2 (select O_course 5))) 

	(let ((a!1 (and (= (course_DEPT_NAME2 (select O_course 5))
                   (department_DEPT_NAME0 (select O_department 1)))
                (> (department_CNT3 (select O_department 1)) 0)))
      (a!2 (and (= (course_DEPT_NAME2 (select O_course 5))
                   (department_DEPT_NAME0 (select O_department 2)))
                (> (department_CNT3 (select O_department 2)) 0)))
      (a!3 (and (= (course_DEPT_NAME2 (select O_course 5))
                   (department_DEPT_NAME0 (select O_department 3)))
                (> (department_CNT3 (select O_department 3)) 0)))
      (a!4 (and (= (course_DEPT_NAME2 (select O_course 5))
                   (department_DEPT_NAME0 (select O_department 4)))
                (> (department_CNT3 (select O_department 4)) 0)))
      (a!5 (and (= (course_DEPT_NAME2 (select O_course 5))
                   (department_DEPT_NAME0 (select O_department 5)))
                (> (department_CNT3 (select O_department 5)) 0)))
      (a!6 (and (= (course_DEPT_NAME2 (select O_course 5))
                   (department_DEPT_NAME0 (select O_department 6)))
                (> (department_CNT3 (select O_department 6)) 0)))
      (a!7 (and (= (course_DEPT_NAME2 (select O_course 5))
                   (department_DEPT_NAME0 (select O_department 7)))
                (> (department_CNT3 (select O_department 7)) 0))))
  (or a!1 a!2 a!3 a!4 a!5 a!6 a!7 (= (course_CNT4 (select O_course 5)) 0))))
)

(assert (or 
	 ( ISNULL_DEPT_NAME(course_DEPT_NAME2 (select O_course 6))) 

	(let ((a!1 (and (= (course_DEPT_NAME2 (select O_course 6))
                   (department_DEPT_NAME0 (select O_department 1)))
                (> (department_CNT3 (select O_department 1)) 0)))
      (a!2 (and (= (course_DEPT_NAME2 (select O_course 6))
                   (department_DEPT_NAME0 (select O_department 2)))
                (> (department_CNT3 (select O_department 2)) 0)))
      (a!3 (and (= (course_DEPT_NAME2 (select O_course 6))
                   (department_DEPT_NAME0 (select O_department 3)))
                (> (department_CNT3 (select O_department 3)) 0)))
      (a!4 (and (= (course_DEPT_NAME2 (select O_course 6))
                   (department_DEPT_NAME0 (select O_department 4)))
                (> (department_CNT3 (select O_department 4)) 0)))
      (a!5 (and (= (course_DEPT_NAME2 (select O_course 6))
                   (department_DEPT_NAME0 (select O_department 5)))
                (> (department_CNT3 (select O_department 5)) 0)))
      (a!6 (and (= (course_DEPT_NAME2 (select O_course 6))
                   (department_DEPT_NAME0 (select O_department 6)))
                (> (department_CNT3 (select O_department 6)) 0)))
      (a!7 (and (= (course_DEPT_NAME2 (select O_course 6))
                   (department_DEPT_NAME0 (select O_department 7)))
                (> (department_CNT3 (select O_department 7)) 0))))
  (or a!1 a!2 a!3 a!4 a!5 a!6 a!7 (= (course_CNT4 (select O_course 6)) 0))))
)
(assert (or 
	 ( ISNULL_DEPT_NAME(instructor_DEPT_NAME2 (select O_instructor 1))) 

	(let ((a!1 (and (= (instructor_DEPT_NAME2 (select O_instructor 1))
                   (department_DEPT_NAME0 (select O_department 1)))
                (> (department_CNT3 (select O_department 1)) 0)))
      (a!2 (and (= (instructor_DEPT_NAME2 (select O_instructor 1))
                   (department_DEPT_NAME0 (select O_department 2)))
                (> (department_CNT3 (select O_department 2)) 0)))
      (a!3 (and (= (instructor_DEPT_NAME2 (select O_instructor 1))
                   (department_DEPT_NAME0 (select O_department 3)))
                (> (department_CNT3 (select O_department 3)) 0)))
      (a!4 (and (= (instructor_DEPT_NAME2 (select O_instructor 1))
                   (department_DEPT_NAME0 (select O_department 4)))
                (> (department_CNT3 (select O_department 4)) 0)))
      (a!5 (and (= (instructor_DEPT_NAME2 (select O_instructor 1))
                   (department_DEPT_NAME0 (select O_department 5)))
                (> (department_CNT3 (select O_department 5)) 0)))
      (a!6 (and (= (instructor_DEPT_NAME2 (select O_instructor 1))
                   (department_DEPT_NAME0 (select O_department 6)))
                (> (department_CNT3 (select O_department 6)) 0)))
      (a!7 (and (= (instructor_DEPT_NAME2 (select O_instructor 1))
                   (department_DEPT_NAME0 (select O_department 7)))
                (> (department_CNT3 (select O_department 7)) 0)))
      (a!8 (and (= (instructor_DEPT_NAME2 (select O_instructor 1))
                   (department_DEPT_NAME0 (select O_department 8)))
                (> (department_CNT3 (select O_department 8)) 0)))
      (a!9 (and (= (instructor_DEPT_NAME2 (select O_instructor 1))
                   (department_DEPT_NAME0 (select O_department 9)))
                (> (department_CNT3 (select O_department 9)) 0)))
      (a!10 (and (= (instructor_DEPT_NAME2 (select O_instructor 1))
                    (department_DEPT_NAME0 (select O_department 10)))
                 (> (department_CNT3 (select O_department 10)) 0))))
  (or a!1
      a!2
      a!3
      a!4
      a!5
      a!6
      a!7
      a!8
      a!9
      a!10
      (= (instructor_CNT4 (select O_instructor 1)) 0))))
)

(assert (or 
	 ( ISNULL_DEPT_NAME(instructor_DEPT_NAME2 (select O_instructor 2))) 

	(let ((a!1 (and (= (instructor_DEPT_NAME2 (select O_instructor 2))
                   (department_DEPT_NAME0 (select O_department 1)))
                (> (department_CNT3 (select O_department 1)) 0)))
      (a!2 (and (= (instructor_DEPT_NAME2 (select O_instructor 2))
                   (department_DEPT_NAME0 (select O_department 2)))
                (> (department_CNT3 (select O_department 2)) 0)))
      (a!3 (and (= (instructor_DEPT_NAME2 (select O_instructor 2))
                   (department_DEPT_NAME0 (select O_department 3)))
                (> (department_CNT3 (select O_department 3)) 0)))
      (a!4 (and (= (instructor_DEPT_NAME2 (select O_instructor 2))
                   (department_DEPT_NAME0 (select O_department 4)))
                (> (department_CNT3 (select O_department 4)) 0)))
      (a!5 (and (= (instructor_DEPT_NAME2 (select O_instructor 2))
                   (department_DEPT_NAME0 (select O_department 5)))
                (> (department_CNT3 (select O_department 5)) 0)))
      (a!6 (and (= (instructor_DEPT_NAME2 (select O_instructor 2))
                   (department_DEPT_NAME0 (select O_department 6)))
                (> (department_CNT3 (select O_department 6)) 0)))
      (a!7 (and (= (instructor_DEPT_NAME2 (select O_instructor 2))
                   (department_DEPT_NAME0 (select O_department 7)))
                (> (department_CNT3 (select O_department 7)) 0)))
      (a!8 (and (= (instructor_DEPT_NAME2 (select O_instructor 2))
                   (department_DEPT_NAME0 (select O_department 8)))
                (> (department_CNT3 (select O_department 8)) 0)))
      (a!9 (and (= (instructor_DEPT_NAME2 (select O_instructor 2))
                   (department_DEPT_NAME0 (select O_department 9)))
                (> (department_CNT3 (select O_department 9)) 0)))
      (a!10 (and (= (instructor_DEPT_NAME2 (select O_instructor 2))
                    (department_DEPT_NAME0 (select O_department 10)))
                 (> (department_CNT3 (select O_department 10)) 0))))
  (or a!1
      a!2
      a!3
      a!4
      a!5
      a!6
      a!7
      a!8
      a!9
      a!10
      (= (instructor_CNT4 (select O_instructor 2)) 0))))
)

(assert (or 
	 ( ISNULL_DEPT_NAME(instructor_DEPT_NAME2 (select O_instructor 3))) 

	(let ((a!1 (and (= (instructor_DEPT_NAME2 (select O_instructor 3))
                   (department_DEPT_NAME0 (select O_department 1)))
                (> (department_CNT3 (select O_department 1)) 0)))
      (a!2 (and (= (instructor_DEPT_NAME2 (select O_instructor 3))
                   (department_DEPT_NAME0 (select O_department 2)))
                (> (department_CNT3 (select O_department 2)) 0)))
      (a!3 (and (= (instructor_DEPT_NAME2 (select O_instructor 3))
                   (department_DEPT_NAME0 (select O_department 3)))
                (> (department_CNT3 (select O_department 3)) 0)))
      (a!4 (and (= (instructor_DEPT_NAME2 (select O_instructor 3))
                   (department_DEPT_NAME0 (select O_department 4)))
                (> (department_CNT3 (select O_department 4)) 0)))
      (a!5 (and (= (instructor_DEPT_NAME2 (select O_instructor 3))
                   (department_DEPT_NAME0 (select O_department 5)))
                (> (department_CNT3 (select O_department 5)) 0)))
      (a!6 (and (= (instructor_DEPT_NAME2 (select O_instructor 3))
                   (department_DEPT_NAME0 (select O_department 6)))
                (> (department_CNT3 (select O_department 6)) 0)))
      (a!7 (and (= (instructor_DEPT_NAME2 (select O_instructor 3))
                   (department_DEPT_NAME0 (select O_department 7)))
                (> (department_CNT3 (select O_department 7)) 0)))
      (a!8 (and (= (instructor_DEPT_NAME2 (select O_instructor 3))
                   (department_DEPT_NAME0 (select O_department 8)))
                (> (department_CNT3 (select O_department 8)) 0)))
      (a!9 (and (= (instructor_DEPT_NAME2 (select O_instructor 3))
                   (department_DEPT_NAME0 (select O_department 9)))
                (> (department_CNT3 (select O_department 9)) 0)))
      (a!10 (and (= (instructor_DEPT_NAME2 (select O_instructor 3))
                    (department_DEPT_NAME0 (select O_department 10)))
                 (> (department_CNT3 (select O_department 10)) 0))))
  (or a!1
      a!2
      a!3
      a!4
      a!5
      a!6
      a!7
      a!8
      a!9
      a!10
      (= (instructor_CNT4 (select O_instructor 3)) 0))))
)


;------------------------------------------------------------
;END OF FOREIGN  KEY CONSTRAINTS
;------------------------------------------------------------


;------------------------------------------------------------
;DOMAIN CONSTRAINTS
;------------------------------------------------------------
(assert (forall ((i Int))
  (let ((a!1 (or (checkSALARY (instructor_SALARY3 (select O_instructor i)))
                 (ISNULL_SALARY (instructor_SALARY3 (select O_instructor i))))))
    (=> (and (<= 1 i) (<= i 3)) (and a!1)))))

(assert (forall ((i Int))
  (let ((a!1 (or (checkYEAR (teaches_YEAR4 (select O_teaches i)))
                 (ISNULL_YEAR (teaches_YEAR4 (select O_teaches i))))))
    (=> (and (<= 1 i) (<= i 2)) (and a!1)))))

(assert (forall ((i Int))
  (let ((a!1 (or (checkBUDGET (department_BUDGET2 (select O_department i)))
                 (ISNULL_BUDGET (department_BUDGET2 (select O_department i))))))
    (=> (and (<= 1 i) (<= i 10)) (and a!1)))))

(assert (forall ((i Int))
  (let ((a!1 (or (checkYEAR (section_YEAR3 (select O_section i)))
                 (ISNULL_YEAR (section_YEAR3 (select O_section i))))))
    (=> (and (<= 1 i) (<= i 3)) (and a!1)))))

(assert (forall ((i Int))
  (let ((a!1 (or (checkCREDITS (course_CREDITS3 (select O_course i)))
                 (ISNULL_CREDITS (course_CREDITS3 (select O_course i))))))
    (=> (and (<= 1 i) (<= i 6)) (and a!1)))))

(assert (forall ((i Int))
  (let ((a!1 (or (checkCAPACITY (classroom_CAPACITY2 (select O_classroom i)))
                 (ISNULL_CAPACITY (classroom_CAPACITY2 (select O_classroom i))))))
    (=> (and (<= 1 i) (<= i 3)) (and a!1)))))

;------------------------------------------------------------
;END OF DOMAIN CONSTRAINTS
;------------------------------------------------------------

(declare-fun CHECKALL_NULLReal (Real) Bool)
(assert (forall ((Realcol Real))
  (= (CHECKALL_NULLReal Realcol) (= Realcol realNullVal))))

(declare-fun MAX_REPLACE_NULL_Real (Real) Real)
(assert (forall ((Realcol Real))
  (= (MAX_REPLACE_NULL_Real Realcol)
     (ite (= Realcol realNullVal) realNullVal Realcol))))

(declare-fun SUM_REPLACE_NULL_Real (Real) Real)
(assert (forall ((Realcol Real))
  (= (SUM_REPLACE_NULL_Real Realcol) (ite (= Realcol realNullVal) 0.0 Realcol))))

(declare-fun MIN_REPLACE_NULL_Real (Real) Real)
(assert (forall ((Realcol Real))
  (= (MIN_REPLACE_NULL_Real Realcol)
     (ite (= Realcol realNullVal) (- 0.0 realNullVal) Realcol))))

(declare-fun CHECKALL_NULLInt (Int) Bool)
(assert (forall ((Intcol Int)) (= (CHECKALL_NULLInt Intcol) (= Intcol intNullVal))))

(declare-fun MAX_REPLACE_NULL_Int (Int) Int)
(assert (forall ((Intcol Int))
  (= (MAX_REPLACE_NULL_Int Intcol)
     (ite (= Intcol intNullVal) intNullVal Intcol))))

(declare-fun SUM_REPLACE_NULL_Int (Int) Int)
(assert (forall ((Intcol Int))
  (= (SUM_REPLACE_NULL_Int Intcol) (ite (= Intcol intNullVal) 0 Intcol))))

(declare-fun MIN_REPLACE_NULL_Int (Int) Int)
(assert (forall ((Intcol Int))
  (= (MIN_REPLACE_NULL_Int Intcol)
     (ite (= Intcol intNullVal) (- 0 intNullVal) Intcol))))


;------------------------------------------------------------
;PRIMARY KEY CONSTRAINTS
;------------------------------------------------------------
(assert
 (let ((a!1 (or (distinct (instructor_ID0 (select O_instructor 1))
                         (instructor_ID0 (select O_instructor 2)))
               (= (instructor_CNT4 (select O_instructor 1)) 0)
               (= (instructor_CNT4 (select O_instructor 2)) 0)))
      (a!2 (or (distinct (instructor_ID0 (select O_instructor 1))
                         (instructor_ID0 (select O_instructor 3)))
               (= (instructor_CNT4 (select O_instructor 1)) 0)
               (= (instructor_CNT4 (select O_instructor 3)) 0)))
      (a!3 (or (distinct (instructor_ID0 (select O_instructor 2))
                         (instructor_ID0 (select O_instructor 3)))
               (= (instructor_CNT4 (select O_instructor 2)) 0)
               (= (instructor_CNT4 (select O_instructor 3)) 0))))
  (and a!1 a!2 a!3))
)
(assert
 (let ((a!1 (or (distinct (teaches_ID0 (select O_teaches 1))
                         (teaches_ID0 (select O_teaches 2)))
               (distinct (teaches_COURSE_ID1 (select O_teaches 1))
                         (teaches_COURSE_ID1 (select O_teaches 2)))
               (distinct (teaches_SEC_ID2 (select O_teaches 1))
                         (teaches_SEC_ID2 (select O_teaches 2)))
               (distinct (teaches_SEMESTER3 (select O_teaches 1))
                         (teaches_SEMESTER3 (select O_teaches 2)))
               (distinct (teaches_YEAR4 (select O_teaches 1))
                         (teaches_YEAR4 (select O_teaches 2)))
               (= (teaches_CNT5 (select O_teaches 1)) 0)
               (= (teaches_CNT5 (select O_teaches 2)) 0))))
  (and a!1))
)
(assert
 (let ((a!1 (or (distinct (department_DEPT_NAME0 (select O_department 1))
                         (department_DEPT_NAME0 (select O_department 2)))
               (= (department_CNT3 (select O_department 1)) 0)
               (= (department_CNT3 (select O_department 2)) 0)))
      (a!2 (or (distinct (department_DEPT_NAME0 (select O_department 1))
                         (department_DEPT_NAME0 (select O_department 3)))
               (= (department_CNT3 (select O_department 1)) 0)
               (= (department_CNT3 (select O_department 3)) 0)))
      (a!3 (or (distinct (department_DEPT_NAME0 (select O_department 1))
                         (department_DEPT_NAME0 (select O_department 4)))
               (= (department_CNT3 (select O_department 1)) 0)
               (= (department_CNT3 (select O_department 4)) 0)))
      (a!4 (or (distinct (department_DEPT_NAME0 (select O_department 1))
                         (department_DEPT_NAME0 (select O_department 5)))
               (= (department_CNT3 (select O_department 1)) 0)
               (= (department_CNT3 (select O_department 5)) 0)))
      (a!5 (or (distinct (department_DEPT_NAME0 (select O_department 1))
                         (department_DEPT_NAME0 (select O_department 6)))
               (= (department_CNT3 (select O_department 1)) 0)
               (= (department_CNT3 (select O_department 6)) 0)))
      (a!6 (or (distinct (department_DEPT_NAME0 (select O_department 1))
                         (department_DEPT_NAME0 (select O_department 7)))
               (= (department_CNT3 (select O_department 1)) 0)
               (= (department_CNT3 (select O_department 7)) 0)))
      (a!7 (or (distinct (department_DEPT_NAME0 (select O_department 1))
                         (department_DEPT_NAME0 (select O_department 8)))
               (= (department_CNT3 (select O_department 1)) 0)
               (= (department_CNT3 (select O_department 8)) 0)))
      (a!8 (or (distinct (department_DEPT_NAME0 (select O_department 1))
                         (department_DEPT_NAME0 (select O_department 9)))
               (= (department_CNT3 (select O_department 1)) 0)
               (= (department_CNT3 (select O_department 9)) 0)))
      (a!9 (or (distinct (department_DEPT_NAME0 (select O_department 1))
                         (department_DEPT_NAME0 (select O_department 10)))
               (= (department_CNT3 (select O_department 1)) 0)
               (= (department_CNT3 (select O_department 10)) 0)))
      (a!10 (or (distinct (department_DEPT_NAME0 (select O_department 2))
                          (department_DEPT_NAME0 (select O_department 3)))
                (= (department_CNT3 (select O_department 2)) 0)
                (= (department_CNT3 (select O_department 3)) 0)))
      (a!11 (or (distinct (department_DEPT_NAME0 (select O_department 2))
                          (department_DEPT_NAME0 (select O_department 4)))
                (= (department_CNT3 (select O_department 2)) 0)
                (= (department_CNT3 (select O_department 4)) 0)))
      (a!12 (or (distinct (department_DEPT_NAME0 (select O_department 2))
                          (department_DEPT_NAME0 (select O_department 5)))
                (= (department_CNT3 (select O_department 2)) 0)
                (= (department_CNT3 (select O_department 5)) 0)))
      (a!13 (or (distinct (department_DEPT_NAME0 (select O_department 2))
                          (department_DEPT_NAME0 (select O_department 6)))
                (= (department_CNT3 (select O_department 2)) 0)
                (= (department_CNT3 (select O_department 6)) 0)))
      (a!14 (or (distinct (department_DEPT_NAME0 (select O_department 2))
                          (department_DEPT_NAME0 (select O_department 7)))
                (= (department_CNT3 (select O_department 2)) 0)
                (= (department_CNT3 (select O_department 7)) 0)))
      (a!15 (or (distinct (department_DEPT_NAME0 (select O_department 2))
                          (department_DEPT_NAME0 (select O_department 8)))
                (= (department_CNT3 (select O_department 2)) 0)
                (= (department_CNT3 (select O_department 8)) 0)))
      (a!16 (or (distinct (department_DEPT_NAME0 (select O_department 2))
                          (department_DEPT_NAME0 (select O_department 9)))
                (= (department_CNT3 (select O_department 2)) 0)
                (= (department_CNT3 (select O_department 9)) 0)))
      (a!17 (or (distinct (department_DEPT_NAME0 (select O_department 2))
                          (department_DEPT_NAME0 (select O_department 10)))
                (= (department_CNT3 (select O_department 2)) 0)
                (= (department_CNT3 (select O_department 10)) 0)))
      (a!18 (or (distinct (department_DEPT_NAME0 (select O_department 3))
                          (department_DEPT_NAME0 (select O_department 4)))
                (= (department_CNT3 (select O_department 3)) 0)
                (= (department_CNT3 (select O_department 4)) 0)))
      (a!19 (or (distinct (department_DEPT_NAME0 (select O_department 3))
                          (department_DEPT_NAME0 (select O_department 5)))
                (= (department_CNT3 (select O_department 3)) 0)
                (= (department_CNT3 (select O_department 5)) 0)))
      (a!20 (or (distinct (department_DEPT_NAME0 (select O_department 3))
                          (department_DEPT_NAME0 (select O_department 6)))
                (= (department_CNT3 (select O_department 3)) 0)
                (= (department_CNT3 (select O_department 6)) 0)))
      (a!21 (or (distinct (department_DEPT_NAME0 (select O_department 3))
                          (department_DEPT_NAME0 (select O_department 7)))
                (= (department_CNT3 (select O_department 3)) 0)
                (= (department_CNT3 (select O_department 7)) 0)))
      (a!22 (or (distinct (department_DEPT_NAME0 (select O_department 3))
                          (department_DEPT_NAME0 (select O_department 8)))
                (= (department_CNT3 (select O_department 3)) 0)
                (= (department_CNT3 (select O_department 8)) 0)))
      (a!23 (or (distinct (department_DEPT_NAME0 (select O_department 3))
                          (department_DEPT_NAME0 (select O_department 9)))
                (= (department_CNT3 (select O_department 3)) 0)
                (= (department_CNT3 (select O_department 9)) 0)))
      (a!24 (or (distinct (department_DEPT_NAME0 (select O_department 3))
                          (department_DEPT_NAME0 (select O_department 10)))
                (= (department_CNT3 (select O_department 3)) 0)
                (= (department_CNT3 (select O_department 10)) 0)))
      (a!25 (or (distinct (department_DEPT_NAME0 (select O_department 4))
                          (department_DEPT_NAME0 (select O_department 5)))
                (= (department_CNT3 (select O_department 4)) 0)
                (= (department_CNT3 (select O_department 5)) 0)))
      (a!26 (or (distinct (department_DEPT_NAME0 (select O_department 4))
                          (department_DEPT_NAME0 (select O_department 6)))
                (= (department_CNT3 (select O_department 4)) 0)
                (= (department_CNT3 (select O_department 6)) 0)))
      (a!27 (or (distinct (department_DEPT_NAME0 (select O_department 4))
                          (department_DEPT_NAME0 (select O_department 7)))
                (= (department_CNT3 (select O_department 4)) 0)
                (= (department_CNT3 (select O_department 7)) 0)))
      (a!28 (or (distinct (department_DEPT_NAME0 (select O_department 4))
                          (department_DEPT_NAME0 (select O_department 8)))
                (= (department_CNT3 (select O_department 4)) 0)
                (= (department_CNT3 (select O_department 8)) 0)))
      (a!29 (or (distinct (department_DEPT_NAME0 (select O_department 4))
                          (department_DEPT_NAME0 (select O_department 9)))
                (= (department_CNT3 (select O_department 4)) 0)
                (= (department_CNT3 (select O_department 9)) 0)))
      (a!30 (or (distinct (department_DEPT_NAME0 (select O_department 4))
                          (department_DEPT_NAME0 (select O_department 10)))
                (= (department_CNT3 (select O_department 4)) 0)
                (= (department_CNT3 (select O_department 10)) 0)))
      (a!31 (or (distinct (department_DEPT_NAME0 (select O_department 5))
                          (department_DEPT_NAME0 (select O_department 6)))
                (= (department_CNT3 (select O_department 5)) 0)
                (= (department_CNT3 (select O_department 6)) 0)))
      (a!32 (or (distinct (department_DEPT_NAME0 (select O_department 5))
                          (department_DEPT_NAME0 (select O_department 7)))
                (= (department_CNT3 (select O_department 5)) 0)
                (= (department_CNT3 (select O_department 7)) 0)))
      (a!33 (or (distinct (department_DEPT_NAME0 (select O_department 5))
                          (department_DEPT_NAME0 (select O_department 8)))
                (= (department_CNT3 (select O_department 5)) 0)
                (= (department_CNT3 (select O_department 8)) 0)))
      (a!34 (or (distinct (department_DEPT_NAME0 (select O_department 5))
                          (department_DEPT_NAME0 (select O_department 9)))
                (= (department_CNT3 (select O_department 5)) 0)
                (= (department_CNT3 (select O_department 9)) 0)))
      (a!35 (or (distinct (department_DEPT_NAME0 (select O_department 5))
                          (department_DEPT_NAME0 (select O_department 10)))
                (= (department_CNT3 (select O_department 5)) 0)
                (= (department_CNT3 (select O_department 10)) 0)))
      (a!36 (or (distinct (department_DEPT_NAME0 (select O_department 6))
                          (department_DEPT_NAME0 (select O_department 7)))
                (= (department_CNT3 (select O_department 6)) 0)
                (= (department_CNT3 (select O_department 7)) 0)))
      (a!37 (or (distinct (department_DEPT_NAME0 (select O_department 6))
                          (department_DEPT_NAME0 (select O_department 8)))
                (= (department_CNT3 (select O_department 6)) 0)
                (= (department_CNT3 (select O_department 8)) 0)))
      (a!38 (or (distinct (department_DEPT_NAME0 (select O_department 6))
                          (department_DEPT_NAME0 (select O_department 9)))
                (= (department_CNT3 (select O_department 6)) 0)
                (= (department_CNT3 (select O_department 9)) 0)))
      (a!39 (or (distinct (department_DEPT_NAME0 (select O_department 6))
                          (department_DEPT_NAME0 (select O_department 10)))
                (= (department_CNT3 (select O_department 6)) 0)
                (= (department_CNT3 (select O_department 10)) 0)))
      (a!40 (or (distinct (department_DEPT_NAME0 (select O_department 7))
                          (department_DEPT_NAME0 (select O_department 8)))
                (= (department_CNT3 (select O_department 7)) 0)
                (= (department_CNT3 (select O_department 8)) 0)))
      (a!41 (or (distinct (department_DEPT_NAME0 (select O_department 7))
                          (department_DEPT_NAME0 (select O_department 9)))
                (= (department_CNT3 (select O_department 7)) 0)
                (= (department_CNT3 (select O_department 9)) 0)))
      (a!42 (or (distinct (department_DEPT_NAME0 (select O_department 7))
                          (department_DEPT_NAME0 (select O_department 10)))
                (= (department_CNT3 (select O_department 7)) 0)
                (= (department_CNT3 (select O_department 10)) 0)))
      (a!43 (or (distinct (department_DEPT_NAME0 (select O_department 8))
                          (department_DEPT_NAME0 (select O_department 9)))
                (= (department_CNT3 (select O_department 8)) 0)
                (= (department_CNT3 (select O_department 9)) 0)))
      (a!44 (or (distinct (department_DEPT_NAME0 (select O_department 8))
                          (department_DEPT_NAME0 (select O_department 10)))
                (= (department_CNT3 (select O_department 8)) 0)
                (= (department_CNT3 (select O_department 10)) 0)))
      (a!45 (or (distinct (department_DEPT_NAME0 (select O_department 9))
                          (department_DEPT_NAME0 (select O_department 10)))
                (= (department_CNT3 (select O_department 9)) 0)
                (= (department_CNT3 (select O_department 10)) 0))))
  (and a!1
       a!2
       a!3
       a!4
       a!5
       a!6
       a!7
       a!8
       a!9
       a!10
       a!11
       a!12
       a!13
       a!14
       a!15
       a!16
       a!17
       a!18
       a!19
       a!20
       a!21
       a!22
       a!23
       a!24
       a!25
       a!26
       a!27
       a!28
       a!29
       a!30
       a!31
       a!32
       a!33
       a!34
       a!35
       a!36
       a!37
       a!38
       a!39
       a!40
       a!41
       a!42
       a!43
       a!44
       a!45))
)
(assert
 (let ((a!1 (or (distinct (section_COURSE_ID0 (select O_section 1))
                         (section_COURSE_ID0 (select O_section 2)))
               (distinct (section_SEC_ID1 (select O_section 1))
                         (section_SEC_ID1 (select O_section 2)))
               (distinct (section_SEMESTER2 (select O_section 1))
                         (section_SEMESTER2 (select O_section 2)))
               (distinct (section_YEAR3 (select O_section 1))
                         (section_YEAR3 (select O_section 2)))
               (= (section_CNT7 (select O_section 1)) 0)
               (= (section_CNT7 (select O_section 2)) 0)))
      (a!2 (or (distinct (section_COURSE_ID0 (select O_section 1))
                         (section_COURSE_ID0 (select O_section 3)))
               (distinct (section_SEC_ID1 (select O_section 1))
                         (section_SEC_ID1 (select O_section 3)))
               (distinct (section_SEMESTER2 (select O_section 1))
                         (section_SEMESTER2 (select O_section 3)))
               (distinct (section_YEAR3 (select O_section 1))
                         (section_YEAR3 (select O_section 3)))
               (= (section_CNT7 (select O_section 1)) 0)
               (= (section_CNT7 (select O_section 3)) 0)))
      (a!3 (or (distinct (section_COURSE_ID0 (select O_section 2))
                         (section_COURSE_ID0 (select O_section 3)))
               (distinct (section_SEC_ID1 (select O_section 2))
                         (section_SEC_ID1 (select O_section 3)))
               (distinct (section_SEMESTER2 (select O_section 2))
                         (section_SEMESTER2 (select O_section 3)))
               (distinct (section_YEAR3 (select O_section 2))
                         (section_YEAR3 (select O_section 3)))
               (= (section_CNT7 (select O_section 2)) 0)
               (= (section_CNT7 (select O_section 3)) 0))))
  (and a!1 a!2 a!3))
)
(assert
 (let ((a!1 (or (distinct (course_COURSE_ID0 (select O_course 1))
                         (course_COURSE_ID0 (select O_course 2)))
               (= (course_CNT4 (select O_course 1)) 0)
               (= (course_CNT4 (select O_course 2)) 0)))
      (a!2 (or (distinct (course_COURSE_ID0 (select O_course 1))
                         (course_COURSE_ID0 (select O_course 3)))
               (= (course_CNT4 (select O_course 1)) 0)
               (= (course_CNT4 (select O_course 3)) 0)))
      (a!3 (or (distinct (course_COURSE_ID0 (select O_course 1))
                         (course_COURSE_ID0 (select O_course 4)))
               (= (course_CNT4 (select O_course 1)) 0)
               (= (course_CNT4 (select O_course 4)) 0)))
      (a!4 (or (distinct (course_COURSE_ID0 (select O_course 1))
                         (course_COURSE_ID0 (select O_course 5)))
               (= (course_CNT4 (select O_course 1)) 0)
               (= (course_CNT4 (select O_course 5)) 0)))
      (a!5 (or (distinct (course_COURSE_ID0 (select O_course 1))
                         (course_COURSE_ID0 (select O_course 6)))
               (= (course_CNT4 (select O_course 1)) 0)
               (= (course_CNT4 (select O_course 6)) 0)))
      (a!6 (or (distinct (course_COURSE_ID0 (select O_course 2))
                         (course_COURSE_ID0 (select O_course 3)))
               (= (course_CNT4 (select O_course 2)) 0)
               (= (course_CNT4 (select O_course 3)) 0)))
      (a!7 (or (distinct (course_COURSE_ID0 (select O_course 2))
                         (course_COURSE_ID0 (select O_course 4)))
               (= (course_CNT4 (select O_course 2)) 0)
               (= (course_CNT4 (select O_course 4)) 0)))
      (a!8 (or (distinct (course_COURSE_ID0 (select O_course 2))
                         (course_COURSE_ID0 (select O_course 5)))
               (= (course_CNT4 (select O_course 2)) 0)
               (= (course_CNT4 (select O_course 5)) 0)))
      (a!9 (or (distinct (course_COURSE_ID0 (select O_course 2))
                         (course_COURSE_ID0 (select O_course 6)))
               (= (course_CNT4 (select O_course 2)) 0)
               (= (course_CNT4 (select O_course 6)) 0)))
      (a!10 (or (distinct (course_COURSE_ID0 (select O_course 3))
                          (course_COURSE_ID0 (select O_course 4)))
                (= (course_CNT4 (select O_course 3)) 0)
                (= (course_CNT4 (select O_course 4)) 0)))
      (a!11 (or (distinct (course_COURSE_ID0 (select O_course 3))
                          (course_COURSE_ID0 (select O_course 5)))
                (= (course_CNT4 (select O_course 3)) 0)
                (= (course_CNT4 (select O_course 5)) 0)))
      (a!12 (or (distinct (course_COURSE_ID0 (select O_course 3))
                          (course_COURSE_ID0 (select O_course 6)))
                (= (course_CNT4 (select O_course 3)) 0)
                (= (course_CNT4 (select O_course 6)) 0)))
      (a!13 (or (distinct (course_COURSE_ID0 (select O_course 4))
                          (course_COURSE_ID0 (select O_course 5)))
                (= (course_CNT4 (select O_course 4)) 0)
                (= (course_CNT4 (select O_course 5)) 0)))
      (a!14 (or (distinct (course_COURSE_ID0 (select O_course 4))
                          (course_COURSE_ID0 (select O_course 6)))
                (= (course_CNT4 (select O_course 4)) 0)
                (= (course_CNT4 (select O_course 6)) 0)))
      (a!15 (or (distinct (course_COURSE_ID0 (select O_course 5))
                          (course_COURSE_ID0 (select O_course 6)))
                (= (course_CNT4 (select O_course 5)) 0)
                (= (course_CNT4 (select O_course 6)) 0))))
  (and a!1 a!2 a!3 a!4 a!5 a!6 a!7 a!8 a!9 a!10 a!11 a!12 a!13 a!14 a!15))
)
(assert
 (let ((a!1 (or (distinct (classroom_BUILDING0 (select O_classroom 1))
                         (classroom_BUILDING0 (select O_classroom 2)))
               (distinct (classroom_ROOM_NUMBER1 (select O_classroom 1))
                         (classroom_ROOM_NUMBER1 (select O_classroom 2)))
               (= (classroom_CNT3 (select O_classroom 1)) 0)
               (= (classroom_CNT3 (select O_classroom 2)) 0)))
      (a!2 (or (distinct (classroom_BUILDING0 (select O_classroom 1))
                         (classroom_BUILDING0 (select O_classroom 3)))
               (distinct (classroom_ROOM_NUMBER1 (select O_classroom 1))
                         (classroom_ROOM_NUMBER1 (select O_classroom 3)))
               (= (classroom_CNT3 (select O_classroom 1)) 0)
               (= (classroom_CNT3 (select O_classroom 3)) 0)))
      (a!3 (or (distinct (classroom_BUILDING0 (select O_classroom 2))
                         (classroom_BUILDING0 (select O_classroom 3)))
               (distinct (classroom_ROOM_NUMBER1 (select O_classroom 2))
                         (classroom_ROOM_NUMBER1 (select O_classroom 3)))
               (= (classroom_CNT3 (select O_classroom 2)) 0)
               (= (classroom_CNT3 (select O_classroom 3)) 0))))
  (and a!1 a!2 a!3))
)


;------------------------------------------------------------
;END OF PRIMARY KEY CONSTRAINTS
;------------------------------------------------------------


;------------------------------------------------------------
;UPPER BOUND LOWER BOUND CONSTRAINTS
;------------------------------------------------------------

(assert (and (>= (instructor_CNT4 (select O_instructor 1)) 0)
     (<= (instructor_CNT4 (select O_instructor 1)) 1)
     (>= (instructor_CNT4 (select O_instructor 2)) 0)
     (<= (instructor_CNT4 (select O_instructor 2)) 1)
     (>= (instructor_CNT4 (select O_instructor 3)) 0)
     (<= (instructor_CNT4 (select O_instructor 3)) 1)))

(assert (and (>= (teaches_CNT5 (select O_teaches 1)) 0)
     (<= (teaches_CNT5 (select O_teaches 1)) 1)
     (>= (teaches_CNT5 (select O_teaches 2)) 0)
     (<= (teaches_CNT5 (select O_teaches 2)) 1)))

(assert (and (>= (department_CNT3 (select O_department 1)) 0)
     (<= (department_CNT3 (select O_department 1)) 1)
     (>= (department_CNT3 (select O_department 2)) 0)
     (<= (department_CNT3 (select O_department 2)) 1)
     (>= (department_CNT3 (select O_department 3)) 0)
     (<= (department_CNT3 (select O_department 3)) 1)
     (>= (department_CNT3 (select O_department 4)) 0)
     (<= (department_CNT3 (select O_department 4)) 1)
     (>= (department_CNT3 (select O_department 5)) 0)
     (<= (department_CNT3 (select O_department 5)) 1)
     (>= (department_CNT3 (select O_department 6)) 0)
     (<= (department_CNT3 (select O_department 6)) 1)
     (>= (department_CNT3 (select O_department 7)) 0)
     (<= (department_CNT3 (select O_department 7)) 1)
     (>= (department_CNT3 (select O_department 8)) 0)
     (<= (department_CNT3 (select O_department 8)) 1)
     (>= (department_CNT3 (select O_department 9)) 0)
     (<= (department_CNT3 (select O_department 9)) 1)
     (>= (department_CNT3 (select O_department 10)) 0)
     (<= (department_CNT3 (select O_department 10)) 1)))

(assert (and (>= (section_CNT7 (select O_section 1)) 0)
     (<= (section_CNT7 (select O_section 1)) 1)
     (>= (section_CNT7 (select O_section 2)) 0)
     (<= (section_CNT7 (select O_section 2)) 1)
     (>= (section_CNT7 (select O_section 3)) 0)
     (<= (section_CNT7 (select O_section 3)) 1)))

(assert (and (>= (course_CNT4 (select O_course 1)) 0)
     (<= (course_CNT4 (select O_course 1)) 1)
     (>= (course_CNT4 (select O_course 2)) 0)
     (<= (course_CNT4 (select O_course 2)) 1)
     (>= (course_CNT4 (select O_course 3)) 0)
     (<= (course_CNT4 (select O_course 3)) 1)
     (>= (course_CNT4 (select O_course 4)) 0)
     (<= (course_CNT4 (select O_course 4)) 1)
     (>= (course_CNT4 (select O_course 5)) 0)
     (<= (course_CNT4 (select O_course 5)) 1)
     (>= (course_CNT4 (select O_course 6)) 0)
     (<= (course_CNT4 (select O_course 6)) 1)))

(assert (and (>= (classroom_CNT3 (select O_classroom 1)) 0)
     (<= (classroom_CNT3 (select O_classroom 1)) 1)
     (>= (classroom_CNT3 (select O_classroom 2)) 0)
     (<= (classroom_CNT3 (select O_classroom 2)) 1)
     (>= (classroom_CNT3 (select O_classroom 3)) 0)
     (<= (classroom_CNT3 (select O_classroom 3)) 1)))

(assert (>= (+ (instructor_CNT4 (select O_instructor 1))
       (instructor_CNT4 (select O_instructor 2))
       (instructor_CNT4 (select O_instructor 3)))
    1) )

(assert (<= (+ (instructor_CNT4 (select O_instructor 1))
       (instructor_CNT4 (select O_instructor 2))
       (instructor_CNT4 (select O_instructor 3)))
    3) )

(assert (>= (+ (teaches_CNT5 (select O_teaches 1)) (teaches_CNT5 (select O_teaches 2)))
    1) )

(assert (<= (+ (teaches_CNT5 (select O_teaches 1)) (teaches_CNT5 (select O_teaches 2)))
    2) )

(assert (>= (+ (department_CNT3 (select O_department 1))
       (department_CNT3 (select O_department 2))
       (department_CNT3 (select O_department 3))
       (department_CNT3 (select O_department 4))
       (department_CNT3 (select O_department 5))
       (department_CNT3 (select O_department 6))
       (department_CNT3 (select O_department 7))
       (department_CNT3 (select O_department 8))
       (department_CNT3 (select O_department 9))
       (department_CNT3 (select O_department 10)))
    1) )

(assert (<= (+ (department_CNT3 (select O_department 1))
       (department_CNT3 (select O_department 2))
       (department_CNT3 (select O_department 3))
       (department_CNT3 (select O_department 4))
       (department_CNT3 (select O_department 5))
       (department_CNT3 (select O_department 6))
       (department_CNT3 (select O_department 7))
       (department_CNT3 (select O_department 8))
       (department_CNT3 (select O_department 9))
       (department_CNT3 (select O_department 10)))
    10) )

(assert (>= (+ (section_CNT7 (select O_section 1))
       (section_CNT7 (select O_section 2))
       (section_CNT7 (select O_section 3)))
    1) )

(assert (<= (+ (section_CNT7 (select O_section 1))
       (section_CNT7 (select O_section 2))
       (section_CNT7 (select O_section 3)))
    3) )

(assert (>= (+ (course_CNT4 (select O_course 1))
       (course_CNT4 (select O_course 2))
       (course_CNT4 (select O_course 3))
       (course_CNT4 (select O_course 4))
       (course_CNT4 (select O_course 5))
       (course_CNT4 (select O_course 6)))
    1) )

(assert (<= (+ (course_CNT4 (select O_course 1))
       (course_CNT4 (select O_course 2))
       (course_CNT4 (select O_course 3))
       (course_CNT4 (select O_course 4))
       (course_CNT4 (select O_course 5))
       (course_CNT4 (select O_course 6)))
    6) )

(assert (>= (+ (classroom_CNT3 (select O_classroom 1))
       (classroom_CNT3 (select O_classroom 2))
       (classroom_CNT3 (select O_classroom 3)))
    0) )

(assert (<= (+ (classroom_CNT3 (select O_classroom 1))
       (classroom_CNT3 (select O_classroom 2))
       (classroom_CNT3 (select O_classroom 3)))
    3) )


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
;NULL CONSTRAINTS FOR OUTER BLOCK OF QUERY
;------------------------------------------------------------




;------------------------------------------------------------
;END OF NULL CONSTRAINTS FOR OUTER BLOCK OF QUERY
;------------------------------------------------------------



;------------------------------------------------------------
;NULL CONSTRAINTS FOR WHERE CLAUSE NESTED SUBQUERY BLOCK
;------------------------------------------------------------




;------------------------------------------------------------
;END OF NULL CONSTRAINTS FOR WHERE CLAUSE NESTED SUBQUERY BLOCK
;------------------------------------------------------------



;------------------------------------------------------------
; CONSTRAINTS OF THIS BLOCK 
;------------------------------------------------------------

 (assert  (and (= (instructor_ID0 (select O_instructor 1)) (teaches_ID0 (select O_teaches 1)))(> (instructor_CNT4 (select O_instructor 1)) 0)(> (teaches_CNT5 (select O_teaches 1)) 0)	)) 

 (assert  (and (= (instructor_CNT4 (select O_instructor 1)) (teaches_CNT5 (select O_teaches 1)))(> (instructor_CNT4 (select O_instructor 1)) 0)(> (teaches_CNT5 (select O_teaches 1)) 0)	)) 

 (assert  (and (= (teaches_CNT5 (select O_teaches 1)) (teaches_CNT5 (select O_teaches 1)))(> (teaches_CNT5 (select O_teaches 1)) 0)(> (teaches_CNT5 (select O_teaches 1)) 0)	)) 

 (assert  (and (= (teaches_CNT5 (select O_teaches 1)) (department_CNT3 (select O_department 1)))(> (teaches_CNT5 (select O_teaches 1)) 0)(> (department_CNT3 (select O_department 1)) 0)	)) 


;------------------------------------------------------------
; CONSTRAINTS FOR THIS CONJUNCT 
;------------------------------------------------------------


;------------------------------------------------------------
; WHERE CLAUSE SUBQUERY BLOCK CONSTRAINTS 
;------------------------------------------------------------


;------------------------------------------------------------
;CONSTRAINTS FOR WHERE CLAUSE SUBQUERY CONNECTIVE 
;------------------------------------------------------------


;------------------------------------------------------------
;CONSTRAINTS FOR CONDITIONS INSIDE WHERE CLAUSE SUBQUERY CONNECTIVE 
;------------------------------------------------------------


;------------------------------------------------------------
;GROUP BY CLAUSE CONSTRAINTS 
;------------------------------------------------------------


;------------------------------------------------------------
;END OF GROUP BY CLAUSE CONSTRAINTS 
;------------------------------------------------------------


;------------------------------------------------------------
;HAVING CLAUSE CONSTRAINTS 
;------------------------------------------------------------


;------------------------------------------------------------
;END OF HAVING CLAUSE CONSTRAINTS 
;------------------------------------------------------------


;------------------------------------------------------------
;END OF CONSTRAINTS FOR CONDITIONS INSIDE WHERE CLAUSE SUBQUERY CONNECTIVE 
;------------------------------------------------------------


;------------------------------------------------------------
; END OF WHERE CLAUSE SUBQUERY BLOCK CONSTRAINTS 
;------------------------------------------------------------


;------------------------------------------------------------
;GROUP BY CLAUSE CONSTRAINTS
;------------------------------------------------------------


;------------------------------------------------------------
;END OF GROUP BY CLAUSE CONSTRAINTS
;------------------------------------------------------------


;------------------------------------------------------------
;HAVING CLAUSE CONSTRAINTS
;------------------------------------------------------------


;------------------------------------------------------------
;END OF HAVING CLAUSE CONSTRAINTS
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
; CONSTRAINTS FOR WHERE CLAUSE SUBQUERY: JOIN SUBQUERY TABLE 
;------------------------------------------------------------
(declare-datatypes ((JSQ1_TupleType 0)) (((JSQ1_TupleType (JSQ1_teaches__ID0 ID) (JSQ1_teaches__COURSE_ID1 COURSE_ID) (JSQ1_teaches__SEC_ID2 SEC_ID) (JSQ1_teaches__SEMESTER3 SEMESTER) (JSQ1_teaches__YEAR4 Int) (JSQ1_teaches__CNT5 Int) (JSQ1_section__COURSE_ID6 COURSE_ID) (JSQ1_section__SEC_ID7 SEC_ID) (JSQ1_section__SEMESTER8 SEMESTER) (JSQ1_section__YEAR9 Int) (JSQ1_section__BUILDING10 BUILDING) (JSQ1_section__ROOM_NUMBER11 ROOM_NUMBER) (JSQ1_section__TIME_SLOT_ID12 TIME_SLOT_ID) (JSQ1_section__CNT13 Int) (JSQ1_course__COURSE_ID14 COURSE_ID) (JSQ1_course__TITLE15 TITLE) (JSQ1_course__DEPT_NAME16 DEPT_NAME) (JSQ1_course__CREDITS17 Int) (JSQ1_course__CNT18 Int) (JSQ1__CNT_k Int)))))
(declare-fun O_JSQ1 () (Array Int JSQ1_TupleType))

(assert (forall ((i1 Int)) 
	(let ((a!1 (= (JSQ1__CNT_k (select O_JSQ1 i1))
              (* (JSQ1_teaches__CNT5 (select O_JSQ1 i1))
                 (JSQ1_section__CNT13 (select O_JSQ1 i1))
                 (JSQ1_course__CNT18 (select O_JSQ1 i1))
                 (JSQ1__CNT_k (select O_JSQ1 i1))))))
(let ((a!2 (or a!1 (= (JSQ1__CNT_k (select O_JSQ1 i1)) 0))))
  (and (>= (JSQ1__CNT_k (select O_JSQ1 i1)) 0)
       (<= (JSQ1__CNT_k (select O_JSQ1 i1)) 36)
       a!2)))))

(define-fun JSQ1_map_teaches((x!0 Int) (x!1 Int)) Bool
(and 
(= (teaches_ID0 (select O_teaches x!0)) (JSQ1_teaches__ID0 (select O_JSQ1 x!1)))
(= (teaches_COURSE_ID1 (select O_teaches x!0))
   (JSQ1_teaches__COURSE_ID1 (select O_JSQ1 x!1)))
(= (teaches_SEC_ID2 (select O_teaches x!0))
   (JSQ1_teaches__SEC_ID2 (select O_JSQ1 x!1)))
(= (teaches_SEMESTER3 (select O_teaches x!0))
   (JSQ1_teaches__SEMESTER3 (select O_JSQ1 x!1)))
(= (teaches_YEAR4 (select O_teaches x!0))
   (JSQ1_teaches__YEAR4 (select O_JSQ1 x!1)))
(= (teaches_CNT5 (select O_teaches x!0))
   (JSQ1_teaches__CNT5 (select O_JSQ1 x!1)))
)
)

(define-fun JSQ1_map_section((x!0 Int) (x!1 Int)) Bool
(and 
(= (section_COURSE_ID0 (select O_section x!0))
   (JSQ1_section__COURSE_ID6 (select O_JSQ1 x!1)))
(= (section_SEC_ID1 (select O_section x!0))
   (JSQ1_section__SEC_ID7 (select O_JSQ1 x!1)))
(= (section_SEMESTER2 (select O_section x!0))
   (JSQ1_section__SEMESTER8 (select O_JSQ1 x!1)))
(= (section_YEAR3 (select O_section x!0))
   (JSQ1_section__YEAR9 (select O_JSQ1 x!1)))
(= (section_BUILDING4 (select O_section x!0))
   (JSQ1_section__BUILDING10 (select O_JSQ1 x!1)))
(= (section_ROOM_NUMBER5 (select O_section x!0))
   (JSQ1_section__ROOM_NUMBER11 (select O_JSQ1 x!1)))
(= (section_TIME_SLOT_ID6 (select O_section x!0))
   (JSQ1_section__TIME_SLOT_ID12 (select O_JSQ1 x!1)))
(= (section_CNT7 (select O_section x!0))
   (JSQ1_section__CNT13 (select O_JSQ1 x!1)))
)
)

(define-fun JSQ1_map_course((x!0 Int) (x!1 Int)) Bool
(and 
(= (course_COURSE_ID0 (select O_course x!0))
   (JSQ1_course__COURSE_ID14 (select O_JSQ1 x!1)))
(= (course_TITLE1 (select O_course x!0))
   (JSQ1_course__TITLE15 (select O_JSQ1 x!1)))
(= (course_DEPT_NAME2 (select O_course x!0))
   (JSQ1_course__DEPT_NAME16 (select O_JSQ1 x!1)))
(= (course_CREDITS3 (select O_course x!0))
   (JSQ1_course__CREDITS17 (select O_JSQ1 x!1)))
(= (course_CNT4 (select O_course x!0)) (JSQ1_course__CNT18 (select O_JSQ1 x!1)))
)
)

(assert (forall ((i1 Int) (j1 Int)) 
	 (=> 
	(and (= (JSQ1_teaches__ID0 (select O_JSQ1 i1))
        (JSQ1_teaches__ID0 (select O_JSQ1 j1)))
     (= (JSQ1_teaches__COURSE_ID1 (select O_JSQ1 i1))
        (JSQ1_teaches__COURSE_ID1 (select O_JSQ1 j1)))
     (= (JSQ1_teaches__SEC_ID2 (select O_JSQ1 i1))
        (JSQ1_teaches__SEC_ID2 (select O_JSQ1 j1)))
     (= (JSQ1_teaches__SEMESTER3 (select O_JSQ1 i1))
        (JSQ1_teaches__SEMESTER3 (select O_JSQ1 j1)))
     (= (JSQ1_teaches__YEAR4 (select O_JSQ1 i1))
        (JSQ1_teaches__YEAR4 (select O_JSQ1 j1)))
     (= (JSQ1_section__COURSE_ID6 (select O_JSQ1 i1))
        (JSQ1_section__COURSE_ID6 (select O_JSQ1 j1)))
     (= (JSQ1_section__SEC_ID7 (select O_JSQ1 i1))
        (JSQ1_section__SEC_ID7 (select O_JSQ1 j1)))
     (= (JSQ1_section__SEMESTER8 (select O_JSQ1 i1))
        (JSQ1_section__SEMESTER8 (select O_JSQ1 j1)))
     (= (JSQ1_section__YEAR9 (select O_JSQ1 i1))
        (JSQ1_section__YEAR9 (select O_JSQ1 j1)))
     (= (JSQ1_course__COURSE_ID14 (select O_JSQ1 i1))
        (JSQ1_course__COURSE_ID14 (select O_JSQ1 j1)))
     (not (= i1 j1)))
		(or (= (JSQ1__CNT_k (select O_JSQ1 i1)) 0)
    (= (JSQ1__CNT_k (select O_JSQ1 j1)) 0)))))

(assert (forall ((teaches_i  Int)(section_i  Int)(course_i  Int)) 
	(=> (and 
		 (=  (teaches_COURSE_ID1 (select O_teaches teaches_i))  (section_COURSE_ID0 (select O_section section_i)) )
		 (=  (teaches_SEC_ID2 (select O_teaches teaches_i))  (section_SEC_ID1 (select O_section section_i)) )
		 (=  (teaches_SEMESTER3 (select O_teaches teaches_i))  (section_SEMESTER2 (select O_section section_i)) )
		 (=  (teaches_YEAR4 (select O_teaches teaches_i))  (section_YEAR3 (select O_section section_i)) )
		 (=  (teaches_CNT5 (select O_teaches teaches_i))  (section_CNT7 (select O_section section_i)) )
		 (=  (section_COURSE_ID0 (select O_section section_i))  (course_COURSE_ID0 (select O_course course_i)) )
		 (=  (section_CNT7 (select O_section section_i))  (course_CNT4 (select O_course course_i)) )
(> (teaches_CNT5 (select O_teaches teaches_i)) 0)
(> (section_CNT7 (select O_section section_i)) 0)
(> (course_CNT4 (select O_course course_i)) 0)
		)  
 	(exists ((JSQ1_i Int)) 
	 (and 
(> JSQ1_i 0)
(<= JSQ1_i 36)
(> (JSQ1__CNT_k (select O_JSQ1 JSQ1_i)) 0)
(JSQ1_map_teaches teaches_i JSQ1_i)
(JSQ1_map_section section_i JSQ1_i)
(JSQ1_map_course course_i JSQ1_i)
))
)
)
)(assert (forall ((i1 Int)) 
 (=> (> (JSQ1__CNT_k (select O_JSQ1 i1)) 0)
(and 
	(> i1 0)
(<= i1 36)


	
	(= ( JSQ1_teaches__COURSE_ID1 (select O_JSQ1 i1 )) ( JSQ1_section__COURSE_ID6 (select O_JSQ1 i1 ))  )
	(= ( JSQ1_teaches__SEC_ID2 (select O_JSQ1 i1 )) ( JSQ1_section__SEC_ID7 (select O_JSQ1 i1 ))  )
	(= ( JSQ1_teaches__SEMESTER3 (select O_JSQ1 i1 )) ( JSQ1_section__SEMESTER8 (select O_JSQ1 i1 ))  )
	(= ( JSQ1_teaches__YEAR4 (select O_JSQ1 i1 )) ( JSQ1_section__YEAR9 (select O_JSQ1 i1 ))  )
	(= ( JSQ1_teaches__CNT5 (select O_JSQ1 i1 )) ( JSQ1_section__CNT13 (select O_JSQ1 i1 ))  )
	(= ( JSQ1_section__COURSE_ID6 (select O_JSQ1 i1 )) ( JSQ1_course__COURSE_ID14 (select O_JSQ1 i1 ))  )
	(= ( JSQ1_section__CNT13 (select O_JSQ1 i1 )) ( JSQ1_course__CNT18 (select O_JSQ1 i1 ))  )
	
	(or 		(JSQ1_map_teaches 	1	i1)
		(JSQ1_map_teaches 	2	i1)

	)
 	(or 		(JSQ1_map_section 	1	i1)
		(JSQ1_map_section 	2	i1)
		(JSQ1_map_section 	3	i1)

	)
 	(or 		(JSQ1_map_course 	1	i1)
		(JSQ1_map_course 	2	i1)
		(JSQ1_map_course 	3	i1)
		(JSQ1_map_course 	4	i1)
		(JSQ1_map_course 	5	i1)
		(JSQ1_map_course 	6	i1)

	)
   )
  
 )
))

;------------------------------------------------------------
;CORRELATION CONSTRAINTS FOR SUB QUERY TABLE
;------------------------------------------------------------
(assert 
	(and 
		
		(= (JSQ1_teaches__ID0 (select O_JSQ1 1))
   (instructor_ID0 (select O_instructor 1)))

	) 
)

;------------------------------------------------------------
;CORRELATION CONSTRAINTS FOR SUB QUERY TABLE END
;------------------------------------------------------------



;------------------------------------------------------------
;END OF CONSTRAINTS FOR WHERE CLAUSE SUBQUERY: JOIN SUBQUERY TABLE 
;------------------------------------------------------------


;------------------------------------------------------------
; END OF WHERE CLAUSE SUBQUERY BLOCK 
;------------------------------------------------------------


;------------------------------------------------------------
; END OF CONSTRAINTS OF THIS BLOCK 
;------------------------------------------------------------



;------------------------------------------------------------
;BRANCHQUERY CONSTRAINTS
;------------------------------------------------------------



;------------------------------------------------------------
; BRANCH QUERY CONSTRAINTS FOR DIFFERENT GROUP BY COLUMN FROM PRIMARY QUERY
;------------------------------------------------------------


;------------------------------------------------------------
; BRANCH QUERY CONSTRAINTS FOR DIFFERENT GROUP BY COLUMN FROM OTHER BRANCH QUERIES
;------------------------------------------------------------


;------------------------------------------------------------
; BRANCH QUERY CONSTRAINTS FOR SAME GROUP BY COLUMN OF A BRANCH QUERY
;------------------------------------------------------------


;------------------------------------------------------------
; BRANCH QUERY GROUP BY CONSTRAINTS
;------------------------------------------------------------


;------------------------------------------------------------
; PRIMARY KEY CONSTRAINTS FOR BRANCH QUERY
;------------------------------------------------------------


;------------------------------------------------------------
; FOREIGN KEY CONSTRAINTS FOR BRANCH QUERY
;------------------------------------------------------------


;------------------------------------------------------------
;NOT NULL CONSTRAINTS FOR BRANCHQUERY


;------------------------------------------------------------



;------------------------------------------------------------
;END OF BRANCHQUERY CONSTRAINTS
;------------------------------------------------------------


;------------------------------------------------------------
;NOT NULL CONSTRAINTS


;------------------------------------------------------------

(assert (forall ((ipk0 Int)) 
 (and 
	(not ( ISNULL_ID(instructor_ID0 (select O_instructor ipk0))) )
 )
))

(assert (forall ((ipk0 Int)) 
 (and 
	(not ( ISNULL_ID(teaches_ID0 (select O_teaches ipk0))) )
	(not ( ISNULL_COURSE_ID(teaches_COURSE_ID1 (select O_teaches ipk0))) )
	(not ( ISNULL_SEC_ID(teaches_SEC_ID2 (select O_teaches ipk0))) )
	(not ( ISNULL_SEMESTER(teaches_SEMESTER3 (select O_teaches ipk0))) )
	(not ( ISNULL_YEAR(teaches_YEAR4 (select O_teaches ipk0))) )
 )
))

(assert (forall ((ipk0 Int)) 
 (and 
	(not ( ISNULL_DEPT_NAME(department_DEPT_NAME0 (select O_department ipk0))) )
 )
))

(assert (forall ((ipk0 Int)) 
 (and 
	(not ( ISNULL_COURSE_ID(section_COURSE_ID0 (select O_section ipk0))) )
	(not ( ISNULL_SEC_ID(section_SEC_ID1 (select O_section ipk0))) )
	(not ( ISNULL_SEMESTER(section_SEMESTER2 (select O_section ipk0))) )
	(not ( ISNULL_YEAR(section_YEAR3 (select O_section ipk0))) )
 )
))

(assert (forall ((ipk0 Int)) 
 (and 
	(not ( ISNULL_COURSE_ID(course_COURSE_ID0 (select O_course ipk0))) )
 )
))

(assert (forall ((ipk0 Int)) 
 (and 
	(not ( ISNULL_BUILDING(classroom_BUILDING0 (select O_classroom ipk0))) )
	(not ( ISNULL_ROOM_NUMBER(classroom_ROOM_NUMBER1 (select O_classroom ipk0))) )
 )
))


;------------------------------------------------------------
;END OF NOT NULL CONSTRAINTS


;------------------------------------------------------------


(check-sat)
(get-model)