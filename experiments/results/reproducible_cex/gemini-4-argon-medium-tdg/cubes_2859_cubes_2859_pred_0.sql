-- Schema DDL
CREATE TABLE "list" ("LastName" TEXT, "FirstName" TEXT, "Grade" INTEGER, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

CREATE TABLE "teachers" ("LastName" TEXT, "FirstName" TEXT, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. Grouping by Classroom vs Grade, LastName, FirstName.
-- 2. Ties in COUNT(*) resolved by secondary sort on Classroom (ASC).
-- 3. NULL Classroom handling in COUNT(*) vs COUNT(Classroom) and NULLS LAST in ORDER BY.
-- 4. Duplicate LastName, FirstName, and Grade values within the same classroom to kill COUNT(DISTINCT ...) mutants.
-- 5. Unmatched classrooms between 'list' and 'teachers' to kill erroneous JOIN mutants.
-- 6. Multiple teachers in the same classroom to cause fan-out if joined.
INSERT INTO teachers (LastName, FirstName, Classroom) VALUES ('T1', 'A', 101);
INSERT INTO teachers (LastName, FirstName, Classroom) VALUES ('T2', 'B', 101);
INSERT INTO teachers (LastName, FirstName, Classroom) VALUES ('T3', 'C', 999);
-- Classroom NULL: count = 2 (ties with 101 and 103, must sort after 103 due to NULLS LAST)
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('N1', 'F1', NULL, NULL);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('N2', 'F2', 1, NULL);
-- Classroom 103: count = 2 (inserted before 101 to test explicit secondary sorting)
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('C1', 'F1', 2, 103);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('C2', 'F2', 3, 103);
-- Classroom 101: count = 2 (ties with 103 and NULL; has duplicate LastName and Grade=0)
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('Smith', 'John', 0, 101);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('Smith', 'Jane', 0, 101);
-- Classroom 102: count = 1 (minimum count, should sort first; Grade is NULL; not in teachers table)
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('B1', 'John', NULL, 102);
-- Classroom 100: count = 3 (maximum count, should sort last despite having the smallest Classroom number)
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('A1', 'SameFirst', 5, 100);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('A2', 'SameFirst', 5, 100);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('A3', 'DiffFirst', 6, 100);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, classroom FROM (SELECT classroom, COUNT(*) AS n FROM list GROUP BY classroom) ORDER BY count___, classroom NULLS LAST;

/*
Gold Result:
(1, 102)
(2, 101)
(2, 103)
(2, None)
(3, 100)
*/

-- Prediction Query
SELECT COUNT(*), classroom FROM list GROUP BY classroom;

/*
Prediction Result:
(2, None)
(3, 100)
(2, 101)
(1, 102)
(2, 103)
*/