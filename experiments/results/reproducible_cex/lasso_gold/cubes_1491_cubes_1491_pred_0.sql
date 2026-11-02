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
INSERT INTO "department" ("dno", "division", "dname", "room", "building", "dphone") VALUES (1110, 'democratic', 'Todd Hudson', 'hope', 'phone', 1111);
INSERT INTO "department" ("dno", "division", "dname", "room", "building", "dphone") VALUES (1115, 'easy', 'Dr. Angel Lewis MD', 'particular', 'remain', 1112);
INSERT INTO "faculty" ("facid", "lname", "fname", "rank", "sex", "phone", "room", "building") VALUES (1112, 'Williams', 'Christopher', 'really', 'past', 1113, 'other', 'necessary');
INSERT INTO "faculty" ("facid", "lname", "fname", "rank", "sex", "phone", "room", "building") VALUES (1117, 'Brewer', 'Stephen', 'woman', 'society', 1118, 'would', 'baby');
INSERT INTO "course" ("cid", "dno", "instructor", "cname", "credits", "days", "hours") VALUES ('four', 1110, 1112, 'INTRODUCTION TO COMPUTER SCIENCE', 1114, 'worry', 'every');
INSERT INTO "course" ("cid", "dno", "instructor", "cname", "credits", "days", "hours") VALUES ('act', 1115, 1117, 'INTRODUCTION TO COMPUTER SCIENCE', 1119, 'low', 'pretty');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "dname", "room" FROM (SELECT "LHS"."dno" AS "dno", "LHS"."division" AS "division", "LHS"."dname" AS "dname", "LHS"."room" AS "room", "LHS"."building" AS "building", "LHS"."dphone" AS "dphone", "RHS"."cid" AS "cid", "RHS"."cname" AS "cname", "RHS"."credits" AS "credits", "RHS"."instructor" AS "instructor", "RHS"."days" AS "days", "RHS"."hours" AS "hours" FROM "department" AS "LHS" INNER JOIN "course" AS "RHS" ON ("LHS"."dno" = "RHS"."dno")) WHERE ("cname" = 'INTRODUCTION TO COMPUTER SCIENCE') ORDER BY dname, "dname" NULLS LAST, "room" NULLS LAST;

/*
Gold Result:
('Dr. Angel Lewis MD', 'particular')
('Todd Hudson', 'hope')
*/

-- Prediction Query
SELECT T2.Dname, T2.Room FROM COURSE AS T1 JOIN DEPARTMENT AS T2 ON T1.DNO = T2.DNO WHERE T1.CName = 'INTRODUCTION TO COMPUTER SCIENCE';

/*
Prediction Result:
('Todd Hudson', 'hope')
('Dr. Angel Lewis MD', 'particular')
*/