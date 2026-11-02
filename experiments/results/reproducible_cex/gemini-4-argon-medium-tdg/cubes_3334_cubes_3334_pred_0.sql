-- Schema DDL
CREATE TABLE "school" ("School_ID" INTEGER PRIMARY KEY, "School" TEXT, "Location" TEXT, "Enrollment" REAL, "Founded" REAL, "Denomination" TEXT, "Boys_or_Girls" TEXT, "Day_or_Boarding" TEXT, "Year_Entered_Competition" REAL, "School_Colors" TEXT);

CREATE TABLE "school_details" ("School_ID" INTEGER PRIMARY KEY, "Nickname" TEXT, "Colors" TEXT, "League" TEXT, "Class" TEXT, "Division" TEXT, FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

CREATE TABLE "school_performance" ("School_Id" INTEGER, "School_Year" TEXT, "Class_A" TEXT, "Class_AA" TEXT, PRIMARY KEY ("School_Id", "School_Year"), FOREIGN KEY ("School_Id") REFERENCES "school" ("School_ID"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "School_ID" INTEGER, "Player" TEXT, "Team" TEXT, "Age" INTEGER, "Position" TEXT, FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic counting (n=1, n=2, n=3), multi-column GROUP BY (Denomination + Day_or_Boarding),
-- duplicate outputs (no DISTINCT), and ordering (Denomination ASC vs n ASC).
INSERT INTO "school" ("School_ID", "School", "Denomination", "Day_or_Boarding") VALUES (1, 'School 1', 'Baptist', 'Day');
INSERT INTO "school" ("School_ID", "School", "Denomination", "Day_or_Boarding") VALUES (2, 'School 2', 'Baptist', 'Boarding');
INSERT INTO "school" ("School_ID", "School", "Denomination", "Day_or_Boarding") VALUES (3, 'School 3', 'Catholic', 'Day');
INSERT INTO "school" ("School_ID", "School", "Denomination", "Day_or_Boarding") VALUES (4, 'School 4', 'Catholic', 'Day');
INSERT INTO "school" ("School_ID", "School", "Denomination", "Day_or_Boarding") VALUES (5, 'School 5', 'Catholic', 'Boarding');
INSERT INTO "school" ("School_ID", "School", "Denomination", "Day_or_Boarding") VALUES (6, 'School 6', 'Catholic', 'Boarding');
INSERT INTO "school" ("School_ID", "School", "Denomination", "Day_or_Boarding") VALUES (7, 'School 7', 'Anglican', 'Day');
INSERT INTO "school" ("School_ID", "School", "Denomination", "Day_or_Boarding") VALUES (8, 'School 8', 'Anglican', 'Day');
INSERT INTO "school" ("School_ID", "School", "Denomination", "Day_or_Boarding") VALUES (9, 'School 9', 'Anglican', 'Day');
INSERT INTO "school" ("School_ID", "School", "Denomination", "Day_or_Boarding") VALUES (10, 'School 10', 'Methodist', 'Day');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT denomination FROM (SELECT day_or_boarding, denomination, COUNT(*) AS n FROM school GROUP BY day_or_boarding, denomination) WHERE (n > 1) ORDER BY denomination;

/*
Gold Result:
('Anglican',)
('Catholic',)
('Catholic',)
*/

-- Prediction Query
SELECT Denomination FROM school GROUP BY Denomination HAVING COUNT(*) > 1;

/*
Prediction Result:
('Anglican',)
('Baptist',)
('Catholic',)
*/