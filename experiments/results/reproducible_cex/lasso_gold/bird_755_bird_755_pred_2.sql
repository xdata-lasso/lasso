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
INSERT INTO "alignment" ("id", "alignment") VALUES (1001, 'purpose');
INSERT INTO "alignment" ("id", "alignment") VALUES (1002, 'brother');
INSERT INTO "alignment" ("id", "alignment") VALUES (1003, 'ago');
INSERT INTO "alignment" ("id", "alignment") VALUES (1004, 'site');
INSERT INTO "alignment" ("id", "alignment") VALUES (1005, 'face');
INSERT INTO "alignment" ("id", "alignment") VALUES (1006, 'election');
INSERT INTO "alignment" ("id", "alignment") VALUES (1007, 'dog');
INSERT INTO "alignment" ("id", "alignment") VALUES (1008, 'chair');
INSERT INTO "colour" ("id", "colour") VALUES (1009, 'since');
INSERT INTO "colour" ("id", "colour") VALUES (1010, 'blue');
INSERT INTO "colour" ("id", "colour") VALUES (1011, 'require');
INSERT INTO "colour" ("id", "colour") VALUES (1012, 'sit');
INSERT INTO "colour" ("id", "colour") VALUES (1013, 'wait');
INSERT INTO "colour" ("id", "colour") VALUES (1014, 'offer');
INSERT INTO "colour" ("id", "colour") VALUES (1015, 'begin');
INSERT INTO "colour" ("id", "colour") VALUES (1016, 'performance');
INSERT INTO "colour" ("id", "colour") VALUES (1049, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1057, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1062, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1072, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1075, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1087, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1088, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1102, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1101, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1117, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1114, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1132, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1127, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1147, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1140, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1162, NULL);
INSERT INTO "gender" ("id", "gender") VALUES (1017, 'knowledge');
INSERT INTO "gender" ("id", "gender") VALUES (1018, 'almost');
INSERT INTO "gender" ("id", "gender") VALUES (1019, 'all');
INSERT INTO "gender" ("id", "gender") VALUES (1020, 'better');
INSERT INTO "gender" ("id", "gender") VALUES (1021, 'discover');
INSERT INTO "gender" ("id", "gender") VALUES (1022, 'early');
INSERT INTO "gender" ("id", "gender") VALUES (1023, 'mouth');
INSERT INTO "gender" ("id", "gender") VALUES (1024, 'play');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1025, 'Cristian Santos');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1026, 'Connie Lawrence');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1027, 'Abigail Shaffer');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1028, 'Gina Moore');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1029, 'Gabrielle Davis');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1030, 'Ryan Munoz');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1031, 'Monica Herrera');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1032, 'Jamie Arnold');
INSERT INTO "race" ("id", "race") VALUES (1033, 'Demi-God');
INSERT INTO "race" ("id", "race") VALUES (1034, 'Demi-God');
INSERT INTO "race" ("id", "race") VALUES (1035, 'Demi-God');
INSERT INTO "race" ("id", "race") VALUES (1036, 'Demi-God');
INSERT INTO "race" ("id", "race") VALUES (1037, 'Demi-God');
INSERT INTO "race" ("id", "race") VALUES (1038, 'Demi-God');
INSERT INTO "race" ("id", "race") VALUES (1039, 'Demi-God');
INSERT INTO "race" ("id", "race") VALUES (1040, 'Demi-God');
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1041, 'Lisa Hensley', 'Margaret Hawkins DDS', 1017, 1009, 1049, 1057, 1033, 1025, 1001, 1065, 1073);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1042, 'Michele Williams', 'Patty Perez', 1018, 1010, 1062.0, 1072.0, 1034, 1026, 1002, 1088.0, 1098.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1043, 'Dylan Miller', 'Ethan Adams', 1019, 1011, 1075.0, 1087.0, 1035, 1027, 1003, 1111.0, 1123.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1044, 'Brian Ramirez', 'Tommy Walter', 1020, 1012, 1088.0, 1102.0, 1036, 1028, 1004, 1134.0, 1148.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1045, 'Holly Wood', 'Matthew Foster', 1021, 1013, 1101.0, 1117.0, 1037, 1029, 1005, 1157.0, 1173.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1046, 'Derek Zuniga', 'Judy Baker', 1022, 1014, 1114.0, 1132.0, 1038, 1030, 1006, 1180.0, 1198.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1047, 'Lisa Jackson', 'Justin Baker', 1023, 1015, 1127.0, 1147.0, 1039, 1031, 1007, 1203.0, 1223.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1048, 'Carla Gray', 'Stephanie Ross', 1024, 1016, 1140.0, 1162.0, 1040, 1032, 1008, 1226.0, 1248.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.full_name FROM superhero AS T1 INNER JOIN race AS T2 ON T1.race_id = T2.id WHERE T2.race = 'Demi-God';

/*
Gold Result:
('Margaret Hawkins DDS',)
('Patty Perez',)
('Ethan Adams',)
('Tommy Walter',)
('Matthew Foster',)
('Judy Baker',)
('Justin Baker',)
('Stephanie Ross',)
*/

-- Prediction Query
SELECT T2.full_name FROM race AS T1 INNER JOIN superhero AS T2 ON T1.id = T2.race_id WHERE T1.race = 'Demi-God' LIMIT 5;

/*
Prediction Result:
('Margaret Hawkins DDS',)
('Patty Perez',)
('Ethan Adams',)
('Tommy Walter',)
('Matthew Foster',)
*/