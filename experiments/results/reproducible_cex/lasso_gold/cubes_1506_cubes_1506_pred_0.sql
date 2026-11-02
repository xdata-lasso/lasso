-- Schema DDL
CREATE TABLE "program" ("Program_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Origin" TEXT, "Launch" REAL, "Owner" TEXT);

CREATE TABLE "channel" ("Channel_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Owner" TEXT, "Share_in_percent" REAL, "Rating_in_percent" REAL);

CREATE TABLE "broadcast" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Time_of_day" TEXT, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

CREATE TABLE "broadcast_share" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Date" TEXT, "Share_in_percent" REAL, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "channel" ("channel_id", "name", "owner", "share_in_percent", "rating_in_percent") VALUES (1001, 'Allison Hill', 'win', 1012.5, 1023.5);
INSERT INTO "channel" ("channel_id", "name", "owner", "share_in_percent", "rating_in_percent") VALUES (1002, 'Noah Rhodes', 'human', 1021.5, 1034.5);
INSERT INTO "channel" ("channel_id", "name", "owner", "share_in_percent", "rating_in_percent") VALUES (1003, 'Angie Henderson', 'bar', 1030.5, 1045.5);
INSERT INTO "channel" ("channel_id", "name", "owner", "share_in_percent", "rating_in_percent") VALUES (1004, 'Daniel Wagner', 'old', 1039.5, 1056.5);
INSERT INTO "channel" ("channel_id", "name", "owner", "share_in_percent", "rating_in_percent") VALUES (1005, 'Cristian Santos', 'finally', 1048.5, 1067.5);
INSERT INTO "channel" ("channel_id", "name", "owner", "share_in_percent", "rating_in_percent") VALUES (1006, 'Connie Lawrence', 'themselves', 1057.5, 1078.5);
INSERT INTO "channel" ("channel_id", "name", "owner", "share_in_percent", "rating_in_percent") VALUES (1007, 'Abigail Shaffer', 'production', 1066.5, 1089.5);
INSERT INTO "channel" ("channel_id", "name", "owner", "share_in_percent", "rating_in_percent") VALUES (1008, 'Gina Moore', 'present', 1075.5, 1100.5);
INSERT INTO "channel" ("channel_id", "name", "owner", "share_in_percent", "rating_in_percent") VALUES (1009, 'Gabrielle Davis', 'value', 1084.5, 1111.5);
INSERT INTO "channel" ("channel_id", "name", "owner", "share_in_percent", "rating_in_percent") VALUES (1010, 'Ryan Munoz', 'training', 1093.5, 1122.5);
INSERT INTO "channel" ("channel_id", "name", "owner", "share_in_percent", "rating_in_percent") VALUES (1011, 'Monica Herrera', 'high', 1102.5, 1133.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM (SELECT * FROM channel ORDER BY share_in_percent DESC, channel.channel_id NULLS LAST) LIMIT 8);

/*
Gold Result:
('Monica Herrera',)
('Ryan Munoz',)
('Gabrielle Davis',)
('Gina Moore',)
('Abigail Shaffer',)
('Connie Lawrence',)
('Cristian Santos',)
('Daniel Wagner',)
*/

-- Prediction Query
SELECT name FROM channel WHERE OWNER = 'CCTV' OR OWNER = 'HBS';

/*
Prediction Result:
*/