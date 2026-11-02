-- Schema DDL
CREATE TABLE "school" ("School_ID" INTEGER PRIMARY KEY, "School" TEXT, "Location" TEXT, "Enrollment" REAL, "Founded" REAL, "Denomination" TEXT, "Boys_or_Girls" TEXT, "Day_or_Boarding" TEXT, "Year_Entered_Competition" REAL, "School_Colors" TEXT);

CREATE TABLE "school_details" ("School_ID" INTEGER PRIMARY KEY, "Nickname" TEXT, "Colors" TEXT, "League" TEXT, "Class" TEXT, "Division" TEXT, FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

CREATE TABLE "school_performance" ("School_Id" INTEGER, "School_Year" TEXT, "Class_A" TEXT, "Class_AA" TEXT, PRIMARY KEY ("School_Id", "School_Year"), FOREIGN KEY ("School_Id") REFERENCES "school" ("School_ID"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "School_ID" INTEGER, "Player" TEXT, "Team" TEXT, "Age" INTEGER, "Position" TEXT, FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "school" ("School_ID", "School") VALUES (1, 'Oak High');
INSERT INTO "school" ("School_ID", "School") VALUES (2, 'Pine High');
INSERT INTO "school" ("School_ID", "School") VALUES (3, 'Maple High');
INSERT INTO "school" ("School_ID", "School") VALUES (4, 'Cedar High');
INSERT INTO "school" ("School_ID", "School") VALUES (5, 'Birch High');
INSERT INTO "school" ("School_ID", "School") VALUES (6, 'Elm High');
INSERT INTO "school_details" ("School_ID", "Nickname", "Division") VALUES (1, 'Eagles', 'Division 1');
INSERT INTO "school_details" ("School_ID", "Nickname", "Division") VALUES (2, 'Tigers', 'Division 2');
INSERT INTO "school_details" ("School_ID", "Nickname", "Division") VALUES (3, 'Tigers', 'Division 3');
INSERT INTO "school_details" ("School_ID", "Nickname", "Division") VALUES (4, 'Bears', NULL);
INSERT INTO "school_details" ("School_ID", "Nickname", "Division") VALUES (5, NULL, 'Division 2');
INSERT INTO "school_details" ("School_ID", "Nickname", "Division") VALUES (6, 'Alphas', 'division 1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "nickname" FROM "school_details" WHERE ("division" <> 'Division 1') ORDER BY nickname, school_details.school_id NULLS LAST;

/*
Gold Result:
(None,)
('Alphas',)
('Tigers',)
('Tigers',)
*/

-- Prediction Query
SELECT Nickname FROM school_details WHERE Division <> 'Division 1';

/*
Prediction Result:
('Tigers',)
('Tigers',)
(None,)
('Alphas',)
*/