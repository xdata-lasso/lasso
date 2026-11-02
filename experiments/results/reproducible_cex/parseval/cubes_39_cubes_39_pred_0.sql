-- Schema DDL
CREATE TABLE "i014" ("id" INTEGER, "string" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: i014 --
INSERT INTO "i014" ("id", "string") VALUES (1, '5k5swwqcgs');

INSERT INTO "i014" ("id", "string") VALUES (1, '9n8');

INSERT INTO "i014" ("id", "string") VALUES (1, '4');

INSERT INTO "i014" ("id", "string") VALUES (1, 'gu7v');

INSERT INTO "i014" ("id", "string") VALUES (1, 'e4');

INSERT INTO "i014" ("id", "string") VALUES (1, 'hria2ypuzhs');

INSERT INTO "i014" ("id", "string") VALUES (NULL, 'rwbbp6luhvd');

INSERT INTO "i014" ("id", "string") VALUES (NULL, 'tti');

INSERT INTO "i014" ("id", "string") VALUES (NULL, 'bnp');

INSERT INTO "i014" ("id", "string") VALUES (NULL, 'mdpos');

INSERT INTO "i014" ("id", "string") VALUES (1, 'ie5');

INSERT INTO "i014" ("id", "string") VALUES (1, 'nw6klf');

INSERT INTO "i014" ("id", "string") VALUES (1, 'a9000t5c4eci');

INSERT INTO "i014" ("id", "string") VALUES (1, 'gce376nium52');

INSERT INTO "i014" ("id", "string") VALUES (1, 'zbuo4nrqrof');

INSERT INTO "i014" ("id", "string") VALUES (1, 'qyp5s5bbp0');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "id", "concatstring" FROM (SELECT "id", GROUP_CONCAT("string", ', ') AS concatstring FROM i014 GROUP BY id) ORDER BY id, "id" NULLS LAST, "concatstring" NULLS LAST;

/*
Gold Result:
(None, 'rwbbp6luhvd, tti, bnp, mdpos')
(1, '5k5swwqcgs, 9n8, 4, gu7v, e4, hria2ypuzhs, ie5, nw6klf, a9000t5c4eci, gce376nium52, zbuo4nrqrof, qyp5s5bbp0')
*/

-- Prediction Query
SELECT id, GROUP_CONCAT(string, ' ') FROM i014 GROUP BY id;

/*
Prediction Result:
(None, 'rwbbp6luhvd tti bnp mdpos')
(1, '5k5swwqcgs 9n8 4 gu7v e4 hria2ypuzhs ie5 nw6klf a9000t5c4eci gce376nium52 zbuo4nrqrof qyp5s5bbp0')
*/