-- Schema DDL
CREATE TABLE badges (Id INTEGER NOT NULL PRIMARY KEY, UserId INTEGER NULL, Name TEXT NULL, Date DATETIME NULL, FOREIGN KEY (UserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE comments (Id INTEGER NOT NULL PRIMARY KEY, PostId INTEGER NULL, Score INTEGER NULL, Text TEXT NULL, CreationDate DATETIME NULL, UserId INTEGER NULL, UserDisplayName TEXT NULL, FOREIGN KEY (PostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (UserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE postHistory (Id INTEGER NOT NULL UNIQUE PRIMARY KEY, PostHistoryTypeId INTEGER NULL, PostId INTEGER NULL, RevisionGUID TEXT NULL, CreationDate DATETIME NULL, UserId INTEGER NULL, Text TEXT NULL, Comment TEXT NULL, UserDisplayName TEXT NULL, FOREIGN KEY (PostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (UserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE postLinks (Id INTEGER NOT NULL PRIMARY KEY, CreationDate DATETIME NULL, PostId INTEGER NULL, RelatedPostId INTEGER NULL, LinkTypeId INTEGER NULL, FOREIGN KEY (PostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (RelatedPostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE posts (Id INTEGER NOT NULL UNIQUE PRIMARY KEY, PostTypeId INTEGER NULL, AcceptedAnswerId INTEGER NULL, CreaionDate DATETIME NULL, Score INTEGER NULL, ViewCount INTEGER NULL, Body TEXT NULL, OwnerUserId INTEGER NULL, LasActivityDate DATETIME NULL, Title TEXT NULL, Tags TEXT NULL, AnswerCount INTEGER NULL, CommentCount INTEGER NULL, FavoriteCount INTEGER NULL, LastEditorUserId INTEGER NULL, LastEditDate DATETIME NULL, CommunityOwnedDate DATETIME NULL, ParentId INTEGER NULL, ClosedDate DATETIME NULL, OwnerDisplayName TEXT NULL, LastEditorDisplayName TEXT NULL, FOREIGN KEY (LastEditorUserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (OwnerUserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE tags (Id INTEGER NOT NULL PRIMARY KEY, TagName TEXT NULL, Count INTEGER NULL, ExcerptPostId INTEGER NULL, WikiPostId INTEGER NULL, FOREIGN KEY (ExcerptPostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE users (Id INTEGER NOT NULL UNIQUE PRIMARY KEY, Reputation INTEGER NULL, CreationDate DATETIME NULL, DisplayName TEXT NULL, LastAccessDate DATETIME NULL, WebsiteUrl TEXT NULL, Location TEXT NULL, AboutMe TEXT NULL, Views INTEGER NULL, UpVotes INTEGER NULL, DownVotes INTEGER NULL, AccountId INTEGER NULL, Age INTEGER NULL, ProfileImageUrl TEXT NULL);

CREATE TABLE votes (Id INTEGER NOT NULL PRIMARY KEY, PostId INTEGER NULL, VoteTypeId INTEGER NULL, CreationDate DATE NULL, UserId INTEGER NULL, BountyAmount INTEGER NULL, FOREIGN KEY (PostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (UserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests Cartesian product of badges and comments per user vs COUNT(DISTINCT), and basic ORDER BY COUNT DESC vs ASC.
-- User 1 has 2 badges (same name) and 2 comments -> joined count = 4.
-- User 2 has 1 badge and 3 comments -> joined count = 3.
-- User 3 has 5 badges and 0 comments -> excluded by INNER JOIN.
INSERT INTO users (Id, DisplayName) VALUES (1, 'Alice');
INSERT INTO users (Id, DisplayName) VALUES (2, 'Bob');
INSERT INTO users (Id, DisplayName) VALUES (3, 'Charlie');
INSERT INTO badges (Id, UserId, Name) VALUES (1, 1, 'GoldBadge');
INSERT INTO badges (Id, UserId, Name) VALUES (2, 1, 'GoldBadge');
INSERT INTO badges (Id, UserId, Name) VALUES (3, 2, 'SilverBadge');
INSERT INTO badges (Id, UserId, Name) VALUES (4, 3, 'BronzeBadge');
INSERT INTO badges (Id, UserId, Name) VALUES (5, 3, 'BronzeBadge');
INSERT INTO badges (Id, UserId, Name) VALUES (6, 3, 'BronzeBadge');
INSERT INTO badges (Id, UserId, Name) VALUES (7, 3, 'BronzeBadge');
INSERT INTO badges (Id, UserId, Name) VALUES (8, 3, 'BronzeBadge');
INSERT INTO comments (Id, UserId, Text) VALUES (1, 1, 'Comment 1');
INSERT INTO comments (Id, UserId, Text) VALUES (2, 1, 'Comment 2');
INSERT INTO comments (Id, UserId, Text) VALUES (3, 2, 'Comment 3');
INSERT INTO comments (Id, UserId, Text) VALUES (4, 2, 'Comment 4');
INSERT INTO comments (Id, UserId, Text) VALUES (5, 2, 'Comment 5');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT Name FROM badges AS T1 INNER JOIN comments AS T2 ON T1.UserId = t2.UserId GROUP BY T2.UserId ORDER BY COUNT(T2.UserId) DESC, Name NULLS LAST LIMIT 1;

/*
Gold Result:
('GoldBadge',)
*/

-- Prediction Query
SELECT b.Name AS BadgeName FROM badges AS b WHERE b.UserId = (SELECT c.UserId FROM comments AS c GROUP BY c.UserId ORDER BY COUNT(c.Id) DESC, c.UserId NULLS LAST LIMIT 1);

/*
Prediction Result:
('SilverBadge',)
*/