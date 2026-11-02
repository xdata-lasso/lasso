-- Schema DDL
CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Sponsor_name" TEXT, "Player_name" TEXT, "Gender" TEXT, "Residence" TEXT, "Occupation" TEXT, "Votes" INTEGER, "Rank" TEXT);

CREATE TABLE "club" ("Club_ID" INTEGER PRIMARY KEY, "Club_name" TEXT, "Region" TEXT, "Start_year" INTEGER);

CREATE TABLE "coach" ("Coach_ID" INTEGER PRIMARY KEY, "Club_ID" INTEGER, "Coach_name" TEXT, "Gender" TEXT, "Rank" INTEGER, FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "player_coach" ("Player_ID" INTEGER, "Coach_ID" INTEGER, "Starting_year" INTEGER, PRIMARY KEY ("Player_ID", "Coach_ID"), FOREIGN KEY ("Coach_ID") REFERENCES "coach" ("Coach_ID"), FOREIGN KEY ("Player_ID") REFERENCES "player" ("Player_ID"));

CREATE TABLE "match_result" ("Rank" INTEGER, "Club_ID" INTEGER, "Gold" INTEGER, "Big_Silver" INTEGER, "Small_Silver" INTEGER, "Bronze" INTEGER, "Points" INTEGER, PRIMARY KEY ("Rank", "Club_ID"), FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "player" ("player_id", "sponsor_name", "player_name", "gender", "residence", "occupation", "votes", "rank") VALUES (1031, 'Katie Rodriguez', 'James Martin', 'place', 'Brandon', 'Records manager', 1033, 'brother');
INSERT INTO "player" ("player_id", "sponsor_name", "player_name", "gender", "residence", "occupation", "votes", "rank") VALUES (1032, 'Sarah Romero', 'Tammy Sellers', 'game', 'Birtle', 'Advertising account executive', 1048.0, 'woman');
INSERT INTO "player" ("player_id", "sponsor_name", "player_name", "gender", "residence", "occupation", "votes", "rank") VALUES (1035, 'William Roman', 'Nicholas Cabrera', 'receive', 'Brandon', 'Stage manager', 1037, 'evidence');
INSERT INTO "player" ("player_id", "sponsor_name", "player_name", "gender", "residence", "occupation", "votes", "rank") VALUES (1036, 'David Bradley', 'Kim Martinez', 'may', 'Birtle', 'Diagnostic radiographer', 1052.0, 'news');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "sponsor_name" FROM "player" WHERE ("residence" = 'Brandon' OR "residence" = 'Birtle') ORDER BY sponsor_name, player.player_id NULLS LAST;

/*
Gold Result:
('David Bradley',)
('Katie Rodriguez',)
('Sarah Romero',)
('William Roman',)
*/

-- Prediction Query
SELECT Sponsor_name FROM player WHERE Residence = 'Brandon' OR Residence = 'Birtle';

/*
Prediction Result:
('Katie Rodriguez',)
('Sarah Romero',)
('William Roman',)
('David Bradley',)
*/