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
-- Inserting into table: colour --
INSERT INTO "colour" ("id", "colour") VALUES (1, 'Gold');

INSERT INTO "colour" ("id", "colour") VALUES (2, 'c2__bd3b83');

INSERT INTO "colour" ("id", "colour") VALUES (3, 'dpos');

INSERT INTO "colour" ("id", "colour") VALUES (4, 'Gold');

INSERT INTO "colour" ("id", "colour") VALUES (5, 'zbuo4nrq');

INSERT INTO "colour" ("id", "colour") VALUES (6, '4ji7zwa');

INSERT INTO "colour" ("id", "colour") VALUES (7, 'msorlwyngc');

INSERT INTO "colour" ("id", "colour") VALUES (8, 'Gold');

INSERT INTO "colour" ("id", "colour") VALUES (-2147483640, 'col_2bb4be');

INSERT INTO "colour" ("id", "colour") VALUES (-2147483639, 'col_2bb4be');

INSERT INTO "colour" ("id", "colour") VALUES (-2147483638, 'col_2bb4be');

INSERT INTO "colour" ("id", "colour") VALUES (-2147483637, 'col_2bb4be');

INSERT INTO "colour" ("id", "colour") VALUES (-2147483636, 'col_2bb4be');

INSERT INTO "colour" ("id", "colour") VALUES (-2147483635, 'col_2bb4be');

INSERT INTO "colour" ("id", "colour") VALUES (-2147483634, 'col_2bb4be');

INSERT INTO "colour" ("id", "colour") VALUES (-2147483633, 'col_2bb4be');

INSERT INTO "colour" ("id", "colour") VALUES (-2147483632, 'col_2bb4be');

INSERT INTO "colour" ("id", "colour") VALUES (-2147483631, 'col_2bb4be');

INSERT INTO "colour" ("id", "colour") VALUES (-2147483630, 'col_2bb4be');

INSERT INTO "colour" ("id", "colour") VALUES (-2147483629, 'col_2bb4be');

INSERT INTO "colour" ("id", "colour") VALUES (-2147483628, 'col_2bb4be');

INSERT INTO "colour" ("id", "colour") VALUES (-2147483627, 'col_2bb4be');

INSERT INTO "colour" ("id", "colour") VALUES (-2147483626, 'col_2bb4be');

INSERT INTO "colour" ("id", "colour") VALUES (-2147483625, 'col_2bb4be');

-- Inserting into table: superhero --
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483648, 'rwbbp6luhvd', 'tti', -2147483648, 2, 1, 1, -2147483648, -2147483648, -2147483648, -1364429300, -1257178728);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483647, 'nw6klf', 'a9000t5c4eci', -2147483648, 3, 1, 1, -2147483648, -2147483648, -2147483648, 1149850321, -1833165707);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483646, 'rofqyp5s5b', 'p', -2147483648, 2, 3, 5, -2147483648, -2147483648, -2147483648, 882961052, 743312762);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483645, 'a11ry', 'ytoo3o9hl7', -2147483648, 3, 3, 3, -2147483648, -2147483648, -2147483648, 1178636309, -1390245819);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483644, 'yrq13p', 'u78d99r', -2147483648, 6, 6, 1, -2147483648, -2147483648, -2147483648, -1362461264, -904834265);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483643, 'qi2rkf9v', 'x58pz', -2147483648, 3, 4, 1, -2147483648, -2147483648, -2147483648, -1529584866, 1196308825);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483642, '9uxj4hwbdvl', 'h2gn', -2147483648, 2, 4, 5, -2147483648, -2147483648, -2147483648, 1968874827, -664193365);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483641, 'hncprjtu0dz', '9fjgq8n2f', -2147483648, 3, 6, 3, -2147483648, -2147483648, -2147483648, -1056308489, -1454058168);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483640, 'kn6vc', '6ah', -2147483648, 6, 2, 1, -2147483648, -2147483648, -2147483648, -348113485, 138842628);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483639, 'xb72fxa7r', 'fdrz16n', -2147483648, 3, 3, 1, -2147483648, -2147483648, -2147483648, -1496556994, -2115841792);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483638, 'grgj', '8', -2147483648, 2, 6, 5, -2147483648, -2147483648, -2147483648, -458359144, 600440952);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483637, 'itsj3', 'y', -2147483648, 3, 1, 3, -2147483648, -2147483648, -2147483648, -598313376, 1972233925);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483636, 'jh3den8c68', '8vacx7', -2147483648, 6, 4, 1, -2147483648, -2147483648, -2147483648, 1523825314, 2078438287);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483635, 'f77pzo72ctd', 't', -2147483648, 3, 3, 1, -2147483648, -2147483648, -2147483648, -1284905200, 7929158);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2, 'qdjpe1io2', '78507cvt', -2147483648, 2, 3, 1, -2147483648, -2147483648, -2147483648, -1523347137, 1582582341);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (3, 'u5zi', '6c4bfkfo', -2147483648, 3, 5, 1, -2147483648, -2147483648, -2147483648, -1950324754, 2115816682);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483632, 'la3', 'okv8uttmu2', -2147483648, 2, 2, 1, -2147483648, -2147483648, -2147483648, -1252009958, 1908593332);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483631, 'zzbe8yvkv', '42q7sx58b4', -2147483648, 3, 6, 1, -2147483648, -2147483648, -2147483648, -1122409769, 1849819405);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483630, 'mkrpdj', 'wzw5chn9mo70', -2147483648, 2, 4, 1, -2147483648, -2147483648, -2147483648, 628082526, -1245584612);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483629, 'szdo2z', 'obb0q0k32o', -2147483648, 3, 1, 1, -2147483648, -2147483648, -2147483648, -1898678660, 440115543);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483628, 'iz', 'k1', -2147483648, 1, 3, 1, -2147483648, -2147483648, -2147483648, 955267863, -1156828895);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (4, 't', 'fuqyxuzkb', -2147483648, 7, 3, 8, -2147483648, -2147483648, -2147483648, -30041412, -277407746);

-- Inserting into table: alignment --
INSERT INTO "alignment" ("id", "alignment") VALUES (-2147483648, '5k5swwqcgs');

-- Inserting into table: gender --
INSERT INTO "gender" ("id", "gender") VALUES (-2147483648, '9n8');

-- Inserting into table: publisher --
INSERT INTO "publisher" ("id", "publisher_name") VALUES (-2147483648, 'pgu7vfe4');

-- Inserting into table: race --
INSERT INTO "race" ("id", "race") VALUES (-2147483648, 'hria2ypuzhs');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.colour FROM superhero AS T1 INNER JOIN colour AS T2 ON T1.eye_colour_id = T2.id INNER JOIN colour AS T3 ON T1.skin_colour_id = T3.id WHERE T3.colour = 'Gold';

/*
Gold Result:
('c2__bd3b83',)
('dpos',)
('4ji7zwa',)
('dpos',)
('4ji7zwa',)
('dpos',)
('4ji7zwa',)
('dpos',)
('c2__bd3b83',)
('dpos',)
('c2__bd3b83',)
('dpos',)
('Gold',)
('c2__bd3b83',)
('dpos',)
('msorlwyngc',)
*/

-- Prediction Query
SELECT DISTINCT c2.colour FROM superhero INNER JOIN colour AS c1 ON superhero.skin_colour_id = c1.id INNER JOIN colour AS c2 ON superhero.eye_colour_id = c2.id WHERE c1.colour = 'Gold';

/*
Prediction Result:
('c2__bd3b83',)
('dpos',)
('4ji7zwa',)
('Gold',)
('msorlwyngc',)
*/