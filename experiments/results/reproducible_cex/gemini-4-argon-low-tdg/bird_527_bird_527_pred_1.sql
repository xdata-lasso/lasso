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
-- Tests ORDER BY T2.date DESC, T1.id ASC, T2.id ASC tie-breaking and anti-correlation between date and IDs
INSERT INTO cards (id, artist, text, uuid) VALUES (10, 'Kev Walker', 'Card 10', 'uuid-10');
INSERT INTO cards (id, artist, text, uuid) VALUES (20, 'Kev Walker', 'Card 20', 'uuid-20');
INSERT INTO cards (id, artist, text, uuid) VALUES (30, 'Kev Walker', 'Card 30', 'uuid-30');
-- Different dates (tests T2.date DESC vs ASC, and ensures date order differs from ID order)
INSERT INTO rulings (id, date, text, uuid) VALUES (5, '2018-05-01', 'Oldest ruling, highest card id', 'uuid-30');
INSERT INTO rulings (id, date, text, uuid) VALUES (1, '2022-10-15', 'Newest ruling, middle card id', 'uuid-20');
-- Same date, different T1.id (tests secondary sort T1.id ASC vs DESC)
INSERT INTO rulings (id, date, text, uuid) VALUES (3, '2020-06-15', 'Tie date, card 20', 'uuid-20');
INSERT INTO rulings (id, date, text, uuid) VALUES (4, '2020-06-15', 'Tie date, card 10', 'uuid-10');
-- Same date, same T1.id, different T2.id (tests tertiary sort T2.id ASC vs DESC)
INSERT INTO rulings (id, date, text, uuid) VALUES (2, '2020-06-15', 'Tie date, card 10, earlier ruling id', 'uuid-10');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.text FROM cards AS T1 INNER JOIN rulings AS T2 ON T2.uuid = T1.uuid WHERE T1.artist = 'Kev Walker' ORDER BY T2.date DESC, T1.id NULLS LAST, T2.id NULLS LAST;

/*
Gold Result:
('Newest ruling, middle card id',)
('Tie date, card 10, earlier ruling id',)
('Tie date, card 10',)
('Tie date, card 20',)
('Oldest ruling, highest card id',)
*/

-- Prediction Query
SELECT T1.text FROM rulings AS T1 INNER JOIN cards AS T2 ON T1.uuid = T2.uuid WHERE T2.artist = 'Kev Walker' ORDER BY T1.date DESC, T1.id NULLS LAST, T2.id NULLS LAST;

/*
Prediction Result:
('Newest ruling, middle card id',)
('Tie date, card 10, earlier ruling id',)
('Tie date, card 20',)
('Tie date, card 10',)
('Oldest ruling, highest card id',)
*/