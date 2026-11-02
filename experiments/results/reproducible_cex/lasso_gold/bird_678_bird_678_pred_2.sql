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
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3389, 3392, '1992-08-20', 'Harvey Motulsky', '1996-01-01', 'http://browning-murphy.net/', '056 Turner Summit
Edwinborough, CT 17742', 'conference', 3396, 3400, 3404, 3408, 3412, 'http://hubbard.info/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3390, 3397.0, '1993-02-16', 'Harvey Motulsky', '1997-06-20', 'http://www.roberts-foster.com/', '5355 Kayla Extension Suite 979
South Brady, GU 31104', 'federal', 3415.0, 3421.0, 3427.0, 3433.0, 3439.0, 'https://smith.biz/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3391, 3402.0, '1993-02-17', 'Harvey Motulsky', '1997-06-21', 'https://www.duncan-williams.biz/', '11039 Misty Viaduct Suite 051
Shannontown, MA 27896', 'deep', 3434.0, 3442.0, 3450.0, 3458.0, 3466.0, 'http://bray.org/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3456, 3407.0, '1993-02-18', 'Harvey Motulsky', '1997-06-22', 'https://www.shaw-ayala.com/', '88487 Heather Skyway
South Brandyhaven, AZ 33984', 'strategy', 3453.0, 3463.0, 3473.0, 3483.0, 3493.0, 'http://www.mason.net/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3388, 3393, '1993-02-15', 'Harvey Motulsky', '1997-06-19', 'http://www.nunez.info/', '376 Ann Street Apt. 314
Morrisshire, CO 15250', 'else', 3397, 3401, 3405, 3409, 3413, 'https://www.pena-smith.biz/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3457, 3465.0, '1992-08-21', 'Harvey Motulsky', '1996-01-02', 'http://www.taylor.com/', '993 Jerry Burg Suite 172
Josephstad, HI 51286', 'natural', 3483.0, 3489.0, 3495.0, 3501.0, 3507.0, 'https://murray-henderson.org/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3458, 3470.0, '1992-08-22', 'Harvey Motulsky', '1996-01-03', 'https://www.forbes-daugherty.com/', '33060 Clements Forges
Port James, HI 58078', 'note', 3502.0, 3510.0, 3518.0, 3526.0, 3534.0, 'http://www.gallegos-hayes.net/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3459, 3475.0, '1992-08-23', 'Harvey Motulsky', '1996-01-04', 'http://grant.com/', '573 Sullivan Canyon Suite 569
New Danielmouth, GU 06060', 'individual', 3521.0, 3531.0, 3541.0, 3551.0, 3561.0, 'http://www.pace.biz/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3448, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3516, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3416, 3420, 3424, '1972-10-23', 3428, 3539.0, 'with', 3389, '1976-03-04', 'Senior tax professional/tax inspector', 'increase', 3436, 3440, 3444, 3448, '1980-07-08', '1984-11-12', 3452, '1988-04-16', 'Harold Garrett', 'Diana Hernandez');
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3418, 3425.0, 3431.0, '1972-10-24', 3439.0, 3445.0, 'seem', 3389, '1976-03-05', 'Industrial/product designer', 'size', 3461.0, 3467.0, 3473.0, 3448, '1980-07-09', '1984-11-13', 3489.0, '1988-04-17', 'William Mason', 'Mary Miller');
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3419, 3430.0, 3438.0, '1972-10-25', 3450.0, 3458.0, 'age', 3389, '1976-03-06', 'Lecturer, further education', 'close', 3486.0, 3494.0, 3502.0, 3448, '1980-07-10', '1984-11-14', 3526.0, '1988-04-18', 'Lori Johns', 'Tyler Salazar');
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3484, 3435.0, 3445.0, '1972-10-26', 3461.0, 3471.0, 'end', 3389, '1976-03-07', 'Recruitment consultant', 'affect', 3511.0, 3521.0, 3531.0, 3448, '1980-07-11', '1984-11-15', 3563.0, '1988-04-19', 'Robin Johnson', 'Crystal Allen');
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3417, 3488, 3492, '1971-05-05', 3496, 3539.0, 'game', 3388, '1975-09-09', 'Professor Emeritus', 'believe', 3504, 3508, 3512, 3516, '1979-02-13', '1983-06-17', 3520, '1987-10-21', 'Carly Quinn', 'Amanda Jackson');
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3485, 3493.0, 3499.0, '1971-05-06', 3507.0, 3513.0, 'little', 3388, '1975-09-10', 'Therapeutic radiographer', 'enough', 3529.0, 3535.0, 3541.0, 3516, '1979-02-14', '1983-06-18', 3557.0, '1987-10-22', 'Michael Walters', 'Seth Huffman');
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3486, 3498.0, 3506.0, '1971-05-07', 3518.0, 3526.0, 'ago', 3388, '1975-09-11', 'Engineer, drilling', 'role', 3554.0, 3562.0, 3570.0, 3516, '1979-02-15', '1983-06-19', 3594.0, '1987-10-23', 'Michael Acosta', 'Charles Hammond');
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3487, 3503.0, 3513.0, '1971-05-08', 3529.0, 3432, 'country', 3388, '1975-09-12', 'Programme researcher, broadcasting/film/video', 'what', 3579.0, 3589.0, 3599.0, 3516, '1979-02-16', '1983-06-20', 3631.0, '1987-10-24', 'Lisa Moore', 'Eric Cross');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Id, T2.Title FROM users AS T1 INNER JOIN posts AS T2 ON T1.Id = T2.OwnerUserId WHERE T1.DisplayName = 'Harvey Motulsky' ORDER BY T2.ViewCount DESC, T1.id NULLS LAST, T2.id NULLS LAST LIMIT 1;

/*
Gold Result:
(3417, 'Professor Emeritus')
*/

-- Prediction Query
SELECT "posts"."id", "posts"."title" FROM "posts" INNER JOIN "users" ON "posts"."owneruserid" = "users"."id" WHERE "users"."displayname" = 'Harvey Motulsky' ORDER BY "posts"."viewcount" DESC, posts.id NULLS LAST, users.id NULLS LAST LIMIT 1;

/*
Prediction Result:
(3416, 'Senior tax professional/tax inspector')
*/