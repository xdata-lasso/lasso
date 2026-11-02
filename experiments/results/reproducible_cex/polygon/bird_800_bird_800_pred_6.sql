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
INSERT INTO "alignment" ("id", "alignment") VALUES (20, 'Blue23');
INSERT INTO "alignment" ("id", "alignment") VALUES (28, 'Blue23');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (22, 'Blue23');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (21, 'Blue23');
INSERT INTO "colour" ("id", "colour") VALUES (23, NULL);
INSERT INTO "gender" ("id", "gender") VALUES (30, 'Blue23');
INSERT INTO "gender" ("id", "gender") VALUES (24, 'Blue23');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (25, 'Blue23');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (31, 'Blue23');
INSERT INTO "race" ("id", "race") VALUES (32, 'Blue23');
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (27, 28, 23, 30, 23, 31, 32, 23, 'Blue38', 'Blue39', 40, 41);
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (26, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Blue23', 'Blue23', 23, 23);
INSERT INTO "hero_attribute" ("attribute_id", "hero_id", "attribute_value") VALUES (21, 26, 23);
INSERT INTO "hero_attribute" ("attribute_id", "hero_id", "attribute_value") VALUES (21, 26, 23);
INSERT INTO "superpower" ("id", "power_name") VALUES (33, 'Blue23');
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (26, 33);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (26, 33);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(CASE WHEN T2.colour = 'Blue' THEN 1 ELSE NULL END) AS REAL) * 100 / COUNT(T1.id) FROM superhero AS T1 INNER JOIN colour AS T2 ON T1.eye_colour_id = T2.id;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN T1.eye_colour_id = (SELECT id FROM colour WHERE colour = 'Blue') THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(*) FROM superhero AS T1;

/*
Prediction Result:
(0.0,)
*/