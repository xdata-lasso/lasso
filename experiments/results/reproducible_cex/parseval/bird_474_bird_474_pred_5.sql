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
INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483648, 99, '5k5swwqcgs', '9n8', 't1__c163fa', 1610062532, -106629402, 1871297066, 809183447, 89267185, 'e4', 1160656988, -992890117, 'a2ypuzhsrwbb', 'p6luhvdlttil', 'n', 'rmdp', '2022-07-21', -918961358, -1602639011, 'unw6klfa');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483647, 99, '9000t5c4ec', 'gce', 'A', -1585009206, -53231346, -443340271, 757448742, -1179823637, 'rqro', 775304493, 373262291, 'p5s5bbp', '02eutliqa11r', 'ytoo3o9', 'l7', '2024-12-21', -1438850342, -305670381, 'i7z');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483646, -2081315180, '2dwyrq13pyu7', 'd99rljsl0', 'O', -2031361952, 1649269347, -1116181514, 1255852738, -1555456236, 'kf9vq', 537874887, -461695645, 'f8jegd21vy9u', 'j4hwbd', 'lph2gn', 'q', '2023-11-15', -1245682094, -1660358170, 'p');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483645, -988981234, 'u0dz7', 'fjgq8n2f3', '_', 806170397, 513454646, -688216274, 331812443, 1382410067, '9', 172461907, 1606439408, '3zb', 'lyr', 'kn6vck6ah0f8', 'sww', '2021-12-25', 1255343543, -541746689, '7ryfdrz16n');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483644, 99, 'jja', '5dh', 't2__a72343', 1583472758, 1449284300, -977470238, -1478247928, 1074760385, 't1afgog', -946046410, -902895762, 'ayxp1q43', '1jh3den', 'c68x8vacx', 'afu5w1of7', '2025-10-22', -1099855564, 87529806, 'ctdctmfg62g0');

-- Inserting into table: set_translations --
INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483648, 'Italian', 't1__c163fa', 't2__dd6d00');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483647, 'Italian', 'O', 't2__dd6d00');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483646, 'Italian', 'O', 't2__dd6d00');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483645, 'Italian', 'O', 't2__dd6d00');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483644, 'Italian', '_', 't2__dd6d00');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (2, 'Italian', 't2__a72343', 't2__dd6d00');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (3, 'Italian', 't2__a72343', 't2__16fe50');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483641, 't2__4e8a00', 't1__c163fa', 't2__dd6d00');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483640, 'Italian', 't1__c163fa', 't2__dd6d00');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483639, 'Italian', 't1__c163fa', NULL);

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483638, 'Italian', 't1__c163fa', 't2__dd6d00');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (4, 'Italian', 't1__c163fa', NULL);

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (5, 'Italian', 't1__c163fa', NULL);

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (6, 'Italian', 't1__c163fa', NULL);

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (7, 'Italian', 't1__c163fa', NULL);

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (8, 'Italian', 't1__c163fa', NULL);

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (9, 'Italian', 't1__c163fa', NULL);

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (10, 'Italian', 't1__c163fa', NULL);

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (11, 'Italian', 't1__c163fa', NULL);

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (12, 'Italian', 't1__c163fa', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.id) FROM sets AS T1 INNER JOIN set_translations AS T2 ON T2.setCode = T1.code WHERE NOT T2.translation IS NULL AND T1.baseSetSize < 10 AND T2.language = 'Italian';

/*
Gold Result:
(4,)
*/

-- Prediction Query
SELECT COUNT(T1.code) FROM sets AS T1 INNER JOIN set_translations AS T2 ON T1.code = T2.setCode WHERE T2.language = 'Italian' AND T1.baseSetSize < 100 AND NOT T2.translation IS NULL;

/*
Prediction Result:
(9,)
*/