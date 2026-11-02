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
INSERT INTO "alignment" ("id", "alignment") VALUES (45, 'Male31');
INSERT INTO "alignment" ("id", "alignment") VALUES (53, 'Male31');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (30, 'Male31');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (29, 'Male31');
INSERT INTO "colour" ("id", "colour") VALUES (31, 'Blue');
INSERT INTO "colour" ("id", "colour") VALUES (55, 'Male31');
INSERT INTO "gender" ("id", "gender") VALUES (32, 'Male31');
INSERT INTO "gender" ("id", "gender") VALUES (60, 'Male');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (47, 'Male31');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (54, 'Male31');
INSERT INTO "race" ("id", "race") VALUES (34, NULL);
INSERT INTO "race" ("id", "race") VALUES (33, 'Male31');
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (46, 45, 31, 60, 31, 47, 34, 31, 'Blue48', 'Male49', 50, 51);
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (52, 53, 55, 60, 31, 54, 34, 55, 'Blue56', 'Male57', 58, 59);
INSERT INTO "hero_attribute" ("attribute_id", "hero_id", "attribute_value") VALUES (29, 52, 31);
INSERT INTO "hero_attribute" ("attribute_id", "hero_id", "attribute_value") VALUES (29, 52, 31);
INSERT INTO "superpower" ("id", "power_name") VALUES (35, 'Male31');
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (52, 35);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (52, 35);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.race FROM superhero AS T1 INNER JOIN colour AS T2 ON T1.hair_colour_id = T2.id INNER JOIN race AS T3 ON T1.race_id = T3.id INNER JOIN gender AS T4 ON T1.gender_id = T4.id WHERE T2.colour = 'Blue' AND T4.gender = 'Male';

/*
Gold Result:
(None,)
(None,)
*/

-- Prediction Query
SELECT DISTINCT race.race FROM superhero INNER JOIN gender ON superhero.gender_id = gender.id INNER JOIN colour ON superhero.hair_colour_id = colour.id INNER JOIN race ON superhero.race_id = race.id WHERE gender.gender = 'Male' AND colour.colour = 'Blue';

/*
Prediction Result:
(None,)
*/