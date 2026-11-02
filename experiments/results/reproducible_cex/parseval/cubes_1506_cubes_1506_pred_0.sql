-- Schema DDL
CREATE TABLE "program" ("Program_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Origin" TEXT, "Launch" REAL, "Owner" TEXT);

CREATE TABLE "channel" ("Channel_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Owner" TEXT, "Share_in_percent" REAL, "Rating_in_percent" REAL);

CREATE TABLE "broadcast" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Time_of_day" TEXT, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

CREATE TABLE "broadcast_share" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Date" TEXT, "Share_in_percent" REAL, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: channel --
INSERT INTO "channel" ("channel_id", "name", "owner", "share_in_percent", "rating_in_percent") VALUES (1, 'cha_8c8f72', 'cha_fadd1d', 1.0, 1.0);

INSERT INTO "channel" ("channel_id", "name", "owner", "share_in_percent", "rating_in_percent") VALUES (-2147483647, 'cha_136455', 'cha_5d5612', 1.0, 1.0);

INSERT INTO "channel" ("channel_id", "name", "owner", "share_in_percent", "rating_in_percent") VALUES (-2147483646, 'q_1_2fda73', '5k5swwqcgs', 171.746906, 557.512061);

INSERT INTO "channel" ("channel_id", "name", "owner", "share_in_percent", "rating_in_percent") VALUES (-2147483645, 'q_1_2fda73', '8c4pgu7vfe', 483.665643, 818.685402);

INSERT INTO "channel" ("channel_id", "name", "owner", "share_in_percent", "rating_in_percent") VALUES (-2147483644, 'q_1_2fda73', 'ri', 710.998147, 945.642658);

INSERT INTO "channel" ("channel_id", "name", "owner", "share_in_percent", "rating_in_percent") VALUES (-2147483643, 'q_1_2fda73', 'ypuzhsrw', 944.247544, 994.117864);

INSERT INTO "channel" ("channel_id", "name", "owner", "share_in_percent", "rating_in_percent") VALUES (-2147483642, 'q_1_2fda73', 'p6luhvdlttil', 22.535764, 600.048938);

INSERT INTO "channel" ("channel_id", "name", "owner", "share_in_percent", "rating_in_percent") VALUES (-2147483641, 'q_1_2fda73', 'rmdp', 227.766936, 971.82669);

INSERT INTO "channel" ("channel_id", "name", "owner", "share_in_percent", "rating_in_percent") VALUES (-2147483640, 'q_1_2fda73', 'ie5', 327.753528, 218.301157);

INSERT INTO "channel" ("channel_id", "name", "owner", "share_in_percent", "rating_in_percent") VALUES (-2147483639, 'q_1_2fda73', 'klfa9000t', 827.854302, 983.124993);

INSERT INTO "channel" ("channel_id", "name", "owner", "share_in_percent", "rating_in_percent") VALUES (2, '4', 'ecigce376n', 7719.0, 805.746877);

INSERT INTO "channel" ("channel_id", "name", "owner", "share_in_percent", "rating_in_percent") VALUES (5, 'm52zbu', '4nrq', 0.0, 597.420508);

INSERT INTO "channel" ("channel_id", "name", "owner", "share_in_percent", "rating_in_percent") VALUES (6, 'fqyp', 's5bbp02e', -21238.0, 325.080047);

INSERT INTO "channel" ("channel_id", "name", "owner", "share_in_percent", "rating_in_percent") VALUES (4, 'iqa', '1ryytoo', -2437.0, 882.985782);

INSERT INTO "channel" ("channel_id", "name", "owner", "share_in_percent", "rating_in_percent") VALUES (3, '9hl7', 'klex14ji', -8855.0, 598.409165);

INSERT INTO "channel" ("channel_id", "name", "owner", "share_in_percent", "rating_in_percent") VALUES (7, 'wau2dwy', 'q13py', -11797.0, 326.912005);

INSERT INTO "channel" ("channel_id", "name", "owner", "share_in_percent", "rating_in_percent") VALUES (8, 'd99rljsl0', '4', -8365.0, 884.000446);

INSERT INTO "channel" ("channel_id", "name", "owner", "share_in_percent", "rating_in_percent") VALUES (9, 'p5qi2rkf9v', 'x58pz', -32285.0, 410.133844);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM (SELECT * FROM channel ORDER BY share_in_percent DESC, channel.channel_id NULLS LAST) LIMIT 8);

/*
Gold Result:
('4',)
('q_1_2fda73',)
('q_1_2fda73',)
('q_1_2fda73',)
('q_1_2fda73',)
('q_1_2fda73',)
('q_1_2fda73',)
('q_1_2fda73',)
*/

-- Prediction Query
SELECT name FROM channel WHERE OWNER = 'CCTV' OR OWNER = 'HBS';

/*
Prediction Result:
*/