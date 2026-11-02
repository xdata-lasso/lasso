-- Schema DDL
CREATE TABLE "cards" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, artist TEXT, asciiName TEXT, availability TEXT, borderColor TEXT, cardKingdomFoilId TEXT, cardKingdomId TEXT, colorIdentity TEXT, colorIndicator TEXT, colors TEXT, convertedManaCost REAL, duelDeck TEXT, edhrecRank INTEGER, faceConvertedManaCost REAL, faceName TEXT, flavorName TEXT, flavorText TEXT, frameEffects TEXT, frameVersion TEXT, hand TEXT, hasAlternativeDeckLimit INTEGER DEFAULT 0 NOT NULL, hasContentWarning INTEGER DEFAULT 0 NOT NULL, hasFoil INTEGER DEFAULT 0 NOT NULL, hasNonFoil INTEGER DEFAULT 0 NOT NULL, isAlternative INTEGER DEFAULT 0 NOT NULL, isFullArt INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isOversized INTEGER DEFAULT 0 NOT NULL, isPromo INTEGER DEFAULT 0 NOT NULL, isReprint INTEGER DEFAULT 0 NOT NULL, isReserved INTEGER DEFAULT 0 NOT NULL, isStarter INTEGER DEFAULT 0 NOT NULL, isStorySpotlight INTEGER DEFAULT 0 NOT NULL, isTextless INTEGER DEFAULT 0 NOT NULL, isTimeshifted INTEGER DEFAULT 0 NOT NULL, keywords TEXT, layout TEXT, leadershipSkills TEXT, life TEXT, loyalty TEXT, manaCost TEXT, mcmId TEXT, mcmMetaId TEXT, mtgArenaId TEXT, mtgjsonV4Id TEXT, mtgoFoilId TEXT, mtgoId TEXT, multiverseId TEXT, name TEXT, number TEXT, originalReleaseDate TEXT, originalText TEXT, originalType TEXT, otherFaceIds TEXT, power TEXT, printings TEXT, promoTypes TEXT, purchaseUrls TEXT, rarity TEXT, scryfallId TEXT, scryfallIllustrationId TEXT, scryfallOracleId TEXT, setCode TEXT, side TEXT, subtypes TEXT, supertypes TEXT, tcgplayerProductId TEXT, text TEXT, toughness TEXT, type TEXT, types TEXT, uuid TEXT NOT NULL UNIQUE, variations TEXT, watermark TEXT);

CREATE TABLE "foreign_data" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, flavorText TEXT, language TEXT, multiverseid INTEGER, name TEXT, text TEXT, type TEXT, uuid TEXT REFERENCES cards (uuid));

CREATE TABLE "legalities" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, format TEXT, status TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

CREATE TABLE "sets" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, baseSetSize INTEGER, block TEXT, booster TEXT, code TEXT NOT NULL UNIQUE, isFoilOnly INTEGER DEFAULT 0 NOT NULL, isForeignOnly INTEGER DEFAULT 0 NOT NULL, isNonFoilOnly INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isPartialPreview INTEGER DEFAULT 0 NOT NULL, keyruneCode TEXT, mcmId INTEGER, mcmIdExtras INTEGER, mcmName TEXT, mtgoCode TEXT, name TEXT, parentCode TEXT, releaseDate DATE, tcgplayerGroupId INTEGER, totalSetSize INTEGER, type TEXT);

CREATE TABLE "set_translations" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, language TEXT, setCode TEXT REFERENCES sets (code) ON update CASCADE ON delete CASCADE, translation TEXT);

CREATE TABLE "rulings" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, date DATE, text TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO cards (id, uuid, name, cardKingdomFoilId, cardKingdomId, frameEffects) VALUES (1, 'u-201', 'Null Effect 1', 'ckf-201', 'ck-201', NULL);
INSERT INTO cards (id, uuid, name, cardKingdomFoilId, cardKingdomId, frameEffects) VALUES (2, 'u-202', 'Null Effect 2', 'ckf-202', 'ck-202', NULL);
INSERT INTO cards (id, uuid, name, cardKingdomFoilId, cardKingdomId, frameEffects) VALUES (3, 'u-203', 'Null Effect 3', 'ckf-203', 'ck-203', NULL);
INSERT INTO cards (id, uuid, name, cardKingdomFoilId, cardKingdomId, frameEffects) VALUES (4, 'u-204', 'Null Effect 4', 'ckf-204', 'ck-204', NULL);
INSERT INTO cards (id, uuid, name, cardKingdomFoilId, cardKingdomId, frameEffects) VALUES (5, 'u-205', 'Legendary 1', 'ckf-205', 'ck-205', 'legendary');
INSERT INTO cards (id, uuid, name, cardKingdomFoilId, cardKingdomId, frameEffects) VALUES (6, 'u-206', 'Legendary 2', 'ckf-206', 'ck-206', 'legendary');
INSERT INTO cards (id, uuid, name, cardKingdomFoilId, cardKingdomId, frameEffects) VALUES (7, 'u-207', 'Extended 1', 'ckf-207', 'ck-207', 'extendedart');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT frameEffects FROM cards WHERE NOT cardKingdomFoilId IS NULL AND NOT cardKingdomId IS NULL GROUP BY frameEffects ORDER BY COUNT(frameEffects) DESC, frameEffects NULLS LAST LIMIT 1;

/*
Gold Result:
('legendary',)
*/

-- Prediction Query
SELECT frameEffects FROM cards WHERE NOT cardKingdomFoilId IS NULL AND NOT cardKingdomId IS NULL GROUP BY frameEffects ORDER BY COUNT(*) DESC, frameEffects NULLS LAST LIMIT 1;

/*
Prediction Result:
(None,)
*/