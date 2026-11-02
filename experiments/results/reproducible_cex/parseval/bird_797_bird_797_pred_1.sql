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
INSERT INTO "colour" ("id", "colour") VALUES (1, 'Blue');

INSERT INTO "colour" ("id", "colour") VALUES (-2147483647, 'Blue');

INSERT INTO "colour" ("id", "colour") VALUES (2, 'Blue');

INSERT INTO "colour" ("id", "colour") VALUES (4, 'siie');

INSERT INTO "colour" ("id", "colour") VALUES (3, 'Brown');

INSERT INTO "colour" ("id", "colour") VALUES (6, 'Brown');

INSERT INTO "colour" ("id", "colour") VALUES (5, 'Blue');

INSERT INTO "colour" ("id", "colour") VALUES (7, 'Brown');

INSERT INTO "colour" ("id", "colour") VALUES (8, 'Blue');

INSERT INTO "colour" ("id", "colour") VALUES (10, 'Brown');

INSERT INTO "colour" ("id", "colour") VALUES (9, 'Blue');

INSERT INTO "colour" ("id", "colour") VALUES (12, 'Brown');

INSERT INTO "colour" ("id", "colour") VALUES (11, 'Blue');

INSERT INTO "colour" ("id", "colour") VALUES (14, 'Brown');

INSERT INTO "colour" ("id", "colour") VALUES (13, 'Blue');

INSERT INTO "colour" ("id", "colour") VALUES (16, 'Brown');

INSERT INTO "colour" ("id", "colour") VALUES (15, 'Blue');

INSERT INTO "colour" ("id", "colour") VALUES (18, 'Brown');

INSERT INTO "colour" ("id", "colour") VALUES (17, 'Blue');

INSERT INTO "colour" ("id", "colour") VALUES (20, 'Brown');

INSERT INTO "colour" ("id", "colour") VALUES (19, 'Blue');

INSERT INTO "colour" ("id", "colour") VALUES (22, 'Brown');

INSERT INTO "colour" ("id", "colour") VALUES (21, 'Blue');

INSERT INTO "colour" ("id", "colour") VALUES (24, 'Brown');

INSERT INTO "colour" ("id", "colour") VALUES (23, 'Blue');

