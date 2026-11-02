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
-- Tests:
-- 1. Tie-breaking for MAX(FavoriteCount) with different OwnerUserIds (kills ORDER BY FavoriteCount DESC LIMIT 1).
-- 2. Duplicate OwnerUserId for the tied MAX(FavoriteCount) (kills SELECT DISTINCT OwnerUserId).
-- 3. NULL FavoriteCount handling (kills ORDER BY FavoriteCount DESC without NULLS LAST in engines where NULLs sort high, or IS NOT NULL mistakes).
-- 4. Column confusion: Score, ViewCount, AnswerCount, CommentCount, and LastEditorUserId have distinct values from FavoriteCount and OwnerUserId.
-- 5. Unreferenced users in the users table (kills erroneous RIGHT/OUTER JOINs on users).
INSERT INTO users (Id, Reputation, DisplayName) VALUES (10, 100, 'UserA');
INSERT INTO users (Id, Reputation, DisplayName) VALUES (20, 200, 'UserB');
INSERT INTO users (Id, Reputation, DisplayName) VALUES (30, 300, 'UserC');
INSERT INTO users (Id, Reputation, DisplayName) VALUES (40, 400, 'UnreferencedUser');
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, FavoriteCount, Score, ViewCount, AnswerCount, CommentCount) VALUES (1, 10, 30, 50, 5, 100, 1, 1);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, FavoriteCount, Score, ViewCount, AnswerCount, CommentCount) VALUES (2, 10, 20, 50, 10, 200, 2, 2);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, FavoriteCount, Score, ViewCount, AnswerCount, CommentCount) VALUES (3, 20, 10, 50, 15, 300, 3, 3);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, FavoriteCount, Score, ViewCount, AnswerCount, CommentCount) VALUES (4, 30, 10, 10, 100, 1000, 50, 50);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, FavoriteCount, Score, ViewCount, AnswerCount, CommentCount) VALUES (5, 30, 20, NULL, 200, 2000, 60, 60);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT OwnerUserId FROM posts WHERE FavoriteCount = (SELECT MAX(FavoriteCount) FROM posts);

/*
Gold Result:
(10,)
(10,)
(20,)
*/

-- Prediction Query
SELECT OwnerUserId FROM posts ORDER BY FavoriteCount DESC, posts.id NULLS LAST LIMIT 1;

/*
Prediction Result:
(10,)
*/