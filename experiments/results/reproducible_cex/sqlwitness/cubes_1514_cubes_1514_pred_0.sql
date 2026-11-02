-- Schema DDL
CREATE TABLE "program" ("Program_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Origin" TEXT, "Launch" REAL, "Owner" TEXT);

CREATE TABLE "channel" ("Channel_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Owner" TEXT, "Share_in_percent" REAL, "Rating_in_percent" REAL);

CREATE TABLE "broadcast" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Time_of_day" TEXT, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

CREATE TABLE "broadcast_share" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Date" TEXT, "Share_in_percent" REAL, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO channel (channel_id, name, owner, share_in_percent, rating_in_percent) VALUES (1, 'Night', 'default2', 0.0, 0.0), (0, 'default2', 'Morning', 1.0, 0.0), (2, 'default1', 'Night', NULL, NULL), (3, 'Morning', 'default1', 0.0, NULL);
INSERT INTO program (program_id, name, origin, launch, owner) VALUES (2, 'Morning', NULL, 0.0, 'Morning'), (0, 'Night', NULL, NULL, NULL), (1, 'default2', 'default2', 1.0, 'Morning'), (3, 'default2', 'default2', 2.0, NULL);
INSERT INTO broadcast (channel_id, program_id, time_of_day) VALUES (3, 1, 'Night'), (3, 3, 'default2'), (3, 2, 'Morning'), (0, 3, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM (SELECT * FROM (SELECT "channel_id", "name", "owner", "share_in_percent", "rating_in_percent", "channel_id_other", "time_of_day", "channel_id" AS "program_id" FROM (SELECT "LHS"."channel_id" AS "channel_id", "LHS"."name" AS "name", "LHS"."owner" AS "owner", "LHS"."share_in_percent" AS "share_in_percent", "LHS"."rating_in_percent" AS "rating_in_percent", "RHS"."channel_id" AS "channel_id_other", "RHS"."time_of_day" AS "time_of_day" FROM "channel" AS "LHS" INNER JOIN "broadcast" AS "RHS" ON ("LHS"."channel_id" = "RHS"."program_id"))) AS "LHS" WHERE EXISTS(SELECT 1 FROM (SELECT * FROM "broadcast" WHERE ("time_of_day" = 'Morning' OR "time_of_day" = 'Night')) AS RHS WHERE (LHS.channel_id = RHS.channel_id AND LHS.time_of_day = RHS.time_of_day AND LHS.program_id = RHS.program_id))) ORDER BY name, "name" NULLS LAST;

/*
Gold Result:
*/

-- Prediction Query
SELECT t1.name FROM channel AS t1 JOIN broadcast AS t2 ON t1.channel_id = t2.channel_id WHERE t2.time_of_day = 'Morning' INTERSECT SELECT t1.name FROM channel AS t1 JOIN broadcast AS t2 ON t1.channel_id = t2.channel_id WHERE t2.time_of_day = 'Night';

/*
Prediction Result:
('Morning',)
*/