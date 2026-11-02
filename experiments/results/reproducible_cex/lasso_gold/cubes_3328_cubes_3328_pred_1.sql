-- Schema DDL
CREATE TABLE "school" ("School_ID" INTEGER PRIMARY KEY, "School" TEXT, "Location" TEXT, "Enrollment" REAL, "Founded" REAL, "Denomination" TEXT, "Boys_or_Girls" TEXT, "Day_or_Boarding" TEXT, "Year_Entered_Competition" REAL, "School_Colors" TEXT);

CREATE TABLE "school_details" ("School_ID" INTEGER PRIMARY KEY, "Nickname" TEXT, "Colors" TEXT, "League" TEXT, "Class" TEXT, "Division" TEXT, FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

CREATE TABLE "school_performance" ("School_Id" INTEGER, "School_Year" TEXT, "Class_A" TEXT, "Class_AA" TEXT, PRIMARY KEY ("School_Id", "School_Year"), FOREIGN KEY ("School_Id") REFERENCES "school" ("School_ID"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "School_ID" INTEGER, "Player" TEXT, "Team" TEXT, "Age" INTEGER, "Position" TEXT, FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "school" ("school_id", "school", "location", "enrollment", "founded", "denomination", "boys_or_girls", "day_or_boarding", "year_entered_competition", "school_colors") VALUES (1010, 'long', '39537 Wilkerson Row Suite 242
Lake Anna, KS 98413', 1011.5, 1012.5, 'Denmark', 'blood', 'almost', 1013.5, 'fall');
INSERT INTO "school" ("school_id", "school", "location", "enrollment", "founded", "denomination", "boys_or_girls", "day_or_boarding", "year_entered_competition", "school_colors") VALUES (1014, 'surface', '161 Calderon River Suite 931
Lake Jeremyport, CO 31013', 1012.5, 1013.5, 'Tonga', 'term', 'husband', 1014.5, 'support');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT LOCATION FROM school ORDER BY LOCATION, school.school_id NULLS LAST;

/*
Gold Result:
('161 Calderon River Suite 931\nLake Jeremyport, CO 31013',)
('39537 Wilkerson Row Suite 242\nLake Anna, KS 98413',)
*/

-- Prediction Query
SELECT LOCATION FROM school ORDER BY Enrollment ASC, school.school_id NULLS LAST;

/*
Prediction Result:
('39537 Wilkerson Row Suite 242\nLake Anna, KS 98413',)
('161 Calderon River Suite 931\nLake Jeremyport, CO 31013',)
*/