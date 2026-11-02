-- Schema DDL
CREATE TABLE "program" ("Program_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Origin" TEXT, "Launch" REAL, "Owner" TEXT);

CREATE TABLE "channel" ("Channel_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Owner" TEXT, "Share_in_percent" REAL, "Rating_in_percent" REAL);

CREATE TABLE "broadcast" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Time_of_day" TEXT, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

CREATE TABLE "broadcast_share" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Date" TEXT, "Share_in_percent" REAL, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: program --
INSERT INTO "program" ("program_id", "name", "origin", "launch", "owner") VALUES (1, 'pro_6d87ac', 'pro_3eb8f0', 1.0, 'pro_750247');

INSERT INTO "program" ("program_id", "name", "origin", "launch", "owner") VALUES (-2147483647, 'pro_8b2ac1', 'pro_0cd871', 1.0, 'pro_dfdda8');

INSERT INTO "program" ("program_id", "name", "origin", "launch", "owner") VALUES (-1, '+', '5k5swwqcgs', 171.746906, 'n8c4pgu7v');

INSERT INTO "program" ("program_id", "name", "origin", "launch", "owner") VALUES (0, '#', 'e4', 779.409124, 'hria2ypuzhs');

INSERT INTO "program" ("program_id", "name", "origin", "launch", "owner") VALUES (-2147483644, 'q_1_b0f120', 'rwbbp6luhvd', 179.378884, 'ilbnp');

INSERT INTO "program" ("program_id", "name", "origin", "launch", "owner") VALUES (-2147483643, 'q_1_b0f120', 'mdpos', 133.007885, '5u');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM (SELECT * FROM program ORDER BY name DESC, program.program_id NULLS LAST) LIMIT 1);

/*
Gold Result:
('q_1_b0f120',)
*/

-- Prediction Query
SELECT name FROM program ORDER BY launch DESC, program.program_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('#',)
*/