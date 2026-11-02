-- Schema DDL
CREATE TABLE "school" ("School_ID" INTEGER PRIMARY KEY, "School" TEXT, "Location" TEXT, "Enrollment" REAL, "Founded" REAL, "Denomination" TEXT, "Boys_or_Girls" TEXT, "Day_or_Boarding" TEXT, "Year_Entered_Competition" REAL, "School_Colors" TEXT);

CREATE TABLE "school_details" ("School_ID" INTEGER PRIMARY KEY, "Nickname" TEXT, "Colors" TEXT, "League" TEXT, "Class" TEXT, "Division" TEXT, FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

CREATE TABLE "school_performance" ("School_Id" INTEGER, "School_Year" TEXT, "Class_A" TEXT, "Class_AA" TEXT, PRIMARY KEY ("School_Id", "School_Year"), FOREIGN KEY ("School_Id") REFERENCES "school" ("School_ID"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "School_ID" INTEGER, "Player" TEXT, "Team" TEXT, "Age" INTEGER, "Position" TEXT, FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: school --
INSERT INTO "school" ("school_id", "school", "location", "enrollment", "founded", "denomination", "boys_or_girls", "day_or_boarding", "year_entered_competition", "school_colors") VALUES (1, '5k5swwqcgs', '9n8', 874.871895, 1889.99, 'sch_910f5f', 'pgu7vfe4', 'hria2ypuzhs', 663.049759, 'wbbp6luhvdlt');

INSERT INTO "school" ("school_id", "school", "location", "enrollment", "founded", "denomination", "boys_or_girls", "day_or_boarding", "year_entered_competition", "school_colors") VALUES (2, 'ilbnp', 'mdpos', 133.007885, 1889.99, 'sch_910f5f', '5u', 'w6kl', 83.204633, '9');

INSERT INTO "school" ("school_id", "school", "location", "enrollment", "founded", "denomination", "boys_or_girls", "day_or_boarding", "year_entered_competition", "school_colors") VALUES (3, '00t5c4e', 'cigce376nium', 779.28645, 1889.99, 'sch_910f5f', '52zbuo4nrq', 'rofqyp5s5b', 22.720462, '02eu');

INSERT INTO "school" ("school_id", "school", "location", "enrollment", "founded", "denomination", "boys_or_girls", "day_or_boarding", "year_entered_competition", "school_colors") VALUES (4, '5k5swwqcgs', '9n8', 874.871895, 1890.0, 'pgu7vfe4', 'hria2ypuzhs', 'rwbbp6luhvd', 179.378884, 'ilbnp');

INSERT INTO "school" ("school_id", "school", "location", "enrollment", "founded", "denomination", "boys_or_girls", "day_or_boarding", "year_entered_competition", "school_colors") VALUES (5, 'mdpos', 'ie5', 327.753528, 1900.0, 'w6kl', 'a9', '00t5c4e', 950.466571, 'i');

INSERT INTO "school" ("school_id", "school", "location", "enrollment", "founded", "denomination", "boys_or_girls", "day_or_boarding", "year_entered_competition", "school_colors") VALUES (6, 'gce376nium52', 'zbuo4nrqrof', 586.906897, NULL, 'p5s5bbp', '02eutliqa11r', 'ytoo3o9', 111.926013, '72klex14ji7z');

INSERT INTO "school" ("school_id", "school", "location", "enrollment", "founded", "denomination", "boys_or_girls", "day_or_boarding", "year_entered_competition", "school_colors") VALUES (7, 'au2dwy', 'q13py', 326.912005, NULL, 'd99rljsl0', '4', 'p5qi2rk', 811.601922, '9v');

INSERT INTO "school" ("school_id", "school", "location", "enrollment", "founded", "denomination", "boys_or_girls", "day_or_boarding", "year_entered_competition", "school_colors") VALUES (8, 'x58pz', 'f8jegd2', 890.091601, NULL, 'y9uxj4', 'wb', 'v', 185.427628, 'h2gn');

INSERT INTO "school" ("school_id", "school", "location", "enrollment", "founded", "denomination", "boys_or_girls", "day_or_boarding", "year_entered_competition", "school_colors") VALUES (9, 'q', 'nqcx5h', 210.05299, NULL, 'rjtu', 'dz79fjg', '8n2f3', 687.701166, 'qv0gcb98ozk');

INSERT INTO "school" ("school_id", "school", "location", "enrollment", "founded", "denomination", "boys_or_girls", "day_or_boarding", "year_entered_competition", "school_colors") VALUES (10, 'zbilyrkn', '6vck6ah0f8js', 346.706184, NULL, 'q7x', '7', '2fxa7ryfdrz', 753.351134, '6nijjai');

INSERT INTO "school" ("school_id", "school", "location", "enrollment", "founded", "denomination", "boys_or_girls", "day_or_boarding", "year_entered_competition", "school_colors") VALUES (11, 'dh5ogrgj', '8', 740.059813, NULL, 'zt1afgo', 'ri', 'tsj3ayxp1q4', 457.141778, '1jh3den');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT denomination FROM school WHERE (founded < 1890.0 AND founded < 1900.0) ORDER BY denomination, school.school_id NULLS LAST;

/*
Gold Result:
('sch_910f5f',)
('sch_910f5f',)
('sch_910f5f',)
*/

-- Prediction Query
SELECT Denomination FROM school WHERE Founded < 1890 INTERSECT SELECT Denomination FROM school WHERE Founded > 1900;

/*
Prediction Result:
*/