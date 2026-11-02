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
-- Tests basic INNER JOIN vs LEFT JOIN, DISTINCT necessity (multiple foreign_data per card),
-- WHERE clause filtering ('boros' vs other vs NULL), and column source disambiguation (cards vs foreign_data).
INSERT INTO cards (id, uuid, name, type, watermark, asciiName, faceName, flavorName, originalType, types, subtypes, supertypes)
VALUES (1, 'uuid-1', 'BorosSwiftblade', 'Creature — Human Soldier', 'boros', 'ASCII_Swiftblade', 'Face_Swiftblade', 'Flavor_Swiftblade', 'Orig_Creature', 'Creature', 'Human Soldier', 'Basic');
INSERT INTO cards (id, uuid, name, type, watermark, asciiName, faceName, flavorName, originalType, types, subtypes, supertypes)
VALUES (2, 'uuid-2', 'BorosGuildgate', 'Land — Gate', 'boros', 'ASCII_Gate', 'Face_Gate', 'Flavor_Gate', 'Orig_Land', 'Land', 'Gate', 'Snow');
INSERT INTO cards (id, uuid, name, type, watermark)
VALUES (3, 'uuid-3', 'DimirCutpurse', 'Creature — Spirit', 'dimir');
INSERT INTO cards (id, uuid, name, type, watermark)
VALUES (4, 'uuid-4', 'LightningBolt', 'Instant', NULL);
-- Multiple foreign_data rows for uuid-1 to test DISTINCT and T1 vs T2 column selection
INSERT INTO foreign_data (id, uuid, name, type, language)
VALUES (1, 'uuid-1', 'Lamepreste de Boros', 'Créature : humain et soldat', 'French');
INSERT INTO foreign_data (id, uuid, name, type, language)
VALUES (2, 'uuid-1', 'Boros-Schnellklinge', 'Kreatur — Mensch, Soldat', 'German');
-- No foreign_data for uuid-2 to test INNER JOIN vs LEFT JOIN (uuid-2 has watermark='boros' but must be excluded)
-- Foreign_data for non-boros cards to test WHERE filter
INSERT INTO foreign_data (id, uuid, name, type, language)
VALUES (3, 'uuid-3', 'Bourse-coupe de Dimir', 'Créature : esprit', 'French');
INSERT INTO foreign_data (id, uuid, name, type, language)
VALUES (4, 'uuid-4', 'Foudre', 'Éphémère', 'French');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.name, T1.type FROM cards AS T1 INNER JOIN foreign_data AS T2 ON T2.uuid = T1.uuid WHERE T1.watermark = 'boros';

/*
Gold Result:
('BorosSwiftblade', 'Creature — Human Soldier')
*/

-- Prediction Query
SELECT foreign_data.name, foreign_data.type FROM cards INNER JOIN foreign_data ON cards.uuid = foreign_data.uuid WHERE cards.watermark = 'boros';

/*
Prediction Result:
('Lamepreste de Boros', 'Créature : humain et soldat')
('Boros-Schnellklinge', 'Kreatur — Mensch, Soldat')
*/