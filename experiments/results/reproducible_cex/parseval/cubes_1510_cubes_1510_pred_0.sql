-- Schema DDL
CREATE TABLE "program" ("Program_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Origin" TEXT, "Launch" REAL, "Owner" TEXT);

CREATE TABLE "channel" ("Channel_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Owner" TEXT, "Share_in_percent" REAL, "Rating_in_percent" REAL);

CREATE TABLE "broadcast" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Time_of_day" TEXT, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

CREATE TABLE "broadcast_share" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Date" TEXT, "Share_in_percent" REAL, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: program --
INSERT INTO "program" ("program_id", "name", "origin", "launch", "owner") VALUES (1, 't1__c64ba1', '5k5swwqcgs', 171.746906, 'n8c4pgu7v');

INSERT INTO "program" ("program_id", "name", "origin", "launch", "owner") VALUES (-2147483647, 't1__c64ba1', '76nium52', 816.814398, 'buo4nrq');

-- Inserting into table: channel --
INSERT INTO "channel" ("channel_id", "name", "owner", "share_in_percent", "rating_in_percent") VALUES (-2147483648, 'e4', 'hria2ypuzhs', 663.049759, 711.020062);

INSERT INTO "channel" ("channel_id", "name", "owner", "share_in_percent", "rating_in_percent") VALUES (-2147483647, 'luhvdltti', 'bnp', 787.938887, 986.066566);

INSERT INTO "channel" ("channel_id", "name", "owner", "share_in_percent", "rating_in_percent") VALUES (-2147483646, 'fa9', '00t5c4e', 950.466571, 796.740316);

INSERT INTO "channel" ("channel_id", "name", "owner", "share_in_percent", "rating_in_percent") VALUES (-2147483645, 'ofqyp', 's5bbp02e', 325.080047, 186.190286);

INSERT INTO "channel" ("channel_id", "name", "owner", "share_in_percent", "rating_in_percent") VALUES (-2147483644, 'oo3o9', 'l7', 443.457804, 774.422647);

INSERT INTO "channel" ("channel_id", "name", "owner", "share_in_percent", "rating_in_percent") VALUES (-2147483643, 'i7z', 'au2dwy', 278.010437, 433.533777);

INSERT INTO "channel" ("channel_id", "name", "owner", "share_in_percent", "rating_in_percent") VALUES (-2147483642, 'jsl', 'b4yp5qi', 447.109657, 164.583726);

INSERT INTO "channel" ("channel_id", "name", "owner", "share_in_percent", "rating_in_percent") VALUES (-2147483641, 'x58pz0f8je', 'd2', 890.091601, 339.69384);

INSERT INTO "channel" ("channel_id", "name", "owner", "share_in_percent", "rating_in_percent") VALUES (-2147483640, 'h2gndqwnqcx5', 'hncprjtu0dz', 521.610309, 654.674676);

INSERT INTO "channel" ("channel_id", "name", "owner", "share_in_percent", "rating_in_percent") VALUES (-2147483639, 'n2f3dqv0g', 'cb98ozk3zbil', 728.712934, 279.382219);

INSERT INTO "channel" ("channel_id", "name", "owner", "share_in_percent", "rating_in_percent") VALUES (-2147483638, '6ah', 'f8jswwl', 260.513699, 969.559316);

INSERT INTO "channel" ("channel_id", "name", "owner", "share_in_percent", "rating_in_percent") VALUES (-2147483637, 'z16nijjai5d', 'h5ogrgjd8yz', 308.482994, 430.111467);

INSERT INTO "channel" ("channel_id", "name", "owner", "share_in_percent", "rating_in_percent") VALUES (-2147483636, 'grit', 'sj3ayxp1q430', 947.945777, 571.595144);

INSERT INTO "channel" ("channel_id", "name", "owner", "share_in_percent", "rating_in_percent") VALUES (-2147483635, 'vacx7afu5', '1of77p', 398.637058, 689.065203);

INSERT INTO "channel" ("channel_id", "name", "owner", "share_in_percent", "rating_in_percent") VALUES (-2147483634, 'v5q8qdj', 'e1io', 443.690199, 518.274259);

INSERT INTO "channel" ("channel_id", "name", "owner", "share_in_percent", "rating_in_percent") VALUES (-2147483633, 'g6bno', '5zi36c', 900.959264, 17.379583);