-- Inserting into table: superhero --
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483648, 't1__9cea18', '4h', -2147483648, 1, 1, 1, -2147483648, -2147483648, -2147483648, -992890117, 1914020640);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2, 't1__9cea18', 'sr', -2147483648, 1, 1, -2147483647, -2147483648, -2147483648, -2147483648, 906324270, 1908028688);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (3, 't1__9cea18', 'dlttil', -2147483648, 1, 1, 1, -2147483648, -2147483648, -2147483648, 429706943, 462974032);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483645, 't1__9cea18', 'klfa9000t', -2147483648, 4, 1, 2, -2147483648, -2147483648, -2147483648, 1408123494, -1964997180);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483644, 't1__9cea18', 'nium52zbu', -2147483648, 1, 4, 3, -2147483648, -2147483648, -2147483648, -1179823637, 1119186446);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483643, 't1__9cea18', 'qyp5s5bbp0', -2147483648, 4, 1, 1, -2147483648, -2147483648, -2147483648, 743312762, -1822992503);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483642, 't1__9cea18', '1ryytoo', -2147483648, 1, 4, 1, -2147483648, -2147483648, -2147483648, 1644911394, -1666765085);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483641, 't1__9cea18', '4ji7zwa', -2147483648, 4, 1, 2, -2147483648, -2147483648, -2147483648, 2123196517, 364869063);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483640, 't1__9cea18', 'u78d99r', -2147483648, 1, 4, -2147483647, -2147483648, -2147483648, -2147483648, -1362461264, -904834265);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483639, 't1__9cea18', 'fjgq8n2f3', -2147483648, 1, 1, 3, -2147483648, -2147483648, -2147483648, 806170397, 513454646);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483638, 't1__9cea18', '8ozk3zbil', -2147483648, 1, 1, 1, -2147483648, -2147483648, -2147483648, 982314585, 638024588);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483637, NULL, 'h0f8jswwlq7x', -2147483648, 1, 1, 3, -2147483648, -2147483648, -2147483648, -541746689, 1294666887);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (4, '16nijja', '5dh', -2147483648, 5, 6, 6, -2147483648, -2147483648, -2147483648, 1583472758, 1449284300);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483635, 'yzt1afgogrit', 'sj3ayxp1q430', -2147483648, 1, 1, 3, -2147483648, -2147483648, -2147483648, 1923912467, 518609210);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (5, 'c68x8vacx', 'afu5w1of7', -2147483648, 8, 7, 4, -2147483648, -2147483648, -2147483648, 76996700, -435350511);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483633, 'mfg62', '0v', -2147483648, 1, 1, 1, -2147483648, -2147483648, -2147483648, 820970595, 1421303999);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (6, 'o22', '8507cvtjp', -2147483648, 9, 10, 5, -2147483648, -2147483648, -2147483648, 1582582341, 453836040);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483631, '5zi36c4bfkfo', 'c', -2147483648, 1, 1, 6, -2147483648, -2147483648, -2147483648, -406331049, -461418236);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (7, 'd5ysxc', 'r0oz', -2147483648, 11, 12, -2147483647, -2147483648, -2147483648, -2147483648, -870767087, -1699185893);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483629, '5lnpim5k58qs', '7p2r94gt', -2147483648, 1, 1, 3, -2147483648, -2147483648, -2147483648, 1273687251, 333302050);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (8, 'a3o', 'v8u', -2147483648, 13, 14, 2, -2147483648, -2147483648, -2147483648, 618058035, 1553368934);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483627, 'yz7zzb', '8y', -2147483648, 1, 1, -2147483647, -2147483648, -2147483648, -2147483648, -705922211, 1043710187);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (9, '58b4pmaus3a', 'vmkrpd', -2147483648, 15, 16, 12, -2147483648, -2147483648, -2147483648, -609553675, 989018473);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483625, 'o705a9n0jxfo', 'ws', -2147483648, 1, 1, 5, -2147483648, -2147483648, -2147483648, 1719800120, -210159774);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (10, '0k32odwcl5a', 'msorlwyngc', -2147483648, 17, 18, 8, -2147483648, -2147483648, -2147483648, -323362455, 453340472);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483623, 'k1', 'yoeyo6l0hdt6', -2147483648, 1, 1, 11, -2147483648, -2147483648, -2147483648, 1435223075, 1617348603);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (11, 'b52', 'gwnlas6', -2147483648, 19, 20, 11, -2147483648, -2147483648, -2147483648, -2076274980, 1731324803);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483621, '5nxih66', 'q2xlyoto', -2147483648, 1, 1, 14, -2147483648, -2147483648, -2147483648, 1774679448, 205676091);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (12, 'aqb0tbind', '39tajz9', -2147483648, 21, 22, 18, -2147483648, -2147483648, -2147483648, -841516418, 152478847);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483619, 'bc3t', 'u', -2147483648, 1, 1, 9, -2147483648, -2147483648, -2147483648, -1943814113, 1514371324);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (13, 'xw1rxe9yfk7', 'k162n', -2147483648, 23, 24, 22, -2147483648, -2147483648, -2147483648, -516345261, -1191116453);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483617, '3', 'rmkio18r', -2147483648, 1, 1, 11, -2147483648, -2147483648, -2147483648, 431832073, 1510892261);

-- Inserting into table: alignment --
INSERT INTO "alignment" ("id", "alignment") VALUES (-2147483648, '5k5swwqcgs');

-- Inserting into table: gender --
INSERT INTO "gender" ("id", "gender") VALUES (-2147483648, '9n8');

-- Inserting into table: publisher --
INSERT INTO "publisher" ("id", "publisher_name") VALUES (-2147483648, '4');

-- Inserting into table: race --
INSERT INTO "race" ("id", "race") VALUES (-2147483648, 'gu7v');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.superhero_name FROM superhero AS T1 INNER JOIN colour AS T2 ON T1.eye_colour_id = T2.id INNER JOIN colour AS T3 ON T1.hair_colour_id = T3.id WHERE T2.colour = 'Blue' AND T3.colour = 'Brown';

/*
Gold Result:
('16nijja',)
('c68x8vacx',)
('o22',)
('d5ysxc',)
('a3o',)
('58b4pmaus3a',)
('0k32odwcl5a',)
('b52',)
('aqb0tbind',)
('xw1rxe9yfk7',)
*/

-- Prediction Query
SELECT superhero_name FROM superhero WHERE eye_colour_id = 7 AND hair_colour_id = 9;

/*
Prediction Result:
*/