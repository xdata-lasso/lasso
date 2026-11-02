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
INSERT INTO "alignment" ("id", "alignment") VALUES (1441, 'return');
INSERT INTO "colour" ("id", "colour") VALUES (1442, 'plan');
INSERT INTO "colour" ("id", "colour") VALUES (1448, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1449, NULL);
INSERT INTO "gender" ("id", "gender") VALUES (1443, 'Male');
INSERT INTO "gender" ("id", "gender") VALUES (1453, 'Male');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1444, 'Rebecca Knight');
INSERT INTO "race" ("id", "race") VALUES (1445, 'analysis');
INSERT INTO "superpower" ("id", "power_name") VALUES (1446, 'Jeffrey Wood');
INSERT INTO "superpower" ("id", "power_name") VALUES (1454, 'Jeffrey Wood');
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1447, 'Gloria Atkinson', 'Ashley Yu', 1443, 1442, 1448, 1449, 1445, 1444, 1441, 1450, 1451);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1452, 'Gloria Atkinson', 'Ashley Yu', 1453, 1442, 1448, 1449, 1445, 1444, 1441, 1450, 1451);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1447, 1446);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1452, 1454);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.power_name FROM superhero AS T1 INNER JOIN hero_power AS T2 ON T1.id = T2.hero_id INNER JOIN superpower AS T3 ON T3.id = T2.power_id INNER JOIN gender AS T4 ON T4.id = T1.gender_id WHERE T4.gender = 'Male' LIMIT 5;

/*
Gold Result:
('Jeffrey Wood',)
('Jeffrey Wood',)
*/

-- Prediction Query
SELECT DISTINCT sp.power_name FROM superhero AS sh JOIN gender AS g ON sh.gender_id = g.id JOIN hero_power AS hp ON sh.id = hp.hero_id JOIN superpower AS sp ON hp.power_id = sp.id WHERE g.gender = 'Male' LIMIT 5;

/*
Prediction Result:
('Jeffrey Wood',)
*/