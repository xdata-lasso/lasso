-- Schema DDL
CREATE TABLE "school" ("School_ID" INTEGER PRIMARY KEY, "School" TEXT, "Location" TEXT, "Enrollment" REAL, "Founded" REAL, "Denomination" TEXT, "Boys_or_Girls" TEXT, "Day_or_Boarding" TEXT, "Year_Entered_Competition" REAL, "School_Colors" TEXT);

CREATE TABLE "school_details" ("School_ID" INTEGER PRIMARY KEY, "Nickname" TEXT, "Colors" TEXT, "League" TEXT, "Class" TEXT, "Division" TEXT, FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

CREATE TABLE "school_performance" ("School_Id" INTEGER, "School_Year" TEXT, "Class_A" TEXT, "Class_AA" TEXT, PRIMARY KEY ("School_Id", "School_Year"), FOREIGN KEY ("School_Id") REFERENCES "school" ("School_ID"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "School_ID" INTEGER, "Player" TEXT, "Team" TEXT, "Age" INTEGER, "Position" TEXT, FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "school" ("school_id", "school", "location", "enrollment", "founded", "denomination", "boys_or_girls", "day_or_boarding", "year_entered_competition", "school_colors") VALUES (1098, 'hundred', 'PSC 9946, Box 8044
APO AE 56847', 1101.5, 1104.5, 'Ecuador', 'choose', 'accept', 1107.5, 'walk');
INSERT INTO "school" ("school_id", "school", "location", "enrollment", "founded", "denomination", "boys_or_girls", "day_or_boarding", "year_entered_competition", "school_colors") VALUES (1099, 'research', '7738 Leon Underpass Apt. 148
Clarencebury, TX 41188', 1110.5, 1115.5, 'Ecuador', 'reality', 'accept', 1126.5, 'social');
INSERT INTO "school" ("school_id", "school", "location", "enrollment", "founded", "denomination", "boys_or_girls", "day_or_boarding", "year_entered_competition", "school_colors") VALUES (1100, 'smile', '00379 Stanley Roads
Lake Heather, NM 52884', 1119.5, 1126.5, 'Ecuador', 'rise', 'accept', 1145.5, 'traditional');
INSERT INTO "school" ("school_id", "school", "location", "enrollment", "founded", "denomination", "boys_or_girls", "day_or_boarding", "year_entered_competition", "school_colors") VALUES (1110, 'value', '870 Samantha Crossing
Andersonmouth, TN 70117', 1113.5, 1116.5, 'Ecuador', 'during', 'speech', 1119.5, 'claim');
INSERT INTO "school" ("school_id", "school", "location", "enrollment", "founded", "denomination", "boys_or_girls", "day_or_boarding", "year_entered_competition", "school_colors") VALUES (1111, 'both', 'Unit 9579 Box 8687
DPO AE 97973', 1122.5, 1127.5, 'Ecuador', 'identify', 'speech', 1138.5, 'seat');
INSERT INTO "school" ("school_id", "school", "location", "enrollment", "founded", "denomination", "boys_or_girls", "day_or_boarding", "year_entered_competition", "school_colors") VALUES (1112, 'start', '3487 Joshua Club Suite 345
Patricialand, DC 20270', 1131.5, 1138.5, 'Ecuador', 'rule', 'speech', 1157.5, 'difficult');
INSERT INTO "school" ("school_id", "school", "location", "enrollment", "founded", "denomination", "boys_or_girls", "day_or_boarding", "year_entered_competition", "school_colors") VALUES (1122, 'start', '3487 Joshua Club Suite 345
Patricialand, DC 20270', 1131.5, 1138.5, 'Ecuador', 'rule', 'speech', 1157.5, 'difficult');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT denomination FROM (SELECT day_or_boarding, denomination, COUNT(*) AS n FROM school GROUP BY day_or_boarding, denomination) WHERE (n > 1) ORDER BY denomination;

/*
Gold Result:
('Ecuador',)
('Ecuador',)
*/

-- Prediction Query
SELECT Denomination FROM school GROUP BY Denomination HAVING COUNT(*) > 1;

/*
Prediction Result:
('Ecuador',)
*/