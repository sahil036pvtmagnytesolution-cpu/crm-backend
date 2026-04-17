-- Add missing columns to ms_services table
ALTER TABLE `ms_services` ADD COLUMN `category` VARCHAR(100) NULL AFTER `name`;
ALTER TABLE `ms_services` ADD COLUMN `status` VARCHAR(20) NOT NULL DEFAULT 'Active' AFTER `category`;
