-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Dorm" ("dormid" INTEGER UNIQUE, "dorm_name" TEXT(20), "student_capacity" INTEGER, "gender" TEXT(1));

CREATE TABLE "Dorm_amenity" ("amenid" INTEGER UNIQUE, "amenity_name" TEXT(25));

CREATE TABLE "Has_amenity" ("amenid" INTEGER, "dormid" INTEGER, FOREIGN KEY ("amenid") REFERENCES "Dorm_amenity" ("amenid"), FOREIGN KEY ("dormid") REFERENCES "Dorm" ("dormid"));

CREATE TABLE "Lives_in" ("dormid" INTEGER, "stuid" INTEGER, "room_number" INTEGER, FOREIGN KEY ("dormid") REFERENCES "Dorm" ("dormid"), FOREIGN KEY ("stuid") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1001, 'Fowler', 'Amy', 1014, 'PM', 1027, 1040, 'Barbaraland');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1002, 'Johnson', 'Jeffrey', 1023.0, 'everything', 1040.0, 1055.0, 'Lake Jeremyport');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1003, 'Hill', 'Bridget', 1032.0, 'surface', 1053.0, 1070.0, 'Port Jesseville');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1004, 'Walker', 'Lisa', 1041.0, 'animal', 1066.0, 1085.0, 'Ramirezstad');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1005, 'Doyle', 'Adam', 1050.0, 'show', 1079.0, 1100.0, 'West Michael');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1006, 'Rhodes', 'Linda', 1059.0, 'machine', 1092.0, 1115.0, 'Jacquelineland');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1007, 'Mcclain', 'Helen', 1068.0, 'not', 1105.0, 1130.0, 'New Jessica');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1008, 'Miller', 'Matthew', 1077.0, 'capital', 1118.0, 1145.0, 'South Noah');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1009, 'Henderson', 'Eric', 1086.0, 'win', 1131.0, 1160.0, 'Lake Mark');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1010, 'Robinson', 'Susan', 1095.0, 'human', 1144.0, 1175.0, 'East Lydiamouth');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1011, 'Wagner', 'Christopher', 1104.0, 'bar', 1157.0, 1190.0, 'Adamsborough');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1012, 'Gonzalez', 'Colin', 1113.0, 'old', 1170.0, 1205.0, 'Jasonfort');
INSERT INTO "student" ("stuid", "lname", "fname", "age", "sex", "major", "advisor", "city_code") VALUES (1013, 'Santos', 'Melanie', 1122.0, 'finally', 1183.0, 1220.0, 'Wilkersonmouth');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT fname, lname FROM (SELECT * FROM (SELECT * FROM (SELECT stuid, lname, fname, age, sex, major, advisor, city_code, AVG(age) OVER () AS meanage FROM student) ORDER BY age) LIMIT 19);

/*
Gold Result:
('Amy', 'Fowler')
('Jeffrey', 'Johnson')
('Bridget', 'Hill')
('Lisa', 'Walker')
('Adam', 'Doyle')
('Linda', 'Rhodes')
('Helen', 'Mcclain')
('Matthew', 'Miller')
('Eric', 'Henderson')
('Susan', 'Robinson')
('Christopher', 'Wagner')
('Colin', 'Gonzalez')
('Melanie', 'Santos')
*/

-- Prediction Query
SELECT fname, lname FROM student WHERE age < (SELECT AVG(age) FROM student);

/*
Prediction Result:
('Amy', 'Fowler')
('Jeffrey', 'Johnson')
('Bridget', 'Hill')
('Lisa', 'Walker')
('Adam', 'Doyle')
('Linda', 'Rhodes')
*/