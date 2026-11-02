-- Schema DDL
CREATE TABLE "school" ("School_ID" INTEGER PRIMARY KEY, "School" TEXT, "Location" TEXT, "Enrollment" REAL, "Founded" REAL, "Denomination" TEXT, "Boys_or_Girls" TEXT, "Day_or_Boarding" TEXT, "Year_Entered_Competition" REAL, "School_Colors" TEXT);

CREATE TABLE "school_details" ("School_ID" INTEGER PRIMARY KEY, "Nickname" TEXT, "Colors" TEXT, "League" TEXT, "Class" TEXT, "Division" TEXT, FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

CREATE TABLE "school_performance" ("School_Id" INTEGER, "School_Year" TEXT, "Class_A" TEXT, "Class_AA" TEXT, PRIMARY KEY ("School_Id", "School_Year"), FOREIGN KEY ("School_Id") REFERENCES "school" ("School_ID"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "School_ID" INTEGER, "Player" TEXT, "Team" TEXT, "Age" INTEGER, "Position" TEXT, FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO school (School_ID, School, Location, Enrollment, Founded, Denomination, Boys_or_Girls, Day_or_Boarding, Year_Entered_Competition, School_Colors) VALUES (1, 'St. Jude', 'North', 500.0, 1950.0, 'Catholic', 'Boys', 'Day', 1960.0, 'Blue');
INSERT INTO school (School_ID, School, Location, Enrollment, Founded, Denomination, Boys_or_Girls, Day_or_Boarding, Year_Entered_Competition, School_Colors) VALUES (2, 'Oak Ridge', 'South', 800.0, 1975.0, 'None', 'Coed', 'Day', 1980.0, 'Green');
INSERT INTO school (School_ID, School, Location, Enrollment, Founded, Denomination, Boys_or_Girls, Day_or_Boarding, Year_Entered_Competition, School_Colors) VALUES (3, 'Pine Crest', 'East', 350.0, 1920.0, 'Presbyterian', 'Girls', 'Boarding', 1930.0, 'Red');
INSERT INTO school_details (School_ID, Nickname, Colors, League, Class, Division) VALUES (1, 'Saints', 'Blue/White', 'Metro', 'AA', 'Div1');
INSERT INTO school_performance (School_Id, School_Year, Class_A, Class_AA) VALUES (2, '2021-22', 'Won', 'Lost');
INSERT INTO school_performance (School_Id, School_Year, Class_A, Class_AA) VALUES (2, '2022-23', 'Lost', 'Won');
INSERT INTO player (Player_ID, School_ID, Player, Team, Age, Position) VALUES (1, 1, 'Aaron', 'Zebras', 25, 'Guard');
INSERT INTO player (Player_ID, School_ID, Player, Team, Age, Position) VALUES (2, 2, 'Blake', 'Zebras', 25, 'Forward');
INSERT INTO player (Player_ID, School_ID, Player, Team, Age, Position) VALUES (3, 1, 'Connor', 'Zebras', 19, 'Center');
INSERT INTO player (Player_ID, School_ID, Player, Team, Age, Position) VALUES (4, 2, 'Derek', 'Hawks', 21, 'Guard');
INSERT INTO player (Player_ID, School_ID, Player, Team, Age, Position) VALUES (5, 3, 'Evan', 'Eagles', 22, 'Forward');
INSERT INTO player (Player_ID, School_ID, Player, Team, Age, Position) VALUES (6, 1, 'Frank', 'Eagles', 22, 'Center');
INSERT INTO player (Player_ID, School_ID, Player, Team, Age, Position) VALUES (7, 2, 'Greg', 'Bears', 24, 'Guard');
INSERT INTO player (Player_ID, School_ID, Player, Team, Age, Position) VALUES (8, 3, 'Henry', 'Bears', 21, 'Forward');
INSERT INTO player (Player_ID, School_ID, Player, Team, Age, Position) VALUES (9, 1, 'Ian', 'Bears', 18, 'Center');
INSERT INTO player (Player_ID, School_ID, Player, Team, Age, Position) VALUES (10, 2, 'Jack', 'Bears', 18, 'Guard');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT team FROM (SELECT * FROM player AS LHS WHERE NOT EXISTS(SELECT 1 FROM (SELECT team, MAX(age) AS age FROM player GROUP BY team) AS RHS WHERE (LHS.team = RHS.team AND LHS.age = RHS.age))) ORDER BY team;

/*
Gold Result:
('Bears',)
('Bears',)
('Bears',)
('Zebras',)
*/

-- Prediction Query
SELECT Team FROM player ORDER BY Age DESC, player.player_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Zebras',)
*/