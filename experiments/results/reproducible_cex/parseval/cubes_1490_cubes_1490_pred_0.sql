-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Faculty" ("FacID" INTEGER PRIMARY KEY, "Lname" TEXT(15), "Fname" TEXT(15), "Rank" TEXT(15), "Sex" TEXT(1), "Phone" INTEGER, "Room" TEXT(5), "Building" TEXT(13));

CREATE TABLE "Department" ("DNO" INTEGER PRIMARY KEY, "Division" TEXT(2), "DName" TEXT(25), "Room" TEXT(5), "Building" TEXT(13), "DPhone" INTEGER);

CREATE TABLE "Member_of" ("DNO" INTEGER, "FacID" INTEGER, "Appt_Type" TEXT(15), FOREIGN KEY ("DNO") REFERENCES "Department" ("DNO"), FOREIGN KEY ("FacID") REFERENCES "Faculty" ("FacID"));

CREATE TABLE "Course" ("CID" TEXT(7) PRIMARY KEY, "DNO" INTEGER, "Instructor" INTEGER, "CName" TEXT(40), "Credits" INTEGER, "Days" TEXT(5), "Hours" TEXT(11), FOREIGN KEY ("DNO") REFERENCES "Department" ("DNO"), FOREIGN KEY ("Instructor") REFERENCES "Faculty" ("FacID"));

