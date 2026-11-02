-- Schema DDL
CREATE TABLE "school" ("School_ID" INTEGER PRIMARY KEY, "School" TEXT, "Location" TEXT, "Enrollment" REAL, "Founded" REAL, "Denomination" TEXT, "Boys_or_Girls" TEXT, "Day_or_Boarding" TEXT, "Year_Entered_Competition" REAL, "School_Colors" TEXT);

CREATE TABLE "school_details" ("School_ID" INTEGER PRIMARY KEY, "Nickname" TEXT, "Colors" TEXT, "League" TEXT, "Class" TEXT, "Division" TEXT, FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

CREATE TABLE "school_performance" ("School_Id" INTEGER, "School_Year" TEXT, "Class_A" TEXT, "Class_AA" TEXT, PRIMARY KEY ("School_Id", "School_Year"), FOREIGN KEY ("School_Id") REFERENCES "school" ("School_ID"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "School_ID" INTEGER, "Player" TEXT, "Team" TEXT, "Age" INTEGER, "Position" TEXT, FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "school" ("School_ID", "School", "Location", "Enrollment", "Founded", "Denomination", "Boys_or_Girls", "Day_or_Boarding", "Year_Entered_Competition", "School_Colors") VALUES (1, 'Oakridge', 'North', 1200.0, 1950.0, 'None', 'Coed', 'Day', 1960.0, 'Blue');
INSERT INTO "school" ("School_ID", "School", "Location", "Enrollment", "Founded", "Denomination", "Boys_or_Girls", "Day_or_Boarding", "Year_Entered_Competition", "School_Colors") VALUES (2, 'Pinecrest', 'South', 800.0, 1970.0, 'None', 'Boys', 'Boarding', 1975.0, 'Green');
INSERT INTO "school" ("School_ID", "School", "Location", "Enrollment", "Founded", "Denomination", "Boys_or_Girls", "Day_or_Boarding", "Year_Entered_Competition", "School_Colors") VALUES (3, 'Mapleleaf', 'East', 950.0, 1980.0, 'Catholic', 'Girls', 'Day', 1985.0, 'Red');
INSERT INTO "school" ("School_ID", "School", "Location", "Enrollment", "Founded", "Denomination", "Boys_or_Girls", "Day_or_Boarding", "Year_Entered_Competition", "School_Colors") VALUES (4, 'Cedarwood', 'West', 1100.0, 1965.0, 'None', 'Coed', 'Day', 1970.0, 'Yellow');
INSERT INTO "school" ("School_ID", "School", "Location", "Enrollment", "Founded", "Denomination", "Boys_or_Girls", "Day_or_Boarding", "Year_Entered_Competition", "School_Colors") VALUES (5, 'Birchwood', 'Central', 600.0, 1990.0, 'Protestant', 'Coed', 'Boarding', 1995.0, 'White');
INSERT INTO "school_details" ("School_ID", "Nickname", "Colors", "League", "Class", "Division") VALUES (1, 'Tigers', 'Orange', 'Metro', 'AA', 'Division 1');
INSERT INTO "school_details" ("School_ID", "Nickname", "Colors", "League", "Class", "Division") VALUES (2, 'Eagles', 'Gold', 'Metro', 'A', 'Division 2');
INSERT INTO "school_details" ("School_ID", "Nickname", "Colors", "League", "Class", "Division") VALUES (3, 'Eagles', 'Silver', 'Valley', 'AA', 'Division 3');
INSERT INTO "school_details" ("School_ID", "Nickname", "Colors", "League", "Class", "Division") VALUES (4, 'Bears', 'Brown', 'Valley', 'A', 'Division 0');
INSERT INTO "school_details" ("School_ID", "Nickname", "Colors", "League", "Class", "Division") VALUES (5, 'Wolves', 'Grey', 'Coastal', 'A', NULL);
INSERT INTO "school_performance" ("School_Id", "School_Year", "Class_A", "Class_AA") VALUES (2, '2020', '1st', 'None');
INSERT INTO "school_performance" ("School_Id", "School_Year", "Class_A", "Class_AA") VALUES (2, '2021', '2nd', 'None');
INSERT INTO "player" ("Player_ID", "School_ID", "Player", "Team", "Age", "Position") VALUES (101, 2, 'John Doe', 'Varsity', 17, 'Forward');
INSERT INTO "player" ("Player_ID", "School_ID", "Player", "Team", "Age", "Position") VALUES (102, 2, 'Jane Smith', 'Varsity', 16, 'Guard');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "nickname" FROM "school_details" WHERE ("division" <> 'Division 1') ORDER BY nickname, school_details.school_id NULLS LAST;

/*
Gold Result:
('Bears',)
('Eagles',)
('Eagles',)
*/

-- Prediction Query
SELECT Nickname FROM school_details WHERE Division <> 'Division 1';

/*
Prediction Result:
('Eagles',)
('Eagles',)
('Bears',)
*/