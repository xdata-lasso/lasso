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
INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483648, 180, 'Ravnica', '5k5swwqcgs', 't1__5cda25', 247012447, -1980249628, -734455130, 1744686505, -1633151678, 'a2y', 1115440883, 1644814318, 'sr', 'wbbp6luhvdlt', 'ilbnp', 'mdpos', '2021-06-28', -1602639011, -45536098, 'w6kl');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483647, 180, 'Ravnica', '00t5c4e', 't1__1b1d1d', 1274489983, -1683203397, 528680845, -1585009206, -53231346, 'zbuo4nrqrof', 373262291, -472966518, 's5bbp02e', 'tliqa1', 'ryytoo3', '9hl7', '2024-12-21', -1438850342, -305670381, 'i7z');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483646, 180, 'Ravnica', '78d99r', 'A', -1362461264, -904834265, -346339240, 1692174491, -1025564911, 'rkf9vqx5', 1836127587, -1529584866, 'd2', 'vy9uxj4', 'wb', 'v', '2022-01-29', 2103044118, -1642259219, 'nd');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483645, -1052964641, 'qcx5', 'hncprjtu0dz', 'G', -1748371085, -1742081330, 894242932, -211209314, -1056308489, 'gcb98oz', 1443629118, -155284187, 'i', 'yrk', 'n6vck6ah0f', 'jswwlq7xb', '2025-11-20', 602161869, 1350414441, 'a7ryfd');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483644, 180, 'Ravnica', '8', 't2__bb3db6', -458359144, 600440952, 1568069663, -1794176801, -1194675273, 'itsj3', -491938169, -106471771, '1jh3den', 'c68x8vacx', 'afu5w1of7', 'pzo72ctdc', '2023-06-03', -1284905200, 7929158, '0v');

-- Inserting into table: set_translations --
INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483648, 't2__30da86', 't1__5cda25', 'a9');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (2, 't2__30da86', 't1__5cda25', 'au2dwy');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (3, 't2__30da86', 't1__5cda25', 'q13py');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483645, 't2__30da86', 'G', 'z16ni');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483644, 't2__30da86', 'G', 'jai');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483643, 't2__30da86', 'G', 'dh5ogrgj');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483642, 't2__30da86', 't1__5cda25', 'q8qdjpe1');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483641, 't2__30da86', 't1__5cda25', 'o22');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483640, NULL, 't1__5cda25', '8507cvtjp');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (4, '5k5swwqcgs', 't1__5cda25', '9n8');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (5, '4', 't1__5cda25', 'gu7v');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (6, 'e4', 't1__5cda25', 'hria2ypuzhs');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (7, 'rwbbp6luhvd', 't1__5cda25', 'tti');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (8, 'bnp', 't1__5cda25', 'mdpos');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (9, 'ie5', 't1__5cda25', 'nw6klf');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (10, 'a9000t5c4eci', 't1__5cda25', 'gce376nium52');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (11, 'zbuo4nrqrof', 't1__5cda25', 'qyp5s5bbp0');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (12, '2eutliqa11r', 't1__5cda25', 'ytoo3o9');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.language FROM sets AS T1 INNER JOIN set_translations AS T2 ON T1.code = T2.setCode WHERE T1.block = 'Ravnica' AND T1.baseSetSize = 180;

/*
Gold Result:
('t2__30da86',)
('t2__30da86',)
('t2__30da86',)
(None,)
('t2__30da86',)
('t2__30da86',)
('5k5swwqcgs',)
('4',)
('e4',)
('rwbbp6luhvd',)
('bnp',)
('ie5',)
('a9000t5c4eci',)
('zbuo4nrqrof',)
('2eutliqa11r',)
*/

-- Prediction Query
SELECT T2.translation FROM sets AS T1 INNER JOIN set_translations AS T2 ON T1.code = T2.setCode WHERE T1.baseSetSize = 180 AND T1.block = 'Ravnica';

/*
Prediction Result:
('a9',)
('q8qdjpe1',)
('o22',)
('8507cvtjp',)
('au2dwy',)
('q13py',)
('9n8',)
('gu7v',)
('hria2ypuzhs',)
('tti',)
('mdpos',)
('nw6klf',)
('gce376nium52',)
('qyp5s5bbp0',)
('ytoo3o9',)
*/