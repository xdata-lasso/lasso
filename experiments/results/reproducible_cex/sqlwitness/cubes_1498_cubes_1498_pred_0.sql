-- Schema DDL
CREATE TABLE "program" ("Program_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Origin" TEXT, "Launch" REAL, "Owner" TEXT);

CREATE TABLE "channel" ("Channel_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Owner" TEXT, "Share_in_percent" REAL, "Rating_in_percent" REAL);

CREATE TABLE "broadcast" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Time_of_day" TEXT, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

CREATE TABLE "broadcast_share" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Date" TEXT, "Share_in_percent" REAL, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO channel (channel_id, name, owner, share_in_percent, rating_in_percent) VALUES (0, 'Morning', 'default2', 1.0, 0.0), (1, NULL, NULL, 1.0, 1.0), (2, 'default2', NULL, NULL, NULL), (3, 'Morning', NULL, NULL, 1.0), (4, 'default2', 'default2', NULL, 1.0), (5, 'default2', NULL, NULL, NULL), (6, NULL, 'Morning', NULL, 1.0), (7, 'Morning', 'default2', 1.0, NULL), (8, 'default1', 'default2', 0.0, NULL), (9, 'default1', 'default1', 1.0, NULL), (10, NULL, NULL, 0.0, NULL);
INSERT INTO program (program_id, name, origin, launch, owner) VALUES (0, 'Morning', 'default2', 0.0, 'default2'), (1, NULL, NULL, 1.0, 'default2'), (2, NULL, 'default2', 0.0, 'default1'), (3, NULL, 'Morning', 1.0, NULL), (4, 'Morning', 'default1', 1.0, 'default2'), (5, NULL, NULL, 0.0, 'default2'), (6, 'default2', 'default1', 0.0, NULL), (7, 'Morning', 'default1', 0.0, 'Morning'), (8, NULL, 'default1', 0.0, 'default2');
INSERT INTO broadcast (channel_id, program_id, time_of_day) VALUES (9, 0, 'default2'), (8, 1, 'default1'), (0, 0, 'default1'), (3, 0, 'default1'), (9, 5, 'default1'), (0, 2, 'default2'), (7, 6, 'Morning'), (4, 8, 'Morning'), (10, 2, 'Morning');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM (SELECT "LHS"."channel_id" AS "channel_id", "LHS"."name" AS "name", "LHS"."owner" AS "owner", "LHS"."share_in_percent" AS "share_in_percent", "LHS"."rating_in_percent" AS "rating_in_percent", "RHS"."program_id" AS "program_id", "RHS"."time_of_day" AS "time_of_day" FROM "channel" AS "LHS" INNER JOIN (SELECT * FROM "broadcast" WHERE ("time_of_day" = 'Morning')) AS RHS ON (LHS.channel_id = RHS.channel_id)) ORDER BY name, "name" NULLS LAST;

/*
Gold Result:
(None,)
('Morning',)
('default2',)
*/

-- Prediction Query
SELECT t1.name FROM channel AS t1 JOIN broadcast AS t2 ON t1.channel_id = t2.channel_id WHERE t2.time_of_day = 'Morning';

/*
Prediction Result:
('Morning',)
('default2',)
(None,)
*/