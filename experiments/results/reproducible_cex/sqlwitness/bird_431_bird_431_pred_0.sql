-- Schema DDL
CREATE TABLE "cards" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, artist TEXT, asciiName TEXT, availability TEXT, borderColor TEXT, cardKingdomFoilId TEXT, cardKingdomId TEXT, colorIdentity TEXT, colorIndicator TEXT, colors TEXT, convertedManaCost REAL, duelDeck TEXT, edhrecRank INTEGER, faceConvertedManaCost REAL, faceName TEXT, flavorName TEXT, flavorText TEXT, frameEffects TEXT, frameVersion TEXT, hand TEXT, hasAlternativeDeckLimit INTEGER DEFAULT 0 NOT NULL, hasContentWarning INTEGER DEFAULT 0 NOT NULL, hasFoil INTEGER DEFAULT 0 NOT NULL, hasNonFoil INTEGER DEFAULT 0 NOT NULL, isAlternative INTEGER DEFAULT 0 NOT NULL, isFullArt INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isOversized INTEGER DEFAULT 0 NOT NULL, isPromo INTEGER DEFAULT 0 NOT NULL, isReprint INTEGER DEFAULT 0 NOT NULL, isReserved INTEGER DEFAULT 0 NOT NULL, isStarter INTEGER DEFAULT 0 NOT NULL, isStorySpotlight INTEGER DEFAULT 0 NOT NULL, isTextless INTEGER DEFAULT 0 NOT NULL, isTimeshifted INTEGER DEFAULT 0 NOT NULL, keywords TEXT, layout TEXT, leadershipSkills TEXT, life TEXT, loyalty TEXT, manaCost TEXT, mcmId TEXT, mcmMetaId TEXT, mtgArenaId TEXT, mtgjsonV4Id TEXT, mtgoFoilId TEXT, mtgoId TEXT, multiverseId TEXT, name TEXT, number TEXT, originalReleaseDate TEXT, originalText TEXT, originalType TEXT, otherFaceIds TEXT, power TEXT, printings TEXT, promoTypes TEXT, purchaseUrls TEXT, rarity TEXT, scryfallId TEXT, scryfallIllustrationId TEXT, scryfallOracleId TEXT, setCode TEXT, side TEXT, subtypes TEXT, supertypes TEXT, tcgplayerProductId TEXT, text TEXT, toughness TEXT, type TEXT, types TEXT, uuid TEXT NOT NULL UNIQUE, variations TEXT, watermark TEXT);

CREATE TABLE "foreign_data" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, flavorText TEXT, language TEXT, multiverseid INTEGER, name TEXT, text TEXT, type TEXT, uuid TEXT REFERENCES cards (uuid));

CREATE TABLE "legalities" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, format TEXT, status TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

CREATE TABLE "sets" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, baseSetSize INTEGER, block TEXT, booster TEXT, code TEXT NOT NULL UNIQUE, isFoilOnly INTEGER DEFAULT 0 NOT NULL, isForeignOnly INTEGER DEFAULT 0 NOT NULL, isNonFoilOnly INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isPartialPreview INTEGER DEFAULT 0 NOT NULL, keyruneCode TEXT, mcmId INTEGER, mcmIdExtras INTEGER, mcmName TEXT, mtgoCode TEXT, name TEXT, parentCode TEXT, releaseDate DATE, tcgplayerGroupId INTEGER, totalSetSize INTEGER, type TEXT);

CREATE TABLE "set_translations" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, language TEXT, setCode TEXT REFERENCES sets (code) ON update CASCADE ON delete CASCADE, translation TEXT);

