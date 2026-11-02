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
INSERT INTO "alignment" ("id", "alignment") VALUES (1361, 'partner');
INSERT INTO "alignment" ("id", "alignment") VALUES (1383, 'price');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (1362, 'Strength');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (1384, 'Strength');
INSERT INTO "colour" ("id", "colour") VALUES (1363, 'evidence');
INSERT INTO "colour" ("id", "colour") VALUES (1385, 'former');
INSERT INTO "colour" ("id", "colour") VALUES (1368, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1369, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1390, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1391, NULL);
INSERT INTO "gender" ("id", "gender") VALUES (1364, 'Female');
INSERT INTO "gender" ("id", "gender") VALUES (1386, 'Female');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1365, 'Kyle Reed');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1387, 'Belinda Mccullough');
INSERT INTO "race" ("id", "race") VALUES (1366, 'stop');
INSERT INTO "race" ("id", "race") VALUES (1388, 'movement');
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1367, 'Larry Dixon', 'Kenneth Scott', 1364, 1363, 1368, 1369, 1366, 1365, 1361, 1370, 1371);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1389, 'Jason Powell', 'Cameron Fisher', 1386, 1385, 1390, 1391, 1388, 1387, 1383, 1392, 1393);
INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1367, 1362, 100);
INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1367, 1362, 100);
INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1389, 1384, 100);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.id) FROM superhero AS T1 INNER JOIN hero_attribute AS T2 ON T1.id = T2.hero_id INNER JOIN attribute AS T3 ON T2.attribute_id = T3.id INNER JOIN gender AS T4 ON T1.gender_id = T4.id WHERE T3.attribute_name = 'Strength' AND T2.attribute_value = 100 AND T4.gender = 'Female';

/*
Gold Result:
(3,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT superhero.id) FROM superhero INNER JOIN gender ON superhero.gender_id = gender.id INNER JOIN hero_attribute ON superhero.id = hero_attribute.hero_id INNER JOIN attribute ON hero_attribute.attribute_id = attribute.id WHERE gender.gender = 'Female' AND attribute.attribute_name = 'Strength' AND hero_attribute.attribute_value = 100;

/*
Prediction Result:
(2,)
*/