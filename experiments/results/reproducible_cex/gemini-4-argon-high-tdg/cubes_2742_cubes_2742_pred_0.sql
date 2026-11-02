-- Schema DDL
CREATE TABLE "Activity" ("actid" INTEGER PRIMARY KEY, "activity_name" TEXT(25));

CREATE TABLE "Participates_in" ("actid" INTEGER, "stuid" INTEGER, FOREIGN KEY ("actid") REFERENCES "Activity" ("actid"), FOREIGN KEY ("stuid") REFERENCES "Student" ("StuID"));

CREATE TABLE "Faculty_Participates_in" ("actid" INTEGER, "FacID" INTEGER, FOREIGN KEY ("actid") REFERENCES "Activity" ("actid"), FOREIGN KEY ("FacID") REFERENCES "Faculty" ("FacID"));

CREATE TABLE "Student" ("StuID" INTEGER PRIMARY KEY, "LName" TEXT(12), "Fname" TEXT(12), "Age" INTEGER, "Sex" TEXT(1), "Major" INTEGER, "Advisor" INTEGER, "city_code" TEXT(3));

CREATE TABLE "Faculty" ("FacID" INTEGER PRIMARY KEY, "Lname" TEXT(15), "Fname" TEXT(15), "Rank" TEXT(15), "Sex" TEXT(1), "Phone" INTEGER, "Room" TEXT(5), "Building" TEXT(13));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Faculty (FacID, Lname, Fname, Rank, Sex, Phone, Room, Building) VALUES (1, 'Adams', 'John', 'Prof', 'M', 1111, '101', 'Zeta_LHS');
INSERT INTO Faculty (FacID, Lname, Fname, Rank, Sex, Phone, Room, Building) VALUES (2, 'Adams', 'Mary', 'Assoc', 'F', 1112, '101', 'Zeta_LHS');
INSERT INTO Faculty (FacID, Lname, Fname, Rank, Sex, Phone, Room, Building) VALUES (3, 'Clark', 'Adams', 'Asst', 'M', 1113, '101', 'Beta_RHS');
INSERT INTO Faculty (FacID, Lname, Fname, Rank, Sex, Phone, Room, Building) VALUES (4, 'Davis', 'Adams', 'Inst', 'F', 1114, '101', 'Beta_RHS');
INSERT INTO Faculty (FacID, Lname, Fname, Rank, Sex, Phone, Room, Building) VALUES (5, 'Grant', 'Grant', 'Prof', 'M', 2222, '202', 'Alpha_Self');
INSERT INTO Faculty (FacID, Lname, Fname, Rank, Sex, Phone, Room, Building) VALUES (6, 'Baker', 'Paul', 'Prof', 'M', 3331, '303', 'Decoy_Room');
INSERT INTO Faculty (FacID, Lname, Fname, Rank, Sex, Phone, Room, Building) VALUES (7, 'Baker', 'Paul', 'Assoc', 'M', 3332, '303', 'Decoy_Room');
INSERT INTO Faculty (FacID, Lname, Fname, Rank, Sex, Phone, Room, Building) VALUES (8, 'Evans', 'Luke', 'Prof', 'M', 4441, '401', 'Decoy_Name');
INSERT INTO Faculty (FacID, Lname, Fname, Rank, Sex, Phone, Room, Building) VALUES (9, 'King', 'Evans', 'Assoc', 'F', 4442, '402', 'Decoy_Name');
INSERT INTO Faculty (FacID, Lname, Fname, Rank, Sex, Phone, Room, Building) VALUES (10, 'Solo', 'None', 'Inst', 'F', 5555, '505', 'Decoy_Unm');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT building FROM (SELECT LHS.facid AS facid, LHS.lname AS lname, LHS.fname AS fname, LHS.rank AS rank, LHS.sex AS sex, LHS.phone AS phone, LHS.room AS room, LHS.building AS building, RHS.n AS n FROM faculty AS LHS INNER JOIN (SELECT fname, room, COUNT(*) AS n FROM faculty GROUP BY fname, room) AS RHS ON (LHS.lname = RHS.fname AND LHS.room = RHS.room)) ORDER BY building;

/*
Gold Result:
('Alpha_Self',)
('Zeta_LHS',)
*/

-- Prediction Query
SELECT building FROM Faculty GROUP BY building ORDER BY COUNT(*) DESC, building NULLS LAST LIMIT 1;

/*
Prediction Result:
('Beta_RHS',)
*/