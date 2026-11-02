-- Schema DDL
CREATE TABLE "cards" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, artist TEXT, asciiName TEXT, availability TEXT, borderColor TEXT, cardKingdomFoilId TEXT, cardKingdomId TEXT, colorIdentity TEXT, colorIndicator TEXT, colors TEXT, convertedManaCost REAL, duelDeck TEXT, edhrecRank INTEGER, faceConvertedManaCost REAL, faceName TEXT, flavorName TEXT, flavorText TEXT, frameEffects TEXT, frameVersion TEXT, hand TEXT, hasAlternativeDeckLimit INTEGER DEFAULT 0 NOT NULL, hasContentWarning INTEGER DEFAULT 0 NOT NULL, hasFoil INTEGER DEFAULT 0 NOT NULL, hasNonFoil INTEGER DEFAULT 0 NOT NULL, isAlternative INTEGER DEFAULT 0 NOT NULL, isFullArt INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isOversized INTEGER DEFAULT 0 NOT NULL, isPromo INTEGER DEFAULT 0 NOT NULL, isReprint INTEGER DEFAULT 0 NOT NULL, isReserved INTEGER DEFAULT 0 NOT NULL, isStarter INTEGER DEFAULT 0 NOT NULL, isStorySpotlight INTEGER DEFAULT 0 NOT NULL, isTextless INTEGER DEFAULT 0 NOT NULL, isTimeshifted INTEGER DEFAULT 0 NOT NULL, keywords TEXT, layout TEXT, leadershipSkills TEXT, life TEXT, loyalty TEXT, manaCost TEXT, mcmId TEXT, mcmMetaId TEXT, mtgArenaId TEXT, mtgjsonV4Id TEXT, mtgoFoilId TEXT, mtgoId TEXT, multiverseId TEXT, name TEXT, number TEXT, originalReleaseDate TEXT, originalText TEXT, originalType TEXT, otherFaceIds TEXT, power TEXT, printings TEXT, promoTypes TEXT, purchaseUrls TEXT, rarity TEXT, scryfallId TEXT, scryfallIllustrationId TEXT, scryfallOracleId TEXT, setCode TEXT, side TEXT, subtypes TEXT, supertypes TEXT, tcgplayerProductId TEXT, text TEXT, toughness TEXT, type TEXT, types TEXT, uuid TEXT NOT NULL UNIQUE, variations TEXT, watermark TEXT);

CREATE TABLE "foreign_data" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, flavorText TEXT, language TEXT, multiverseid INTEGER, name TEXT, text TEXT, type TEXT, uuid TEXT REFERENCES cards (uuid));

CREATE TABLE "legalities" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, format TEXT, status TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

CREATE TABLE "sets" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, baseSetSize INTEGER, block TEXT, booster TEXT, code TEXT NOT NULL UNIQUE, isFoilOnly INTEGER DEFAULT 0 NOT NULL, isForeignOnly INTEGER DEFAULT 0 NOT NULL, isNonFoilOnly INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isPartialPreview INTEGER DEFAULT 0 NOT NULL, keyruneCode TEXT, mcmId INTEGER, mcmIdExtras INTEGER, mcmName TEXT, mtgoCode TEXT, name TEXT, parentCode TEXT, releaseDate DATE, tcgplayerGroupId INTEGER, totalSetSize INTEGER, type TEXT);

CREATE TABLE "set_translations" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, language TEXT, setCode TEXT REFERENCES sets (code) ON update CASCADE ON delete CASCADE, translation TEXT);

