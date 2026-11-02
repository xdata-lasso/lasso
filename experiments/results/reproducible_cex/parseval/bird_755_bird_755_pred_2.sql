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
INSERT INTO "colour" ("id", "colour") VALUES (-2147483648, '9n8');

-- Inserting into table: superhero --
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483648, 'e4', 't2__ec815a', -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, -2147483648, 1160656988, -992890117);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483647, 'sr', 't2__bd65e4', -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, -2147483648, 906324270, 1908028688);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483646, 'l', 't2__68ab00', -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, -2147483648, -845863578, -1610064545);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483645, 'posiie5unw6k', 't2__20c968', -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, -2147483648, 1151980946, 1620389964);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483644, 'ecigce376n', 't2__e37417', -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, -2147483648, 1313172851, -761141909);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2, 'nrqrofqy', 't2__ec815a', -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, -2147483648, -1106983592, 1884179925);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (3, 'eutliqa11r', 't2__ec815a', -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, -2147483648, 2137741668, -525979501);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483643, '72klex14ji7z', 't2__68ab00', -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, -2147483648, -2081315180, 1909986641);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483640, 'yu78', 't2__20c968', -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, -2147483648, 244829661, -1362461264);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483639, 'p5qi2rkf9v', 't2__e37417', -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, -2147483648, 556727997, 1178000634);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483638, 'vy9uxj4', 't2__ec815a', -2147483648, -2147483648, -2147483648, -2147483648, 12, -2147483648, -2147483648, -1612443122, -2050247126);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483637, 'dqwn', 't2__bd65e4', -2147483648, -2147483648, -2147483648, -2147483648, 12, -2147483648, -2147483648, -1070063173, 555413010);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483636, 'tu0', 't2__68ab00', -2147483648, -2147483648, -2147483648, -2147483648, 12, -2147483648, -2147483648, -1898531797, -1748371085);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483635, 'dqv0gcb98ozk', 't2__20c968', -2147483648, -2147483648, -2147483648, -2147483648, 12, -2147483648, -2147483648, -155284187, 1686459626);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483634, '6vck6ah0f8js', 't2__e37417', -2147483648, -2147483648, -2147483648, -2147483648, 12, -2147483648, -2147483648, -658391922, -1388029300);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483633, '7ryfdrz16n', 't2__ec815a', -2147483648, -2147483648, -2147483648, -2147483648, 12, -2147483648, -2147483648, -1496556994, -2115841792);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483632, 'gjd8y', 't2__bd65e4', -2147483648, -2147483648, -2147483648, -2147483648, 12, -2147483648, -2147483648, 1129658414, 1250290042);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483631, 'sj3ayxp1q430', 't2__68ab00', -2147483648, -2147483648, -2147483648, -2147483648, 12, -2147483648, -2147483648, 1923912467, 518609210);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483630, '68x8vacx7a', 't2__20c968', -2147483648, -2147483648, -2147483648, -2147483648, 12, -2147483648, -2147483648, 2078438287, -47052816);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483629, '72ctdctmfg62', 't2__e37417', -2147483648, -2147483648, -2147483648, -2147483648, 12, -2147483648, -2147483648, -1744557630, 1870300798);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483628, '1i', 't2__ec815a', -2147483648, -2147483648, -2147483648, -2147483648, 12, -2147483648, -2147483648, 1897687032, -241848752);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483627, 'ttg6', 't2__bd65e4', -2147483648, -2147483648, -2147483648, -2147483648, 12, -2147483648, -2147483648, 1467355421, -1171104889);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483626, 'f', 't2__68ab00', -2147483648, -2147483648, -2147483648, -2147483648, 12, -2147483648, -2147483648, -1173368267, 382831862);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483625, 'zjo7wgxd5ysx', 't2__20c968', -2147483648, -2147483648, -2147483648, -2147483648, 12, -2147483648, -2147483648, -2005628382, 1721638020);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483624, '5i3', 't2__e37417', -2147483648, -2147483648, -2147483648, -2147483648, 12, -2147483648, -2147483648, -1405314653, 1816660482);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483623, '58q', 't2__ec815a', -2147483648, -2147483648, -2147483648, -2147483648, 12, -2147483648, -2147483648, 1817366143, 1615073310);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483622, '2m', 't2__bd65e4', -2147483648, -2147483648, -2147483648, -2147483648, 12, -2147483648, -2147483648, 418247369, -1524425594);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483621, 'uttmu2ne5', 't2__68ab00', -2147483648, -2147483648, -2147483648, -2147483648, 12, -2147483648, -2147483648, -1402164108, 2123471885);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483620, 'yvkv42q7s', 't2__20c968', -2147483648, -2147483648, -2147483648, -2147483648, 12, -2147483648, -2147483648, 1735561423, 756202403);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483619, '3auvm', 't2__e37417', -2147483648, -2147483648, -2147483648, -2147483648, 12, -2147483648, -2147483648, 274891948, 609771851);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483618, 'of', 't2__68ab00', -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, -2147483648, -634585028, 1719800120);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483617, '0', 't2__20c968', -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, -2147483648, 375841374, -1449226553);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483616, '5amsorlwyngc', 't2__e37417', -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, -2147483648, -323362455, 453340472);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483615, 'fuqyxuzkb', 't2__68ab00', -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, -2147483648, -30041412, -277407746);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483614, 'lboeowii1z5', 't2__20c968', -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, -2147483648, 1557188093, 548968280);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483613, 'lyotow9oaaw', 't2__e37417', -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, -2147483648, -1048779857, -381485009);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483612, 'bc3t', 't2__68ab00', -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, -2147483648, 1378873397, 1964331395);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483611, 'vzxw1rxe9y', 't2__20c968', -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, -2147483648, -1046720861, 643589729);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483610, 'o', 't2__e37417', -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, -2147483648, -732999244, 1654100852);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483609, 'tp6ewtqxxn', 't2__68ab00', -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, -2147483648, -1485875026, -2080232972);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483608, '7h33p6', 't2__20c968', -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, -2147483648, -891525031, -1154091048);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483607, 'zys7', 't2__e37417', -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, -2147483648, 1487347213, 1328948152);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483606, 'c', 't2__ec815a', -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, -2147483648, 973811121, 280292620);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483605, 'ygmayq3q', 't2__bd65e4', -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, -2147483648, 1032339628, 608093726);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483604, 'rhm5w', 't2__68ab00', -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, -2147483648, -1369148652, 899787662);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483603, 'dmsqtg', 't2__20c968', -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, -2147483648, -1872934808, -1974774786);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483602, 'cukjq1quik1y', 't2__e37417', -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, -2147483648, 775289854, -2052350430);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483601, 'qomiztvb6m', NULL, -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, -2147483648, -74691962, -2128972904);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483600, '8', NULL, -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, -2147483648, 1183069552, -1057355067);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483599, 'wsj8kj', NULL, -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, -2147483648, -55270062, -1101814296);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483598, 'z0kaq', NULL, -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, -2147483648, 1388796595, -881085433);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483597, 'b', NULL, -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, -2147483648, -1924635316, 313797011);

