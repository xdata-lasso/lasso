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
INSERT INTO "department" ("dno", "division", "dname", "room", "building", "dphone") VALUES (1, 'lhs_04eadf', 'lhs_19fcfc', 'lhs_ad56c3', 'lhs_08e11d', 1);

INSERT INTO "department" ("dno", "division", "dname", "room", "building", "dphone") VALUES (-2147483647, 'lhs_7a2189', 'lhs_633e47', 'lhs_903a8b', 'lhs_09520c', 1);

INSERT INTO "department" ("dno", "division", "dname", "room", "building", "dphone") VALUES (2, '23', 'dep_a90c17', '41e62', 'dep_9335f9', -55602865);

INSERT INTO "department" ("dno", "division", "dname", "room", "building", "dphone") VALUES (3, '23', 'dep_a90c17', '41e62', 'dep_9335f9', -59984348);

INSERT INTO "department" ("dno", "division", "dname", "room", "building", "dphone") VALUES (-2147483644, '23', 'q_0_29111f', '41e62', 'dep_9335f9', -664303813);

INSERT INTO "department" ("dno", "division", "dname", "room", "building", "dphone") VALUES (-2147483643, '23', 'q_0_29111f', '41e62', 'dep_9335f9', -1022641847);

-- Inserting into table: student --
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (-2147483648, 'stu_5554fd', 'stu_ebb0d7', -1726781632, 'f', 247012447, -1980249628, 'db6');

-- Inserting into table: minor_in --
INSERT INTO "minor_in" ("dno", "stuid") VALUES (2, -2147483648);

INSERT INTO "minor_in" ("dno", "stuid") VALUES (3, -2147483648);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT dname FROM (SELECT * FROM department AS LHS WHERE NOT EXISTS(SELECT 1 FROM minor_in AS RHS WHERE (LHS.dno = RHS.dno))) ORDER BY dname;

/*
Gold Result:
('lhs_19fcfc',)
('lhs_633e47',)
('q_0_29111f',)
('q_0_29111f',)
*/

-- Prediction Query
SELECT DName FROM DEPARTMENT EXCEPT SELECT T1.DName FROM DEPARTMENT AS T1 JOIN MINOR_IN AS T2 ON T1.DNO = T2.DNO;

/*
Prediction Result:
('lhs_19fcfc',)
('lhs_633e47',)
('q_0_29111f',)
*/