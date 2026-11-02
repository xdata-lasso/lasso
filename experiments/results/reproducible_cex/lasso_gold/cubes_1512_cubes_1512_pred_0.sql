-- Schema DDL
CREATE TABLE "program" ("Program_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Origin" TEXT, "Launch" REAL, "Owner" TEXT);

CREATE TABLE "channel" ("Channel_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Owner" TEXT, "Share_in_percent" REAL, "Rating_in_percent" REAL);

CREATE TABLE "broadcast" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Time_of_day" TEXT, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

CREATE TABLE "broadcast_share" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Date" TEXT, "Share_in_percent" REAL, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "program" ("program_id", "name", "origin", "launch", "owner") VALUES (1001, 'Allison Hill', 'agreement', 1005.5, 'rate');
INSERT INTO "program" ("program_id", "name", "origin", "launch", "owner") VALUES (1002, 'Noah Rhodes', 'option', 1014.5, 'science');
INSERT INTO "program" ("program_id", "name", "origin", "launch", "owner") VALUES (1003, 'Angie Henderson', 'decide', 1023.5, 'offer');
INSERT INTO "program" ("program_id", "name", "origin", "launch", "owner") VALUES (1004, 'Daniel Wagner', 'sense', 1032.5, 'kind');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM (SELECT * FROM program ORDER BY name DESC, program.program_id NULLS LAST) LIMIT 1);

/*
Gold Result:
('Noah Rhodes',)
*/

-- Prediction Query
SELECT name FROM program ORDER BY launch DESC, program.program_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Daniel Wagner',)
*/