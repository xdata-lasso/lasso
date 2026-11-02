-- Schema DDL
CREATE TABLE "college" ("College_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Leader_Name" TEXT, "College_Location" TEXT);

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "College_ID" INTEGER, "Name" TEXT, "Country" TEXT, FOREIGN KEY ("College_ID") REFERENCES "college" ("College_ID"));

CREATE TABLE "round" ("Round_ID" INTEGER, "Member_ID" INTEGER, "Decoration_Theme" TEXT, "Rank_in_Round" INTEGER, PRIMARY KEY ("Round_ID", "Member_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "college" ("college_id", "name", "leader_name", "college_location") VALUES (1015, 'Nicole Vaughn', 'Jennifer Powers', '33150 Brianna Avenue Apt. 031
Port Markhaven, IA 37001');
INSERT INTO "college" ("college_id", "name", "leader_name", "college_location") VALUES (1017, 'Laura Sanchez', 'Jason Davis', '6701 Richard Junction Apt. 333
Taylorburgh, KY 61138');
INSERT INTO "member" ("member_id", "college_id", "name", "country") VALUES (1016, 1015, 'Cindy Anderson', 'Tokelau');
INSERT INTO "member" ("member_id", "college_id", "name", "country") VALUES (1018, 1017, 'Annette Pearson', 'Vietnam');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM member AS LHS WHERE NOT EXISTS(SELECT 1 FROM round AS RHS WHERE (LHS.member_id = RHS.member_id))) ORDER BY name;

/*
Gold Result:
('Annette Pearson',)
('Cindy Anderson',)
*/

-- Prediction Query
SELECT Name FROM member WHERE NOT Member_ID IN (SELECT Member_ID FROM round);

/*
Prediction Result:
('Cindy Anderson',)
('Annette Pearson',)
*/