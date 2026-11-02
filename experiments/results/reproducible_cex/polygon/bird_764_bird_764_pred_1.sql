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
INSERT INTO "alignment" ("id", "alignment") VALUES (21, '38');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (23, '38');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (22, '38');
INSERT INTO "colour" ("id", "colour") VALUES (25, '38');
INSERT INTO "colour" ("id", "colour") VALUES (24, '38');
INSERT INTO "gender" ("id", "gender") VALUES (27, '38');
INSERT INTO "gender" ("id", "gender") VALUES (26, '38');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (29, '38');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (28, '38');
INSERT INTO "race" ("id", "race") VALUES (31, '38');
INSERT INTO "race" ("id", "race") VALUES (30, '38');
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (1, 21, 24, 26, 24, 29, NULL, NULL, '38', '38', 38, 38);
INSERT INTO "superpower" ("id", "power_name") VALUES (33, '38');
INSERT INTO "superpower" ("id", "power_name") VALUES (38, NULL);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 38);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1, 38);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T2.power_name FROM hero_power AS T1 INNER JOIN superpower AS T2 ON T1.power_id = T2.id WHERE T1.hero_id = 1;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT sp.power_name FROM hero_power AS hp JOIN superpower AS sp ON hp.power_id = sp.id WHERE hp.hero_id = 1;

/*
Prediction Result:
(None,)
(None,)
*/