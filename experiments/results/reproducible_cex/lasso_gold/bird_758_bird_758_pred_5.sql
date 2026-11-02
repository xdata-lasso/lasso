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
INSERT INTO "alignment" ("id", "alignment") VALUES (1218, 'score');
INSERT INTO "alignment" ("id", "alignment") VALUES (1236, 'land');
INSERT INTO "alignment" ("id", "alignment") VALUES (1227, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1219, 'five');
INSERT INTO "colour" ("id", "colour") VALUES (1237, 'themselves');
INSERT INTO "colour" ("id", "colour") VALUES (1224, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1225, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1233, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1234, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1242, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1243, NULL);
INSERT INTO "gender" ("id", "gender") VALUES (1220, 'population');
INSERT INTO "gender" ("id", "gender") VALUES (1238, 'factor');
INSERT INTO "gender" ("id", "gender") VALUES (1229, NULL);
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1221, 'Dr. Kendra Contreras');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1239, 'Gavin Anderson');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1230, NULL);
INSERT INTO "race" ("id", "race") VALUES (1222, 'Human');
INSERT INTO "race" ("id", "race") VALUES (1240, 'Human');
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1223, 'Tara Garcia', 'Deborah Preston', 1220, 1224, 1219, 1225, 1222, 1221, 1218, 185, 1226);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1232, 'Mark Baker', 'Taylor Mathis Jr.', 1229, 1233, 1219, 1234, 1222, 1230, 1227, 185, 1235);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1241, 'Candice Ramos', 'Kristina Rodriguez', 1238, 1242, 1237, 1243, 1240, 1239, 1236, 185, 1244);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T3.colour FROM superhero AS T1 INNER JOIN race AS T2 ON T1.race_id = T2.id INNER JOIN colour AS T3 ON T1.hair_colour_id = T3.id WHERE T1.height_cm = 185 AND T2.race = 'Human';

/*
Gold Result:
('five',)
('themselves',)
*/

-- Prediction Query
SELECT T1.colour FROM colour AS T1 JOIN superhero AS T2 ON T1.id = T2.hair_colour_id WHERE T2.height_cm = 185 AND T2.race_id = (SELECT id FROM race WHERE race = 'Human');

/*
Prediction Result:
('five',)
('five',)
*/