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
INSERT INTO "alignment" ("id", "alignment") VALUES (1323, 'religious');
INSERT INTO "alignment" ("id", "alignment") VALUES (1343, 'few');
INSERT INTO "colour" ("id", "colour") VALUES (1324, 'debate');
INSERT INTO "colour" ("id", "colour") VALUES (1344, 'develop');
INSERT INTO "colour" ("id", "colour") VALUES (1330, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1331, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1350, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1351, NULL);
INSERT INTO "gender" ("id", "gender") VALUES (1325, 'himself');
INSERT INTO "gender" ("id", "gender") VALUES (1345, 'law');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1326, 'Travis Mccall');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1346, 'Lisa Morris');
INSERT INTO "race" ("id", "race") VALUES (1327, 'price');
INSERT INTO "race" ("id", "race") VALUES (1347, 'letter');
INSERT INTO "superpower" ("id", "power_name") VALUES (1328, 'Super Strength');
INSERT INTO "superpower" ("id", "power_name") VALUES (1348, 'Super Strength');
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1329, 'Ryan Cortez', 'Eric Ortiz', 1325, 1324, 1330, 1331, 1327, 1326, 1323, 201, 1332);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1349, 'Daniel Kennedy', 'Rebecca Jackson', 1345, 1344, 1350, 1351, 1347, 1346, 1343, 201, 1352);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1329, 1328);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1329, 1328);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1349, 1348);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.id) FROM superhero AS T1 INNER JOIN hero_power AS T2 ON T1.id = T2.hero_id INNER JOIN superpower AS T3 ON T2.power_id = T3.id WHERE T3.power_name = 'Super Strength' AND T1.height_cm > 200;

/*
Gold Result:
(3,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT superhero.id) AS number_of_superheroes FROM superhero JOIN hero_power ON superhero.id = hero_power.hero_id JOIN superpower ON hero_power.power_id = superpower.id WHERE superpower.power_name = 'Super Strength' AND superhero.height_cm > 200;

/*
Prediction Result:
(2,)
*/