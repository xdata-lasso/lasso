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
INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483648, -55602865, 'swwqcgsk', '9n8c4pgu7v', 'ARC', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw', 1908028688, 2122220075, 'Archenemy', 'p6luhvdlttil', 'n', 'rmdp', '2022-07-21', -918961358, -1602639011, 'unw6klfa');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483647, -1683203397, 'e376nium52', 'zbuo4nrqrof', 'code_2', 373262291, -472966518, -921187550, -2070843029, 328305758, 'tliqa1', 2074205376, 274769912, 'Archenemy', 'oo3o9', 'l7', 'klex14ji', '2025-11-18', -453362185, 481163439, '2dwyrq');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483646, 1649269347, 'p5qi2rkf9v', 'x58pz', 'O', -1529584866, 1196308825, 910894705, -283454505, 233994589, 'j4hwbd', -736979194, 2103044118, 'Archenemy', 'h2gndqwnqcx5', 'hncprjtu0dz', '9fjgq8n2f', '2025-02-11', 806170397, 513454646, '0gcb98');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483645, 1686459626, 'lyr', 'kn6vck6ah0f8', 'G', -1520489792, -658391922, -1388029300, -566887085, 602161869, 'xa', 1294666887, -515895469, 'Archenemy', 'r', 'z16nijjai5d', 'h5ogrgjd8yz', '2023-06-17', 600440952, 1568069663, 'fgogritsj3ay');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483644, 1523825314, 'u5', '1of77p', 't1__098d63', -435350511, 1992637800, -820614248, 481546706, -1784554553, '2g0v5q8qd', 569007824, -1139855872, 'Archenemy', 'io22785', '7cvtjpt', 'tg6bnou5zi', '2025-03-18', -68044929, -1776877925, 'oa');

-- Inserting into table: set_translations --
INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483648, 't2__43b6af', 'ARC', '9000t5c4ec');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (2, 't2__43b6af', 'ARC', '3pyu78d');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (3, 't2__43b6af', 'ARC', '9rljsl0b4');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483645, 't2__43b6af', 'ARC', 'zk3z');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483644, 't2__43b6af', 'ARC', 'p1q430');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483643, 't2__43b6af', 'ARC', 'jh3den8');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483642, 't2__43b6af', 'ARC', 'c68x8vacx7');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483641, 't2__43b6af', 't1__098d63', 'cd07z2zezjo7');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483640, NULL, 'ARC', 'wgxd5ysxcm');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (4, '5k5swwqcgsk9', 't1__098d63', '8c4p');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (5, 'u7vfe4hria2y', 'ARC', 'uzhs');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (6, 'wbbp6luhvdlt', 'O', 'ilbnp');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (7, 'dpos', 'O', 'ie5');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (8, 'w6kl', 'O', 'a9');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (9, '00t5c4ecigc', 'G', 'e376nium52');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (10, 'u', 'G', '4nrq');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (11, 'ofqyp', 't1__098d63', 's5bbp02e');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (12, 'liqa1', 'O', 'ryytoo3');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.language FROM sets AS T1 INNER JOIN set_translations AS T2 ON T1.code = T2.setCode WHERE T1.mcmName = 'Archenemy' AND T2.setCode = 'ARC';

/*
Gold Result:
('t2__43b6af',)
('t2__43b6af',)
('t2__43b6af',)
('t2__43b6af',)
('t2__43b6af',)
(None,)
('t2__43b6af',)
('t2__43b6af',)
('u7vfe4hria2y',)
*/

-- Prediction Query
SELECT DISTINCT set_translations.language FROM sets INNER JOIN set_translations ON sets.code = set_translations.setcode WHERE sets.mcmname = 'Archenemy' AND set_translations.setcode = 'ARC';

/*
Prediction Result:
('t2__43b6af',)
(None,)
('u7vfe4hria2y',)
*/