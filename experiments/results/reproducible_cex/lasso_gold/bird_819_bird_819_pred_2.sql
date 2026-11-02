-- Schema DDL
CREATE TABLE alignment (id INTEGER NOT NULL PRIMARY KEY, alignment TEXT DEFAULT NULL);

CREATE TABLE attribute (id INTEGER NOT NULL PRIMARY KEY, attribute_name TEXT DEFAULT NULL);

CREATE TABLE colour (id INTEGER NOT NULL PRIMARY KEY, colour TEXT DEFAULT NULL);

CREATE TABLE gender (id INTEGER NOT NULL PRIMARY KEY, gender TEXT DEFAULT NULL);

CREATE TABLE publisher (id INTEGER NOT NULL PRIMARY KEY, publisher_name TEXT DEFAULT NULL);

CREATE TABLE race (id INTEGER NOT NULL PRIMARY KEY, race TEXT DEFAULT NULL);

CREATE TABLE superhero (id INTEGER NOT NULL PRIMARY KEY, superhero_name TEXT DEFAULT NULL, full_name TEXT DEFAULT NULL, gender_id INTEGER DEFAULT NULL, eye_colour_id INTEGER DEFAULT NULL, hair_colour_id INTEGER DEFAULT NULL, skin_colour_id INTEGER DEFAULT NULL, race_id INTEGER DEFAULT NULL, publisher_id INTEGER DEFAULT NULL, alignment_id INTEGER DEFAULT NULL, height_cm INTEGER DEFAULT NULL, weight_kg INTEGER DEFAULT NULL, FOREIGN KEY (alignment_id) REFERENCES alignment (id), FOREIGN KEY (eye_colour_id) REFERENCES colour (id), FOREIGN KEY (gender_id) REFERENCES gender (id), FOREIGN KEY (hair_colour_id) REFERENCES colour (id), FOREIGN KEY (publisher_id) REFERENCES publisher (id), FOREIGN KEY (race_id) REFERENCES race (id), FOREIGN KEY (skin_colour_id) REFERENCES colour (id));

CREATE TABLE hero_attribute (hero_id INTEGER DEFAULT NULL, attribute_id INTEGER DEFAULT NULL, attribute_value INTEGER DEFAULT NULL, FOREIGN KEY (attribute_id) REFERENCES attribute (id), FOREIGN KEY (hero_id) REFERENCES superhero (id));

CREATE TABLE superpower (id INTEGER NOT NULL PRIMARY KEY, power_name TEXT DEFAULT NULL);

CREATE TABLE hero_power (hero_id INTEGER DEFAULT NULL, power_id INTEGER DEFAULT NULL, FOREIGN KEY (hero_id) REFERENCES superhero (id), FOREIGN KEY (power_id) REFERENCES superpower (id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "alignment" ("id", "alignment") VALUES (1053, 'term');
INSERT INTO "alignment" ("id", "alignment") VALUES (1054, 'almost');
INSERT INTO "colour" ("id", "colour") VALUES (7, 'support');
INSERT INTO "colour" ("id", "colour") VALUES (1, 'four');
INSERT INTO "colour" ("id", "colour") VALUES (1062, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1064, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1075, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1079, NULL);
INSERT INTO "gender" ("id", "gender") VALUES (0, 'institution');
INSERT INTO "gender" ("id", "gender") VALUES (1055, 'executive');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1056, 'Thomas Bradley');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1057, 'Christy Porter');
INSERT INTO "race" ("id", "race") VALUES (1058, 'usually');
INSERT INTO "race" ("id", "race") VALUES (1059, 'who');
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1060, 'Brenda Taylor', 'Kevin Cox', 0, 7, 1062, 1064, 1058, 1056, 1053, 1066, 1052);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1061, 'Kimberly Burgess', 'Brenda Snyder PhD', 0, 1, 1075.0, 1079.0, 1058, 1056, 1053, 1089.0, 1052);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(CASE WHEN T2.id = 7 THEN 1 ELSE 0 END) - SUM(CASE WHEN T2.id = 1 THEN 1 ELSE 0 END) FROM superhero AS T1 INNER JOIN colour AS T2 ON T1.eye_colour_id = T2.id WHERE T1.weight_kg = 0 OR T1.weight_kg IS NULL;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT COUNT(CASE WHEN "colour"."id" = 7 THEN 1 ELSE NULL END) - COUNT(CASE WHEN "colour"."id" = 1 THEN 1 ELSE NULL END) FROM "superhero" INNER JOIN "colour" ON "superhero"."eye_colour_id" = "colour"."id" WHERE "superhero"."weight_kg" = 0 OR "superhero"."weight_kg" IS NULL;

/*
Prediction Result:
(0,)
*/