/*
  Warnings:

  - The values [LIBRARIAN] on the enum `Role` will be removed. If these variants are still used in the database, this will fail.
  - You are about to drop the `Book` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `BookInfo` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Loan` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Penalty` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Student` table. If the table is not empty, all the data it contains will be lost.
  - A unique constraint covering the columns `[phone]` on the table `User` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `address` to the `User` table without a default value. This is not possible if the table is not empty.
  - Added the required column `codephone` to the `User` table without a default value. This is not possible if the table is not empty.
  - Added the required column `image` to the `User` table without a default value. This is not possible if the table is not empty.
  - Added the required column `phone` to the `User` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "paymentMethod" AS ENUM ('CASH', 'CARD', 'DELIPOINTS');

-- CreateEnum
CREATE TYPE "Membership" AS ENUM ('FREE', 'PREMIUM');

-- AlterEnum
BEGIN;
CREATE TYPE "Role_new" AS ENUM ('ADMIN', 'USER', 'SUPPORT', 'DRIVER');
ALTER TABLE "User" ALTER COLUMN "role" DROP DEFAULT;
ALTER TABLE "User" ALTER COLUMN "role" TYPE "Role_new" USING ("role"::text::"Role_new");
ALTER TYPE "Role" RENAME TO "Role_old";
ALTER TYPE "Role_new" RENAME TO "Role";
DROP TYPE "Role_old";
ALTER TABLE "User" ALTER COLUMN "role" SET DEFAULT 'USER';
COMMIT;

-- DropForeignKey
ALTER TABLE "BookInfo" DROP CONSTRAINT "BookInfo_bookId_fkey";

-- DropForeignKey
ALTER TABLE "Loan" DROP CONSTRAINT "Loan_bookInfoId_fkey";

-- DropForeignKey
ALTER TABLE "Loan" DROP CONSTRAINT "Loan_studentId_fkey";

-- DropForeignKey
ALTER TABLE "Penalty" DROP CONSTRAINT "Penalty_studentId_fkey";

-- AlterTable
ALTER TABLE "User" ADD COLUMN     "address" TEXT NOT NULL,
ADD COLUMN     "codephone" TEXT NOT NULL,
ADD COLUMN     "image" TEXT NOT NULL,
ADD COLUMN     "membership" "Membership" NOT NULL DEFAULT 'FREE',
ADD COLUMN     "paymentMethod" "paymentMethod" NOT NULL DEFAULT 'CASH',
ADD COLUMN     "phone" TEXT NOT NULL,
ALTER COLUMN "role" SET DEFAULT 'USER';

-- DropTable
DROP TABLE "Book";

-- DropTable
DROP TABLE "BookInfo";

-- DropTable
DROP TABLE "Loan";

-- DropTable
DROP TABLE "Penalty";

-- DropTable
DROP TABLE "Student";

-- DropEnum
DROP TYPE "BookStatus";

-- DropEnum
DROP TYPE "PenaltyStatus";

-- DropEnum
DROP TYPE "StudentStatus";

-- CreateIndex
CREATE UNIQUE INDEX "User_phone_key" ON "User"("phone");
