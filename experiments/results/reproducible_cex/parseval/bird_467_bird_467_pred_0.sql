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
INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483648, 1, '5k5swwqcgs', '9n8', 't1__f08107', 1610062532, -106629402, 1871297066, 809183447, 89267185, 'e4', 1160656988, -992890117, 'a2ypuzhsrwbb', 'p6luhvdlttil', 'n', 'rmdp', '2022-07-21', -918961358, -1602639011, 'unw6klfa');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (2, 1, 'gce', '76nium52', 'C', -443340271, 757448742, -1179823637, 1119186446, 781505063, 'rofqyp5s5b', 2107872094, 882961052, '2eutliqa11r', 'ytoo3o9', 'l7', 'klex14ji', '2025-11-18', -453362185, 481163439, '2dwyrq');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (3, 1, '3pyu78d', '9rljsl0b4', 'A', 1649269347, -1116181514, 1255852738, -1555456236, -975213201, '9v', 556727997, 1178000634, 'pz0f8jegd', '1vy9uxj4', 'wb', 'v', '2022-01-29', 2103044118, -1642259219, 'nd');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483645, 1, '79fjgq8', 'n2f3dqv0gcb9', '_', 172461907, 1606439408, 1443629118, -155284187, 1686459626, 'lyr', 1038566008, 32204797, 'k', 'ah0f8jsww', 'q7x', '7', '2024-12-09', 1350414441, 2094425101, '7');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483644, 1, '16nijjai5dh', 'ogrgjd8y', 'G', 1129658414, 1250290042, -1717646459, -1696173285, 710458518, 'sj3ayxp1q430', 1923912467, 518609210, '3d', 'n8', 'c68x8vacx7', 'f', '2023-07-08', 1371234901, -290314193, 'f77pzo72ctd');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483643, 1, 'mfg62g0v5q8q', 'j', 'O', -1139855872, -288338724, 1897687032, -241848752, 2004147439, 'tjpttg', -2033879835, 1798111945, '5zi36c', 'bfkfoacd', '7z2zezj', '7wgx', '2020-07-27', 1999335832, -526612570, 'cmr0oz');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483642, 1, 'lq5lnpim', 'k58qs27p', 't2__53f989', 988954859, -1719383707, 1273687251, 333302050, 1162591638, 'ajjla3okv8u', 618058035, 1553368934, 'e578', 'fvy', '7zzbe8y', 'kv42q7', '2023-03-03', 1735561423, 756202403, '8b4pmaus3au');

-- Inserting into table: set_translations --
INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483648, '9000t5c4ec', 't1__f08107', 'Hauptset Zehnte Edition');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483647, 'wnqcx', 'C', 'Hauptset Zehnte Edition');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483646, '5hncprjtu0d', 'C', 'Hauptset Zehnte Edition');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483645, 'yfdrz', 'A', 'Hauptset Zehnte Edition');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483644, 't', 'A', 'Hauptset Zehnte Edition');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483643, 'dgj5i', 'A', 'Hauptset Zehnte Edition');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (2, 'mkrpdj', 't2__53f989', 'Hauptset Zehnte Edition');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (3, 'wzw5chn9mo70', 't2__53f989', 'Hauptset Zehnte Edition');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483640, 'a9n0jxfo', 't1__f08107', 't2__388f74');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483639, 'ws', 't1__f08107', 'Hauptset Zehnte Edition');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (4, '5k5swwqcgs', 't1__f08107', NULL);

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (5, '5k5swwqcgs', 't1__f08107', 'Hauptset Zehnte Edition');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (6, '9n8', 't1__f08107', 'Hauptset Zehnte Edition');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (7, '4', 't1__f08107', 'Hauptset Zehnte Edition');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (8, 'gu7v', 't1__f08107', 'Hauptset Zehnte Edition');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (9, 'e4', 't1__f08107', 'Hauptset Zehnte Edition');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (10, 'hria2ypuzhs', 't1__f08107', 'Hauptset Zehnte Edition');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.baseSetSize FROM sets AS T1 INNER JOIN set_translations AS T2 ON T2.setCode = T1.code WHERE T2.translation = 'Hauptset Zehnte Edition';

/*
Gold Result:
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
*/

-- Prediction Query
SELECT baseSetSize FROM sets WHERE code = (SELECT setCode FROM set_translations WHERE translation = 'Hauptset Zehnte Edition');

/*
Prediction Result:
(1,)
*/