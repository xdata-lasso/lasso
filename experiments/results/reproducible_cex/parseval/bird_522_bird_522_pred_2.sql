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
INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (-2147483648, '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs', 'rwbbp6luhvd', 'tti', 'bnp', 787.938887, 'dpos', 1, 133.007885, '5u', 'w6kl', 'a9', '00t5c4e', 'cigce376nium', '52zbuo4nrq', 418417917, -1031969798, -1106983592, 1884179925, 902551284, 2107872094, 882961052, 743312762, -1822992503, -868774469, -1068298341, -314162272, 2137741668, -525979501, 1898504886, 'o3o9hl72klex', '4ji7zwa', '2dwyrq', '3pyu78d', '9rljsl0b4', 'p5qi2rk', '9v', 'x58pz', 'f8jegd2', 'vy9uxj4', 'wb', 'v', 'ph2', 't1__9dcfcd', 'nd', 'wnqcx', '5hncprjtu0d', '79fjgq8', 'n2f3dqv0gcb9', 'ozk3zbily', 'kn6vc', '6ah', 'f8jswwl', '7xb72', 'xa', '7ryfdrz16n', 'jja', '5dh', 'ogrgjd8y', 't1afgog', 'itsj3', 'y', 'p1q430', 'jh3den8', 'c68x8vacx7', 'f', 't1__036a48', '5w1of7', 'pzo72ctdc');

INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (-2147483647, 'mfg62', '0v', 'q8qdjpe1', 'o22', '8507cvtjp', 'ttg6bnou5zi3', 'c4bfkfoac', '0', '7z2zezjo7wg', 790.772456, '5', 1, 377.388457, 'cmr0oz', 'dgj5i', 'lq5lnpim', 'k58qs27p', 'r94gth2m', 'ajjl', -2096405521, 1803796945, 872694102, 618058035, 1553368934, -1252009958, 1908593332, 697257217, -451030047, -2052653308, -489120589, -72442907, -2060082151, -1122409769, 1849819405, 'us3auvmkrpdj', 'wzw5chn9mo70', 'a9n0jxfo', 'ws', 'do2zobb', 'q0k32od', 'cl5ams', 'orlwyngc1dj', '9erhizgk1yoe', 'o6l0hdt', 'fuqyxuzkb', '521gwnlas6e', 'lboeowii1z5', 't1__9dcfcd', 'xih6', '2q2xlyoto', '9oaawg', '6aqb0tbin', 'z', '9tajz9td', 'n5wcgumbc', '3tdu6bd0w960', 'vzxw1rxe', '9yfk7qk162n', '55', '3dohvu0', 'dza35rmki', '18ri', 'hy08ftp6', 'wt', 'xxnja', 'bymzn2mfx7h3', 'p6sto1cj', 'sh5knzys7', 'y', 'yd1jmgjach8', 't1__3f03a4', 'qta8y3a17v4y', 'ma');

INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (-2147483646, 'q3qdpua', '96rn', 'dqrhm', 'wlic7dn2', 'p490', 'dmsqtg', 'lc', 'qb9i9f', 'ccukjq1q', 763.851917, 'ik1yhb', 1, 414.619293, 'ls', 't1pqomiztvb6', '4iz7', 'aqqlud8ft', '8', '9114q', -2063751689, 36589303, -1537647691, 364280973, 1592061050, -1451520332, -55270062, -1101814296, 1939337883, -996196097, 986268139, 2042428747, 1228655416, -388527046, -1040951738, 'ncgc8s3b7v', '88kwdmdbdht6', 'j47nxar50h', 'sjhanzxdpu', 'mwfw', 'qrlawk', '14r5dqt', 'mg97a', 'z2o20', 'pj6ddlysu6ip', 'dk', 'u2gir31vwq5', 'oa2sb3u', 't1__9dcfcd', 'i1pa', 'cvwnyq', 'ouirl', 'rpouit63xyf', 'mjwpp2', 'mb3aj0ju0', '3r', '133ir1axyy', 'hpl2i9esap', 'pgckqwtsr', '54o6qjektb1', '2', 'zg3r', 'jkwns47j2j', '8', 'c', 'y', 'vjwq49yr', 'nxs6dvdxdo2v', '7t3gvplj9f', 'vuu', '7k10', 't1__654bfa', 'z2my1ogyv1r', 'ez');

INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (-2147483645, 'x', '1', 'l', 'upgly78oit', 'xeilpe019cy', 'od033dlhd', 'vnhed', '9lqv26u3', '1spxpw30', 22.436232, 'kxginl', 1, 767.869106, '6id', 'p61l', 'o3ak162o', 'cagjeevxzxlu', '49kuboe8cd', '4u', 426006253, 1097428449, -712974538, 1201135348, -681356377, -1846517698, 2117356203, 824044840, -214587907, -54963162, 1084895939, 765955451, 1372042958, 1147974039, -220327705, 'c296xiy', 'et8xjhcf46c', 'pe', 'rxa61sjv8nv', 'ddrokuez', 'ctehia3cmvb', '7vpc0xffwo', '1esks', '9q', '2qg01huij', '7f8kqhiu5g', '8gxb', 'qjlsawsp', 't1__9dcfcd', 'kwi3hl7j', '3y795ybv', '3kr3w4jn2', '19xgjja', 'cgmukfb5if4', '80terbf', 'kvee', 'sltut6lu2', 'cel8mhfcim', 'n5enii0fmbgz', 'oqxs27xh', '88y1k253s', '5', 'ls1ehn1md', 'aqqhyyzsnp64', 'mn', 'w4m0', 'rwbjk', 'bph6gdw', '7', 'jjplwtlzh42n', 'j5yrji5', '_', 'qkna', '38gfxswb2d0');

INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (-2147483644, 'mxwdb7o', 'p5qo1', '4c6', 'gwnkd4kc3ii', 'axz', '90nhs', '9gob', '6', 'rn5u', 913.067252, 'hybn', 1, 846.321829, 'y', 'hvyx8s', 'r', 'fs3qn0b', 'm2rlxcrw', 'x0', 1950697910, -964661721, 1269188010, 1901522221, -1292966884, 1800088659, -322010175, 1154760301, -367478888, 499998313, 1915216858, 1270732094, 354693690, 399119867, 207340898, '50q8', '3g865zm6', 'p', 'ewew092p40', '2vil21', 'sad6q5', 'iqoauy0', '3lwh994f', 'qc1m9gr8xj', 'qbloxd4sj5il', 'wnd6dvygw', 'akmwgw73fy3d', 'dip', 't1__9dcfcd', 'txfbl10qx6j', 'd4fc75m4s', 'ajdu26xu', 'j90tefx3u5u', '709qf9lx8', 'qzabivuumwu', 'alj0jwk6h', '2o', '79', '50fzrv1l', '930', 'vkviql', 'n0rlpsaxe', 'in', 'bciv', 'ojsmeqv3', '3uxdo', 'a0ol1z', 'mjrssbh72404', 'pp330', 'a1ngqut8', '184dwojdlhlz', 'Q', 'dyxk', '0a0cql1c8c');

INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (-2147483643, 'wvadbp0760', 'gk2hjz', 'pg1lcg', 'a4gkjog8d', 'w16f5tqhjd', 'mabmkr2t', 'dlb6i42', 'tew5c29d', 't1havc', 792.049687, '4', 1, 400.092976, '8672fv', 'e0jf4i5t99kv', 'bhvi', 'tp3tfndtw', '9qy6sru4e', 'fiof8o', 1796323549, -1022360195, -1517836823, -2124619836, -1746125330, 765163181, 24627578, 2033421216, 794301748, 376872332, -23658516, -1799118529, 1246886254, -327742602, -1457401052, '0g5', '0j597fznqc', 'ex41fa', 'c1je44', 'u5lvdbp3c', 'hy', '3o', 'lciif0l', '46upleo', 'h3m3q0pq97j', '534j5xbk11y', 'pzc7x', 'v4pmp', 't1__9dcfcd', 'jve', '2', 'rn6j7', '2vkwegrf6snl', '5jw5pbgw', 'ojnhh6va3tdx', 'hn75b733', '58zb', 'yx', '0twou', '4', 'yi4h5c4f1q', '9w43ial8s8', 'sp4j9fod', 't9kcq2iae6', 'j', 'ql1676lk8', 'azkjy', 'fxsove98b8', '0235v8ik', '3qu7', 'cxswgr124', 'O', 'u6v8hk', 'lzy93zu8yb');

INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (-2147483642, '4qpog5smdhct', 'nj8y6whwhl', '5i', 'dtdjm8r', 'y9lhw6lv7j45', 'k1qzqt5u', '42p20g', 'tfhk1l', 'bjksuye6', 782.115898, 'hvzboodlz60', -1609119007, 326.013138, 'c2', 'fghixb', 'gxislq', 'isdq44u2', 'kz', 'w', 1422871709, -1023537273, -2051635326, 1823535648, 1006743508, -674972001, 589902891, -580079713, -693134353, 1729319706, 1094417174, -1269361504, -1174111678, -1042280380, -1374868354, 'uodbvf3ya6l4', '1gfeg6q6', 'if', 'tvx', '41zjf', '1qj3se4dpb4l', '6rurl72q8ip', 'pxb659q4tkf5', '4ce', 'y485ys1g', '7p3hvg0', 'ytzip2', 'a6d2hqs4zc1', '2282rnfvk', 'mfoqp', 'ucnn53i', '8owqwx0hv', 'v0oh59ivnipn', 'drokt16hq', '9', 'jae9ps4don', 'e0b6piqkuizi', '2308npqdb', 'wew42zl4ptf8', 'l0lw90', '2klya', 'cw1g', 'o6r9', '3', 'dayv5uh', 'rvcc', 'wraqxeddnko4', 'dq70691b7', 's1i0k8thqz3', 's94x3', 'yxg3ufg', 'A', 'efrzw0qgiqh4', 'o');

INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (-2147483641, 'k79v0940', '7swb3349kf', '5l6rnd3rhb', 'nmbp96v512', 'bvxjnuw8', '4jm31nfs4ni', 'om2u85br29', '1kpjnnbss', '75w5nag', 706.271025, 'j6o317kajtw7', 1, 295.910924, 'iuj9f', '945ycwnr8d', '5gbzj', 'euvj', 'cr9l03', 'f515y8am0q', 1092973308, -797802265, -208707815, -173789692, -317767232, -742079274, -1438216227, 70240108, -1716157367, 1906070650, 566755160, 1911765704, 134367627, 329158882, -1833915455, '2lwenn4ilc3k', 'spw6gvoc9l', 'zmrsv641', '6b', 'ugt8ygq', 'fzr1', 'v7z6i', 'r1w', 'x1', 'l', 'bbk27zz', 'uuwyewbihg8', '1ev3gqe', 't1__9dcfcd', 'nehcnt2v', 'lraxg0gt', 'ot6vp1', 'lrhqsxyube', 'yhmlrnycz8d5', 'kabtcpo', '1ke8euy0kcx', '8e4', 'bkfphyyxnm', 'cmn8usy', 'c1vk27ki', 'uvof5ndg', '80z', 'qe9rs1z82tw', '4o1sqir', 'hj1', 'xi', 'o9km29vphx5v', '7jo', 'y', '1skvh4q', 'y4gp', 't2__952084', '0kr5bk0d0gkg', 'qavutce54k');

