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
INSERT INTO "alignment" ("id", "alignment") VALUES (34, 'Blue41');
INSERT INTO "alignment" ("id", "alignment") VALUES (59, 'Blue41');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (29, 'Blue41');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (28, 'Blue41');
INSERT INTO "colour" ("id", "colour") VALUES (69, 'Blue');
INSERT INTO "colour" ("id", "colour") VALUES (61, 'Blue41');
INSERT INTO "gender" ("id", "gender") VALUES (35, 'Blue41');
INSERT INTO "gender" ("id", "gender") VALUES (30, 'Blue41');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (62, 'Blue41');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (31, 'Blue41');
INSERT INTO "race" ("id", "race") VALUES (63, 'Blue41');
INSERT INTO "race" ("id", "race") VALUES (32, 'Blue41');
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (41, 59, 69, NULL, 61, 62, 63, NULL, 'Blue65', 'Agility66', 67, NULL);
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (33, 34, 69, 35, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "hero_attribute" ("attribute_id", "hero_id", "attribute_value") VALUES (28, 33, 41);
INSERT INTO "superpower" ("id", "power_name") VALUES (42, 'Agility');
INSERT INTO "superpower" ("id", "power_name") VALUES (40, 'Blue41');
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (41, 42);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (41, 42);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.id) FROM superhero AS T1 INNER JOIN hero_power AS T2 ON T1.id = T2.hero_id INNER JOIN superpower AS T3 ON T2.power_id = T3.id INNER JOIN colour AS T4 ON T1.eye_colour_id = T4.id WHERE T3.power_name = 'Agility' AND T4.colour = 'Blue';

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT superhero.id) AS blueeyed_agility_heroes FROM superhero INNER JOIN colour ON superhero.eye_colour_id = colour.id INNER JOIN hero_power ON superhero.id = hero_power.hero_id INNER JOIN superpower ON hero_power.power_id = superpower.id WHERE colour.colour = 'Blue' AND superpower.power_name = 'Agility';

/*
Prediction Result:
(1,)
*/