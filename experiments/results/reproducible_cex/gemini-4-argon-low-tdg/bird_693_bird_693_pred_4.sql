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
-- 1. COUNT(T2.Id) vs COUNT(DISTINCT T2.Id) via multiple comments on the same post.
-- 2. Join condition mutations (T1.Id = T2.OwnerUserId vs LastEditorUserId, T3.PostId = T2.Id vs T3.UserId = T1.Id).
-- 3. INNER JOIN vs LEFT JOIN (users without posts, posts with NULL OwnerUserId, posts without comments, comments with NULL PostId).
-- 4. COUNT(T2.Id) vs COUNT(T3.UserId) or other nullable columns.
INSERT INTO users (Id, CreationDate, DisplayName) VALUES (1, '2020-01-01 10:00:00', 'UserOne');
INSERT INTO users (Id, CreationDate, DisplayName) VALUES (2, '2020-01-02 10:00:00', 'UserTwo');
INSERT INTO users (Id, CreationDate, DisplayName) VALUES (3, '2020-01-03 10:00:00', 'UserWithNoPosts');
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Title) VALUES (10, 1, 2, 'Post With Two Comments');
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Title) VALUES (20, 2, 1, 'Post With No Comments');
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Title) VALUES (30, NULL, 1, 'Post With Null Owner');
INSERT INTO comments (Id, PostId, UserId, Text) VALUES (100, 10, 2, 'First comment on post 10');
INSERT INTO comments (Id, PostId, UserId, Text) VALUES (101, 10, NULL, 'Second comment on post 10 with NULL UserId');
INSERT INTO comments (Id, PostId, UserId, Text) VALUES (102, 30, 1, 'Comment on post with NULL owner');
INSERT INTO comments (Id, PostId, UserId, Text) VALUES (103, NULL, 1, 'Comment with NULL PostId');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T2.Id) FROM users AS T1 INNER JOIN posts AS T2 ON T1.Id = T2.OwnerUserId INNER JOIN comments AS T3 ON T3.PostId = T2.Id ORDER BY T1.CreationDate DESC, T1.id NULLS LAST, T2.id NULLS LAST, T3.id NULLS LAST LIMIT 1;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT (SELECT COUNT(*) FROM posts WHERE OwnerUserId = u.Id) AS post_count, (SELECT COUNT(*) FROM comments WHERE UserId = u.Id) AS comment_count FROM users AS u WHERE u.CreationDate = (SELECT MAX(CreationDate) FROM users);

/*
Prediction Result:
(0, 0)
*/