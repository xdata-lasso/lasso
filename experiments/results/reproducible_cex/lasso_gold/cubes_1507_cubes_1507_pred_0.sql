-- Schema DDL
CREATE TABLE "program" ("Program_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Origin" TEXT, "Launch" REAL, "Owner" TEXT);

CREATE TABLE "channel" ("Channel_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Owner" TEXT, "Share_in_percent" REAL, "Rating_in_percent" REAL);

CREATE TABLE "broadcast" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Time_of_day" TEXT, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

CREATE TABLE "broadcast_share" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Date" TEXT, "Share_in_percent" REAL, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "channel" ("channel_id", "name", "owner", "share_in_percent", "rating_in_percent") VALUES (0, 'David Garcia', 'fall', 1033.5, 1034.5);
INSERT INTO "channel" ("channel_id", "name", "owner", "share_in_percent", "rating_in_percent") VALUES (150, 'David Garcia', 'hear', 1036.5, 1037.5);
INSERT INTO "channel" ("channel_id", "name", "owner", "share_in_percent", "rating_in_percent") VALUES (20, 'Mark Ferguson', 'raise', 1039.5, 1040.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM channel ORDER BY name, channel.channel_id NULLS LAST;

/*
Gold Result:
('David Garcia',)
('David Garcia',)
('Mark Ferguson',)
*/

-- Prediction Query
SELECT name FROM channel ORDER BY rating_in_percent DESC, channel.channel_id NULLS LAST;

/*
Prediction Result:
('Mark Ferguson',)
('David Garcia',)
('David Garcia',)
*/