-- Inserting into table: alignment --
INSERT INTO "alignment" ("id", "alignment") VALUES (-2147483648, '5k5swwqcgs');

-- Inserting into table: gender --
INSERT INTO "gender" ("id", "gender") VALUES (-2147483648, '4');

-- Inserting into table: publisher --
INSERT INTO "publisher" ("id", "publisher_name") VALUES (-2147483648, 'u7');

-- Inserting into table: race --
INSERT INTO "race" ("id", "race") VALUES (1, 'Demi-God');

INSERT INTO "race" ("id", "race") VALUES (-2147483647, 'Demi-God');

INSERT INTO "race" ("id", "race") VALUES (7, 'Demi-God');

INSERT INTO "race" ("id", "race") VALUES (8, 'Demi-God');

INSERT INTO "race" ("id", "race") VALUES (9, 'Demi-God');

INSERT INTO "race" ("id", "race") VALUES (10, 'Demi-God');

INSERT INTO "race" ("id", "race") VALUES (11, 'Demi-God');

INSERT INTO "race" ("id", "race") VALUES (12, 'gd');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.full_name FROM superhero AS T1 INNER JOIN race AS T2 ON T1.race_id = T2.id WHERE T2.race = 'Demi-God';

/*
Gold Result:
('t2__ec815a',)
('t2__bd65e4',)
('t2__68ab00',)
('t2__20c968',)
('t2__e37417',)
('t2__68ab00',)
('t2__20c968',)
('t2__e37417',)
('t2__68ab00',)
('t2__20c968',)
('t2__e37417',)
('t2__68ab00',)
('t2__20c968',)
('t2__e37417',)
('t2__68ab00',)
('t2__20c968',)
('t2__e37417',)
('t2__68ab00',)
('t2__20c968',)
('t2__e37417',)
('t2__ec815a',)
('t2__bd65e4',)
('t2__68ab00',)
('t2__20c968',)
('t2__e37417',)
(None,)
(None,)
(None,)
(None,)
(None,)
('t2__ec815a',)
('t2__ec815a',)
*/

-- Prediction Query
SELECT T2.full_name FROM race AS T1 INNER JOIN superhero AS T2 ON T1.id = T2.race_id WHERE T1.race = 'Demi-God' LIMIT 5;

/*
Prediction Result:
('t2__ec815a',)
('t2__bd65e4',)
('t2__68ab00',)
('t2__20c968',)
('t2__e37417',)
*/