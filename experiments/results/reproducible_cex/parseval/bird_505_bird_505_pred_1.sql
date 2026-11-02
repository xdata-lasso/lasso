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
INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483648, -55602865, 'swwqcgsk', '9n8c4pgu7v', 'set_e924fd', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw', 1908028688, 2122220075, 'p6luhvdlttil', 'n', 'Mirrodin', 'rmdp', '2022-07-21', -918961358, -1602639011, 'unw6klfa');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483647, 1419861592, '4ecigce376n', 'um5', 'set_9f750d', 742285925, -747753377, 902887186, -967741825, 775304493, 'qyp5s5bbp0', 743312762, -1822992503, 'liqa1', 'ryytoo3', 'Mirrodin', '9hl7', '2024-12-21', -1438850342, -305670381, 'i7z');

-- Inserting into table: set_translations --
INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (2, 'Chinese Simplified', 'set_e924fd', 'set_9f9782');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (3, 'Chinese Simplified', 'set_9f750d', 'set_9f9782');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483646, 'Chinese Simplified', 'set_e924fd', 'set_9f9782');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483645, 'set_32d61e', 'set_e924fd', 'set_9f9782');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483644, 'Chinese Simplified', 'set_e924fd', NULL);

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483643, 'Chinese Simplified', 'set_e924fd', 'set_9f9782');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483642, 'Chinese Simplified', 'set_9f750d', 'au2dwyrq13');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (4, 'yu78', 'set_9f750d', '9');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483640, 'Chinese Simplified', 'set_9f750d', 'jsl');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (5, 'b4yp5qi', 'set_9f750d', 'rkf9vqx5');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483638, 'Chinese Simplified', 'set_e924fd', 'z0f8jegd21vy');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (6, '9uxj4hwbdvl', 'set_9f750d', 'h2gn');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483636, 'Chinese Simplified', 'set_e924fd', 'wnqcx');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (7, '5hncprjtu0d', 'set_9f750d', '79fjgq8');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483634, 'Chinese Simplified', 'set_e924fd', 'f3dqv0gc');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (8, '9', 'set_9f750d', 'ozk3zbily');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT translation FROM set_translations WHERE setCode IN (SELECT code FROM sets WHERE name = 'Mirrodin') AND language = 'Chinese Simplified';

/*
Gold Result:
('set_9f9782',)
(None,)
('set_9f9782',)
('au2dwyrq13',)
('jsl',)
('z0f8jegd21vy',)
('wnqcx',)
('f3dqv0gc',)
('set_9f9782',)
('set_9f9782',)
*/

-- Prediction Query
SELECT translation FROM set_translations WHERE setCode = (SELECT code FROM sets WHERE name = 'Mirrodin') AND language = 'Chinese Simplified';

/*
Prediction Result:
('set_9f9782',)
(None,)
('set_9f9782',)
('z0f8jegd21vy',)
('wnqcx',)
('f3dqv0gc',)
('set_9f9782',)
*/