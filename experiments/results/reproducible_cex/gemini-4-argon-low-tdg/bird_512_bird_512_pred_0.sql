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
-- Comprehensive dataset testing power variations (*, 1+*, *+1, *2*, NULL, normal numbers, empty string), WHERE clause boundaries (hasFoil, duelDeck), and other table joins.
INSERT INTO sets (id, code, name, isFoilOnly) VALUES (1, 'DD1', 'Duel Decks: Elves vs. Goblins', 0);
INSERT INTO cards (id, uuid, name, setCode, hasFoil, duelDeck, power, toughness) VALUES (1, 'u1', 'Card Exact Star', 'DD1', 0, 'a', '*', '1');
INSERT INTO cards (id, uuid, name, setCode, hasFoil, duelDeck, power, toughness) VALUES (2, 'u2', 'Card Prefix Star', 'DD1', 0, 'a', '*+1', '2');
INSERT INTO cards (id, uuid, name, setCode, hasFoil, duelDeck, power, toughness) VALUES (3, 'u3', 'Card Suffix Star', 'DD1', 0, 'a', '1+*', '3');
INSERT INTO cards (id, uuid, name, setCode, hasFoil, duelDeck, power, toughness) VALUES (4, 'u4', 'Card Mid Star', 'DD1', 0, 'a', '2*2', '*');
INSERT INTO cards (id, uuid, name, setCode, hasFoil, duelDeck, power, toughness) VALUES (5, 'u5', 'Card Null Power', 'DD1', 0, 'a', NULL, NULL);
INSERT INTO cards (id, uuid, name, setCode, hasFoil, duelDeck, power, toughness) VALUES (6, 'u6', 'Card Numeric Power', 'DD1', 0, 'a', '3', '*');
INSERT INTO cards (id, uuid, name, setCode, hasFoil, duelDeck, power, toughness) VALUES (7, 'u7', 'Card Zero Power', 'DD1', 0, 'a', '0', '1');
INSERT INTO cards (id, uuid, name, setCode, hasFoil, duelDeck, power, toughness) VALUES (8, 'u8', 'Card Empty String Power', 'DD1', 0, 'a', '', '1');
-- Rows failing WHERE conditions to kill mutants that drop or alter predicates
INSERT INTO cards (id, uuid, name, setCode, hasFoil, duelDeck, power, toughness) VALUES (9, 'u9', 'Foil Card With Star', 'DD1', 1, 'a', '*', '*');
INSERT INTO cards (id, uuid, name, setCode, hasFoil, duelDeck, power, toughness) VALUES (10, 'u10', 'Foil Card Null Power', 'DD1', 1, 'a', NULL, NULL);
INSERT INTO cards (id, uuid, name, setCode, hasFoil, duelDeck, power, toughness) VALUES (11, 'u11', 'Deck B Card With Star', 'DD1', 0, 'b', '*', '*');
INSERT INTO cards (id, uuid, name, setCode, hasFoil, duelDeck, power, toughness) VALUES (12, 'u12', 'Deck B Card Null Power', 'DD1', 0, 'b', NULL, NULL);
INSERT INTO cards (id, uuid, name, setCode, hasFoil, duelDeck, power, toughness) VALUES (13, 'u13', 'Null Deck Card With Star', 'DD1', 0, NULL, '*', '*');
INSERT INTO cards (id, uuid, name, setCode, hasFoil, duelDeck, power, toughness) VALUES (14, 'u14', 'Upper A Deck Card', 'DD1', 0, 'A', '*', '*');
-- Child rows to kill mutants that unnecessarily INNER JOIN other tables (some matching cards have 0 children, some have multiple)
INSERT INTO legalities (id, uuid, format, status) VALUES (1, 'u1', 'commander', 'Legal');
INSERT INTO legalities (id, uuid, format, status) VALUES (2, 'u1', 'legacy', 'Legal');
INSERT INTO rulings (id, uuid, date, text) VALUES (1, 'u1', '2020-01-01', 'Ruling 1');
INSERT INTO rulings (id, uuid, date, text) VALUES (2, 'u1', '2020-01-02', 'Ruling 2');
INSERT INTO foreign_data (id, uuid, language, name) VALUES (1, 'u1', 'German', 'Karte 1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(CASE WHEN power LIKE '%*%' OR power IS NULL THEN 1 ELSE 0 END) FROM cards WHERE hasFoil = 0 AND duelDeck = 'a';

/*
Gold Result:
(5,)
*/

-- Prediction Query
SELECT COUNT(id) FROM cards WHERE power IS NULL OR power = '*' AND hasFoil = 0 AND duelDeck = 'a';

/*
Prediction Result:
(4,)
*/