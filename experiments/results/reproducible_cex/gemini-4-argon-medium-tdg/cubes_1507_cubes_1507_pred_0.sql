-- Schema DDL
CREATE TABLE "program" ("Program_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Origin" TEXT, "Launch" REAL, "Owner" TEXT);

CREATE TABLE "channel" ("Channel_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Owner" TEXT, "Share_in_percent" REAL, "Rating_in_percent" REAL);

CREATE TABLE "broadcast" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Time_of_day" TEXT, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

CREATE TABLE "broadcast_share" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Date" TEXT, "Share_in_percent" REAL, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests NULL handling in Name and Channel_ID (Note: in SQLite, INTEGER PRIMARY KEY allows a single NULL under legacy quirks or standard rowid assignment,
-- though typically auto-populated; we test NULLs in Name and negative/zero IDs, plus unreferenced channels to kill INNER JOIN mutants).
INSERT INTO "program" ("Program_ID", "Name", "Origin", "Launch", "Owner") VALUES (100, 'Alpha_Program', 'Canada', 1999.0, 'Net_A');
INSERT INTO "channel" ("Channel_ID", "Name", "Owner", "Share_in_percent", "Rating_in_percent") VALUES (1, NULL, 'Owner_1', 10.0, 2.0);
INSERT INTO "channel" ("Channel_ID", "Name", "Owner", "Share_in_percent", "Rating_in_percent") VALUES (2, '', 'Owner_2', 20.0, 4.0);
INSERT INTO "channel" ("Channel_ID", "Name", "Owner", "Share_in_percent", "Rating_in_percent") VALUES (-5, 'B_Channel', NULL, NULL, NULL);
INSERT INTO "channel" ("Channel_ID", "Name", "Owner", "Share_in_percent", "Rating_in_percent") VALUES (0, 'A_Channel', 'Owner_0', 0.0, 0.0);
INSERT INTO "broadcast" ("Channel_ID", "Program_ID", "Time_of_day") VALUES (0, 100, 'Night');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM channel ORDER BY name, channel.channel_id NULLS LAST;

/*
Gold Result:
(None,)
('',)
('A_Channel',)
('B_Channel',)
*/

-- Prediction Query
SELECT name FROM channel ORDER BY rating_in_percent DESC, channel.channel_id NULLS LAST;

/*
Prediction Result:
('',)
(None,)
('A_Channel',)
('B_Channel',)
*/