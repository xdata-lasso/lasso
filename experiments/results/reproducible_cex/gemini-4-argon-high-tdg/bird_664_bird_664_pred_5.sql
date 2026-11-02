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
INSERT INTO posts (Id, PostTypeId, Score, ViewCount, AnswerCount, CommentCount, FavoriteCount) VALUES (1, 1, 10, 100, 1, 2, 3);
INSERT INTO posts (Id, PostTypeId, Score, ViewCount, AnswerCount, CommentCount, FavoriteCount) VALUES (2, 1, 20, 200, 2, 3, 4);
INSERT INTO posts (Id, PostTypeId, Score, ViewCount, AnswerCount, CommentCount, FavoriteCount) VALUES (3, 2, 30, 300, 3, 4, 5);
INSERT INTO posts (Id, PostTypeId, Score, ViewCount, AnswerCount, CommentCount, FavoriteCount) VALUES (10, 4, 45, 50, 0, 1, 0);
INSERT INTO posts (Id, PostTypeId, Score, ViewCount, AnswerCount, CommentCount, FavoriteCount) VALUES (20, 4, 85, 40, 0, 0, 1);
INSERT INTO posts (Id, PostTypeId, Score, ViewCount, AnswerCount, CommentCount, FavoriteCount) VALUES (30, 4, 15, 900, 5, 8, 9);
INSERT INTO posts (Id, PostTypeId, Score, ViewCount, AnswerCount, CommentCount, FavoriteCount) VALUES (40, 5, 99, 500, 0, 0, 0);
INSERT INTO tags (Id, TagName, Count, ExcerptPostId, WikiPostId) VALUES (1, 'sql', 50, 10, 40);
INSERT INTO tags (Id, TagName, Count, ExcerptPostId, WikiPostId) VALUES (2, 'database', 200, 20, 40);
INSERT INTO tags (Id, TagName, Count, ExcerptPostId, WikiPostId) VALUES (3, 'sqlite', 5, 30, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT Score FROM posts WHERE Id = (SELECT ExcerptPostId FROM tags ORDER BY Count DESC, tags.id NULLS LAST LIMIT 1);

/*
Gold Result:
(85,)
*/

-- Prediction Query
SELECT SUM(Score) AS TotalScore FROM posts WHERE LasActivityDate LIKE '2010-07-19%';

/*
Prediction Result:
(None,)
*/