CREATE TABLE "rulings" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, date DATE, text TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO sets (id, basesetsize, block, booster, code, isfoilonly, isforeignonly, isnonfoilonly, isonlineonly, ispartialpreview, keyrunecode, mcmid, mcmidextras, mcmname, mtgocode, name, parentcode, releasedate, tcgplayergroupid, totalsetsize, type) VALUES (2, 2, 'default2', 'Japanese', 'Japanese', 0, 1, 2, 0, -1, 'Japanese', 0, -1, 'default1', 'Japanese', 'Japanese', 'default1', '2023-01-01', 2, -1, NULL), (-1, 2, 'default2', 'Japanese', 'default1', -1, 2, -1, -1, -1, 'Japanese', 1, 0, NULL, NULL, 'default1', NULL, '2023-01-02', NULL, -1, 'default1'), (1, NULL, 'Japanese', 'default1', 'default2', 1, 1, 1, 0, 2, NULL, 0, 2, 'default1', 'Japanese', 'default2', 'Japanese', NULL, -1, 1, 'Japanese'), (0, NULL, 'default1', 'Japanese', 'unique_3', 1, 0, 2, -1, 2, 'default1', 0, -1, 'default1', NULL, 'Japanese', 'default1', '2023-01-02', NULL, NULL, NULL), (3, -1, NULL, 'default2', 'unique_4', -1, 1, 0, 1, -1, 'Japanese', -1, 0, NULL, 'default1', 'default2', 'default1', '2023-01-02', -1, 0, NULL), (4, NULL, 'default1', 'default2', 'unique_5', 1, 0, 2, 1, 2, 'Japanese', 2, NULL, 'Japanese', 'default1', 'Japanese', 'Japanese', NULL, 0, NULL, 'default1'), (5, NULL, 'default1', NULL, 'unique_6', 0, 2, 0, -1, 1, NULL, 1, 0, 'default1', 'default2', 'default2', 'Japanese', '2023-01-02', 1, -1, 'default2'), (6, 1, 'default1', 'Japanese', 'unique_7', 2, 2, -1, -1, 1, 'default2', NULL, NULL, 'Japanese', 'default2', 'default1', 'Japanese', '2023-01-02', NULL, NULL, NULL), (7, NULL, 'Japanese', 'default1', 'unique_8', -1, 0, 0, 0, 1, 'Japanese', 0, NULL, 'default2', 'default2', 'default2', 'default1', '2023-01-01', 0, 1, 'default2'), (8, -1, 'Japanese', 'default2', 'unique_9', -1, 2, -1, 0, 1, NULL, NULL, 2, 'Japanese', 'Japanese', 'Japanese', 'default1', NULL, 1, 0, NULL), (9, 0, NULL, 'default2', 'unique_10', 1, 0, 2, 1, 0, NULL, 2, -1, NULL, NULL, NULL, 'default1', '2023-01-02', 0, 2, 'default2');
INSERT INTO set_translations (id, setcode, language, translation) VALUES (2, 'default1', 'Japanese', 'default2'), (-1, 'unique_10', NULL, 'default2'), (1, 'unique_6', NULL, 'Japanese'), (0, 'unique_6', 'default2', 'default2'), (3, 'Japanese', NULL, NULL), (4, 'Japanese', 'default1', 'Japanese'), (5, 'unique_5', 'default2', 'Japanese'), (6, 'unique_5', 'default1', 'default2'), (7, 'unique_9', 'Japanese', 'Japanese'), (8, 'unique_3', 'Japanese', 'Japanese'), (9, 'unique_3', 'Japanese', NULL), (10, 'unique_9', 'default2', 'default1'), (11, 'unique_8', 'default2', 'default1'), (12, 'unique_10', NULL, NULL), (13, 'unique_9', NULL, 'default2'), (14, 'unique_4', 'Japanese', 'default1'), (15, NULL, 'default2', 'Japanese');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.name, T1.id FROM sets AS T1 INNER JOIN set_translations AS T2 ON T1.code = T2.setCode WHERE T2.language = 'Japanese' AND T1.isFoilOnly = 1 AND T1.isForeignOnly = 0;

/*
Gold Result:
('Japanese', 0)
('Japanese', 0)
*/

-- Prediction Query
SELECT "sets"."id", "sets"."name" FROM "sets" INNER JOIN "set_translations" ON "sets"."code" = "set_translations"."setcode" WHERE "sets"."isforeignonly" = 0 AND "sets"."isfoilonly" = 1 AND "set_translations"."language" = 'Japanese';

/*
Prediction Result:
(0, 'Japanese')
(0, 'Japanese')
*/