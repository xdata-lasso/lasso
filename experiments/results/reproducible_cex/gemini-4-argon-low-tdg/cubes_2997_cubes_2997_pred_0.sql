-- Schema DDL
CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Dorm" ("dormid" INTEGER UNIQUE, "dorm_name" TEXT(20), "student_capacity" INTEGER, "gender" TEXT(1));

CREATE TABLE "Dorm_amenity" ("amenid" INTEGER UNIQUE, "amenity_name" TEXT(25));

CREATE TABLE "Has_amenity" ("amenid" INTEGER, "dormid" INTEGER, FOREIGN KEY ("amenid") REFERENCES "Dorm_amenity" ("amenid"), FOREIGN KEY ("dormid") REFERENCES "Dorm" ("dormid"));

CREATE TABLE "Lives_in" ("dormid" INTEGER, "stuid" INTEGER, "room_number" INTEGER, FOREIGN KEY ("dormid") REFERENCES "Dorm" ("dormid"), FOREIGN KEY ("stuid") REFERENCES "Student" ("StuID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO Dorm (dormid, dorm_name, student_capacity, gender) VALUES (101, 'Alpha Dorm', 50, 'F');
INSERT INTO Dorm (dormid, dorm_name, student_capacity, gender) VALUES (102, 'Beta Dorm', 60, 'M');
INSERT INTO Dorm_amenity (amenid, amenity_name) VALUES (1, 'Study Room');
INSERT INTO Dorm_amenity (amenid, amenity_name) VALUES (2, 'Kitchen');
INSERT INTO Has_amenity (amenid, dormid) VALUES (1, 101);
INSERT INTO Has_amenity (amenid, dormid) VALUES (2, 102);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "dorm_name" FROM (SELECT * FROM (SELECT * FROM (SELECT "LHS"."dormid" AS "dormid", "LHS"."dorm_name" AS "dorm_name", "LHS"."student_capacity" AS "student_capacity", "LHS"."gender" AS "gender", "RHS"."amenid" AS "amenid", "RHS"."amenity_name" AS "amenity_name" FROM "dorm" AS "LHS" CROSS JOIN "dorm_amenity" AS "RHS") WHERE ("amenity_name" = 'TV Lounge')) AS LHS WHERE NOT EXISTS(SELECT 1 FROM has_amenity AS RHS WHERE (LHS.amenid = RHS.amenid AND LHS.dormid = RHS.dormid))) ORDER BY dorm_name, "dorm_name" NULLS LAST;

/*
Gold Result:
*/

-- Prediction Query
SELECT dorm_name FROM dorm EXCEPT SELECT T1.dorm_name FROM dorm AS T1 JOIN has_amenity AS T2 ON T1.dormid = T2.dormid JOIN dorm_amenity AS T3 ON T2.amenid = T3.amenid WHERE T3.amenity_name = 'TV Lounge';

/*
Prediction Result:
('Alpha Dorm',)
('Beta Dorm',)
*/