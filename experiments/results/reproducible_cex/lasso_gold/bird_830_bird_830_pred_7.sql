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
INSERT INTO "alignment" ("id", "alignment") VALUES (1289, 'hope');
INSERT INTO "alignment" ("id", "alignment") VALUES (1337, 'style');
INSERT INTO "alignment" ("id", "alignment") VALUES (1385, 'ahead');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (1293, 'Michele Carr');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (1341, 'Michele Carr');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (1389, 'Victor Baker');
INSERT INTO "colour" ("id", "colour") VALUES (1297, 'on');
INSERT INTO "colour" ("id", "colour") VALUES (1345, 'cost');
INSERT INTO "colour" ("id", "colour") VALUES (1393, 'section');
INSERT INTO "colour" ("id", "colour") VALUES (1317, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1321, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1365, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1369, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1413, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1417, NULL);
INSERT INTO "gender" ("id", "gender") VALUES (1301, 'point');
INSERT INTO "gender" ("id", "gender") VALUES (1349, 'country');
INSERT INTO "gender" ("id", "gender") VALUES (1397, 'wish');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1305, 'Mark Baker');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1353, 'Jennifer Santiago');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1401, 'Natalie Lambert');
INSERT INTO "race" ("id", "race") VALUES (1309, 'site');
INSERT INTO "race" ("id", "race") VALUES (1357, 'hard');
INSERT INTO "race" ("id", "race") VALUES (1405, 'issue');
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1313, 'Black Panther', 'Adam Jones', 1301, 1297, 1317, 1321, 1309, 1305, 1289, 1325, 1329);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1361, 'Black Panther', 'Courtney Keller', 1349, 1345, 1365, 1369, 1357, 1353, 1337, 1373, 1377);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1409, 'Black Panther', 'Cameron Fisher', 1397, 1393, 1413, 1417, 1405, 1401, 1385, 1421, 1425);
INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1313, 1293, 100);
INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1361, 1341, 10);
INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1409, 1389, 50);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.attribute_name FROM superhero AS T1 INNER JOIN hero_attribute AS T2 ON T1.id = T2.hero_id INNER JOIN attribute AS T3 ON T2.attribute_id = T3.id WHERE T1.superhero_name = 'Black Panther' ORDER BY T2.attribute_value ASC, T1.id NULLS LAST, T2.hero_id NULLS LAST, T2.attribute_id NULLS LAST, T3.id NULLS LAST LIMIT 1;

/*
Gold Result:
('Michele Carr',)
*/

-- Prediction Query
SELECT DISTINCT T1.attribute_name FROM attribute AS T1 INNER JOIN hero_attribute AS T2 ON T1.id = T2.attribute_id INNER JOIN superhero AS T3 ON T2.hero_id = T3.id WHERE T3.superhero_name = 'Black Panther' ORDER BY T2.attribute_value ASC, T1.attribute_name NULLS LAST LIMIT 1;

/*
Prediction Result:
('Victor Baker',)
*/