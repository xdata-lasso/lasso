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
INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483648, -55602865, 'swwqcgsk', '9n8c4pgu7v', 'set_bca419', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw', 1908028688, 2122220075, 'p6luhvdlttil', 'n', 'Eighth Edition', 'rmdp', '2022-07-21', -918961358, -1602639011, 'unw6klfa');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483647, 1419861592, '4ecigce376n', 'um5', 'set_2d5ca0', 742285925, -747753377, 902887186, -967741825, 775304493, 'qyp5s5bbp0', 743312762, -1822992503, 'liqa1', 'ryytoo3', 'Eighth Edition', '9hl7', '2024-12-21', -1438850342, -305670381, 'i7z');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483646, -511185946, '13pyu', '8d99rljsl', 'A', -346339240, 1692174491, -1025564911, -227162283, 2056419640, 'vqx58pz0f', 176555546, -1937207087, 'vy9uxj4', 'wb', 'Eighth Edition', 'v', '2022-01-29', 2103044118, -1642259219, 'nd');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483645, -1056308489, 'gcb98oz', '3zb', '@', -1554531873, 982314585, 638024588, -688098735, 1784916884, 'ah0f8jsww', -1388029300, -566887085, '72fxa7ryfd', 'z16ni', 'Eighth Edition', 'jai', '2025-08-02', 1360271423, 1583472758, 'rg');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483644, -197933860, 'xp1q430', 'jh3den8', 'B', 195720193, 1774087382, 1732258051, -1762140823, 1371234901, '1of77p', -435350511, 1992637800, 'dctmf', '62', 'Eighth Edition', '0v', '2025-07-11', -1021978385, 569007824, 'e1io');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483643, 1798111945, '5zi36c', 'bfkfoacd', 'C', 2115816682, 76987628, -253138337, 641521863, 304189298, 'xd', 1999335832, -526612570, 'cmr0oz', 'dgj5i', 'Eighth Edition', 'lq5lnpim', '2025-06-18', -1125548818, 1497321728, '4gth2mnaj');

-- Inserting into table: set_translations --
INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (2, 'Chinese Simplified', 'set_2d5ca0', 'set_5aac6c');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (3, 'Chinese Simplified', 'set_bca419', 'set_5aac6c');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483646, 'Chinese Simplified', 'set_2d5ca0', 'set_5aac6c');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483645, 'set_4a10d5', 'set_2d5ca0', 'set_5aac6c');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483644, 'Chinese Simplified', 'set_bca419', NULL);

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483643, 'Chinese Simplified', 'set_2d5ca0', 'set_5aac6c');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (4, 'wnqcx', 'A', '5hncprjtu0d');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483641, 'Chinese Simplified', 'set_2d5ca0', '9fjgq8n2f');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (5, 'd8y', '@', 't1afgog');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483639, 'Chinese Simplified', 'A', 'tsj');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (6, '278507cv', 'B', 'jpttg');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483637, 'Chinese Simplified', 'B', 'n');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (7, 'la3', 'C', 'okv8uttmu2');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483635, 'Chinese Simplified', 'set_2d5ca0', '57');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.translation FROM sets AS T1 INNER JOIN set_translations AS T2 ON T2.setCode = T1.code WHERE T1.name = 'Eighth Edition' AND T2.language = 'Chinese Simplified';

/*
Gold Result:
('set_5aac6c',)
(None,)
('set_5aac6c',)
('9fjgq8n2f',)
('tsj',)
('n',)
('57',)
('set_5aac6c',)
('set_5aac6c',)
*/

-- Prediction Query
SELECT translation FROM set_translations WHERE setCode = (SELECT code FROM sets WHERE name = 'Eighth Edition') AND language = 'Chinese Simplified';

/*
Prediction Result:
(None,)
('set_5aac6c',)
*/