CREATE TABLE "Minor_in" ("DNO" INTEGER, "StuID" INTEGER, FOREIGN KEY ("DNO") REFERENCES "Department" ("DNO"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

CREATE TABLE "Enrolled_in" ("Grade" TEXT(2), "CID" TEXT(7), "StuID" INTEGER, FOREIGN KEY ("Grade") REFERENCES "Gradeconversion" ("lettergrade"), FOREIGN KEY ("CID") REFERENCES "Course" ("CID"), FOREIGN KEY ("StuID") REFERENCES "Student" ("StuID"));

CREATE TABLE "Gradeconversion" ("lettergrade" TEXT(2) PRIMARY KEY, "gradepoint" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: department --
INSERT INTO "department" ("dno", "division", "dname", "room", "building", "dphone") VALUES (140, '23', 'dep_a90c17', '41e62', 'dep_9335f9', -55602865);

INSERT INTO "department" ("dno", "division", "dname", "room", "building", "dphone") VALUES (1, '23', 'dep_a90c17', '41e62', 'dep_9335f9', -59984348);

-- Inserting into table: student --
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1, 'lhs_c0fee6', 'lhs_fc2d1a', 1, 'lhs_09e603', 1, 1, 'lhs_f1c65a');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483647, 'lhs_e0d626', 'lhs_3fb593', 1, 'lhs_a71f2c', 1, 1, 'lhs_d532d9');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (2, 'lhs_c0fee6', 'lhs_fc2d1a', 1, 'lhs_09e603', 1, 1, 'lhs_f1c65a');

INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (3, 'stu_5554fd', 'stu_ebb0d7', -664303813, 'f', -1022641847, -1726781632, 'db6');

-- Inserting into table: minor_in --
INSERT INTO "minor_in" ("dno", "stuid") VALUES (140, 1);

INSERT INTO "minor_in" ("dno", "stuid") VALUES (1, 1);

INSERT INTO "minor_in" ("dno", "stuid") VALUES (140, 1);

INSERT INTO "minor_in" ("dno", "stuid") VALUES (140, 1);

INSERT INTO "minor_in" ("dno", "stuid") VALUES (1, 1);

INSERT INTO "minor_in" ("dno", "stuid") VALUES (1, 1);

INSERT INTO "minor_in" ("dno", "stuid") VALUES (140, 1);

INSERT INTO "minor_in" ("dno", "stuid") VALUES (1, 3);

INSERT INTO "minor_in" ("dno", "stuid") VALUES (140, 1);

INSERT INTO "minor_in" ("dno", "stuid") VALUES (1, 3);

INSERT INTO "minor_in" ("dno", "stuid") VALUES (140, 1);

INSERT INTO "minor_in" ("dno", "stuid") VALUES (1, 3);

INSERT INTO "minor_in" ("dno", "stuid") VALUES (140, 1);

INSERT INTO "minor_in" ("dno", "stuid") VALUES (1, 3);

INSERT INTO "minor_in" ("dno", "stuid") VALUES (140, 1);

INSERT INTO "minor_in" ("dno", "stuid") VALUES (1, 1);

INSERT INTO "minor_in" ("dno", "stuid") VALUES (1, 1);

INSERT INTO "minor_in" ("dno", "stuid") VALUES (140, 1);

INSERT INTO "minor_in" ("dno", "stuid") VALUES (1, 1);

INSERT INTO "minor_in" ("dno", "stuid") VALUES (1, 1);

INSERT INTO "minor_in" ("dno", "stuid") VALUES (140, 1);

INSERT INTO "minor_in" ("dno", "stuid") VALUES (1, 1);

INSERT INTO "minor_in" ("dno", "stuid") VALUES (1, 1);

INSERT INTO "minor_in" ("dno", "stuid") VALUES (140, 1);

INSERT INTO "minor_in" ("dno", "stuid") VALUES (1, 1);

INSERT INTO "minor_in" ("dno", "stuid") VALUES (1, 1);

INSERT INTO "minor_in" ("dno", "stuid") VALUES (140, -2147483647);

INSERT INTO "minor_in" ("dno", "stuid") VALUES (1, 1);

INSERT INTO "minor_in" ("dno", "stuid") VALUES (140, 1);

INSERT INTO "minor_in" ("dno", "stuid") VALUES (140, 1);

INSERT INTO "minor_in" ("dno", "stuid") VALUES (140, 1);

INSERT INTO "minor_in" ("dno", "stuid") VALUES (1, 1);

INSERT INTO "minor_in" ("dno", "stuid") VALUES (140, 1);

INSERT INTO "minor_in" ("dno", "stuid") VALUES (1, 1);

INSERT INTO "minor_in" ("dno", "stuid") VALUES (140, 1);

INSERT INTO "minor_in" ("dno", "stuid") VALUES (1, 1);

INSERT INTO "minor_in" ("dno", "stuid") VALUES (140, 1);

INSERT INTO "minor_in" ("dno", "stuid") VALUES (1, 1);

INSERT INTO "minor_in" ("dno", "stuid") VALUES (140, 1);

INSERT INTO "minor_in" ("dno", "stuid") VALUES (1, 1);

INSERT INTO "minor_in" ("dno", "stuid") VALUES (140, 1);

INSERT INTO "minor_in" ("dno", "stuid") VALUES (1, 1);

INSERT INTO "minor_in" ("dno", "stuid") VALUES (140, 1);

INSERT INTO "minor_in" ("dno", "stuid") VALUES (1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT fname, lname FROM (SELECT LHS.stuid AS stuid, LHS.lname AS lname, LHS.fname AS fname, LHS.age AS age, LHS.sex AS sex, LHS.major AS major, LHS.advisor AS advisor, LHS.city_code AS city_code, LHS.dno AS dno FROM (SELECT LHS.stuid AS stuid, LHS.lname AS lname, LHS.fname AS fname, LHS.age AS age, LHS.sex AS sex, LHS.major AS major, LHS.advisor AS advisor, LHS.city_code AS city_code, RHS.dno AS dno FROM student AS LHS INNER JOIN minor_in AS RHS ON (LHS.stuid = RHS.stuid)) AS LHS INNER JOIN (SELECT * FROM minor_in WHERE (dno = 140)) AS RHS ON (LHS.stuid = RHS.stuid AND LHS.dno = RHS.dno)) ORDER BY fname, lname NULLS LAST;

/*
Gold Result:
('lhs_3fb593', 'lhs_e0d626')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
*/

-- Prediction Query
SELECT T2.Fname, T2.Lname FROM MINOR_IN AS T1 JOIN STUDENT AS T2 ON T1.StuID = T2.StuID WHERE T1.DNO = 140;

/*
Prediction Result:
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_3fb593', 'lhs_e0d626')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
('lhs_fc2d1a', 'lhs_c0fee6')
*/