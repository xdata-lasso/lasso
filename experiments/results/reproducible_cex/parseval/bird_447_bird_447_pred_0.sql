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
INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483648, -55602865, 'swwqcgsk', '9n8c4pgu7v', 't1__e8d6e1', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw', 1908028688, 2122220075, 'p6luhvdlttil', 'n', 'rmdp', 'siie', '2025-06-27', -1209887326, -1399556171, 'commander');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483647, -443340271, 'uo4nrqrofqy', '5s5b', 't2__aa8f1f', 2107872094, 882961052, 743312762, -1822992503, -868774469, 'qa1', 2074205376, 274769912, 'oo3o9', 'l7', 'klex14ji', '7zwau2dwyr', '2022-12-09', -1097120355, 244829661, 'commander');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483646, -1362461264, 'l0b4y', 'p5qi2rkf9v', 'code_2', 556727997, 1178000634, 1836127587, -1529584866, 1196308825, 'd21vy9uxj4hw', -2050247126, -736979194, 'h2gn', 'q', 'nqcx5h', 'cprj', '2023-05-30', -792947627, -1898531797, 'commander');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483645, 1784916884, 'ah0f8jsww', 'q7x', 'G', -541746689, 1294666887, -515895469, 1427161052, 564390026, '6nijjai5dh', 1583472758, 1449284300, 'gjd8y', 't1afgog', 'itsj3', 'y', '2024-01-17', -106471771, 1235416111, 'commander');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483644, 1923912467, 'jh3den8c68', '8vacx7', 'A', 1523825314, 2078438287, -47052816, 645287482, 765724008, '7pzo72ctd', 481546706, -1784554553, '2g0v5q8qd', 'jpe1io22785', '7cvtjpt', 'tg6bnou5zi', '2025-03-18', -68044929, -1776877925, 'oa');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483643, -1609653472, 'q5l', 'pim5', 'I', -1125548818, 1497321728, -95808609, -244633520, 418247369, 'jla', 1919033056, -1428186898, 'uttmu2ne5', '78lfvyz7zz', 'be8yvkv42q7', 'x58b4', '2022-09-04', 319284352, 1164790775, 'commander');

-- Inserting into table: set_translations --
INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483648, 'a9000t5c4eci', 't1__e8d6e1', 'gce376nium52');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (2, '9fjgq8n2f', 't2__aa8f1f', 'dqv0gcb9');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (3, 'ozk3zbily', 't2__aa8f1f', 'kn6vc');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483645, 'cd07z2zezjo7', 'A', 'wgxd5ysxcm');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483644, '0oztd', 'A', 'j5');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483643, 'auvmkrpd', 'A', 'wzw');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483642, 'chn9mo70', 't1__e8d6e1', 'a9n0jxfo');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483641, 'ws', 't1__e8d6e1', 'do2zobb');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (4, '5k5swwqcgs', 't1__e8d6e1', '9n8');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (5, '4', 't1__e8d6e1', 'gu7v');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (6, 'e4', 't1__e8d6e1', 'hria2ypuzhs');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (7, 'rwbbp6luhvd', 't1__e8d6e1', 'tti');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (8, 'bnp', 't1__e8d6e1', 'mdpos');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (9, 'ie5', 't1__e8d6e1', 'nw6klf');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (10, 'a9000t5c4eci', 't1__e8d6e1', 'gce376nium52');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (11, 'zbuo4nrqrof', 't1__e8d6e1', 'qyp5s5bbp0');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (12, '2eutliqa11r', 't1__e8d6e1', 'ytoo3o9');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.setCode FROM sets AS T1 INNER JOIN set_translations AS T2 ON T2.setCode = T1.code WHERE T1.type = 'commander';

/*
Gold Result:
('t1__e8d6e1',)
('t1__e8d6e1',)
('t1__e8d6e1',)
('t2__aa8f1f',)
('t2__aa8f1f',)
('t1__e8d6e1',)
('t1__e8d6e1',)
('t1__e8d6e1',)
('t1__e8d6e1',)
('t1__e8d6e1',)
('t1__e8d6e1',)
('t1__e8d6e1',)
('t1__e8d6e1',)
('t1__e8d6e1',)
*/

-- Prediction Query
SELECT code FROM sets WHERE type = 'expansion';

/*
Prediction Result:
*/