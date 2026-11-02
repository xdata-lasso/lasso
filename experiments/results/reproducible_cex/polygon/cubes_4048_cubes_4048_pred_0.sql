-- Schema DDL
CREATE TABLE "program" ("Program_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Origin" TEXT, "Launch" REAL, "Owner" TEXT);

CREATE TABLE "channel" ("Channel_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Owner" TEXT, "Share_in_percent" REAL, "Rating_in_percent" REAL);

CREATE TABLE "broadcast" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Time_of_day" TEXT, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

CREATE TABLE "broadcast_share" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Date" TEXT, "Share_in_percent" REAL, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "program" ("program_id", "name", "origin", "launch", "owner") VALUES (13, '19', '19', 19, '19');
INSERT INTO "program" ("program_id", "name", "origin", "launch", "owner") VALUES (12, '19', '19', 19, '19');
INSERT INTO "channel" ("channel_id", "name", "owner", "share_in_percent", "rating_in_percent") VALUES (17, NULL, '19', NULL, -635);
INSERT INTO "channel" ("channel_id", "name", "owner", "share_in_percent", "rating_in_percent") VALUES (14, '19', '15', 19, -634);
INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (14, 13, '19');
INSERT INTO "broadcast_share" ("channel_id", "program_id", "date", "share_in_percent") VALUES (14, 12, '19', 19);
INSERT INTO "broadcast_share" ("channel_id", "program_id", "date", "share_in_percent") VALUES (14, 13, '19', 19);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT OWNER FROM (SELECT LHS.channel_id AS channel_id, LHS.name AS name, LHS.owner AS OWNER, LHS.share_in_percent AS share_in_percent, LHS.rating_in_percent AS rating_in_percent, LHS.maxrating_in_percent AS maxrating_in_percent, RHS.channel_id AS channel_id_other, RHS.name AS name_other, RHS.owner AS owner_other, RHS.share_in_percent AS share_in_percent_other, RHS.rating_in_percent AS rating_in_percent_other, RHS.maxrating_in_percent AS maxrating_in_percent_other FROM (SELECT channel_id, name, OWNER, share_in_percent, rating_in_percent, MAX(rating_in_percent) OVER () AS maxrating_in_percent FROM channel) AS LHS CROSS JOIN (SELECT channel_id, name, OWNER, share_in_percent, rating_in_percent, MAX(rating_in_percent) OVER () AS maxrating_in_percent FROM channel) AS RHS) WHERE (rating_in_percent >= maxrating_in_percent_other AND rating_in_percent_other <> maxrating_in_percent_other) ORDER BY OWNER;

/*
Gold Result:
('15',)
*/

-- Prediction Query
SELECT OWNER FROM channel ORDER BY rating_in_percent DESC, channel.channel_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('15',)
*/