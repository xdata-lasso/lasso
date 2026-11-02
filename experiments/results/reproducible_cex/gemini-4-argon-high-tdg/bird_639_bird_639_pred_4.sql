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
INSERT INTO users (Id, Reputation, DisplayName) VALUES (10, 1, 'Community');
INSERT INTO users (Id, Reputation, DisplayName) VALUES (20, 500, 'Alice');
INSERT INTO posts (Id, PostTypeId, OwnerUserId, Title, Tags) VALUES (101, 4, 10, 'Excerpt 1', 'r');
INSERT INTO posts (Id, PostTypeId, OwnerUserId, Title, Tags) VALUES (102, 4, 10, 'Excerpt 2', 'python');
INSERT INTO posts (Id, PostTypeId, OwnerUserId, Title, Tags) VALUES (103, 4, 10, 'Excerpt 3', 'sql');
INSERT INTO posts (Id, PostTypeId, OwnerUserId, Title, Tags) VALUES (104, 4, 20, 'Excerpt 4', 'r');
INSERT INTO postHistory (Id, PostHistoryTypeId, PostId, UserId, Text) VALUES (1001, 2, 101, 10, 'Initial r excerpt');
INSERT INTO postHistory (Id, PostHistoryTypeId, PostId, UserId, Text) VALUES (1002, 2, 102, 10, 'Initial python excerpt');
INSERT INTO postHistory (Id, PostHistoryTypeId, PostId, UserId, Text) VALUES (1003, 2, 103, 10, 'Initial sql excerpt');
INSERT INTO postHistory (Id, PostHistoryTypeId, PostId, UserId, Text) VALUES (1004, 2, 104, 20, 'Alice r excerpt');
INSERT INTO postHistory (Id, PostHistoryTypeId, PostId, UserId, Text) VALUES (1005, 5, 101, 20, 'Alice edit on r');
INSERT INTO tags (Id, TagName, Count, ExcerptPostId, WikiPostId) VALUES (501, 'r', 42, 101, 999);
INSERT INTO tags (Id, TagName, Count, ExcerptPostId, WikiPostId) VALUES (502, 'python', 15, 102, 998);
INSERT INTO tags (Id, TagName, Count, ExcerptPostId, WikiPostId) VALUES (503, 'sql', 88, 103, 997);
INSERT INTO tags (Id, TagName, Count, ExcerptPostId, WikiPostId) VALUES (504, 'r', 120, 104, 996);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(IIF(T3.TagName = 'r', 1, 0)) AS REAL) * 100 / COUNT(T1.Id) FROM users AS T1 INNER JOIN postHistory AS T2 ON T1.Id = T2.UserId INNER JOIN tags AS T3 ON T3.ExcerptPostId = T2.PostId WHERE T1.DisplayName = 'Community';

/*
Gold Result:
(33.333333333333336,)
*/

-- Prediction Query
SELECT (100.0 * CAST(SUM(CASE WHEN ',' || posts.Tags || ',' LIKE '%<r>%' THEN 1 ELSE 0 END) AS REAL) / CAST(COUNT(posts.Id) AS REAL)) AS percentage FROM posts JOIN users ON posts.OwnerUserId = users.Id WHERE users.DisplayName = 'Community';

/*
Prediction Result:
(0.0,)
*/