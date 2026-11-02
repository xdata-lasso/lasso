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
-- Tests basic filtering on user CreationDate year ('2010' vs '2009', '2011'), ordering by FavoriteCount DESC, and inner join vs outer join (user without posts, post without owner).
INSERT INTO users (Id, CreationDate, DisplayName, Reputation, Views) VALUES (1, '2009-12-31 23:59:59', 'User2009', 1000, 500);
INSERT INTO users (Id, CreationDate, DisplayName, Reputation, Views) VALUES (2, '2010-01-01 00:00:00', 'User2010_LowFav', 500, 200);
INSERT INTO users (Id, CreationDate, DisplayName, Reputation, Views) VALUES (3, '2010-06-15 12:30:00', 'User2010_HighFav', 100, 50);
INSERT INTO users (Id, CreationDate, DisplayName, Reputation, Views) VALUES (4, '2011-01-01 00:00:00', 'User2011', 2000, 1000);
INSERT INTO users (Id, CreationDate, DisplayName, Reputation, Views) VALUES (5, '2010-08-20 08:00:00', 'User2010_NoPosts', 3000, 1500);
INSERT INTO posts (Id, OwnerUserId, CreaionDate, FavoriteCount, Score, ViewCount) VALUES (101, 1, '2010-05-05 10:00:00', 999, 50, 100);
INSERT INTO posts (Id, OwnerUserId, CreaionDate, FavoriteCount, Score, ViewCount) VALUES (102, 2, '2009-05-05 10:00:00', 10, 500, 1000);
INSERT INTO posts (Id, OwnerUserId, CreaionDate, FavoriteCount, Score, ViewCount) VALUES (103, 3, '2011-05-05 10:00:00', 50, 5, 10);
INSERT INTO posts (Id, OwnerUserId, CreaionDate, FavoriteCount, Score, ViewCount) VALUES (104, 4, '2010-05-05 10:00:00', 888, 60, 200);
INSERT INTO posts (Id, OwnerUserId, CreaionDate, FavoriteCount, Score, ViewCount) VALUES (105, NULL, '2010-05-05 10:00:00', 1000, 70, 300);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.OwnerUserId, T1.DisplayName FROM users AS T1 INNER JOIN posts AS T2 ON T1.Id = T2.OwnerUserId WHERE STRFTIME('%Y', T1.CreationDate) = '2010' ORDER BY T2.FavoriteCount DESC, T1.id NULLS LAST, T2.id NULLS LAST LIMIT 1;

/*
Gold Result:
(3, 'User2010_HighFav')
*/

-- Prediction Query
SELECT Id, OwnerDisplayName FROM posts WHERE SUBSTRING(CreaionDate, 1, 4) = '2010' ORDER BY FavoriteCount DESC, posts.id NULLS LAST LIMIT 1;

/*
Prediction Result:
(105, None)
*/