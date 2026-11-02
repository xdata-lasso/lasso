-- Schema DDL
CREATE TABLE "program" ("Program_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Origin" TEXT, "Launch" REAL, "Owner" TEXT);

CREATE TABLE "channel" ("Channel_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Owner" TEXT, "Share_in_percent" REAL, "Rating_in_percent" REAL);

CREATE TABLE "broadcast" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Time_of_day" TEXT, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

CREATE TABLE "broadcast_share" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Date" TEXT, "Share_in_percent" REAL, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: program --
INSERT INTO "program" ("program_id", "name", "origin", "launch", "owner") VALUES (-2147483648, 'pro_f2ea34', '5k5swwqcgs', 171.746906, 'n8c4pgu7v');

INSERT INTO "program" ("program_id", "name", "origin", "launch", "owner") VALUES (1, 't1__00668b', 'e4', 779.409124, 'hria2ypuzhs');

INSERT INTO "program" ("program_id", "name", "origin", "launch", "owner") VALUES (2, 'pro_f2ea34', 'prmd', 792.223623, 'posiie5unw6k');

INSERT INTO "program" ("program_id", "name", "origin", "launch", "owner") VALUES (3, 'pro_f2ea34', 'fa9', 877.276439, '00t5c4ecigc');

INSERT INTO "program" ("program_id", "name", "origin", "launch", "owner") VALUES (-2147483646, 't1__a89d31', 'e376nium52', 816.814398, 'buo4nrq');

INSERT INTO "program" ("program_id", "name", "origin", "launch", "owner") VALUES (-2147483643, 'pro_f2ea34', '72klex14ji7z', 353.163664, 'u');

INSERT INTO "program" ("program_id", "name", "origin", "launch", "owner") VALUES (-2147483642, 'pro_eaa89a', '2dwyrq13pyu7', 798.947629, '9');

INSERT INTO "program" ("program_id", "name", "origin", "launch", "owner") VALUES (-2147483641, 'pro_f2ea34', '8jegd21vy9ux', 585.18838, '4hw');

INSERT INTO "program" ("program_id", "name", "origin", "launch", "owner") VALUES (-2147483640, 'pro_f2ea34', 'v', 185.427628, 'h2gn');

INSERT INTO "program" ("program_id", "name", "origin", "launch", "owner") VALUES (-2147483639, 'pro_f2ea34', 'fjgq8n2f3d', 656.638403, 'qv0gcb98oz');

INSERT INTO "program" ("program_id", "name", "origin", "launch", "owner") VALUES (-2147483638, 'pro_f2ea34', 'zbilyrkn', 692.775559, 'ck6ah0');

INSERT INTO "program" ("program_id", "name", "origin", "launch", "owner") VALUES (-2147483637, 'pro_f2ea34', '16nijjai5dh', 488.601669, 'grgj');

INSERT INTO "program" ("program_id", "name", "origin", "launch", "owner") VALUES (-2147483636, 'pro_f2ea34', 'acx7af', 313.653498, 'w1of77pz');

INSERT INTO "program" ("program_id", "name", "origin", "launch", "owner") VALUES (-2147483635, 'pro_f2ea34', '7cvtjpt', 605.666938, '6b');

INSERT INTO "program" ("program_id", "name", "origin", "launch", "owner") VALUES (-2147483634, 'pro_f2ea34', 'ysxcmr0o', 698.769833, 'dgj5i');

INSERT INTO "program" ("program_id", "name", "origin", "launch", "owner") VALUES (-2147483633, 'pro_f2ea34', 'kv8u', 311.951038, 'mu2ne');

INSERT INTO "program" ("program_id", "name", "origin", "launch", "owner") VALUES (-2147483632, NULL, 'o705a9n0jxfo', 82.48091, 'zdo2z');

-- Inserting into table: channel --
INSERT INTO "channel" ("channel_id", "name", "owner", "share_in_percent", "rating_in_percent") VALUES (-2147483648, 'rwbbp6luhvd', 'tti', 182.319045, 998.421621);

INSERT INTO "channel" ("channel_id", "name", "owner", "share_in_percent", "rating_in_percent") VALUES (-2147483647, 'fqyp', 's5bbp02e', 325.080047, 186.190286);

INSERT INTO "channel" ("channel_id", "name", "owner", "share_in_percent", "rating_in_percent") VALUES (-2147483646, '1', 'ryytoo3', 228.583847, 111.926013);

INSERT INTO "channel" ("channel_id", "name", "owner", "share_in_percent", "rating_in_percent") VALUES (-2147483645, 'ljsl0', '4', 884.000446, 598.741024);

INSERT INTO "channel" ("channel_id", "name", "owner", "share_in_percent", "rating_in_percent") VALUES (-2147483644, 'qi2rkf9v', 'x58pz', 410.133844, 88.474525);

