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
-- Tests ORDER BY T2.date DESC, T1.id ASC, T2.id ASC, and ensures join is on uuid, not id.
INSERT INTO cards (id, uuid, artist, text) VALUES (10, 'uuid-a', 'Kev Walker', 'Card A');
INSERT INTO cards (id, uuid, artist, text) VALUES (20, 'uuid-b', 'Kev Walker', 'Card B');
-- Different dates to test primary sort (T2.date DESC)
INSERT INTO rulings (id, uuid, date, text) VALUES (100, 'uuid-a', '2019-01-01', 'Date 2019');
INSERT INTO rulings (id, uuid, date, text) VALUES (101, 'uuid-b', '2021-01-01', 'Date 2021');
-- Same date ('2020-01-01'), different T1.id (10 vs 20) to test secondary sort (T1.id ASC)
-- Note: T2.id is inverted relative to T1.id (id 300 is with card 10, id 200 is with card 20) to catch wrong column sorting
INSERT INTO rulings (id, uuid, date, text) VALUES (200, 'uuid-b', '2020-01-01', 'Date 2020, Card 20, Ruling 200');
INSERT INTO rulings (id, uuid, date, text) VALUES (300, 'uuid-a', '2020-01-01', 'Date 2020, Card 10, Ruling 300');
-- Same date ('2020-01-01'), same T1.id (10), different T2.id (300 vs 250) to test tertiary sort (T2.id ASC)
INSERT INTO rulings (id, uuid, date, text) VALUES (250, 'uuid-a', '2020-01-01', 'Date 2020, Card 10, Ruling 250');
-- Trap for mutant joining on T1.id = T2.id
INSERT INTO cards (id, uuid, artist, text) VALUES (500, 'uuid-trap', 'Other Artist', 'Trap Card');
INSERT INTO rulings (id, uuid, date, text) VALUES (10, 'uuid-trap', '2025-01-01', 'Trap Ruling matching Card 10 id');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.text FROM cards AS T1 INNER JOIN rulings AS T2 ON T2.uuid = T1.uuid WHERE T1.artist = 'Kev Walker' ORDER BY T2.date DESC, T1.id NULLS LAST, T2.id NULLS LAST;

/*
Gold Result:
('Date 2021',)
('Date 2020, Card 10, Ruling 250',)
('Date 2020, Card 10, Ruling 300',)
('Date 2020, Card 20, Ruling 200',)
('Date 2019',)
*/

-- Prediction Query
SELECT rulings.text FROM rulings INNER JOIN cards ON rulings.uuid = cards.uuid WHERE cards.artist = 'Kev Walker' ORDER BY rulings.date DESC, rulings.id NULLS LAST, cards.id NULLS LAST;

/*
Prediction Result:
('Date 2021',)
('Date 2020, Card 20, Ruling 200',)
('Date 2020, Card 10, Ruling 250',)
('Date 2020, Card 10, Ruling 300',)
('Date 2019',)
*/