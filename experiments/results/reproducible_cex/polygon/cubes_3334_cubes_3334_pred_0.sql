-- Schema DDL
CREATE TABLE "school" ("School_ID" INTEGER PRIMARY KEY, "School" TEXT, "Location" TEXT, "Enrollment" REAL, "Founded" REAL, "Denomination" TEXT, "Boys_or_Girls" TEXT, "Day_or_Boarding" TEXT, "Year_Entered_Competition" REAL, "School_Colors" TEXT);

CREATE TABLE "school_details" ("School_ID" INTEGER PRIMARY KEY, "Nickname" TEXT, "Colors" TEXT, "League" TEXT, "Class" TEXT, "Division" TEXT, FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

CREATE TABLE "school_performance" ("School_Id" INTEGER, "School_Year" TEXT, "Class_A" TEXT, "Class_AA" TEXT, PRIMARY KEY ("School_Id", "School_Year"), FOREIGN KEY ("School_Id") REFERENCES "school" ("School_ID"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "School_ID" INTEGER, "Player" TEXT, "Team" TEXT, "Age" INTEGER, "Position" TEXT, FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "school" ("school_id", "school", "location", "enrollment", "founded", "denomination", "boys_or_girls", "day_or_boarding", "year_entered_competition", "school_colors") VALUES (9, '15', '15', 15, 15, '15', '15', '14', 15, '15');
INSERT INTO "school" ("school_id", "school", "location", "enrollment", "founded", "denomination", "boys_or_girls", "day_or_boarding", "year_entered_competition", "school_colors") VALUES (8, '15', '15', 15, 15, '15', '15', NULL, 15, '15');
INSERT INTO "school_details" ("school_id", "nickname", "colors", "league", "class", "division") VALUES (9, '15', '15', '15', '15', '15');
INSERT INTO "school_details" ("school_id", "nickname", "colors", "league", "class", "division") VALUES (8, '15', '15', '15', '15', '15');
INSERT INTO "school_performance" ("school_id", "school_year", "class_a", "class_aa") VALUES (8, '15', '15', '15');
INSERT INTO "player" ("player_id", "school_id", "player", "team", "age", "position") VALUES (12, 9, '15', '15', 15, '15');
INSERT INTO "player" ("player_id", "school_id", "player", "team", "age", "position") VALUES (11, 8, '15', '15', 15, '15');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT denomination FROM (SELECT day_or_boarding, denomination, COUNT(*) AS n FROM school GROUP BY day_or_boarding, denomination) WHERE (n > 1) ORDER BY denomination;

/*
Gold Result:
*/

-- Prediction Query
SELECT Denomination FROM school GROUP BY Denomination HAVING COUNT(*) > 1;

/*
Prediction Result:
('15',)
*/