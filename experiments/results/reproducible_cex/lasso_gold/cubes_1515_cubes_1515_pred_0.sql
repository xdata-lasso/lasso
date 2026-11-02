-- Schema DDL
CREATE TABLE "program" ("Program_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Origin" TEXT, "Launch" REAL, "Owner" TEXT);

CREATE TABLE "channel" ("Channel_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Owner" TEXT, "Share_in_percent" REAL, "Rating_in_percent" REAL);

CREATE TABLE "broadcast" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Time_of_day" TEXT, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

CREATE TABLE "broadcast_share" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Date" TEXT, "Share_in_percent" REAL, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "program" ("program_id", "name", "origin", "launch", "owner") VALUES (1006, 'Kevin Pacheco', 'mouth', 1007.5, 'kind');
INSERT INTO "program" ("program_id", "name", "origin", "launch", "owner") VALUES (1008, 'Allen Robinson', 'offer', 1008.5, 'play');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, origin, OWNER FROM program ORDER BY name, program.program_id NULLS LAST;

/*
Gold Result:
('Allen Robinson', 'offer', 'play')
('Kevin Pacheco', 'mouth', 'kind')
*/

-- Prediction Query
SELECT name, origin, OWNER FROM program;

/*
Prediction Result:
('Kevin Pacheco', 'mouth', 'kind')
('Allen Robinson', 'offer', 'play')
*/