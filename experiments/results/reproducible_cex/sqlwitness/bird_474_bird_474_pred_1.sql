-- Schema DDL
CREATE TABLE "cards" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, artist TEXT, asciiName TEXT, availability TEXT, borderColor TEXT, cardKingdomFoilId TEXT, cardKingdomId TEXT, colorIdentity TEXT, colorIndicator TEXT, colors TEXT, convertedManaCost REAL, duelDeck TEXT, edhrecRank INTEGER, faceConvertedManaCost REAL, faceName TEXT, flavorName TEXT, flavorText TEXT, frameEffects TEXT, frameVersion TEXT, hand TEXT, hasAlternativeDeckLimit INTEGER DEFAULT 0 NOT NULL, hasContentWarning INTEGER DEFAULT 0 NOT NULL, hasFoil INTEGER DEFAULT 0 NOT NULL, hasNonFoil INTEGER DEFAULT 0 NOT NULL, isAlternative INTEGER DEFAULT 0 NOT NULL, isFullArt INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isOversized INTEGER DEFAULT 0 NOT NULL, isPromo INTEGER DEFAULT 0 NOT NULL, isReprint INTEGER DEFAULT 0 NOT NULL, isReserved INTEGER DEFAULT 0 NOT NULL, isStarter INTEGER DEFAULT 0 NOT NULL, isStorySpotlight INTEGER DEFAULT 0 NOT NULL, isTextless INTEGER DEFAULT 0 NOT NULL, isTimeshifted INTEGER DEFAULT 0 NOT NULL, keywords TEXT, layout TEXT, leadershipSkills TEXT, life TEXT, loyalty TEXT, manaCost TEXT, mcmId TEXT, mcmMetaId TEXT, mtgArenaId TEXT, mtgjsonV4Id TEXT, mtgoFoilId TEXT, mtgoId TEXT, multiverseId TEXT, name TEXT, number TEXT, originalReleaseDate TEXT, originalText TEXT, originalType TEXT, otherFaceIds TEXT, power TEXT, printings TEXT, promoTypes TEXT, purchaseUrls TEXT, rarity TEXT, scryfallId TEXT, scryfallIllustrationId TEXT, scryfallOracleId TEXT, setCode TEXT, side TEXT, subtypes TEXT, supertypes TEXT, tcgplayerProductId TEXT, text TEXT, toughness TEXT, type TEXT, types TEXT, uuid TEXT NOT NULL UNIQUE, variations TEXT, watermark TEXT);

CREATE TABLE "foreign_data" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, flavorText TEXT, language TEXT, multiverseid INTEGER, name TEXT, text TEXT, type TEXT, uuid TEXT REFERENCES cards (uuid));

CREATE TABLE "legalities" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, format TEXT, status TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

CREATE TABLE "sets" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, baseSetSize INTEGER, block TEXT, booster TEXT, code TEXT NOT NULL UNIQUE, isFoilOnly INTEGER DEFAULT 0 NOT NULL, isForeignOnly INTEGER DEFAULT 0 NOT NULL, isNonFoilOnly INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isPartialPreview INTEGER DEFAULT 0 NOT NULL, keyruneCode TEXT, mcmId INTEGER, mcmIdExtras INTEGER, mcmName TEXT, mtgoCode TEXT, name TEXT, parentCode TEXT, releaseDate DATE, tcgplayerGroupId INTEGER, totalSetSize INTEGER, type TEXT);

CREATE TABLE "set_translations" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, language TEXT, setCode TEXT REFERENCES sets (code) ON update CASCADE ON delete CASCADE, translation TEXT);

CREATE TABLE "rulings" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, date DATE, text TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO sets (id, basesetsize, block, booster, code, isfoilonly, isforeignonly, isnonfoilonly, isonlineonly, ispartialpreview, keyrunecode, mcmid, mcmidextras, mcmname, mtgocode, name, parentcode, releasedate, tcgplayergroupid, totalsetsize, type) VALUES (11, NULL, 'Italian', 'Italian', 'default2', 11, 9, 1, 100, 11, NULL, 100, NULL, 'default2', NULL, NULL, NULL, '2023-01-02', 0, 10, 'default2'), (1, 10, 'default1', 'default2', 'Italian', 101, 11, 11, 0, 11, NULL, 10, 10, 'default2', 'default2', 'Italian', 'default2', NULL, NULL, 10, NULL), (9, 0, 'Italian', 'default1', 'default1', 0, 1, 11, 9, 10, 'Italian', 0, 1, 'default2', 'default1', NULL, NULL, NULL, 1, 100, 'default2'), (100, 100, 'Italian', NULL, 'unique_3', 10, 0, 99, 0, 1, 'default1', 11, 1, NULL, 'default2', 'Italian', NULL, '2023-01-02', 11, 1, NULL), (10, 0, NULL, NULL, 'unique_4', 10, 0, 11, 1, 1, 'default1', 10, 0, 'default1', 'Italian', 'Italian', 'default2', '2023-01-01', 10, 10, 'default2'), (101, 0, NULL, NULL, 'unique_5', 10, 99, 9, 11, 10, 'default2', 99, NULL, 'Italian', 'Italian', 'default1', NULL, NULL, 99, 1, 'Italian'), (99, NULL, 'Italian', 'Italian', 'unique_6', 10, 101, 9, 99, 1, 'default2', NULL, NULL, 'Italian', NULL, NULL, 'default2', NULL, 101, 0, 'default2');
INSERT INTO set_translations (id, setcode, language, translation) VALUES (1, 'Italian', 'Italian', 'Italian'), (10, 'Italian', 'Italian', 'default2'), (100, 'unique_5', 'Italian', NULL), (101, 'default2', NULL, 'Italian'), (99, 'unique_4', 'default1', 'default1'), (9, 'unique_3', 'Italian', NULL), (11, 'default2', 'default1', 'Italian'), (0, 'default1', 'default2', 'default2'), (2, 'unique_4', 'default2', 'Italian'), (3, 'default2', 'Italian', 'Italian'), (4, NULL, 'default2', 'default1'), (5, 'unique_6', NULL, 'default2'), (6, 'unique_5', NULL, 'Italian'), (7, 'unique_3', 'default2', 'Italian'), (8, 'unique_5', 'Italian', 'default1'), (12, 'unique_3', 'default1', 'Italian'), (13, 'unique_4', 'Italian', 'default1'), (14, 'default2', 'Italian', 'Italian'), (15, 'default2', 'default1', 'Italian'), (16, 'unique_6', 'default1', 'Italian'), (17, 'unique_3', 'Italian', 'Italian'), (18, 'unique_4', NULL, 'default2'), (19, NULL, 'default2', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.id) FROM sets AS T1 INNER JOIN set_translations AS T2 ON T2.setCode = T1.code WHERE NOT T2.translation IS NULL AND T1.baseSetSize < 10 AND T2.language = 'Italian';

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT "sets"."id") FROM "sets" INNER JOIN "set_translations" ON "sets"."code" = "set_translations"."setcode" WHERE "set_translations"."language" = 'Italian' AND NOT "set_translations"."translation" IS NULL AND "sets"."basesetsize" < 100;

/*
Prediction Result:
(3,)
*/