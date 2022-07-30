CREATE DATABASE pratica_modelagem;

CREATE TABLE "customers" (
    "id" SERIAL PRIMARY KEY,
    "fullName" TEXT NOT NULL,
    "cpf" VARCHAR(11) UNIQUE NOT NULL,
    "email" TEXT UNIQUE NOT NULL,
    "password" TEXT NOT NULL
);

CREATE TABLE "bankAccount" (
    "id" SERIAL PRIMARY KEY,
    "customerId" INTEGER NOT NULL REFERENCES "customers"("id"),
    "accountNumber" TEXT NOT NULL,
    "agency" TEXT NOT NULL,
    "openDate" TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT NOW(),
    "closeDate" TIMESTAMP WITHOUT TIME ZONE DEFAULT null
);

CREATE TYPE "transactionType" AS ENUM('deposit', 'withdraw');
CREATE TABLE "transactions" (
    "id" SERIAL PRIMARY KEY,
    "bankAccountId" INTEGER NOT NULL REFERENCES "bankAccount"("id"),
    "amount" INTEGER NOT NULL,
    "type" "transactionType" NOT NULL,
    "time" TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT NOW(),
    "description" TEXT,
    "cancelled" BOOLEAN NOT NULL
);

CREATE TABLE "creditCards" (
    "id" SERIAL PRIMARY KEY,
    "bankAccountId" INTEGER NOT NULL REFERENCES "bankAccount"("id"),
    "name" TEXT NOT NULL,
    "number" VARCHAR(16) NOT NULL,
    "securityCode" VARCHAR(3) NOT NULL,
    "expirationMonth" VARCHAR(2) NOT NULL,
    "expirationYear" VARCHAR(4) NOT NULL,
    "password" VARCHAR(4) NOT NULL,
    "limit" INTEGER NOT NULL DEFAULT 0
);

CREATE TYPE "phoneType" AS ENUM('landline', 'mobile');
CREATE TABLE "customerPhones" (
    "id" SERIAL PRIMARY KEY,
    "customerId" INTEGER NOT NULL REFERENCES "customers"("id"),
    "number" VARCHAR(11) NOT NULL,
    "type" "phoneType" NOT NULL
);

CREATE TABLE "states" (
    "id" SERIAL PRIMARY KEY,
    "name" TEXT NOT NULL
);

CREATE TABLE "cities" (
    "id" SERIAL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "stateId" INTEGER NOT NULL REFERENCES "states"("id")
);

CREATE TABLE "customerAdressess" (
    "id" SERIAL PRIMARY KEY,
    "customerId" INTEGER UNIQUE NOT NULL REFERENCES "customers"("id"),
    "street" TEXT NOT NULL,
    "number" TEXT NOT NULL,
    "complement" TEXT,
    "postalCode" VARCHAR(8) NOT NULL,
    "cityId" INTEGER NOT NULL REFERENCES "cities"("id")
);