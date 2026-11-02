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
INSERT INTO "department" ("dno", "division", "dname", "room", "building", "dphone") VALUES (1500, 'against', 'Miss Debra Williams PhD', 'many', 'natural', 1501);
INSERT INTO "department" ("dno", "division", "dname", "room", "building", "dphone") VALUES (1542, 'until', 'Benjamin Barton', 'too', 'join', 1543);
INSERT INTO "faculty" ("facid", "lname", "fname", "rank", "sex", "phone", "room", "building") VALUES (1502, 'Pearson', 'Sabrina', 'course', 'pay', 1503, 'least', 'prove');
INSERT INTO "faculty" ("facid", "lname", "fname", "rank", "sex", "phone", "room", "building") VALUES (1583, 'Morgan', 'Kristin', 'example', 'tend', 1544, 'able', 'fear');
INSERT INTO "gradeconversion" ("lettergrade", "gradepoint") VALUES ('teach', 1504.5);
INSERT INTO "gradeconversion" ("lettergrade", "gradepoint") VALUES ('happen', 1509.5);
INSERT INTO "gradeconversion" ("lettergrade", "gradepoint") VALUES ('issue', 1514.5);
INSERT INTO "gradeconversion" ("lettergrade", "gradepoint") VALUES ('goal', 1519.5);
INSERT INTO "gradeconversion" ("lettergrade", "gradepoint") VALUES ('full', 1524.5);
INSERT INTO "gradeconversion" ("lettergrade", "gradepoint") VALUES ('she', 1545.5);
INSERT INTO "gradeconversion" ("lettergrade", "gradepoint") VALUES ('fire', 1550.5);
INSERT INTO "gradeconversion" ("lettergrade", "gradepoint") VALUES ('third', 1555.5);
INSERT INTO "gradeconversion" ("lettergrade", "gradepoint") VALUES ('particularly', 1560.5);
INSERT INTO "gradeconversion" ("lettergrade", "gradepoint") VALUES ('receive', 1565.5);
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1509, 'Santiago', 'Sierra', 1514, 'game', 1519, 1524, 'Lake Mollymouth');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1510, 'Hodge', 'Lisa', 1523.0, 'business', 1532.0, 1539.0, 'Brownhaven');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1511, 'Rivera', 'Andrea', 1532.0, 'spring', 1545.0, 1554.0, 'Cindyfort');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1512, 'Steele', 'Shawn', 1541.0, 'international', 1558.0, 1569.0, 'Wolfborough');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1513, 'Roberts', 'Leonard', 1550.0, 'treatment', 1571.0, 1584.0, 'Andreaport');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1550, 'Burns', 'Stanley', 1555, 'east', 1560, 1565, 'Thorntonfurt');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1551, 'Hernandez', 'Marc', 1564.0, 'total', 1573.0, 1580.0, 'Mcneilberg');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1552, 'Ryan', 'Jacob', 1573.0, 'item', 1586.0, 1595.0, 'Hannaberg');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1553, 'Arnold', 'Heidi', 1582.0, 'animal', 1599.0, 1610.0, 'Mollymouth');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1554, 'Daniels', 'Ashley', 1591.0, 'friend', 1612.0, 1625.0, 'New Reneetown');
INSERT INTO "course" ("cid", "dno", "instructor", "cname", "credits", "days", "hours") VALUES ('left', 1500, 1502, 'Cynthia Moore', 1537, 'marriage', 'identify');
INSERT INTO "course" ("cid", "dno", "instructor", "cname", "credits", "days", "hours") VALUES ('say', 1500, 1502, 'Kristen Davis', 1548.0, 'either', 'will');
INSERT INTO "course" ("cid", "dno", "instructor", "cname", "credits", "days", "hours") VALUES ('memory', 1500, 1502, 'Susan Murray MD', 1559.0, 'loss', 'place');
INSERT INTO "course" ("cid", "dno", "instructor", "cname", "credits", "days", "hours") VALUES ('campaign', 1500, 1502, 'Kathleen Moran', 1570.0, 'ok', 'movie');
INSERT INTO "course" ("cid", "dno", "instructor", "cname", "credits", "days", "hours") VALUES ('professor', 1500, 1502, 'Denise Davenport', 1581.0, 'check', 'skin');
INSERT INTO "course" ("cid", "dno", "instructor", "cname", "credits", "days", "hours") VALUES ('seven', 1542, 1502, 'Angela Harrington', 1578, 'prepare', 'believe');
INSERT INTO "course" ("cid", "dno", "instructor", "cname", "credits", "days", "hours") VALUES ('charge', 1542, 1502, 'Marcus Sanders', 1589.0, 'authority', 'leader');
INSERT INTO "course" ("cid", "dno", "instructor", "cname", "credits", "days", "hours") VALUES ('it', 1542, 1502, 'Gary Craig', 1600.0, 'easy', 'billion');
INSERT INTO "course" ("cid", "dno", "instructor", "cname", "credits", "days", "hours") VALUES ('truth', 1542, 1502, 'Tiffany Sims', 1611.0, 'program', 'soon');
INSERT INTO "course" ("cid", "dno", "instructor", "cname", "credits", "days", "hours") VALUES ('real', 1542, 1502, 'Katherine Weaver', 1622.0, 'field', 'property');
INSERT INTO "enrolled_in" ("grade", "cid", "stuid") VALUES ('teach', 'left', 1509);
INSERT INTO "enrolled_in" ("grade", "cid", "stuid") VALUES ('teach', 'left', 1510);
INSERT INTO "enrolled_in" ("grade", "cid", "stuid") VALUES ('teach', 'left', 1511);
INSERT INTO "enrolled_in" ("grade", "cid", "stuid") VALUES ('teach', 'left', 1512);
INSERT INTO "enrolled_in" ("grade", "cid", "stuid") VALUES ('teach', 'left', 1513);
INSERT INTO "enrolled_in" ("grade", "cid", "stuid") VALUES ('she', 'seven', 1550);
INSERT INTO "enrolled_in" ("grade", "cid", "stuid") VALUES ('she', 'seven', 1551);
INSERT INTO "enrolled_in" ("grade", "cid", "stuid") VALUES ('she', 'seven', 1552);
INSERT INTO "enrolled_in" ("grade", "cid", "stuid") VALUES ('she', 'seven', 1553);
INSERT INTO "enrolled_in" ("grade", "cid", "stuid") VALUES ('she', 'seven', 1554);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT cname FROM (SELECT LHS.cid AS cid, LHS.n AS n, RHS.cname AS cname, RHS.credits AS credits, RHS.instructor AS instructor, RHS.days AS days, RHS.hours AS hours, RHS.dno AS dno FROM (SELECT * FROM (SELECT cid, COUNT(*) AS n FROM enrolled_in GROUP BY cid) WHERE (n >= 5)) AS LHS INNER JOIN course AS RHS ON (LHS.cid = RHS.cid)) ORDER BY cname;

/*
Gold Result:
('Angela Harrington',)
('Cynthia Moore',)
*/

-- Prediction Query
SELECT T1.CName FROM COURSE AS T1 JOIN ENROLLED_IN AS T2 ON T1.CID = T2.CID GROUP BY T2.CID HAVING COUNT(*) >= 5;

/*
Prediction Result:
('Cynthia Moore',)
('Angela Harrington',)
*/