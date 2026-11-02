-- Schema DDL
CREATE TABLE "cards" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, artist TEXT, asciiName TEXT, availability TEXT, borderColor TEXT, cardKingdomFoilId TEXT, cardKingdomId TEXT, colorIdentity TEXT, colorIndicator TEXT, colors TEXT, convertedManaCost REAL, duelDeck TEXT, edhrecRank INTEGER, faceConvertedManaCost REAL, faceName TEXT, flavorName TEXT, flavorText TEXT, frameEffects TEXT, frameVersion TEXT, hand TEXT, hasAlternativeDeckLimit INTEGER DEFAULT 0 NOT NULL, hasContentWarning INTEGER DEFAULT 0 NOT NULL, hasFoil INTEGER DEFAULT 0 NOT NULL, hasNonFoil INTEGER DEFAULT 0 NOT NULL, isAlternative INTEGER DEFAULT 0 NOT NULL, isFullArt INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isOversized INTEGER DEFAULT 0 NOT NULL, isPromo INTEGER DEFAULT 0 NOT NULL, isReprint INTEGER DEFAULT 0 NOT NULL, isReserved INTEGER DEFAULT 0 NOT NULL, isStarter INTEGER DEFAULT 0 NOT NULL, isStorySpotlight INTEGER DEFAULT 0 NOT NULL, isTextless INTEGER DEFAULT 0 NOT NULL, isTimeshifted INTEGER DEFAULT 0 NOT NULL, keywords TEXT, layout TEXT, leadershipSkills TEXT, life TEXT, loyalty TEXT, manaCost TEXT, mcmId TEXT, mcmMetaId TEXT, mtgArenaId TEXT, mtgjsonV4Id TEXT, mtgoFoilId TEXT, mtgoId TEXT, multiverseId TEXT, name TEXT, number TEXT, originalReleaseDate TEXT, originalText TEXT, originalType TEXT, otherFaceIds TEXT, power TEXT, printings TEXT, promoTypes TEXT, purchaseUrls TEXT, rarity TEXT, scryfallId TEXT, scryfallIllustrationId TEXT, scryfallOracleId TEXT, setCode TEXT, side TEXT, subtypes TEXT, supertypes TEXT, tcgplayerProductId TEXT, text TEXT, toughness TEXT, type TEXT, types TEXT, uuid TEXT NOT NULL UNIQUE, variations TEXT, watermark TEXT);

CREATE TABLE "foreign_data" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, flavorText TEXT, language TEXT, multiverseid INTEGER, name TEXT, text TEXT, type TEXT, uuid TEXT REFERENCES cards (uuid));

CREATE TABLE "legalities" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, format TEXT, status TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

CREATE TABLE "sets" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, baseSetSize INTEGER, block TEXT, booster TEXT, code TEXT NOT NULL UNIQUE, isFoilOnly INTEGER DEFAULT 0 NOT NULL, isForeignOnly INTEGER DEFAULT 0 NOT NULL, isNonFoilOnly INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isPartialPreview INTEGER DEFAULT 0 NOT NULL, keyruneCode TEXT, mcmId INTEGER, mcmIdExtras INTEGER, mcmName TEXT, mtgoCode TEXT, name TEXT, parentCode TEXT, releaseDate DATE, tcgplayerGroupId INTEGER, totalSetSize INTEGER, type TEXT);

CREATE TABLE "set_translations" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, language TEXT, setCode TEXT REFERENCES sets (code) ON update CASCADE ON delete CASCADE, translation TEXT);

