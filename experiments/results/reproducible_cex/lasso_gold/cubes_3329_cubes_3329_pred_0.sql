-- Schema DDL
CREATE TABLE "school" ("School_ID" INTEGER PRIMARY KEY, "School" TEXT, "Location" TEXT, "Enrollment" REAL, "Founded" REAL, "Denomination" TEXT, "Boys_or_Girls" TEXT, "Day_or_Boarding" TEXT, "Year_Entered_Competition" REAL, "School_Colors" TEXT);

CREATE TABLE "school_details" ("School_ID" INTEGER PRIMARY KEY, "Nickname" TEXT, "Colors" TEXT, "League" TEXT, "Class" TEXT, "Division" TEXT, FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

CREATE TABLE "school_performance" ("School_Id" INTEGER, "School_Year" TEXT, "Class_A" TEXT, "Class_AA" TEXT, PRIMARY KEY ("School_Id", "School_Year"), FOREIGN KEY ("School_Id") REFERENCES "school" ("School_ID"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "School_ID" INTEGER, "Player" TEXT, "Team" TEXT, "Age" INTEGER, "Position" TEXT, FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "school" ("school_id", "school", "location", "enrollment", "founded", "denomination", "boys_or_girls", "day_or_boarding", "year_entered_competition", "school_colors") VALUES (1058, 'church', '826 Bobby Lakes Apt. 533
West Kimberlychester, RI 98736', 1059.5, 1060.5, 'Cape Verde', 'wish', 'wonder', 1061.5, 'economic');
INSERT INTO "school" ("school_id", "school", "location", "enrollment", "founded", "denomination", "boys_or_girls", "day_or_boarding", "year_entered_competition", "school_colors") VALUES (1062, 'since', 'PSC 6342, Box 1607
APO AE 26659', 1063.5, 1064.5, 'Svalbard & Jan Mayen Islands', 'why', 'magazine', 1065.5, 'hard');
INSERT INTO "school_details" ("school_id", "nickname", "colors", "league", "class", "division") VALUES (1058, 'Vanessa Cochran', 'agent', 'itself', 'ago', 'country');
INSERT INTO "school_details" ("school_id", "nickname", "colors", "league", "class", "division") VALUES (1062, 'Sean Rasmussen', 'upon', 'receive', 'data', 'inside');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "nickname" FROM "school_details" WHERE ("division" <> 'Division 1') ORDER BY nickname, school_details.school_id NULLS LAST;

/*
Gold Result:
('Sean Rasmussen',)
('Vanessa Cochran',)
*/

-- Prediction Query
SELECT Nickname FROM school_details WHERE Division <> 'Division 1';

/*
Prediction Result:
('Vanessa Cochran',)
('Sean Rasmussen',)
*/