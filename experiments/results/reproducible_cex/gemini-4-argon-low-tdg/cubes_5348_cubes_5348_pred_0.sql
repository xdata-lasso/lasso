-- Schema DDL
CREATE TABLE "list" ("LastName" TEXT, "FirstName" TEXT, "Grade" INTEGER, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

CREATE TABLE "teachers" ("LastName" TEXT, "FirstName" TEXT, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. Grouping by (classroom, grade) vs grouping by ONLY classroom or ONLY grade.
-- 2. Ties for maximum (classroom, grade) count across different classrooms (102 and 103 both have max count 3).
-- 3. Ordering of results (inserted in reverse order of classroom numbers).
-- 4. Unmatched classrooms in 'teachers' vs 'list' (tests erroneous JOINs with 'teachers').
-- 5. Classroom 101 has total 4 students (2+2), which is greater than the max (classroom, grade) count of 3.
-- 6. Grade 2 has total 4 students (2+2), which is also greater than 3.
INSERT INTO teachers (LastName, FirstName, Classroom) VALUES ('T1', 'F1', 102);
INSERT INTO teachers (LastName, FirstName, Classroom) VALUES ('T2', 'F2', 999);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('S1', 'A', 4, 103);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('S2', 'A', 4, 103);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('S3', 'A', 4, 103);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('S4', 'A', 3, 102);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('S5', 'A', 3, 102);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('S6', 'A', 3, 102);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('S7', 'A', 1, 101);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('S8', 'A', 1, 101);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('S9', 'A', 2, 101);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('S10', 'A', 2, 101);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('S11', 'A', 2, 104);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('S12', 'A', 2, 104);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT classroom FROM (SELECT LHS.classroom AS classroom, LHS.grade AS grade, LHS.n AS n, LHS.maxn AS maxn, RHS.classroom AS classroom_other, RHS.grade AS grade_other, RHS.n AS n_other, RHS.maxn AS maxn_other FROM (SELECT classroom, grade, n, MAX(n) OVER () AS maxn FROM (SELECT classroom, grade, COUNT(*) AS n FROM list GROUP BY classroom, grade)) AS LHS CROSS JOIN (SELECT classroom, grade, n, MAX(n) OVER () AS maxn FROM (SELECT classroom, grade, COUNT(*) AS n FROM list GROUP BY classroom, grade)) AS RHS) WHERE (n >= maxn AND maxn >= n_other) ORDER BY classroom;

/*
Gold Result:
(102,)
(103,)
*/

-- Prediction Query
SELECT classroom FROM list GROUP BY classroom ORDER BY COUNT(*) DESC, classroom NULLS LAST LIMIT 1;

/*
Prediction Result:
(101,)
*/