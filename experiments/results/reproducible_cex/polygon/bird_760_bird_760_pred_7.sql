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
INSERT INTO "alignment" ("id", "alignment") VALUES (20, 'Marvel Comics33');
INSERT INTO "alignment" ("id", "alignment") VALUES (32, 'Marvel Comics33');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (22, 'Marvel Comics33');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (21, 'Marvel Comics33');
INSERT INTO "colour" ("id", "colour") VALUES (33, 'Marvel Comics33');
INSERT INTO "colour" ("id", "colour") VALUES (36, 'Marvel Comics33');
INSERT INTO "gender" ("id", "gender") VALUES (34, 'Marvel Comics33');
INSERT INTO "gender" ("id", "gender") VALUES (23, 'Marvel Comics33');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (52, NULL);
INSERT INTO "publisher" ("id", "publisher_name") VALUES (40, 'Marvel Comics');
INSERT INTO "race" ("id", "race") VALUES (24, 'Marvel Comics33');
INSERT INTO "race" ("id", "race") VALUES (35, 'Marvel Comics33');
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (31, 32, 33, 34, 33, 40, 35, 36, 'Marvel Comics37', 'Marvel Comics38', 150, 39);
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (41, NULL, NULL, NULL, NULL, 52, NULL, NULL, NULL, 'Marvel Comics49', 150, NULL);
INSERT INTO "hero_attribute" ("attribute_id", "hero_id", "attribute_value") VALUES (21, 41, 33);
INSERT INTO "superpower" ("id", "power_name") VALUES (26, 'Marvel Comics33');
INSERT INTO "superpower" ("id", "power_name") VALUES (25, 'Marvel Comics33');
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (41, 25);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(CASE WHEN T2.publisher_name = 'Marvel Comics' THEN 1 ELSE NULL END) AS REAL) * 100 / COUNT(T1.id) FROM superhero AS T1 INNER JOIN publisher AS T2 ON T1.publisher_id = T2.id WHERE T1.height_cm BETWEEN 150 AND 180;

/*
Gold Result:
(50.0,)
*/

-- Prediction Query
SELECT (COUNT(CASE WHEN T2.publisher_name = 'Marvel Comics' THEN 1 ELSE NULL END) * 100.0 / COUNT(T2.publisher_name)) AS percentage FROM superhero AS T1 INNER JOIN publisher AS T2 ON T1.publisher_id = T2.id WHERE T1.height_cm BETWEEN 150 AND 180;

/*
Prediction Result:
(100.0,)
*/