INSERT INTO "channel" ("channel_id", "name", "owner", "share_in_percent", "rating_in_percent") VALUES (-2147483632, '0', '7z2zezjo7wg', 790.772456, 50.798088);

INSERT INTO "channel" ("channel_id", "name", "owner", "share_in_percent", "rating_in_percent") VALUES (-2147483631, 'dgj5i', 'lq5lnpim', 487.138399, 821.273487);

INSERT INTO "channel" ("channel_id", "name", "owner", "share_in_percent", "rating_in_percent") VALUES (-2147483630, 'h2mna', 'jla', 462.366429, 946.809703);

INSERT INTO "channel" ("channel_id", "name", "owner", "share_in_percent", "rating_in_percent") VALUES (-2147483629, 'tmu2ne578l', 'vy', 392.947196, 527.633597);

INSERT INTO "channel" ("channel_id", "name", "owner", "share_in_percent", "rating_in_percent") VALUES (-2147483628, '42q7sx58b4', 'pmaus3auvmkr', 641.973572, 49.701386);

INSERT INTO "channel" ("channel_id", "name", "owner", "share_in_percent", "rating_in_percent") VALUES (-2147483627, 'a9n0jxfofws', 'do2zobb', 407.368744, 983.253685);

INSERT INTO "channel" ("channel_id", "name", "owner", "share_in_percent", "rating_in_percent") VALUES (-2147483626, 'msorlwyngc', 'dj9erhi', 746.006477, 106.602942);

INSERT INTO "channel" ("channel_id", "name", "owner", "share_in_percent", "rating_in_percent") VALUES (-2147483625, 'o6l0hdt', 'fuqyxuzkb', 904.57762, 769.556907);

INSERT INTO "channel" ("channel_id", "name", "owner", "share_in_percent", "rating_in_percent") VALUES (-2147483624, 'lb', 'eowi', 125.054027, 393.510383);

-- Inserting into table: broadcast --
INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (-2147483648, 1, 'b');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (-2147483647, 1, 'dposiie5unw');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (-2147483646, 1, 'gce');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (-2147483645, 1, 'a11ry');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (-2147483644, 1, 'ex1');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (-2147483643, 1, 'pyu78d99');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (-2147483642, 1, '9v');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (-2147483641, 1, '9uxj4hwbdvl');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (-2147483640, 1, 'jg');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (-2147483639, 1, 'n6v');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (-2147483638, 1, 'xb72fxa7ryfd');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (-2147483637, 1, 'f');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (-2147483636, 1, 'jh3den8c68');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (-2147483635, 1, '72ctdctmfg62');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (-2147483634, 1, '07cvtjpt');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (-2147483633, 1, 'foa');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (-2147483632, 1, 'ysxcmr0o');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (-2147483631, 1, 'qs27p2r94');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (-2147483630, 1, 'v8u');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (-2147483629, 1, 'zbe8yvk');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (-2147483628, 1, 'wzw5chn9mo70');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (-2147483627, 1, '0k32odwcl5a');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (-2147483626, 1, '1yo');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (-2147483625, 1, '521gwnlas6');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (-2147483624, 1, 'xih6');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.program_id AS program_id, LHS.name AS name, LHS.origin AS origin, LHS.launch AS launch, LHS.owner AS OWNER, RHS.origin AS origin_other FROM program AS LHS INNER JOIN (SELECT name, origin, COUNT(*) AS n FROM (SELECT LHS.channel_id AS channel_id, LHS.program_id AS program_id, LHS.time_of_day AS time_of_day, RHS.name AS name, RHS.origin AS origin, RHS.launch AS launch, RHS.owner AS OWNER FROM broadcast AS LHS INNER JOIN program AS RHS ON (LHS.program_id = RHS.program_id)) GROUP BY name, origin) AS RHS ON (LHS.program_id = RHS.n AND LHS.name = RHS.name)) ORDER BY name;

/*
Gold Result:
*/

-- Prediction Query
SELECT t1.name FROM program AS t1 JOIN broadcast AS t2 ON t1.program_id = t2.program_id GROUP BY t2.program_id ORDER BY COUNT(*) DESC, t1.name NULLS LAST LIMIT 1;

/*
Prediction Result:
('t1__c64ba1',)
*/