CREATE TABLE "rulings" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, date DATE, text TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: sets --
INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483648, -55602865, 'swwqcgsk', '9n8c4pgu7v', 't1__ad7a7a', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw', 1908028688, 2122220075, 'p6luhvdlttil', 'n', 't1__952564', 'rmdp', '2022-07-21', -918961358, 1, 'e5u');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (2, 1620389964, '00t5c4ecigc', 'e376nium52', 'A', -443340271, 757448742, -1179823637, 1119186446, 781505063, 'rofqyp5s5b', 2107872094, 882961052, '2eutliqa11r', 'ytoo3o9', 't1__952564', 'l7', '2024-12-21', -1438850342, 1, 'x1');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (3, -74849714, '7zw', 'au2dwyrq13', 'C', 2142703426, -533293970, 176380444, -977635379, 1661181156, '0b4', 1649269347, -1116181514, 'i2rkf', 'vqx58pz0f', 't1__952564', '8jegd21vy9ux', '2021-09-16', -87647544, 1, 'bdvlph');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483645, -1898531797, '9fjgq8n2f', 'dqv0gcb9', 'O', 172461907, 1606439408, 1443629118, -155284187, 1686459626, 'lyr', 1038566008, 32204797, 'k', 'ah0f8jsww', 'q7x', '7', '2024-12-09', 1350414441, 2094425101, '7');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483644, 1583472758, 'rg', 'd8y', 'G', 1129658414, 1250290042, -1717646459, -1696173285, 710458518, 'sj3ayxp1q430', 1923912467, 518609210, '3d', 'n8', 'c68x8vacx7', 'f', '2023-07-08', 1371234901, -290314193, 'f77pzo72ctd');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483643, -1284905200, '62', '0v', 't2__cf9777', 820970595, 1421303999, -1488156735, -1858644047, -1180042408, '78507cvt', -1523347137, 1582582341, 'tg6bnou5zi', '6c4bfkfo', 't1__952564', 'c', '2020-09-06', 2115816682, 1, '7z2zezjo7wg');

-- Inserting into table: set_translations --
INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483648, 'Italian', 't1__ad7a7a', 'w6kl');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483647, 'Italian', 'A', 'gndqwnqc');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483646, 'Italian', 'A', 'x5hncprjtu0');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483645, 'Italian', 'O', 'yfdrz');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483644, 'Italian', 'O', '16nijjai5dh');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483643, 'Italian', 'G', 't');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (2, 'Italian', 't2__cf9777', 'd5ysxc');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (3, 'Italian', 't2__cf9777', 'r0oz');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483640, 't2__04c659', 't1__ad7a7a', 'dgj5i');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483639, 'Italian', 't1__ad7a7a', 'lq5lnpim');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483638, 'Italian', 't1__ad7a7a', 'k58qs27p');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (4, NULL, 't1__ad7a7a', '5k5swwqcgs');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (5, 'Italian', 't1__ad7a7a', '5k5swwqcgs');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (6, 'Italian', 't1__ad7a7a', '9n8');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (7, 'Italian', 't1__ad7a7a', '4');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (8, 'Italian', 't1__ad7a7a', 'gu7v');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (9, 'Italian', 't1__ad7a7a', 'e4');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (10, 'Italian', 't1__ad7a7a', 'hria2ypuzhs');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.name, T1.totalSetSize FROM sets AS T1 INNER JOIN set_translations AS T2 ON T1.code = T2.setCode WHERE T2.language = 'Italian';

/*
Gold Result:
('t1__952564', 1)
('t1__952564', 1)
('t1__952564', 1)
('q7x', 2094425101)
('q7x', 2094425101)
('c68x8vacx7', -290314193)
('t1__952564', 1)
('t1__952564', 1)
('t1__952564', 1)
('t1__952564', 1)
('t1__952564', 1)
('t1__952564', 1)
('t1__952564', 1)
('t1__952564', 1)
('t1__952564', 1)
('t1__952564', 1)
*/

-- Prediction Query
SELECT s.code AS setCode, s.totalSetSize FROM set_translations AS st INNER JOIN sets AS s ON st.setCode = s.code WHERE st.language = 'Italian';

/*
Prediction Result:
('t1__ad7a7a', 1)
('A', 1)
('A', 1)
('O', 2094425101)
('O', 2094425101)
('G', -290314193)
('t1__ad7a7a', 1)
('t1__ad7a7a', 1)
('t2__cf9777', 1)
('t2__cf9777', 1)
('t1__ad7a7a', 1)
('t1__ad7a7a', 1)
('t1__ad7a7a', 1)
('t1__ad7a7a', 1)
('t1__ad7a7a', 1)
('t1__ad7a7a', 1)
*/