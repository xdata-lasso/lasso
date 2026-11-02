-- Schema DDL
CREATE TABLE "cards" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, artist TEXT, asciiName TEXT, availability TEXT, borderColor TEXT, cardKingdomFoilId TEXT, cardKingdomId TEXT, colorIdentity TEXT, colorIndicator TEXT, colors TEXT, convertedManaCost REAL, duelDeck TEXT, edhrecRank INTEGER, faceConvertedManaCost REAL, faceName TEXT, flavorName TEXT, flavorText TEXT, frameEffects TEXT, frameVersion TEXT, hand TEXT, hasAlternativeDeckLimit INTEGER DEFAULT 0 NOT NULL, hasContentWarning INTEGER DEFAULT 0 NOT NULL, hasFoil INTEGER DEFAULT 0 NOT NULL, hasNonFoil INTEGER DEFAULT 0 NOT NULL, isAlternative INTEGER DEFAULT 0 NOT NULL, isFullArt INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isOversized INTEGER DEFAULT 0 NOT NULL, isPromo INTEGER DEFAULT 0 NOT NULL, isReprint INTEGER DEFAULT 0 NOT NULL, isReserved INTEGER DEFAULT 0 NOT NULL, isStarter INTEGER DEFAULT 0 NOT NULL, isStorySpotlight INTEGER DEFAULT 0 NOT NULL, isTextless INTEGER DEFAULT 0 NOT NULL, isTimeshifted INTEGER DEFAULT 0 NOT NULL, keywords TEXT, layout TEXT, leadershipSkills TEXT, life TEXT, loyalty TEXT, manaCost TEXT, mcmId TEXT, mcmMetaId TEXT, mtgArenaId TEXT, mtgjsonV4Id TEXT, mtgoFoilId TEXT, mtgoId TEXT, multiverseId TEXT, name TEXT, number TEXT, originalReleaseDate TEXT, originalText TEXT, originalType TEXT, otherFaceIds TEXT, power TEXT, printings TEXT, promoTypes TEXT, purchaseUrls TEXT, rarity TEXT, scryfallId TEXT, scryfallIllustrationId TEXT, scryfallOracleId TEXT, setCode TEXT, side TEXT, subtypes TEXT, supertypes TEXT, tcgplayerProductId TEXT, text TEXT, toughness TEXT, type TEXT, types TEXT, uuid TEXT NOT NULL UNIQUE, variations TEXT, watermark TEXT);

CREATE TABLE "foreign_data" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, flavorText TEXT, language TEXT, multiverseid INTEGER, name TEXT, text TEXT, type TEXT, uuid TEXT REFERENCES cards (uuid));

CREATE TABLE "legalities" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, format TEXT, status TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

CREATE TABLE "sets" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, baseSetSize INTEGER, block TEXT, booster TEXT, code TEXT NOT NULL UNIQUE, isFoilOnly INTEGER DEFAULT 0 NOT NULL, isForeignOnly INTEGER DEFAULT 0 NOT NULL, isNonFoilOnly INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isPartialPreview INTEGER DEFAULT 0 NOT NULL, keyruneCode TEXT, mcmId INTEGER, mcmIdExtras INTEGER, mcmName TEXT, mtgoCode TEXT, name TEXT, parentCode TEXT, releaseDate DATE, tcgplayerGroupId INTEGER, totalSetSize INTEGER, type TEXT);

CREATE TABLE "set_translations" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, language TEXT, setCode TEXT REFERENCES sets (code) ON update CASCADE ON delete CASCADE, translation TEXT);

CREATE TABLE "rulings" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, date DATE, text TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO sets (id, code, name) VALUES (1, 'SET1', 'Set One');
INSERT INTO sets (id, code, name) VALUES (2, 'SET2', 'Set Two');
INSERT INTO sets (id, code, name) VALUES (3, 'SET3', 'Set Three');
INSERT INTO cards (id, name, asciiName, faceName, flavorName, setCode, uuid) VALUES (1, 'Angel of Mercy', 'Other Card', 'Other Card', 'Other Card', 'SET1', 'uuid-1');
INSERT INTO cards (id, name, asciiName, faceName, flavorName, setCode, uuid) VALUES (2, 'Angel of Mercy', 'Angel of Mercy', 'Angel of Mercy', 'Angel of Mercy', 'SET2', 'uuid-2');
INSERT INTO cards (id, name, asciiName, faceName, flavorName, setCode, uuid) VALUES (3, 'Archangel of Mercy', 'Angel of Mercy', 'Angel of Mercy', 'Angel of Mercy', 'SET1', 'uuid-3');
INSERT INTO cards (id, name, asciiName, faceName, flavorName, setCode, uuid) VALUES (4, 'angel of mercy', 'Angel of Mercy', 'Angel of Mercy', 'Angel of Mercy', 'SET1', 'uuid-4');
INSERT INTO cards (id, name, asciiName, faceName, flavorName, setCode, uuid) VALUES (5, NULL, 'Angel of Mercy', 'Angel of Mercy', 'Angel of Mercy', 'SET1', 'uuid-5');
INSERT INTO set_translations (id, language, setCode, translation) VALUES (1, 'French', 'SET2', 'Traduction 1');
INSERT INTO set_translations (id, language, setCode, translation) VALUES (2, 'French', 'SET3', 'Traduction 2');
INSERT INTO set_translations (id, language, setCode, translation) VALUES (3, 'German', 'SET1', 'Traduction 3');
INSERT INTO set_translations (id, language, setCode, translation) VALUES (4, 'Spanish', 'SET1', 'Traduction 4');
INSERT INTO set_translations (id, language, setCode, translation) VALUES (5, 'Italian', 'SET1', 'Traduction 5');
INSERT INTO set_translations (id, language, setCode, translation) VALUES (6, 'Japanese', 'SET1', 'Traduction 6');
INSERT INTO foreign_data (id, language, name, uuid) VALUES (1, 'Portuguese', 'Anjo da Misericórdia', 'uuid-3');
INSERT INTO foreign_data (id, language, name, uuid) VALUES (2, 'Russian', 'Angel of Mercy', 'uuid-3');
INSERT INTO foreign_data (id, language, name, uuid) VALUES (7, 'Korean', 'Angel of Mercy', 'uuid-1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT language FROM set_translations WHERE id IN (SELECT id FROM cards WHERE name = 'Angel of Mercy');

/*
Gold Result:
('French',)
('French',)
*/

-- Prediction Query
SELECT T2.language FROM sets AS T1 INNER JOIN set_translations AS T2 ON T1.code = T2.setCode WHERE T1.code = (SELECT setCode FROM cards WHERE name = 'Angel of Mercy') GROUP BY T2.language;

/*
Prediction Result:
('German',)
('Italian',)
('Japanese',)
('Spanish',)
*/