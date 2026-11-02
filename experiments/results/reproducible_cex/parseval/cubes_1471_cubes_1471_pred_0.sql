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
INSERT INTO "department" ("dno", "division", "dname", "room", "building", "dphone") VALUES (1, '23', 'dep_a90c17', '41e62', 'dep_9335f9', -55602865);

-- Inserting into table: faculty --
INSERT INTO "faculty" ("facid", "lname", "fname", "rank", "sex", "phone", "room", "building") VALUES (1, 'fac_7ec0ad', 'fac_d8837b', 'fac_80d96e', '1', -59984348, '24d2f', 'fac_a140e0');

-- Inserting into table: course --
INSERT INTO "course" ("cid", "dno", "instructor", "cname", "credits", "days", "hours") VALUES ('cou_8d1fd4', 1, 1, 'cou_fb680d', 1, 'cou_6ccc53', 'cou_081600');

INSERT INTO "course" ("cid", "dno", "instructor", "cname", "credits", "days", "hours") VALUES ('A', 1, 1, NULL, -59984348, '0ce45', 'cou_0aeae2');

INSERT INTO "course" ("cid", "dno", "instructor", "cname", "credits", "days", "hours") VALUES ('@', 1, 1, 'cou_59898b', NULL, '0ce45', 'cou_0aeae2');

INSERT INTO "course" ("cid", "dno", "instructor", "cname", "credits", "days", "hours") VALUES ('B', 1, 1, 'cou_59898b', -1726781632, '0ce45', 'cou_0aeae2');

INSERT INTO "course" ("cid", "dno", "instructor", "cname", "credits", "days", "hours") VALUES ('?', 1, 1, 'cou_59898b', -1980249628, '0ce45', 'cou_0aeae2');

INSERT INTO "course" ("cid", "dno", "instructor", "cname", "credits", "days", "hours") VALUES ('G', 1, 1, 'cou_59898b', 809183447, '0ce45', 'cou_0aeae2');

INSERT INTO "course" ("cid", "dno", "instructor", "cname", "credits", "days", "hours") VALUES ('C', 1, 1, 'cou_59898b', 1744686505, '0ce45', 'cou_0aeae2');

INSERT INTO "course" ("cid", "dno", "instructor", "cname", "credits", "days", "hours") VALUES ('D', 1, 1, 'cou_59898b', -992890117, '0ce45', 'cou_0aeae2');

INSERT INTO "course" ("cid", "dno", "instructor", "cname", "credits", "days", "hours") VALUES ('!', 1, 1, 'cou_59898b', 1219478689, '0ce45', 'cou_0aeae2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT cid, cname, credits, instructor, days, hours, dno FROM course ORDER BY cid;

/*
Gold Result:
('!', 'cou_59898b', 1219478689, 1, '0ce45', 'cou_0aeae2', 1)
('?', 'cou_59898b', -1980249628, 1, '0ce45', 'cou_0aeae2', 1)
('@', 'cou_59898b', None, 1, '0ce45', 'cou_0aeae2', 1)
('A', None, -59984348, 1, '0ce45', 'cou_0aeae2', 1)
('B', 'cou_59898b', -1726781632, 1, '0ce45', 'cou_0aeae2', 1)
('C', 'cou_59898b', 1744686505, 1, '0ce45', 'cou_0aeae2', 1)
('D', 'cou_59898b', -992890117, 1, '0ce45', 'cou_0aeae2', 1)
('G', 'cou_59898b', 809183447, 1, '0ce45', 'cou_0aeae2', 1)
('cou_8d1fd4', 'cou_fb680d', 1, 1, 'cou_6ccc53', 'cou_081600', 1)
*/

-- Prediction Query
SELECT * FROM COURSE ORDER BY Credits, COURSE.cid NULLS LAST;

/*
Prediction Result:
('@', 1, 1, 'cou_59898b', None, '0ce45', 'cou_0aeae2')
('?', 1, 1, 'cou_59898b', -1980249628, '0ce45', 'cou_0aeae2')
('B', 1, 1, 'cou_59898b', -1726781632, '0ce45', 'cou_0aeae2')
('D', 1, 1, 'cou_59898b', -992890117, '0ce45', 'cou_0aeae2')
('A', 1, 1, None, -59984348, '0ce45', 'cou_0aeae2')
('cou_8d1fd4', 1, 1, 'cou_fb680d', 1, 'cou_6ccc53', 'cou_081600')
('G', 1, 1, 'cou_59898b', 809183447, '0ce45', 'cou_0aeae2')
('!', 1, 1, 'cou_59898b', 1219478689, '0ce45', 'cou_0aeae2')
('C', 1, 1, 'cou_59898b', 1744686505, '0ce45', 'cou_0aeae2')
*/