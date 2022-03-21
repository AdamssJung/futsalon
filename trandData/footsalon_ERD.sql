CREATE TABLE "players" (
  "id" SERIAL PRIMARY KEY,
  "name" varchar,
  "created_at" timestamp,
  "joined at" varchar,
  "mobile" int,
  "bod" datetime
);

CREATE TABLE "matchinfohistory" (
  "match_id" SERIAL PRIMARY KEY,
  "season" varchar,
  "match_num" int,
  "match_date" date,
  "match_time" varchar,
  "stadium" varchar
);

CREATE index index_season_mnum on matchinfohistory (season, match_num);

CREATE TABLE "awards" (
  "season" varchar,
  "award" varchar,
  "player_id" varchar,
  "prize" varchar
);

CREATE TABLE "match_result" (
  "match_id" int,
  "game_num" int,
  "hTeam" varchar,
  "htScore" int,
  "htHelper" varchar,
  "htKeep "varchar,
  "ATeam" varchar,
  "atScore" integer,
  "atHelper" varchar,
  "atKeep" varchar,
  "goal1" varchar,
  "assist1" varchar,
  "goal2" varchar,
  "Assist2" varchar,
  "Goal3" varchar,
  "Assist3" varchar
);

CREATE TABLE "mom" (
  "mom_id" int SERIAL PRIMARY KEY,
  "name" varchar,
  "vote" varchar
);

CREATE TABLE "products" (
  "id" int PRIMARY KEY,
  "name" varchar,
  "merchant_id" int NOT NULL,
  "price" int,
  "status" products_status,
  "created_at" datetime DEFAULT (now())
);

CREATE TABLE "merchants" (
  "id" int,

);


ALTER TABLE "awards" ADD FOREIGN KEY ("player_id") REFERENCES "players" ("id");

ALTER TABLE "awards" ADD FOREIGN KEY ("season") REFERENCES "matchinfohistory" ("season");

ALTER TABLE "match_result" ADD FOREIGN KEY ("match_id") REFERENCES "matchinfohistory" ("match_id");

ALTER TABLE "mom" ADD FOREIGN KEY ("name") REFERENCES "players" ("name");

ALTER TABLE "merchants" ADD FOREIGN KEY ("admin_id") REFERENCES "users" ("id");

ALTER TABLE "products" ADD FOREIGN KEY ("merchant_id") REFERENCES "merchants" ("id");

CREATE INDEX "product_status" ON "products" ("merchant_id", "status");

CREATE UNIQUE INDEX ON "products" ("id");

COMMENT ON COLUMN "orders"."created_at" IS 'When order created';
