-- Schema DDL
CREATE TABLE "program" ("Program_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Origin" TEXT, "Launch" REAL, "Owner" TEXT);

CREATE TABLE "channel" ("Channel_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Owner" TEXT, "Share_in_percent" REAL, "Rating_in_percent" REAL);

CREATE TABLE "broadcast" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Time_of_day" TEXT, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

CREATE TABLE "broadcast_share" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Date" TEXT, "Share_in_percent" REAL, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO channel (channel_id, name, owner, share_in_percent, rating_in_percent) VALUES (1, 'default1', 'default1', 1.0, 0.0), (0, 'default2', 'default1', 0.0, 1.0), (2, 'default2', NULL, NULL, NULL), (3, 'default1', 'default2', NULL, NULL), (4, NULL, NULL, 1.0, 1.0);
INSERT INTO program (program_id, name, origin, launch, owner) VALUES (0, 'default1', 'default1', 0.0, 'default1'), (1, 'default2', 'default2', 0.0, 'default1'), (2, 'default2', 'default1', 1.0, NULL);
INSERT INTO broadcast (channel_id, program_id, time_of_day) VALUES (2, 1, NULL), (0, 2, 'default1'), (4, 2, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, time_of_day FROM (SELECT time_of_day, COUNT(*) AS n FROM broadcast GROUP BY time_of_day) ORDER BY count___, time_of_day NULLS LAST;

/*
Gold Result:
(1, 'default1')
(2, None)
*/

-- Prediction Query
SELECT COUNT(*), time_of_day FROM broadcast GROUP BY time_of_day;

/*
Prediction Result:
(2, None)
(1, 'default1')
*/