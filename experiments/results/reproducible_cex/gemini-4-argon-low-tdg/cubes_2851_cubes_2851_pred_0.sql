-- Schema DDL
CREATE TABLE "list" ("LastName" TEXT, "FirstName" TEXT, "Grade" INTEGER, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

CREATE TABLE "teachers" ("LastName" TEXT, "FirstName" TEXT, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Kills mutants that GROUP BY only classroom, GROUP BY only grade, ORDER BY ASC, omit LIMIT 1, or select grade instead of classroom.
-- (Classroom, Grade) counts: (101, 1)->2, (101, 2)->2, (102, 3)->3, (103, 1)->1, (104, 1)->2.
-- Expected winner: Classroom 102 (from pair (102, 3) with count 3).
-- If GROUP BY classroom only: Classroom 101 wins (count 4 vs 3).
-- If GROUP BY grade only: Grade 1 wins (count 5 vs 3).
-- If ORDER BY n ASC: Classroom 103 wins (count 1).
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('A1', 'F1', 1, 101);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('A2', 'F2', 1, 101);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('A3', 'F3', 2, 101);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('A4', 'F4', 2, 101);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('B1', 'F1', 3, 102);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('B2', 'F2', 3, 102);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('B3', 'F3', 3, 102);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('C1', 'F1', 1, 103);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('D1', 'F1', 1, 104);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('D2', 'F2', 1, 104);
INSERT INTO teachers (LastName, FirstName, Classroom) VALUES ('T1', 'TF1', 101);
INSERT INTO teachers (LastName, FirstName, Classroom) VALUES ('T2', 'TF2', 102);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT classroom FROM (SELECT * FROM (SELECT * FROM (SELECT classroom, grade, COUNT(*) AS n FROM list GROUP BY classroom, grade) ORDER BY n DESC) LIMIT 1);

/*
Gold Result:
(102,)
*/

-- Prediction Query
SELECT classroom FROM list GROUP BY classroom ORDER BY COUNT(*) DESC, classroom NULLS LAST LIMIT 1;

/*
Prediction Result:
(101,)
*/