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
INSERT INTO "alignment" ("id", "alignment") VALUES (25, 'Speed44');
INSERT INTO "alignment" ("id", "alignment") VALUES (26, 'Speed44');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (44, 'Speed');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (43, 'Speed');
INSERT INTO "colour" ("id", "colour") VALUES (35, 'Speed44');
INSERT INTO "colour" ("id", "colour") VALUES (34, 'Speed44');
INSERT INTO "gender" ("id", "gender") VALUES (28, 'Speed44');
INSERT INTO "gender" ("id", "gender") VALUES (29, 'Speed44');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (30, 'Speed44');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (31, 'Speed44');
INSERT INTO "race" ("id", "race") VALUES (33, 'Speed44');
INSERT INTO "race" ("id", "race") VALUES (32, 'Speed44');
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (24, 25, NULL, 28, 35, 30, 32, 34, NULL, 'Speed48', 49, 50);
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (23, 26, 34, 29, 34, 31, 33, 35, NULL, 'Speed52', 53, 54);
INSERT INTO "hero_attribute" ("attribute_id", "hero_id", "attribute_value") VALUES (43, 24, NULL);
INSERT INTO "hero_attribute" ("attribute_id", "hero_id", "attribute_value") VALUES (44, 23, 100);
INSERT INTO "superpower" ("id", "power_name") VALUES (37, 'Speed44');
INSERT INTO "superpower" ("id", "power_name") VALUES (36, 'Speed44');
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (23, 36);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T3.superhero_name) FROM hero_attribute AS T1 INNER JOIN attribute AS T2 ON T1.attribute_id = T2.id INNER JOIN superhero AS T3 ON T1.hero_id = T3.id WHERE T2.attribute_name = 'Speed' ORDER BY T1.attribute_value DESC, T1.hero_id NULLS LAST, T1.attribute_id NULLS LAST, T2.id NULLS LAST, T3.id NULLS LAST LIMIT 1;

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT COUNT(T1.id) FROM attribute AS T1 INNER JOIN hero_attribute AS T2 ON T1.id = T2.attribute_id WHERE T1.attribute_name = 'Speed' AND T2.attribute_value = 100;

/*
Prediction Result:
(1,)
*/