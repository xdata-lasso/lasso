-- Schema DDL
CREATE TABLE "college" ("College_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Leader_Name" TEXT, "College_Location" TEXT);

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "College_ID" INTEGER, "Name" TEXT, "Country" TEXT, FOREIGN KEY ("College_ID") REFERENCES "college" ("College_ID"));

CREATE TABLE "round" ("Round_ID" INTEGER, "Member_ID" INTEGER, "Decoration_Theme" TEXT, "Rank_in_Round" INTEGER, PRIMARY KEY ("Round_ID", "Member_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "college" ("college_id", "name", "leader_name", "college_location") VALUES (1026, 'Benjamin Ware', 'Angel Lewis MD', 'USS Suarez
FPO AA 37854');
INSERT INTO "college" ("college_id", "name", "leader_name", "college_location") VALUES (1028, 'Jimmy Murillo', 'Tara Garcia', '18244 Jennifer Ford Suite 874
North Cynthiaview, AZ 00965');
INSERT INTO "member" ("member_id", "college_id", "name", "country") VALUES (1027, 1026, 'Roy Warner', 'Central African Republic');
INSERT INTO "member" ("member_id", "college_id", "name", "country") VALUES (1029, 1028, 'Kristen Patterson', 'New Zealand');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name_other AS name___1, name AS name___2 FROM (SELECT LHS.college_id AS college_id, LHS.name AS name, LHS.leader_name AS leader_name, LHS.college_location AS college_location, RHS.member_id AS member_id, RHS.name AS name_other, RHS.country AS country FROM college AS LHS INNER JOIN member AS RHS ON (LHS.college_id = RHS.college_id)) ORDER BY name___1, name___2 NULLS LAST;

/*
Gold Result:
('Kristen Patterson', 'Jimmy Murillo')
('Roy Warner', 'Benjamin Ware')
*/

-- Prediction Query
SELECT T2.Name, T1.Name FROM college AS T1 JOIN member AS T2 ON T1.College_ID = T2.College_ID;

/*
Prediction Result:
('Roy Warner', 'Benjamin Ware')
('Kristen Patterson', 'Jimmy Murillo')
*/