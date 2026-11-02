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
INSERT INTO cards (id, uuid, name, asciiName, faceName, rarity) VALUES (1, 'u1', 'Card B', 'ASCII B', 'Face B', 'uncommon');
INSERT INTO cards (id, uuid, name, asciiName, faceName, rarity) VALUES (2, 'u2', 'Card A', 'ASCII A', 'Face A', 'uncommon');
INSERT INTO cards (id, uuid, name, asciiName, faceName, rarity) VALUES (3, 'u3', 'Card C', 'ASCII C', 'Face C', 'uncommon');
INSERT INTO cards (id, uuid, name, asciiName, faceName, rarity) VALUES (4, 'u4', 'Card D', 'ASCII D', 'Face D', 'uncommon');
INSERT INTO cards (id, uuid, name, asciiName, faceName, rarity) VALUES (5, 'u5', 'Card Rare', 'ASCII Rare', 'Face Rare', 'rare');
INSERT INTO cards (id, uuid, name, asciiName, faceName, rarity) VALUES (6, 'u6', 'Card NoRuling', 'ASCII NoRuling', 'Face NoRuling', 'uncommon');
INSERT INTO rulings (id, uuid, date, text) VALUES (10, 'u5', '2018-01-01', 'Ruling for rare card');
INSERT INTO rulings (id, uuid, date, text) VALUES (1, 'u1', '2020-01-01', 'First ruling for Card B');
INSERT INTO rulings (id, uuid, date, text) VALUES (2, 'u1', '2020-01-02', 'Second ruling for Card B to test DISTINCT');
INSERT INTO rulings (id, uuid, date, text) VALUES (3, 'u2', '2021-01-01', 'Ruling for Card A');
INSERT INTO rulings (id, uuid, date, text) VALUES (4, 'u3', '2022-01-01', 'Ruling for Card C');
INSERT INTO rulings (id, uuid, date, text) VALUES (5, 'u4', '2023-01-01', 'Ruling for Card D to test LIMIT 3');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.name FROM cards AS T1 INNER JOIN rulings AS T2 ON T1.uuid = T2.uuid WHERE T1.rarity = 'uncommon' ORDER BY T2.date ASC, T1.name NULLS LAST LIMIT 3;

/*
Gold Result:
('Card B',)
('Card A',)
('Card C',)
*/

-- Prediction Query
SELECT cards.name FROM cards INNER JOIN rulings ON cards.uuid = rulings.uuid WHERE cards.rarity = 'uncommon' ORDER BY rulings.date ASC, cards.id NULLS LAST, rulings.id NULLS LAST LIMIT 3;

/*
Prediction Result:
('Card B',)
('Card B',)
('Card A',)
*/