CREATE TABLE "rulings" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, date DATE, text TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: cards --
INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (-2147483648, '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs', 'rwbbp6luhvd', 'tti', 'bnp', 787.938887, 'dpos', -1576219117, 75.403642, 'nw6klf', 'a9000t5c4eci', 'gce376nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', '2eutliqa11r', 2137741668, -525979501, 1898504886, 624571013, 1644911394, -1666765085, 1178636309, -1390245819, 1055976837, 1775126557, -74849714, 105869088, -2081315180, 1909986641, 1485335077, 'yrq13pyu78d9', 'rljsl0b4y', 'p5qi2rkf9v', 'x58pz', 'f8jegd2', 'vy9uxj4', 'wb', 'v', 'ph2', 'nd', 'wnqcx', '5hncprjtu0d', '79fjgq8', 'n2f3dqv0gcb9', 'ozk3zbily', 'kn6vc', '6ah', 'f8jswwl', '7xb72', 'xa', '7ryfdrz16n', 'jja', '5dh', 'ogrgjd8y', 't1afgog', 'itsj3', 'y', 'p1q430', 'jh3den8', 't1__fc9683', 't1__d9aefb', 'c68x8vacx7', 'f', '5w1of7', 'pzo72ctdc', 'mfg62', 't1__6b9eb5', '0v', 'q8qdjpe1');

INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (3, 'f', 'foa', 'cd07z2zezjo7', 'wgxd5ysxcm', '0oztd', 'j5', '3lq', '5lnpim5k58qs', '7p2r94gt', 796.553419, '2mnajjla3o', -1428186898, 543.846419, 'uttmu2ne578', 'fvy', '7zzbe8y', 'kv42q7', 'x58b4', 'pmaus3auvmkr', 609771851, -1934017803, 1105964624, -663234145, -2013213247, 101754718, 628082526, -1245584612, 1731843275, -582376271, -1165594842, -634585028, 1719800120, -210159774, 270415200, 'b', 'q0k32od', 'cl5ams', 'orlwyngc1dj', '9erhizgk1yoe', 'o6l0hdt', 'fuqyxuzkb', '521gwnlas6e', 'lboeowii1z5', 'xih6', '2q2xlyoto', '9oaawg', '6aqb0tbin', 'z', '9tajz9td', 'n5wcgumbc', '3tdu6bd0w960', 'vzxw1rxe', '9yfk7qk162n', '55', '3dohvu0', 'dza35rmki', '18ri', 'hy08ftp6', 'wt', 'xxnja', 'bymzn2mfx7h3', 'p6sto1cj', 'sh5knzys7', 't1__fc9683', 't1__d9aefb', 'y', 'yd1jmgjach8', 'qta8y3a17v4y', 'ma', 'q3qdpua', 'C', '96rn', 'dqrhm');

INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (-2147483646, 'iztv', '6', '4iz7', 'aqqlud8ft', '8', '9114q', 'r', '6b', 'jeuuwsj8kj', 114.099596, 'wpxlvris', 2042428747, 852.317741, 'z0kaq', 'ncgc8', '3b7v8', 'kwdmdbdht', 'j47nxar50', 'sj', -1652411404, -553121210, 1720208360, -1243923337, 1231129324, -1782325492, -544173163, -958321297, 2015039199, -641927001, 558684943, -120625031, 572453185, 1348973408, -911953404, '97', 'aqz2o20pj6d', 'dlysu6iphd', 'u2g', 'r31', 'wq51oa', 'sb3uoi1p', 'avcvwnyqroui', 'lrpou', 't63', 'xyfvmjwpp26', 'b3aj', '0ju0h3r133ir', 'axyyhpl', 'i9esap8p', 'gckqwtsr54', '6qje', 'ktb1d2nzg3rj', 'wns', '47j2ja8dccy3', 'vjwq49yrnx', '6dvdx', 'o', 'v7t3gvpl', '9fj', 'uun7k1', 'z2my1og', 'v1rgeza', 'xc1clupgly', 't1__fc9683', 't1__d9aefb', '8oitxeilp', 'e019cy7od0', '3dlhdsvn', 'ed', '9lqv26u3', 'A', '1spxpw30', 'g');

INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (-2147483645, 'kxginl', '6id', 'p61l', 'o3ak162o', 'cagjeevxzxlu', '49kuboe8cd', '4u', 'kh', 'llbwvdpu5v0e', 52.807863, 'y9v2z12983', 1870044139, 363.048023, 'epac', 'db2f0c', '96xiyet8', 'jhcf46', 'f', 'perxa61sjv', -1265768652, 2081562124, -1879135081, -958249959, -1446721688, -1963148607, -1652058172, 1509710997, 652687353, 848275284, 736542812, -1977676789, 1434462631, 1621309369, -1745755546, 'r1es', 'sf9', '82qg0', 'huij7f8', 'qhi', 'u5gm8gxb5qj', 'saw', 'p4kwi', 'hl7j43y7', '5ybv83kr3', 'w4jn2z19xgj', 'jacgmukfb5', 'f41', '80terbfokvee', 'sltut6lu2', 'cel8mhfcim', 'n5enii0fmbgz', 'oqxs27xh', '88y1k253s', '5', 'ls1ehn1md', 'aqqhyyzsnp64', 'mn', 'w4m0', 'rwbjk', 'bph6gdw', '7', 'jjplwtlzh42n', 'j5yrji5', 'qkna', '38gfxswb2d0', 'mxwdb7o', 'p5qo1', '4c6', 'gwnkd4kc3ii', 'axz', 'Q', '90nhs', '9gob');

INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (-2147483644, 'r', 'fs3qn0b', 'm2rlxcrw', 'x0', '3rzgz84lqm', '2w', 'b1b3vun66e0i', 'olt0', '0zi90o50q', 537.92848, 'g865zm6d', 1939546744, 718.930875, 'w0', '2p40u2vil', '1xsad6q5', 'iqoauy0', '3lwh994f', 'qc1m9gr8xj', 1072042049, 1690134584, -551513589, -81327703, -1531362377, -1580370971, 1338378083, 945802166, 47431001, -698277997, 748510826, 990008540, -2083332040, -1732139002, 104130853, 'y3', 'k', 'i', 'txfb', 'l10qx6j6d4fc', '5m4s2ajdu', '6xuj90te', 'x3', '5u7709', 'qf9lx8qzabi', 'uumwu7', 'l', '0jw', '6hh', 'oe79350f', 'zrv1ll930xvk', 'viql6n0rlp', 'saxeeinmbc', 'v5o', 'sme', 'v3r3u', 'doxa0o', 'l1zmjrssbh', '2404qpp33', '3a1ngqu', '8184d', 'ojdlhl', 'pdyxk0a', 'cql1c8c', 'wvadbp0760', 'gk2hjz', 'pg1lcg', 'a4gkjog8d', 'w16f5tqhjd', 'mabmkr2t', 'dlb6i42', '_', 'tew5c29d', 't1havc');

INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (-2147483643, 'p9qgjradfhj', '8zr6k53p8e5o', 'f0y', '1u', 'r8kzi0g50j5', '7fznqcuex', '1faxc1je', '48u5lvdb', '3ceh', 390.136935, '3oylciif0l', 1346552102, 241.483027, 'eoh3m3q0pq97', '534', '5xb', '11y', 'pzc7x', 'v4pmp', -1502776895, -2011163283, -656237101, -1721897132, -898823195, -1406885347, 2043776789, -623382493, 2055961123, -2077724886, -1188970734, 776771076, 1853786940, -679517978, 1213984698, 'dx5hn', '5b733o58z', 'g', 'xt0twou', '4', 'yi4h5c4f1q', '9w43ial8s8', 'sp4j9fod', 't9kcq2iae6', 'j', 'ql1676lk8', 'azkjy', 'fxsove98b8', '0235v8ik', '3qu7', 'cxswgr124', 'u6v8hk', 'lzy93zu8yb', '4qpog5smdhct', 'nj8y6whwhl', '5i', 'dtdjm8r', 'y9lhw6lv7j45', 'k1qzqt5u', '42p20g', 'tfhk1l', 'bjksuye6', 'hvzboodlz60', 'sijufc2vfgh', 't1__fc9683', 't1__d9aefb', 'xbu', 'xi', 'lq2is', 'q', '4u2fkzbw', 't2__6e46bd', '3q5br3', 'qobvbj26k');

