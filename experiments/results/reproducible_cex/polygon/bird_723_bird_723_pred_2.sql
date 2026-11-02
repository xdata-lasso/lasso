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
INSERT INTO "alignment" ("id", "alignment") VALUES (29, 'Blue51');
INSERT INTO "alignment" ("id", "alignment") VALUES (28, 'Blue51');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (31, 'Blue51');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (30, 'Blue51');
INSERT INTO "colour" ("id", "colour") VALUES (51, 'Blue');
INSERT INTO "gender" ("id", "gender") VALUES (32, 'Blue51');
INSERT INTO "gender" ("id", "gender") VALUES (52, 'Blue51');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (53, 'Blue51');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (33, 'Blue51');
INSERT INTO "race" ("id", "race") VALUES (54, 'Blue51');
INSERT INTO "race" ("id", "race") VALUES (34, 'Blue51');
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (49, NULL, 51, 52, 51, 53, 54, 51, 'Blue55', 'Agility56', 57, 58);
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (35, 29, NULL, 52, 51, 33, 34, 51, 'Blue51', 'Blue51', 51, 51);
INSERT INTO "hero_attribute" ("attribute_id", "hero_id", "attribute_value") VALUES (30, 35, 51);
INSERT INTO "hero_attribute" ("attribute_id", "hero_id", "attribute_value") VALUES (30, 35, 51);
INSERT INTO "superpower" ("id", "power_name") VALUES (36, 'Agility');
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (49, 36);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (49, 36);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.id) FROM superhero AS T1 INNER JOIN hero_power AS T2 ON T1.id = T2.hero_id INNER JOIN superpower AS T3 ON T2.power_id = T3.id INNER JOIN colour AS T4 ON T1.eye_colour_id = T4.id WHERE T3.power_name = 'Agility' AND T4.colour = 'Blue';

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT superhero.id) AS count FROM hero_power INNER JOIN superhero ON hero_power.hero_id = superhero.id INNER JOIN superpower ON hero_power.power_id = superpower.id INNER JOIN colour ON superhero.eye_colour_id = colour.id WHERE superpower.power_name = 'Agility' AND colour.colour = 'Blue';

/*
Prediction Result:
(1,)
*/