-- Schema DDL
CREATE TABLE people (people_id INTEGER PRIMARY KEY, birth_place TEXT, height REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: people --
INSERT INTO "people" ("people_id", "birth_place", "height") VALUES (-2147483648, 'peo_d5645e', 582.588439);

INSERT INTO "people" ("people_id", "birth_place", "height") VALUES (-2147483647, 'peo_d5645e', 582.588439);

INSERT INTO "people" ("people_id", "birth_place", "height") VALUES (-2147483646, 'peo_d5645e', 582.588439);

INSERT INTO "people" ("people_id", "birth_place", "height") VALUES (2, 'peo_d5645e', 680.190136);

INSERT INTO "people" ("people_id", "birth_place", "height") VALUES (3, 'peo_d5645e', 680.190136);

INSERT INTO "people" ("people_id", "birth_place", "height") VALUES (-2147483645, 'peo_d5645e', 680.190136);

INSERT INTO "people" ("people_id", "birth_place", "height") VALUES (-2147483642, 'peo_d5645e', 487.053947);

INSERT INTO "people" ("people_id", "birth_place", "height") VALUES (-2147483641, 'peo_d5645e', 487.053947);

INSERT INTO "people" ("people_id", "birth_place", "height") VALUES (-2147483640, 'peo_d5645e', 487.053947);

INSERT INTO "people" ("people_id", "birth_place", "height") VALUES (-2147483639, NULL, 486.033807);

INSERT INTO "people" ("people_id", "birth_place", "height") VALUES (-2147483638, NULL, 486.033807);

INSERT INTO "people" ("people_id", "birth_place", "height") VALUES (-2147483637, NULL, 486.033807);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT birth_place, COUNT(*) FROM people GROUP BY birth_place, height;

/*
Gold Result:
(None, 3)
('peo_d5645e', 3)
('peo_d5645e', 3)
('peo_d5645e', 3)
*/

-- Prediction Query
SELECT birth_place, COUNT(*) FROM people GROUP BY birth_place;

/*
Prediction Result:
(None, 3)
('peo_d5645e', 9)
*/