INSERT INTO "channel" ("channel_id", "name", "owner", "share_in_percent", "rating_in_percent") VALUES (-2147483643, 'wnqcx', '5hncprjtu0d', 395.809081, 552.472052);

INSERT INTO "channel" ("channel_id", "name", "owner", "share_in_percent", "rating_in_percent") VALUES (-2147483642, 'jswwlq7xb', '72fxa7ryfd', 276.61064, 399.319982);

INSERT INTO "channel" ("channel_id", "name", "owner", "share_in_percent", "rating_in_percent") VALUES (-2147483641, 'yzt1afgog', 'itsj3', 15.432127, 385.461721);

INSERT INTO "channel" ("channel_id", "name", "owner", "share_in_percent", "rating_in_percent") VALUES (-2147483640, 'q4301jh', 'den8c68x', 897.348977, 764.833588);

INSERT INTO "channel" ("channel_id", "name", "owner", "share_in_percent", "rating_in_percent") VALUES (-2147483639, '72ctdctmfg62', '0v', 492.883123, 691.147113);

INSERT INTO "channel" ("channel_id", "name", "owner", "share_in_percent", "rating_in_percent") VALUES (-2147483638, 'djpe1', 'o22', 518.274259, 494.537964);

INSERT INTO "channel" ("channel_id", "name", "owner", "share_in_percent", "rating_in_percent") VALUES (-2147483637, 'u5zi', '6c4bfkfo', 12.330671, 774.96573);

INSERT INTO "channel" ("channel_id", "name", "owner", "share_in_percent", "rating_in_percent") VALUES (-2147483636, '0', '7z2zezjo7wg', 790.772456, 50.798088);

INSERT INTO "channel" ("channel_id", "name", "owner", "share_in_percent", "rating_in_percent") VALUES (-2147483635, 'q5l', 'pim5', 167.377262, 492.8451);

INSERT INTO "channel" ("channel_id", "name", "owner", "share_in_percent", "rating_in_percent") VALUES (-2147483634, 's27p2r94gth2', 'najj', 185.260952, 462.366429);

INSERT INTO "channel" ("channel_id", "name", "owner", "share_in_percent", "rating_in_percent") VALUES (-2147483633, '78lfvyz7zz', 'be8yvkv42q7', 282.68858, 369.678951);

INSERT INTO "channel" ("channel_id", "name", "owner", "share_in_percent", "rating_in_percent") VALUES (-2147483632, '8b4pmaus3au', 'mkrpdj', 736.632717, 757.502454);

INSERT INTO "channel" ("channel_id", "name", "owner", "share_in_percent", "rating_in_percent") VALUES (-2147483631, 'b', 'q0k32od', 357.061424, 979.99406);

-- Inserting into table: broadcast --
INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (-2147483648, 1, 'Morning');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (-2147483647, 1, 'Morning');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (-2147483646, 1, 'Morning');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (-2147483645, 1, 'Morning');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (-2147483644, 1, 'Morning');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (-2147483648, 3, 'Morning');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (-2147483643, 3, 'Morning');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (-2147483647, 3, 'Morning');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (-2147483642, 3, 'Morning');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (-2147483641, 1, 'Morning');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (-2147483640, 1, 'Morning');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (-2147483639, 1, 'Morning');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (-2147483638, 1, 'Morning');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (-2147483637, 1, 'Morning');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (-2147483636, 1, 'Morning');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (-2147483635, 1, 'Morning');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (-2147483634, 1, 'Morning');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (-2147483633, 1, 't2__ac014e');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (-2147483632, 1, 'w5chn9m');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (-2147483631, 1, 'Morning');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM (SELECT * FROM "program" AS "LHS" WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM "broadcast" WHERE ("time_of_day" = 'Morning')) AS RHS WHERE (LHS.program_id = RHS.program_id))) ORDER BY name, "name" NULLS LAST;

/*
Gold Result:
(None,)
('pro_eaa89a',)
('pro_f2ea34',)
('pro_f2ea34',)
('pro_f2ea34',)
('pro_f2ea34',)
('pro_f2ea34',)
('pro_f2ea34',)
('pro_f2ea34',)
('pro_f2ea34',)
('pro_f2ea34',)
('pro_f2ea34',)
('pro_f2ea34',)
('pro_f2ea34',)
('t1__a89d31',)
*/

-- Prediction Query
SELECT name FROM program EXCEPT SELECT t1.name FROM program AS t1 JOIN broadcast AS t2 ON t1.program_id = t2.program_id WHERE t2.Time_of_day = 'Morning';

/*
Prediction Result:
(None,)
('pro_eaa89a',)
('t1__a89d31',)
*/