-- Schema DDL
CREATE TABLE "school" ("School_ID" INTEGER PRIMARY KEY, "School" TEXT, "Location" TEXT, "Enrollment" REAL, "Founded" REAL, "Denomination" TEXT, "Boys_or_Girls" TEXT, "Day_or_Boarding" TEXT, "Year_Entered_Competition" REAL, "School_Colors" TEXT);

CREATE TABLE "school_details" ("School_ID" INTEGER PRIMARY KEY, "Nickname" TEXT, "Colors" TEXT, "League" TEXT, "Class" TEXT, "Division" TEXT, FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

CREATE TABLE "school_performance" ("School_Id" INTEGER, "School_Year" TEXT, "Class_A" TEXT, "Class_AA" TEXT, PRIMARY KEY ("School_Id", "School_Year"), FOREIGN KEY ("School_Id") REFERENCES "school" ("School_ID"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "School_ID" INTEGER, "Player" TEXT, "Team" TEXT, "Age" INTEGER, "Position" TEXT, FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "school" ("School_ID") VALUES (1);
INSERT INTO "school" ("School_ID") VALUES (2);
INSERT INTO "school_details" ("School_ID", "Nickname", "Division") VALUES (1, 'Tigers', 'Division 2');
INSERT INTO "school_details" ("School_ID", "Nickname", "Division") VALUES (2, 'Bears', 'Division 2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "nickname" FROM "school_details" WHERE ("division" <> 'Division 1') ORDER BY nickname, school_details.school_id NULLS LAST;

/*
Gold Result:
('Bears',)
('Tigers',)
*/

-- Prediction Query
SELECT Nickname FROM school_details WHERE Division <> 'Division 1';

/*
Prediction Result:
('Tigers',)
('Bears',)
*/