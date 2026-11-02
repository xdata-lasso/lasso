-- Schema DDL
CREATE TABLE "school" ("School_ID" INTEGER PRIMARY KEY, "School" TEXT, "Location" TEXT, "Enrollment" REAL, "Founded" REAL, "Denomination" TEXT, "Boys_or_Girls" TEXT, "Day_or_Boarding" TEXT, "Year_Entered_Competition" REAL, "School_Colors" TEXT);

CREATE TABLE "school_details" ("School_ID" INTEGER PRIMARY KEY, "Nickname" TEXT, "Colors" TEXT, "League" TEXT, "Class" TEXT, "Division" TEXT, FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

CREATE TABLE "school_performance" ("School_Id" INTEGER, "School_Year" TEXT, "Class_A" TEXT, "Class_AA" TEXT, PRIMARY KEY ("School_Id", "School_Year"), FOREIGN KEY ("School_Id") REFERENCES "school" ("School_ID"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "School_ID" INTEGER, "Player" TEXT, "Team" TEXT, "Age" INTEGER, "Position" TEXT, FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "school" ("school_id", "school", "location", "enrollment", "founded", "denomination", "boys_or_girls", "day_or_boarding", "year_entered_competition", "school_colors") VALUES (1034, 'why', '0154 Brian Wells Apt. 171
East Donna, OH 22144', 1035.5, 100, 'Estonia', 'news', 'turn', 1037.5, 'policy');
INSERT INTO "school" ("school_id", "school", "location", "enrollment", "founded", "denomination", "boys_or_girls", "day_or_boarding", "year_entered_competition", "school_colors") VALUES (1038, 'land', '0154 Brian Wells Apt. 171
East Donna, OH 22144', 1039.5, -50, 'Czech Republic', 'attack', 'ground', 1041.5, 'against');
INSERT INTO "school" ("school_id", "school", "location", "enrollment", "founded", "denomination", "boys_or_girls", "day_or_boarding", "year_entered_competition", "school_colors") VALUES (1042, 'per', '6311 Gomez Loop
Shieldston, TX 86150', 1043.5, 80, 'Saint Kitts and Nevis', 'worry', 'us', 1045.5, 'own');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT LOCATION FROM school ORDER BY LOCATION, school.school_id NULLS LAST;

/*
Gold Result:
('0154 Brian Wells Apt. 171\nEast Donna, OH 22144',)
('0154 Brian Wells Apt. 171\nEast Donna, OH 22144',)
('6311 Gomez Loop\nShieldston, TX 86150',)
*/

-- Prediction Query
SELECT LOCATION FROM school ORDER BY Founded DESC, school.school_id NULLS LAST;

/*
Prediction Result:
('0154 Brian Wells Apt. 171\nEast Donna, OH 22144',)
('6311 Gomez Loop\nShieldston, TX 86150',)
('0154 Brian Wells Apt. 171\nEast Donna, OH 22144',)
*/