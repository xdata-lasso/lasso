-- Schema DDL
CREATE TABLE "school" ("School_ID" INTEGER PRIMARY KEY, "School" TEXT, "Location" TEXT, "Enrollment" REAL, "Founded" REAL, "Denomination" TEXT, "Boys_or_Girls" TEXT, "Day_or_Boarding" TEXT, "Year_Entered_Competition" REAL, "School_Colors" TEXT);

CREATE TABLE "school_details" ("School_ID" INTEGER PRIMARY KEY, "Nickname" TEXT, "Colors" TEXT, "League" TEXT, "Class" TEXT, "Division" TEXT, FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

CREATE TABLE "school_performance" ("School_Id" INTEGER, "School_Year" TEXT, "Class_A" TEXT, "Class_AA" TEXT, PRIMARY KEY ("School_Id", "School_Year"), FOREIGN KEY ("School_Id") REFERENCES "school" ("School_ID"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "School_ID" INTEGER, "Player" TEXT, "Team" TEXT, "Age" INTEGER, "Position" TEXT, FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: school --
INSERT INTO "school" ("school_id", "school", "location", "enrollment", "founded", "denomination", "boys_or_girls", "day_or_boarding", "year_entered_competition", "school_colors") VALUES (1, 'sch_3c7d26', 'sch_3417ea', 1.0, 1.0, 'sch_4e03ed', 'sch_360f80', 'sch_0fea9c', 1.0, 'sch_982ca7');

INSERT INTO "school" ("school_id", "school", "location", "enrollment", "founded", "denomination", "boys_or_girls", "day_or_boarding", "year_entered_competition", "school_colors") VALUES (-2147483647, 'sch_8f7bb2', 'sch_8fb6d8', 1.0, 1.0, 'sch_7ca42d', 'sch_76058f', 'sch_ff00e8', 1.0, 'sch_9acb54');

INSERT INTO "school" ("school_id", "school", "location", "enrollment", "founded", "denomination", "boys_or_girls", "day_or_boarding", "year_entered_competition", "school_colors") VALUES (-2147483646, '5k5swwqcgs', '9n8', 874.871895, 475.173408, 'u7', 'fe4hri', 'a2ypuzhsrwbb', 749.826493, 'q_1_ae34fa');

INSERT INTO "school" ("school_id", "school", "location", "enrollment", "founded", "denomination", "boys_or_girls", "day_or_boarding", "year_entered_competition", "school_colors") VALUES (-2147483645, 'luhvdltti', 'bnp', 787.938887, 986.066566, 'dposiie5unw', 'klfa9000t', 'c4ecigce', 467.07027, 'q_1_ae34fa');

INSERT INTO "school" ("school_id", "school", "location", "enrollment", "founded", "denomination", "boys_or_girls", "day_or_boarding", "year_entered_competition", "school_colors") VALUES (-1, 'nium52zbu', '4nrq', 597.420508, 220.906948, 'qy', '5s5b', '"', 22.720462, '02eu');

INSERT INTO "school" ("school_id", "school", "location", "enrollment", "founded", "denomination", "boys_or_girls", "day_or_boarding", "year_entered_competition", "school_colors") VALUES (0, 'liqa1', 'ryytoo3', 228.583847, 111.926013, '72klex14ji7z', 'au2dwy', '!', 278.010437, '3pyu78d');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT school_colors FROM (SELECT * FROM (SELECT * FROM school ORDER BY day_or_boarding DESC, school.school_id NULLS LAST) LIMIT 1);

/*
Gold Result:
('sch_9acb54',)
*/

-- Prediction Query
SELECT School_Colors FROM school ORDER BY Enrollment DESC, school.school_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('q_1_ae34fa',)
*/