-- Inserting into table: foreign_data --
INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483648, 'o22', 'German', 2004147439, 'tjpttg', 'bnou5zi36', '4', 't1__6b9eb5');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483647, 'wlic7dn2', 'German', 1409697108, 'p490xdmsqt', 'el', 'u', 't1__6b9eb5');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483646, 'qb9i9f2ccu', 'German', -1414362698, '1quik', 'yhb08hl', 't1pqo', 't1__6b9eb5');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483645, '6', 'German', -976193147, 'ujphybna', 'y', 'hvyx8s', 'Q');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483644, 'c4zpw867', 'German', 1821429906, 've0jf4i5t99k', 'nbhvi6', 'p3tfn', '_');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483643, 'dtw89qy6sru4', 'German', -1877887746, 'io', '8o', '6b', 'Q');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (2, 'xc56', 'German', -693134353, 'h2flntl', 'o', 'qtl1u', 't2__6e46bd');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (3, 'dbvf', 'German', -534387926, 'l431gfeg6', '6gifj', 'vxt41', 't2__6e46bd');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483640, 'jf1qj3s', 't2__7a6bb3', -1119890665, 'l6rurl72', '8ippx', '6', 't1__6b9eb5');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483639, '59q4tkf5j4c', 'German', 2132312264, 'y485ys1g', '7p3hvg0', 'ytzip2', 't1__6b9eb5');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483638, 'a6d2hqs4zc1', 'German', -254442524, '2rnfvkrmf', 'qpzu', 'n', 't1__6b9eb5');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (4, 'n53i98owqwx0', 'hvv0oh59iv', 1826148003, 'ipn6drokt1', '6hqb9jae9ps4', 'o', 't1__6b9eb5');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (5, 'e0b6', 'piqkuizi6230', 186866531, 'pqdbwew42z', '4pt', '8u', 't1__6b9eb5');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (6, 'l0lw90t2kl', 'apcw1gn', 2032090551, 'r9d3zdayv', 'uhorvccw', 'raqxeddnko4', 't1__6b9eb5');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (7, 'dq70691b7', 's1i0k8thqz3', 1277292188, '94x3y', 'xg3ufge', 'rz', 't1__6b9eb5');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (8, 'w0qgiqh4ao3k', '9v09407sw', -158691005, '49kf5l6rnd3r', 'bn', 'bp96', 't1__6b9eb5');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (9, 'v5122bvxjnuw', '4jm31nfs4', -1152645284, 'u85br297', 'kpjnnbs', 'y75w5', 't1__6b9eb5');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (10, 'nagrj6o317ka', 'tw7', -1017874103, 'j9f945', 'cwnr8dq', '5gbzjmeuvjv', 't1__6b9eb5');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (11, 'cr9l03f515y', '8am0qjut2f31', -317767232, 'vk4s7w', 'gg', '0zchdq8o', 't1__6b9eb5');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (12, 'xze42', 'wen', -1233317434, 'lc3', 'spw', 'gvoc9l5zm', 't1__6b9eb5');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (13, 'sv641', '6b', 1820491976, 'ugt8ygqofzr1', 'v7z6i', 'r1w', 't1__6b9eb5');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.subtypes, T1.supertypes FROM cards AS T1 INNER JOIN foreign_data AS T2 ON T1.uuid = T2.uuid WHERE T2.language = 'German' AND NOT T1.subtypes IS NULL AND NOT T1.supertypes IS NULL;

/*
Gold Result:
('t1__fc9683', 't1__d9aefb')
('t1__fc9683', 't1__d9aefb')
('t1__fc9683', 't1__d9aefb')
('qkna', '38gfxswb2d0')
('wvadbp0760', 'gk2hjz')
('qkna', '38gfxswb2d0')
('t1__fc9683', 't1__d9aefb')
('t1__fc9683', 't1__d9aefb')
('t1__fc9683', 't1__d9aefb')
('t1__fc9683', 't1__d9aefb')
*/

-- Prediction Query
SELECT DISTINCT cards.subtypes, cards.supertypes FROM cards INNER JOIN foreign_data ON cards.uuid = foreign_data.uuid WHERE foreign_data.language = 'German' AND NOT cards.subtypes IS NULL AND NOT cards.supertypes IS NULL;

/*
Prediction Result:
('t1__fc9683', 't1__d9aefb')
('qkna', '38gfxswb2d0')
('wvadbp0760', 'gk2hjz')
*/