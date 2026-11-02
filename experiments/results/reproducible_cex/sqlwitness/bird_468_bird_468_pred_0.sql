-- Schema DDL
CREATE TABLE "cards" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, artist TEXT, asciiName TEXT, availability TEXT, borderColor TEXT, cardKingdomFoilId TEXT, cardKingdomId TEXT, colorIdentity TEXT, colorIndicator TEXT, colors TEXT, convertedManaCost REAL, duelDeck TEXT, edhrecRank INTEGER, faceConvertedManaCost REAL, faceName TEXT, flavorName TEXT, flavorText TEXT, frameEffects TEXT, frameVersion TEXT, hand TEXT, hasAlternativeDeckLimit INTEGER DEFAULT 0 NOT NULL, hasContentWarning INTEGER DEFAULT 0 NOT NULL, hasFoil INTEGER DEFAULT 0 NOT NULL, hasNonFoil INTEGER DEFAULT 0 NOT NULL, isAlternative INTEGER DEFAULT 0 NOT NULL, isFullArt INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isOversized INTEGER DEFAULT 0 NOT NULL, isPromo INTEGER DEFAULT 0 NOT NULL, isReprint INTEGER DEFAULT 0 NOT NULL, isReserved INTEGER DEFAULT 0 NOT NULL, isStarter INTEGER DEFAULT 0 NOT NULL, isStorySpotlight INTEGER DEFAULT 0 NOT NULL, isTextless INTEGER DEFAULT 0 NOT NULL, isTimeshifted INTEGER DEFAULT 0 NOT NULL, keywords TEXT, layout TEXT, leadershipSkills TEXT, life TEXT, loyalty TEXT, manaCost TEXT, mcmId TEXT, mcmMetaId TEXT, mtgArenaId TEXT, mtgjsonV4Id TEXT, mtgoFoilId TEXT, mtgoId TEXT, multiverseId TEXT, name TEXT, number TEXT, originalReleaseDate TEXT, originalText TEXT, originalType TEXT, otherFaceIds TEXT, power TEXT, printings TEXT, promoTypes TEXT, purchaseUrls TEXT, rarity TEXT, scryfallId TEXT, scryfallIllustrationId TEXT, scryfallOracleId TEXT, setCode TEXT, side TEXT, subtypes TEXT, supertypes TEXT, tcgplayerProductId TEXT, text TEXT, toughness TEXT, type TEXT, types TEXT, uuid TEXT NOT NULL UNIQUE, variations TEXT, watermark TEXT);

CREATE TABLE "foreign_data" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, flavorText TEXT, language TEXT, multiverseid INTEGER, name TEXT, text TEXT, type TEXT, uuid TEXT REFERENCES cards (uuid));

CREATE TABLE "legalities" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, format TEXT, status TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

CREATE TABLE "sets" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, baseSetSize INTEGER, block TEXT, booster TEXT, code TEXT NOT NULL UNIQUE, isFoilOnly INTEGER DEFAULT 0 NOT NULL, isForeignOnly INTEGER DEFAULT 0 NOT NULL, isNonFoilOnly INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isPartialPreview INTEGER DEFAULT 0 NOT NULL, keyruneCode TEXT, mcmId INTEGER, mcmIdExtras INTEGER, mcmName TEXT, mtgoCode TEXT, name TEXT, parentCode TEXT, releaseDate DATE, tcgplayerGroupId INTEGER, totalSetSize INTEGER, type TEXT);

CREATE TABLE "set_translations" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, language TEXT, setCode TEXT REFERENCES sets (code) ON update CASCADE ON delete CASCADE, translation TEXT);

CREATE TABLE "rulings" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, date DATE, text TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO sets (id, basesetsize, block, booster, code, isfoilonly, isforeignonly, isnonfoilonly, isonlineonly, ispartialpreview, keyrunecode, mcmid, mcmidextras, mcmname, mtgocode, name, parentcode, releasedate, tcgplayergroupid, totalsetsize, type) VALUES (0, 1, 'Chinese Simplified', 'Eighth Edition', 'default1', 0, 1, 1, 1, 0, 'Chinese Simplified', 0, 1, 'default2', 'Chinese Simplified', NULL, 'Simplified Chinese', NULL, 1, 1, 'default2'), (1, 1, 'Simplified Chinese', NULL, 'Eighth Edition', 1, 0, 1, 1, 0, 'default2', 1, 0, 'default2', 'Simplified Chinese', 'Eighth Edition', 'default1', '2023-01-01', 1, 0, NULL), (2, 1, NULL, 'Chinese Simplified', 'Simplified Chinese', 0, 1, 0, 0, 1, 'Simplified Chinese', NULL, NULL, 'Simplified Chinese', 'default1', 'Chinese Simplified', NULL, NULL, NULL, 1, NULL), (3, 1, 'Chinese Simplified', 'Simplified Chinese', 'Chinese Simplified', 1, 1, 1, 1, 0, 'Simplified Chinese', 0, 0, NULL, 'Simplified Chinese', 'Simplified Chinese', NULL, '2023-01-01', NULL, 0, NULL), (4, 1, 'default2', 'Simplified Chinese', 'default2', 1, 1, 0, 1, 1, 'default2', NULL, 1, 'Simplified Chinese', 'default2', 'default2', 'default1', NULL, 0, NULL, 'Simplified Chinese'), (5, 0, 'default1', 'default1', 'unique_5', 0, 1, 1, 0, 0, 'Simplified Chinese', 0, 1, 'default1', 'default1', 'Eighth Edition', 'Eighth Edition', '2023-01-02', 0, 0, 'default2');
INSERT INTO set_translations (id, setcode, language, translation) VALUES (0, 'unique_5', NULL, NULL), (1, NULL, 'Simplified Chinese', 'Simplified Chinese'), (2, 'Chinese Simplified', 'Simplified Chinese', 'Chinese Simplified'), (3, 'default1', 'Chinese Simplified', 'default1'), (4, 'Chinese Simplified', 'default2', 'Eighth Edition'), (5, 'Eighth Edition', 'Simplified Chinese', 'Eighth Edition'), (6, NULL, 'Simplified Chinese', 'default2'), (7, 'Simplified Chinese', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.translation FROM sets AS T1 INNER JOIN set_translations AS T2 ON T2.setCode = T1.code WHERE T1.name = 'Eighth Edition' AND T2.language = 'Chinese Simplified';

/*
Gold Result:
*/

-- Prediction Query
SELECT translation FROM set_translations WHERE setCode = (SELECT code FROM sets WHERE name = 'Eighth Edition') AND language = 'Simplified Chinese';

/*
Prediction Result:
('Eighth Edition',)
*/