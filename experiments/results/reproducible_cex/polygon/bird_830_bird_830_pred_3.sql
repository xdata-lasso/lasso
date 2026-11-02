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
INSERT INTO "alignment" ("id", "alignment") VALUES (35, 'Black Panther39');
INSERT INTO "alignment" ("id", "alignment") VALUES (27, 'Black Panther39');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (53, NULL);
INSERT INTO "attribute" ("id", "attribute_name") VALUES (28, 'Black Panther39');
INSERT INTO "colour" ("id", "colour") VALUES (29, 'Black Panther39');
INSERT INTO "colour" ("id", "colour") VALUES (39, 'Black Panther39');
INSERT INTO "gender" ("id", "gender") VALUES (30, 'Black Panther39');
INSERT INTO "gender" ("id", "gender") VALUES (36, 'Black Panther39');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (37, 'Black Panther39');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (31, 'Black Panther39');
INSERT INTO "race" ("id", "race") VALUES (32, 'Black Panther39');
INSERT INTO "race" ("id", "race") VALUES (38, 'Black Panther39');
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (34, 27, 29, 30, 29, 31, 32, 29, 'Black Panther39', 'Black Panther39', 39, 39);
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (33, 35, 39, 36, 39, 37, 38, 39, 'Black Panther', 'Black Panther46', 47, 48);
INSERT INTO "hero_attribute" ("attribute_id", "hero_id", "attribute_value") VALUES (53, 33, 51);
INSERT INTO "hero_attribute" ("attribute_id", "hero_id", "attribute_value") VALUES (53, 33, 54);
INSERT INTO "superpower" ("id", "power_name") VALUES (41, 'Black Panther39');
INSERT INTO "superpower" ("id", "power_name") VALUES (40, 'Black Panther39');
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (33, 40);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.attribute_name FROM superhero AS T1 INNER JOIN hero_attribute AS T2 ON T1.id = T2.hero_id INNER JOIN attribute AS T3 ON T2.attribute_id = T3.id WHERE T1.superhero_name = 'Black Panther' ORDER BY T2.attribute_value ASC, T1.id NULLS LAST, T2.hero_id NULLS LAST, T2.attribute_id NULLS LAST, T3.id NULLS LAST LIMIT 1;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT DISTINCT T1.attribute_name FROM attribute AS T1 INNER JOIN hero_attribute AS T2 ON T1.id = T2.attribute_id INNER JOIN superhero AS T3 ON T2.hero_id = T3.id WHERE T3.superhero_name = 'Black Panther' ORDER BY T2.attribute_value ASC, T1.attribute_name NULLS LAST LIMIT 1;

/*
Prediction Result:
(None,)
*/