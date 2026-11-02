-- Schema DDL
CREATE TABLE "mountain" ("Mountain_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "climber" ("Climber_ID" INTEGER PRIMARY KEY, "Mountain_ID" INTEGER, "Name" TEXT, "Country" TEXT, "Time" TEXT, "Points" REAL, FOREIGN KEY ("Mountain_ID") REFERENCES "mountain" ("Mountain_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: mountain --
INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (-2147483648, '5k5swwqcgs', 171.746906, 557.512061, 'mou_449f1c', 'mou_b7f484');

INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (-2147483647, '8c4pgu7vfe', 483.665643, 818.685402, 'mou_449f1c', 'mou_b7f484');

INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (-2147483646, 'ri', 710.998147, 945.642658, 'mou_449f1c', 'mou_b7f484');

INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (-2147483645, 'ypuzhsrw', 944.247544, 994.117864, 'mou_449f1c', 'mou_b7f484');

INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (-2147483644, 'p6luhvdlttil', 22.535764, 600.048938, 'mou_449f1c', 'mou_b7f484');

INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (-2147483643, 'rmdp', 227.766936, 971.82669, 'mou_449f1c', 'mou_b7f484');

INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (-2147483642, 'ie5', 327.753528, 218.301157, 'mou_449f1c', 'mou_b7f484');

INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (-2147483641, 'klfa9000t', 827.854302, 983.124993, 'mou_449f1c', 'mou_b7f484');

INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (-2147483640, '4', 587.103196, 950.466571, 'mou_449f1c', 'mou_b7f484');

INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (-2147483639, 'i', 734.586266, 767.720387, 'mou_449f1c', NULL);

INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (-2147483638, 'e', 467.07027, 875.837169, 'mou_449f1c', NULL);

INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (-2147483637, 'nium52zbu', 225.300904, 760.580899, 'mou_449f1c', NULL);

INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (-2147483636, 'rqrofqyp5s', 499.570479, 710.141592, NULL, 'mou_b7f484');

INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (-2147483635, 'p', 705.580387, 673.065986, NULL, 'mou_b7f484');

INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (-2147483634, 'eutliqa11r', 997.73177, 881.232072, NULL, 'mou_b7f484');

INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (-2147483633, 'too3o9h', 187.343342, 954.976638, 'mou_449f1c', 'mou_b7f484');

INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (-2147483632, '2klex14ji', 598.409165, 394.443388, 'mou_449f1c', 'mou_b7f484');

INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (-2147483631, 'au2dwyrq13', 998.887019, 375.832821, 'mou_449f1c', 'mou_b7f484');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT country FROM (SELECT country, RANGE, COUNT(*) AS n FROM mountain GROUP BY country, RANGE) WHERE (n <> 1) ORDER BY country;

/*
Gold Result:
(None,)
('mou_b7f484',)
('mou_b7f484',)
*/

-- Prediction Query
SELECT Country FROM mountain GROUP BY Country HAVING COUNT(*) > 1;

/*
Prediction Result:
(None,)
('mou_b7f484',)
*/