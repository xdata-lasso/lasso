-- Schema DDL
CREATE TABLE "program" ("Program_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Origin" TEXT, "Launch" REAL, "Owner" TEXT);

CREATE TABLE "channel" ("Channel_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Owner" TEXT, "Share_in_percent" REAL, "Rating_in_percent" REAL);

CREATE TABLE "broadcast" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Time_of_day" TEXT, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

CREATE TABLE "broadcast_share" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Date" TEXT, "Share_in_percent" REAL, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO channel (Channel_ID, Name, Owner, Share_in_percent, Rating_in_percent) VALUES (1, 'Ch1', 'Owner1', 10.0, 20.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT OWNER FROM (SELECT LHS.channel_id AS channel_id, LHS.name AS name, LHS.owner AS OWNER, LHS.share_in_percent AS share_in_percent, LHS.rating_in_percent AS rating_in_percent, LHS.maxrating_in_percent AS maxrating_in_percent, RHS.channel_id AS channel_id_other, RHS.name AS name_other, RHS.owner AS owner_other, RHS.share_in_percent AS share_in_percent_other, RHS.rating_in_percent AS rating_in_percent_other, RHS.maxrating_in_percent AS maxrating_in_percent_other FROM (SELECT channel_id, name, OWNER, share_in_percent, rating_in_percent, MAX(rating_in_percent) OVER () AS maxrating_in_percent FROM channel) AS LHS CROSS JOIN (SELECT channel_id, name, OWNER, share_in_percent, rating_in_percent, MAX(rating_in_percent) OVER () AS maxrating_in_percent FROM channel) AS RHS) WHERE (rating_in_percent >= maxrating_in_percent_other AND rating_in_percent_other <> maxrating_in_percent_other) ORDER BY OWNER;

/*
Gold Result:
*/

-- Prediction Query
SELECT OWNER FROM channel ORDER BY rating_in_percent DESC, channel.channel_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Owner1',)
*/