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
INSERT INTO "alignment" ("id", "alignment") VALUES (26, NULL);
INSERT INTO "alignment" ("id", "alignment") VALUES (35, NULL);
INSERT INTO "attribute" ("id", "attribute_name") VALUES (43, 'Neutral44');
INSERT INTO "colour" ("id", "colour") VALUES (27, 'Neutral44');
INSERT INTO "colour" ("id", "colour") VALUES (41, 'Neutral44');
INSERT INTO "gender" ("id", "gender") VALUES (29, 'Neutral44');
INSERT INTO "gender" ("id", "gender") VALUES (28, 'Neutral44');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (31, 'Neutral44');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (30, 'Neutral44');
INSERT INTO "race" ("id", "race") VALUES (33, 'Neutral44');
INSERT INTO "race" ("id", "race") VALUES (32, 'Neutral44');
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (34, 26, 27, 28, 41, NULL, NULL, 27, 'Neutral44', 'Neutral44', 44, 44);
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (44, 35, NULL, NULL, NULL, NULL, NULL, 41, 'Neutral51', NULL, NULL, NULL);
INSERT INTO "hero_attribute" ("attribute_id", "hero_id", "attribute_value") VALUES (NULL, 44, -253);
INSERT INTO "hero_attribute" ("attribute_id", "hero_id", "attribute_value") VALUES (43, 44, 1891);
INSERT INTO "superpower" ("id", "power_name") VALUES (46, 'Neutral44');
INSERT INTO "superpower" ("id", "power_name") VALUES (45, 'Neutral44');
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (44, 45);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(T1.attribute_value) FROM hero_attribute AS T1 INNER JOIN superhero AS T2 ON T1.hero_id = T2.id INNER JOIN alignment AS T3 ON T2.alignment_id = T3.id WHERE T3.alignment = 'Neutral';

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT AVG(attribute_value) FROM hero_attribute WHERE hero_id IN (SELECT id FROM superhero WHERE alignment_id = (SELECT id FROM alignment WHERE alignment = 'Neutral'));

/*
Prediction Result:
(None,)
*/