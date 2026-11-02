-- Schema DDL
CREATE TABLE "program" ("Program_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Origin" TEXT, "Launch" REAL, "Owner" TEXT);

CREATE TABLE "channel" ("Channel_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Owner" TEXT, "Share_in_percent" REAL, "Rating_in_percent" REAL);

CREATE TABLE "broadcast" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Time_of_day" TEXT, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

CREATE TABLE "broadcast_share" ("Channel_ID" INTEGER, "Program_ID" INTEGER, "Date" TEXT, "Share_in_percent" REAL, PRIMARY KEY ("Channel_ID", "Program_ID"), FOREIGN KEY ("Program_ID") REFERENCES "program" ("Program_ID"), FOREIGN KEY ("Channel_ID") REFERENCES "channel" ("Channel_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: program --
INSERT INTO "program" ("program_id", "name", "origin", "launch", "owner") VALUES (-2147483648, '8c4pgu7vfe', 'hria2ypu', 882.963176, 'sr');

INSERT INTO "program" ("program_id", "name", "origin", "launch", "owner") VALUES (-2147483647, 'b', 'p6luhvdlttil', 22.535764, 'nprmdposii');

INSERT INTO "program" ("program_id", "name", "origin", "launch", "owner") VALUES (-2147483646, 'gce376nium52', 'zbuo4nrqrof', 586.906897, 'p5s5bbp');

INSERT INTO "program" ("program_id", "name", "origin", "launch", "owner") VALUES (-2147483645, '2eutliqa11r', 'ytoo3o9', 111.926013, '72klex14ji7z');

INSERT INTO "program" ("program_id", "name", "origin", "launch", "owner") VALUES (-2147483644, 'yu78', '9', 557.003843, 'jsl');

INSERT INTO "program" ("program_id", "name", "origin", "launch", "owner") VALUES (-2147483643, '4', 'p5qi2rk', 811.601922, '9v');

INSERT INTO "program" ("program_id", "name", "origin", "launch", "owner") VALUES (-2147483642, 'x58pz0f8je', 'd2', 890.091601, 'y9uxj4');

INSERT INTO "program" ("program_id", "name", "origin", "launch", "owner") VALUES (-2147483641, 'bdvlph', 'gndqwnqc', 629.317167, '5hncprjtu0d');

INSERT INTO "program" ("program_id", "name", "origin", "launch", "owner") VALUES (-2147483640, 'gq8', 'n2f3dqv0gcb9', 540.154414, 'k3zbily');

INSERT INTO "program" ("program_id", "name", "origin", "launch", "owner") VALUES (-2147483639, 'n6vck6ah0f', 'jswwlq7xb', 598.428216, '2fxa7ryfdrz');

INSERT INTO "program" ("program_id", "name", "origin", "launch", "owner") VALUES (-2147483638, '6nijjai5dh', 'ogrgjd8y', 763.019095, '1afgo');

INSERT INTO "program" ("program_id", "name", "origin", "launch", "owner") VALUES (-2147483637, 'itsj3', 'y', 360.694313, 'q4301jh');

INSERT INTO "program" ("program_id", "name", "origin", "launch", "owner") VALUES (-2147483636, 'n8', 'c68x8vacx7', 854.793228, 'u5');

INSERT INTO "program" ("program_id", "name", "origin", "launch", "owner") VALUES (-2147483635, '1of77pzo72c', 'dctmf', 102.360106, '2g0v5q8qd');

INSERT INTO "program" ("program_id", "name", "origin", "launch", "owner") VALUES (-2147483634, 'e1io', '278507cv', 298.188866, 'ttg6');

INSERT INTO "program" ("program_id", "name", "origin", "launch", "owner") VALUES (-2147483633, 'ou5z', '36c', 900.959264, 'f');

INSERT INTO "program" ("program_id", "name", "origin", "launch", "owner") VALUES (-2147483632, 'c', '0', 668.776683, 'z2zezjo7w');

INSERT INTO "program" ("program_id", "name", "origin", "launch", "owner") VALUES (-2147483631, 'd5ysxc', 'r0oz', 297.258735, 'j5');

INSERT INTO "program" ("program_id", "name", "origin", "launch", "owner") VALUES (-2147483630, 'lq5lnpim', 'k58qs27p', 452.630377, '94gth');

INSERT INTO "program" ("program_id", "name", "origin", "launch", "owner") VALUES (-2147483629, 'mnajjla3', 'okv8uttmu2', 208.49371, '78lfvyz7');

INSERT INTO "program" ("program_id", "name", "origin", "launch", "owner") VALUES (-2147483628, 'zbe8yvk', 'v42q7sx58b4p', 199.318647, 'u');

INSERT INTO "program" ("program_id", "name", "origin", "launch", "owner") VALUES (-2147483627, 'auvmkrpd', 'wzw', 487.079129, 'n9');

INSERT INTO "program" ("program_id", "name", "origin", "launch", "owner") VALUES (-2147483626, '05a9n0jxf', 'fwsz', 55.294573, '2zob');

INSERT INTO "program" ("program_id", "name", "origin", "launch", "owner") VALUES (-2147483625, 'q0k32od', 'cl5ams', 665.099697, 'lwyng');

INSERT INTO "program" ("program_id", "name", "origin", "launch", "owner") VALUES (-2147483624, 'dj9erhi', 'zgk1yoeyo6l0', 124.067083, '6fuqy');

INSERT INTO "program" ("program_id", "name", "origin", "launch", "owner") VALUES (-2147483623, 'uzkb521gwnl', 's', 509.069144, 'elboeowii1');

INSERT INTO "program" ("program_id", "name", "origin", "launch", "owner") VALUES (-2147483622, 'xih6', '2q2xlyoto', 913.199755, 'oaawg96aq');

INSERT INTO "program" ("program_id", "name", "origin", "launch", "owner") VALUES (-2147483621, 'tbindz3', 'tajz9td8n', 655.746331, 'wcgumbc3');

INSERT INTO "program" ("program_id", "name", "origin", "launch", "owner") VALUES (-2147483620, 'tdu6bd0w96', '3vzxw1r', 372.360229, '9y');

INSERT INTO "program" ("program_id", "name", "origin", "launch", "owner") VALUES (-2147483619, '7qk', '162nh55y3d', 602.631056, 'vu');

INSERT INTO "program" ("program_id", "name", "origin", "launch", "owner") VALUES (-2147483618, '6dza35r', 'mkio18ri2hy', 745.189516, '08ftp6ewtqx');

INSERT INTO "program" ("program_id", "name", "origin", "launch", "owner") VALUES (-2147483617, 'jaby', 'mzn2mfx7h3', 453.840746, '6sto');

INSERT INTO "program" ("program_id", "name", "origin", "launch", "owner") VALUES (-2147483616, 'j', 'sh5knzys7', 846.300006, 'yd1jmgj');

INSERT INTO "program" ("program_id", "name", "origin", "launch", "owner") VALUES (-2147483615, 'h', 'qta8y3a17', 741.721165, '4ygmay');

INSERT INTO "program" ("program_id", "name", "origin", "launch", "owner") VALUES (-2147483614, 'qdpuap96', 'ntdqr', 110.952654, 'wlic7dn2');

INSERT INTO "program" ("program_id", "name", "origin", "launch", "owner") VALUES (-2147483613, 'p490xdmsqt', 'el', 40.211911, 'qb9i9f2ccu');

INSERT INTO "program" ("program_id", "name", "origin", "launch", "owner") VALUES (-2147483612, '1quik', 'yhb08hl', 770.955182, 't1pqo');

INSERT INTO "program" ("program_id", "name", "origin", "launch", "owner") VALUES (-2147483611, 'ztv', '6', 196.268517, 'z78');

INSERT INTO "program" ("program_id", "name", "origin", "launch", "owner") VALUES (-2147483610, 'qlud8', 'tb', 544.766726, '9114qbre6bj');

INSERT INTO "program" ("program_id", "name", "origin", "launch", "owner") VALUES (-2147483609, 'uuwsj8kjh8', 'wpxlvris', 637.018037, 'rz0kaq');

INSERT INTO "program" ("program_id", "name", "origin", "launch", "owner") VALUES (-2147483608, 'ncgc8s3b7v', '88kwdmdbdht6', 573.061557, '7nxar50h');

INSERT INTO "program" ("program_id", "name", "origin", "launch", "owner") VALUES (-2147483607, 'jhanz', 'dpunmw', 986.324533, 'wx');

INSERT INTO "program" ("program_id", "name", "origin", "launch", "owner") VALUES (-2147483606, 'lawk0', '14r5dqtsmg97', 654.911516, 'q');

INSERT INTO "program" ("program_id", "name", "origin", "launch", "owner") VALUES (-2147483605, 'dlysu6iphd', 'u2g', 828.819416, 'r31');

INSERT INTO "program" ("program_id", "name", "origin", "launch", "owner") VALUES (-2147483604, 'sb3uoi1pavcv', 'wnyqrouirlrp', 738.89705, 'it63xy');

INSERT INTO "program" ("program_id", "name", "origin", "launch", "owner") VALUES (-2147483603, 'mjwpp2', 'mb3aj0ju0', 124.099574, 'r133ir1a');

-- Inserting into table: channel --
INSERT INTO "channel" ("channel_id", "name", "owner", "share_in_percent", "rating_in_percent") VALUES (1, 't1__99aca4', '5k5swwqcgs', 171.746906, 557.512061);

INSERT INTO "channel" ("channel_id", "name", "owner", "share_in_percent", "rating_in_percent") VALUES (2, 't1__99aca4', '5u', 933.422701, 345.718563);

INSERT INTO "channel" ("channel_id", "name", "owner", "share_in_percent", "rating_in_percent") VALUES (3, 't1__99aca4', 'klfa9000t', 827.854302, 983.124993);

INSERT INTO "channel" ("channel_id", "name", "owner", "share_in_percent", "rating_in_percent") VALUES (-2147483647, 't1__aa470a', '4', 587.103196, 950.466571);

INSERT INTO "channel" ("channel_id", "name", "owner", "share_in_percent", "rating_in_percent") VALUES (-2147483644, 't1__d68dd1', 'au2dwy', 278.010437, 433.533777);

-- Inserting into table: broadcast --
INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (1, -2147483648, 'Night');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (1, -2147483647, 'Morning');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (2, -2147483648, 'Night');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (2, -2147483646, 'Night');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (1, -2147483646, 'Morning');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (1, -2147483645, 'Morning');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (1, -2147483644, 'Night');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (1, -2147483643, 'Night');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (2, -2147483642, 'Morning');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (2, -2147483641, 'Morning');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (3, -2147483642, 'Night');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (1, -2147483640, 'Morning');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (3, -2147483644, 'Night');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (1, -2147483639, 'Morning');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (3, -2147483638, 'Night');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (1, -2147483637, 'Morning');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (1, -2147483641, 'Night');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (2, -2147483636, 'Morning');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (1, -2147483635, 'Night');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (2, -2147483638, 'Morning');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (1, -2147483634, 'Night');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (2, -2147483635, 'Morning');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (1, -2147483633, 'Night');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (2, -2147483643, 'Morning');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (3, -2147483646, 'Night');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (1, -2147483632, 'Morning');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (1, -2147483631, 'Night');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (1, -2147483630, 'Night');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (1, -2147483629, 'Morning');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (1, -2147483628, 'Night');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (1, -2147483627, 'Night');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (1, -2147483642, 'Morning');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (1, -2147483626, 'Night');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (1, -2147483625, 'Night');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (1, -2147483624, 'Morning');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (1, -2147483623, 'Night');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (1, -2147483636, 'Morning');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (1, -2147483622, 'Morning');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (1, -2147483621, 'Night');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (1, -2147483620, 'Morning');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (1, -2147483619, 'Morning');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (1, -2147483618, 'Night');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (1, -2147483617, 'Morning');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (1, -2147483616, 'Morning');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (1, -2147483615, 'Night');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (1, -2147483614, 'Morning');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (1, -2147483613, 'Morning');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (1, -2147483638, 'Night');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (1, -2147483612, 'Night');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (1, -2147483611, 'Morning');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (1, -2147483610, 't2__f970ac');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (1, -2147483609, 'Morning');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (1, -2147483608, 'Night');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (1, -2147483607, 't2__9452fd');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (1, -2147483606, '2o20pj6');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (1, -2147483605, 'wq51oa');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (1, -2147483604, 'Night');

INSERT INTO "broadcast" ("channel_id", "program_id", "time_of_day") VALUES (1, -2147483603, 'Morning');
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
('t1__99aca4',)
*/