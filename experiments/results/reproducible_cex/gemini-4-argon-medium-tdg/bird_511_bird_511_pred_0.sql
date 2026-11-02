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
INSERT INTO cards (uuid, cardKingdomFoilId, cardKingdomId, frameEffects, frameVersion) VALUES ('u1', 'f1', 'c1', 'legendary', '2015');
INSERT INTO cards (uuid, cardKingdomFoilId, cardKingdomId, frameEffects, frameVersion) VALUES ('u2', 'f2', 'c2', 'legendary', '2015');
INSERT INTO cards (uuid, cardKingdomFoilId, cardKingdomId, frameEffects, frameVersion) VALUES ('u3', 'f3', 'c3', 'legendary', '2003');
INSERT INTO cards (uuid, cardKingdomFoilId, cardKingdomId, frameEffects, frameVersion) VALUES ('u4', 'f4', 'c4', 'miracle', '2015');
INSERT INTO cards (uuid, cardKingdomFoilId, cardKingdomId, frameEffects, frameVersion) VALUES ('u5', 'f5', 'c5', 'miracle', '2015');
INSERT INTO cards (uuid, cardKingdomFoilId, cardKingdomId, frameEffects, frameVersion) VALUES ('u6', 'f6', 'c6', 'nyxtouched', '2015');
INSERT INTO cards (uuid, cardKingdomFoilId, cardKingdomId, frameEffects, frameVersion) VALUES ('u7', NULL, 'c7', 'nyxtouched', '1997');
INSERT INTO cards (uuid, cardKingdomFoilId, cardKingdomId, frameEffects, frameVersion) VALUES ('u8', NULL, 'c8', 'nyxtouched', '1997');
INSERT INTO cards (uuid, cardKingdomFoilId, cardKingdomId, frameEffects, frameVersion) VALUES ('u9', NULL, 'c9', 'nyxtouched', '1997');
INSERT INTO cards (uuid, cardKingdomFoilId, cardKingdomId, frameEffects, frameVersion) VALUES ('u10', 'f10', NULL, 'devoid', '1993');
INSERT INTO cards (uuid, cardKingdomFoilId, cardKingdomId, frameEffects, frameVersion) VALUES ('u11', 'f11', NULL, 'devoid', '1993');
INSERT INTO cards (uuid, cardKingdomFoilId, cardKingdomId, frameEffects, frameVersion) VALUES ('u12', 'f12', NULL, 'devoid', '1993');
INSERT INTO cards (uuid, cardKingdomFoilId, cardKingdomId, frameEffects, frameVersion) VALUES ('u13', 'f13', NULL, 'devoid', '1993');
INSERT INTO cards (uuid, cardKingdomFoilId, cardKingdomId, frameEffects, frameVersion) VALUES ('u14', NULL, NULL, 'sunmoondfc', 'future');
INSERT INTO cards (uuid, cardKingdomFoilId, cardKingdomId, frameEffects, frameVersion) VALUES ('u15', NULL, NULL, 'sunmoondfc', 'future');
INSERT INTO cards (uuid, cardKingdomFoilId, cardKingdomId, frameEffects, frameVersion) VALUES ('u16', NULL, NULL, 'sunmoondfc', 'future');
INSERT INTO cards (uuid, cardKingdomFoilId, cardKingdomId, frameEffects, frameVersion) VALUES ('u17', NULL, NULL, 'sunmoondfc', 'future');
INSERT INTO cards (uuid, cardKingdomFoilId, cardKingdomId, frameEffects, frameVersion) VALUES ('u18', NULL, NULL, 'sunmoondfc', 'future');
INSERT INTO cards (uuid, cardKingdomFoilId, cardKingdomId, frameEffects, frameVersion) VALUES ('u19', 'f19', 'c19', NULL, '2015');
INSERT INTO cards (uuid, cardKingdomFoilId, cardKingdomId, frameEffects, frameVersion) VALUES ('u20', 'f20', 'c20', NULL, '2015');
INSERT INTO cards (uuid, cardKingdomFoilId, cardKingdomId, frameEffects, frameVersion) VALUES ('u21', 'f21', 'c21', NULL, '2015');
INSERT INTO cards (uuid, cardKingdomFoilId, cardKingdomId, frameEffects, frameVersion) VALUES ('u22', 'f22', 'c22', NULL, '2015');
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