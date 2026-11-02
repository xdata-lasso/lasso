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
-- Tests basic positive match, WHERE clause predicate omissions (format, text, side), and COUNT(DISTINCT) vs COUNT(*)
INSERT INTO cards (id, uuid, side, name) VALUES (1, 'u1', NULL, 'Card 1');
INSERT INTO cards (id, uuid, side, name) VALUES (2, 'u2', 'a', 'Card 2');
INSERT INTO cards (id, uuid, side, name) VALUES (3, 'u3', NULL, 'Card 3');
INSERT INTO cards (id, uuid, side, name) VALUES (4, 'u4', NULL, 'Card 4');
-- u1: Matches all conditions, plus has duplicate matching rulings to test COUNT(T1.id) vs COUNT(DISTINCT T1.id)
INSERT INTO legalities (id, uuid, format, status) VALUES (10, 'u1', 'premodern', 'Legal');
INSERT INTO rulings (id, uuid, date, text) VALUES (100, 'u1', '2020-01-01', 'This is a triggered mana ability.');
INSERT INTO rulings (id, uuid, date, text) VALUES (101, 'u1', '2020-01-02', 'This is a triggered mana ability.');
-- u2: Fails T1.Side IS NULL (Side is 'a')
INSERT INTO legalities (id, uuid, format, status) VALUES (20, 'u2', 'premodern', 'Legal');
INSERT INTO rulings (id, uuid, date, text) VALUES (200, 'u2', '2020-01-01', 'This is a triggered mana ability.');
-- u3: Fails T2.format = 'premodern'
INSERT INTO legalities (id, uuid, format, status) VALUES (30, 'u3', 'modern', 'Legal');
INSERT INTO rulings (id, uuid, date, text) VALUES (300, 'u3', '2020-01-01', 'This is a triggered mana ability.');
-- u4: Fails T3.text = 'This is a triggered mana ability.'
INSERT INTO legalities (id, uuid, format, status) VALUES (40, 'u4', 'premodern', 'Legal');
INSERT INTO rulings (id, uuid, date, text) VALUES (400, 'u4', '2020-01-01', 'Some other ruling text.');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.id) FROM cards AS T1 INNER JOIN legalities AS T2 ON T1.uuid = T2.uuid INNER JOIN rulings AS T3 ON T1.uuid = T3.uuid WHERE T2.format = 'premodern' AND T3.text = 'This is a triggered mana ability.' AND T1.Side IS NULL;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT cards.uuid) AS card_count FROM cards INNER JOIN legalities ON cards.uuid = legalities.uuid INNER JOIN rulings ON cards.uuid = rulings.uuid WHERE legalities.format = 'premodern' AND rulings.text = 'This is a triggered mana ability.' AND cards.side IS NULL;

/*
Prediction Result:
(1,)
*/