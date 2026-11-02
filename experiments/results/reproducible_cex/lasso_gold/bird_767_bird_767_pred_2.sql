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
INSERT INTO "alignment" ("id", "alignment") VALUES (1164, 'arm');
INSERT INTO "colour" ("id", "colour") VALUES (1, 'report');
INSERT INTO "colour" ("id", "colour") VALUES (2, 'ready');
INSERT INTO "colour" ("id", "colour") VALUES (3, 'race');
INSERT INTO "colour" ("id", "colour") VALUES (1173, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1176, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1184, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1189, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1195, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1202, NULL);
INSERT INTO "gender" ("id", "gender") VALUES (1165, 'billion');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1166, 'Nicholas Mcbride');
INSERT INTO "race" ("id", "race") VALUES (1167, 'boy');
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1168, 'Connor West', 'Amber Kidd', 1165, 1173, 1176, 1, 1167, 1166, 1164, 1185, 1188);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1169, 'Donald Wright', 'Tracy House', 1165, 1184.0, 1189.0, 2, 1167, 1166, 1164, 1208.0, 1213.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1170, 'Jessica Callahan', 'Carol Tucker', 1165, 1195.0, 1202.0, 3, 1167, 1166, 1164, 1231.0, 1238.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(*) AS REAL) / SUM(CASE WHEN T2.id = 1 THEN 1 ELSE 0 END) FROM superhero AS T1 INNER JOIN colour AS T2 ON T1.skin_colour_id = T2.id;

/*
Gold Result:
(3.0,)
*/

-- Prediction Query
SELECT COUNT("superhero"."id") * 1.0 / SUM("superhero"."skin_colour_id" = 1) FROM "superhero" WHERE "superhero"."skin_colour_id" = 1;

/*
Prediction Result:
(1.0,)
*/