-- Inserting into table: legalities --
INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (-2147483648, 't2__c6cef2', 'Banned', 't1__036a48');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (-2147483647, 't2__c6cef2', 'Banned', 't1__036a48');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (-2147483646, 't2__c6cef2', 'Banned', 't1__036a48');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (2, 't2__c6cef2', 'Banned', 't1__036a48');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (3, 't2__c6cef2', 'Banned', 't1__036a48');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (-2147483645, 't2__c6cef2', 'Banned', 't1__036a48');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (-2147483642, 't2__c6cef2', 'Banned', 'A');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (-2147483641, 't2__c6cef2', 'Banned', 'A');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (-2147483640, 't2__c6cef2', 'Banned', 'A');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (-2147483639, 't2__c6cef2', 'Banned', 'A');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (-2147483638, 't2__c6cef2', 'Banned', 'A');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (-2147483637, 't2__c6cef2', 'Banned', 'A');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (-2147483636, 't2__c6cef2', 'Banned', 'A');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (-2147483635, 't2__c6cef2', 'Banned', 'A');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (-2147483634, 't2__c6cef2', 'Banned', 'A');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (-2147483633, 't2__c6cef2', 'Banned', 'A');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (-2147483632, 't2__c6cef2', 'Banned', 'A');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (-2147483631, 't2__c6cef2', 'Banned', 'A');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (-2147483630, 't2__c6cef2', 'Banned', 't2__952084');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (-2147483629, 't2__c6cef2', 'Banned', 't2__952084');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (-2147483628, 't2__c6cef2', 'Banned', 't2__952084');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (-2147483627, 't2__c6cef2', 'Banned', 't2__952084');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (-2147483626, 't2__c6cef2', 'Banned', 't1__036a48');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (-2147483625, 't2__c6cef2', 'Banned', 't1__036a48');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (-2147483624, 't2__c6cef2', 'Banned', 't1__036a48');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (-2147483623, 't2__c6cef2', 't2__be577a', 't1__036a48');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (-2147483622, 't2__c6cef2', 't2__207320', 't1__036a48');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (-2147483621, 't2__c6cef2', 't2__904c34', 't1__036a48');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (-2147483620, 't2__c6cef2', 'Banned', 't1__036a48');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (-2147483619, 't2__c6cef2', 'Banned', 't1__036a48');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (-2147483618, 't2__c6cef2', 'Banned', 't1__036a48');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (-2147483617, 't2__c6cef2', 'Banned', 't1__036a48');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (-2147483616, 't2__c6cef2', 'Banned', 't1__036a48');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (-2147483615, 't2__c6cef2', 'Banned', 't1__036a48');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (-2147483614, NULL, 'Banned', 't1__036a48');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (-2147483613, NULL, 'Banned', 't1__036a48');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (-2147483612, NULL, 'Banned', 't1__036a48');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (-2147483611, 't2__c6cef2', 'Banned', 't1__036a48');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (-2147483610, 't2__c6cef2', 'Banned', 't1__036a48');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (-2147483609, 't2__c6cef2', 'Banned', 't1__036a48');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.name, T2.format FROM cards AS T1 INNER JOIN legalities AS T2 ON T2.uuid = T1.uuid WHERE T1.edhrecRank = 1 AND T2.status = 'Banned' GROUP BY T1.name, T2.format;

/*
Gold Result:
('t1__9dcfcd', None)
('t1__9dcfcd', 't2__c6cef2')
*/

-- Prediction Query
SELECT T1.name, T2.format FROM cards AS T1 INNER JOIN legalities AS T2 ON T1.uuid = T2.uuid WHERE T1.edhrecRank = 1 AND T2.status = 'Banned';

/*
Prediction Result:
('t1__9dcfcd', 't2__c6cef2')
('t1__9dcfcd', 't2__c6cef2')
('t1__9dcfcd', 't2__c6cef2')
('t1__9dcfcd', 't2__c6cef2')
('t1__9dcfcd', 't2__c6cef2')
('t1__9dcfcd', 't2__c6cef2')
('t1__9dcfcd', 't2__c6cef2')
('t1__9dcfcd', 't2__c6cef2')
('t1__9dcfcd', 't2__c6cef2')
('t1__9dcfcd', 't2__c6cef2')
('t1__9dcfcd', 't2__c6cef2')
('t1__9dcfcd', 't2__c6cef2')
('t1__9dcfcd', 't2__c6cef2')
('t1__9dcfcd', 't2__c6cef2')
('t1__9dcfcd', 't2__c6cef2')
('t1__9dcfcd', 't2__c6cef2')
('t1__9dcfcd', 't2__c6cef2')
('t1__9dcfcd', None)
('t1__9dcfcd', None)
('t1__9dcfcd', None)
('t1__9dcfcd', 't2__c6cef2')
('t1__9dcfcd', 't2__c6cef2')
('t1__9dcfcd', 't2__c6cef2')
('t1__9dcfcd', 't2__c6cef2')
('t1__9dcfcd', 't2__c6cef2')
*/