-- MariaDB dump 10.17  Distrib 10.4.11-MariaDB, for osx10.14 (x86_64)
--
-- Host: 127.0.0.1    Database: sandbox_starter
-- ------------------------------------------------------
-- Server version	10.4.11-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `assetindexdata`
--

DROP TABLE IF EXISTS `assetindexdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assetindexdata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sessionId` varchar(36) NOT NULL DEFAULT '',
  `volumeId` int(11) NOT NULL,
  `uri` text DEFAULT NULL,
  `size` bigint(20) unsigned DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  `recordId` int(11) DEFAULT NULL,
  `inProgress` tinyint(1) DEFAULT 0,
  `completed` tinyint(1) DEFAULT 0,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `assetindexdata_sessionId_volumeId_idx` (`sessionId`,`volumeId`),
  KEY `assetindexdata_volumeId_idx` (`volumeId`),
  CONSTRAINT `assetindexdata_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `assets`
--

DROP TABLE IF EXISTS `assets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assets` (
  `id` int(11) NOT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `folderId` int(11) NOT NULL,
  `uploaderId` int(11) DEFAULT NULL,
  `filename` varchar(255) NOT NULL,
  `kind` varchar(50) NOT NULL DEFAULT 'unknown',
  `width` int(11) unsigned DEFAULT NULL,
  `height` int(11) unsigned DEFAULT NULL,
  `size` bigint(20) unsigned DEFAULT NULL,
  `focalPoint` varchar(13) DEFAULT NULL,
  `deletedWithVolume` tinyint(1) DEFAULT NULL,
  `keptFile` tinyint(1) DEFAULT NULL,
  `dateModified` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `assets_filename_folderId_idx` (`filename`,`folderId`),
  KEY `assets_folderId_idx` (`folderId`),
  KEY `assets_volumeId_idx` (`volumeId`),
  KEY `assets_uploaderId_fk` (`uploaderId`),
  CONSTRAINT `assets_folderId_fk` FOREIGN KEY (`folderId`) REFERENCES `volumefolders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `assets_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `assets_uploaderId_fk` FOREIGN KEY (`uploaderId`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `assets_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `assettransformindex`
--

DROP TABLE IF EXISTS `assettransformindex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assettransformindex` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `assetId` int(11) NOT NULL,
  `filename` varchar(255) DEFAULT NULL,
  `format` varchar(255) DEFAULT NULL,
  `location` varchar(255) NOT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `fileExists` tinyint(1) NOT NULL DEFAULT 0,
  `inProgress` tinyint(1) NOT NULL DEFAULT 0,
  `dateIndexed` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `assettransformindex_volumeId_assetId_location_idx` (`volumeId`,`assetId`,`location`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `assettransforms`
--

DROP TABLE IF EXISTS `assettransforms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assettransforms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `mode` enum('stretch','fit','crop') NOT NULL DEFAULT 'crop',
  `position` enum('top-left','top-center','top-right','center-left','center-center','center-right','bottom-left','bottom-center','bottom-right') NOT NULL DEFAULT 'center-center',
  `width` int(11) unsigned DEFAULT NULL,
  `height` int(11) unsigned DEFAULT NULL,
  `format` varchar(255) DEFAULT NULL,
  `quality` int(11) DEFAULT NULL,
  `interlace` enum('none','line','plane','partition') NOT NULL DEFAULT 'none',
  `dimensionChangeTime` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `assettransforms_name_unq_idx` (`name`),
  UNIQUE KEY `assettransforms_handle_unq_idx` (`handle`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `parentId` int(11) DEFAULT NULL,
  `deletedWithGroup` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `categories_groupId_idx` (`groupId`),
  KEY `categories_parentId_fk` (`parentId`),
  CONSTRAINT `categories_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `categorygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `categories_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `categories_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `categorygroups`
--

DROP TABLE IF EXISTS `categorygroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categorygroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `categorygroups_name_idx` (`name`),
  KEY `categorygroups_handle_idx` (`handle`),
  KEY `categorygroups_structureId_idx` (`structureId`),
  KEY `categorygroups_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `categorygroups_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `categorygroups_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `categorygroups_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `categorygroups_sites`
--

DROP TABLE IF EXISTS `categorygroups_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categorygroups_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT 1,
  `uriFormat` text DEFAULT NULL,
  `template` varchar(500) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `categorygroups_sites_groupId_siteId_unq_idx` (`groupId`,`siteId`),
  KEY `categorygroups_sites_siteId_idx` (`siteId`),
  CONSTRAINT `categorygroups_sites_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `categorygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `categorygroups_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `changedattributes`
--

DROP TABLE IF EXISTS `changedattributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `changedattributes` (
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `attribute` varchar(255) NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `propagated` tinyint(1) NOT NULL,
  `userId` int(11) DEFAULT NULL,
  PRIMARY KEY (`elementId`,`siteId`,`attribute`),
  KEY `changedattributes_elementId_siteId_dateUpdated_idx` (`elementId`,`siteId`,`dateUpdated`),
  KEY `changedattributes_siteId_fk` (`siteId`),
  KEY `changedattributes_userId_fk` (`userId`),
  CONSTRAINT `changedattributes_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `changedattributes_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `changedattributes_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `changedfields`
--

DROP TABLE IF EXISTS `changedfields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `changedfields` (
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `propagated` tinyint(1) NOT NULL,
  `userId` int(11) DEFAULT NULL,
  PRIMARY KEY (`elementId`,`siteId`,`fieldId`),
  KEY `changedfields_elementId_siteId_dateUpdated_idx` (`elementId`,`siteId`,`dateUpdated`),
  KEY `changedfields_siteId_fk` (`siteId`),
  KEY `changedfields_fieldId_fk` (`fieldId`),
  KEY `changedfields_userId_fk` (`userId`),
  CONSTRAINT `changedfields_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `changedfields_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `changedfields_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `changedfields_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `content`
--

DROP TABLE IF EXISTS `content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `content` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `field_sidebar` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `content_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `content_siteId_idx` (`siteId`),
  KEY `content_title_idx` (`title`),
  CONSTRAINT `content_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `content_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craftidtokens`
--

DROP TABLE IF EXISTS `craftidtokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craftidtokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `accessToken` text NOT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craftidtokens_userId_fk` (`userId`),
  CONSTRAINT `craftidtokens_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `deprecationerrors`
--

DROP TABLE IF EXISTS `deprecationerrors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `deprecationerrors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(255) NOT NULL,
  `fingerprint` varchar(255) NOT NULL,
  `lastOccurrence` datetime NOT NULL,
  `file` varchar(255) NOT NULL,
  `line` smallint(6) unsigned DEFAULT NULL,
  `message` text DEFAULT NULL,
  `traces` text DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `deprecationerrors_key_fingerprint_unq_idx` (`key`,`fingerprint`)
) ENGINE=InnoDB AUTO_INCREMENT=86 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `drafts`
--

DROP TABLE IF EXISTS `drafts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `drafts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sourceId` int(11) DEFAULT NULL,
  `creatorId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `notes` text DEFAULT NULL,
  `trackChanges` tinyint(1) NOT NULL DEFAULT 0,
  `dateLastMerged` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `drafts_creatorId_fk` (`creatorId`),
  KEY `drafts_sourceId_fk` (`sourceId`),
  CONSTRAINT `drafts_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `drafts_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `elementindexsettings`
--

DROP TABLE IF EXISTS `elementindexsettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `elementindexsettings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `settings` text DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `elementindexsettings_type_unq_idx` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `elements`
--

DROP TABLE IF EXISTS `elements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `elements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `draftId` int(11) DEFAULT NULL,
  `revisionId` int(11) DEFAULT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
  `archived` tinyint(1) NOT NULL DEFAULT 0,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `elements_dateDeleted_idx` (`dateDeleted`),
  KEY `elements_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `elements_type_idx` (`type`),
  KEY `elements_enabled_idx` (`enabled`),
  KEY `elements_archived_dateCreated_idx` (`archived`,`dateCreated`),
  KEY `elements_draftId_fk` (`draftId`),
  KEY `elements_revisionId_fk` (`revisionId`),
  KEY `elements_archived_dateDeleted_draftId_revisionId_idx` (`archived`,`dateDeleted`,`draftId`,`revisionId`),
  CONSTRAINT `elements_draftId_fk` FOREIGN KEY (`draftId`) REFERENCES `drafts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `elements_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `elements_revisionId_fk` FOREIGN KEY (`revisionId`) REFERENCES `revisions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=159 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `elements_sites`
--

DROP TABLE IF EXISTS `elements_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `elements_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `uri` varchar(255) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `elements_sites_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `elements_sites_siteId_idx` (`siteId`),
  KEY `elements_sites_slug_siteId_idx` (`slug`,`siteId`),
  KEY `elements_sites_enabled_idx` (`enabled`),
  KEY `elements_sites_uri_siteId_idx` (`uri`,`siteId`),
  CONSTRAINT `elements_sites_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `elements_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=159 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `entries`
--

DROP TABLE IF EXISTS `entries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `entries` (
  `id` int(11) NOT NULL,
  `sectionId` int(11) NOT NULL,
  `parentId` int(11) DEFAULT NULL,
  `typeId` int(11) NOT NULL,
  `authorId` int(11) DEFAULT NULL,
  `postDate` datetime DEFAULT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `deletedWithEntryType` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `entries_postDate_idx` (`postDate`),
  KEY `entries_expiryDate_idx` (`expiryDate`),
  KEY `entries_authorId_idx` (`authorId`),
  KEY `entries_sectionId_idx` (`sectionId`),
  KEY `entries_typeId_idx` (`typeId`),
  KEY `entries_parentId_fk` (`parentId`),
  CONSTRAINT `entries_authorId_fk` FOREIGN KEY (`authorId`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entries_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entries_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `entries` (`id`) ON DELETE SET NULL,
  CONSTRAINT `entries_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entries_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `entrytypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `entrytypes`
--

DROP TABLE IF EXISTS `entrytypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `entrytypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sectionId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `hasTitleField` tinyint(1) NOT NULL DEFAULT 1,
  `titleLabel` varchar(255) DEFAULT 'Title',
  `titleFormat` varchar(255) DEFAULT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `entrytypes_name_sectionId_idx` (`name`,`sectionId`),
  KEY `entrytypes_handle_sectionId_idx` (`handle`,`sectionId`),
  KEY `entrytypes_sectionId_idx` (`sectionId`),
  KEY `entrytypes_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `entrytypes_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `entrytypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `entrytypes_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fieldgroups`
--

DROP TABLE IF EXISTS `fieldgroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fieldgroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `fieldgroups_name_unq_idx` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fieldlayoutfields`
--

DROP TABLE IF EXISTS `fieldlayoutfields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fieldlayoutfields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `layoutId` int(11) NOT NULL,
  `tabId` int(11) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `required` tinyint(1) NOT NULL DEFAULT 0,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `fieldlayoutfields_layoutId_fieldId_unq_idx` (`layoutId`,`fieldId`),
  KEY `fieldlayoutfields_sortOrder_idx` (`sortOrder`),
  KEY `fieldlayoutfields_tabId_idx` (`tabId`),
  KEY `fieldlayoutfields_fieldId_idx` (`fieldId`),
  CONSTRAINT `fieldlayoutfields_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fieldlayoutfields_layoutId_fk` FOREIGN KEY (`layoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fieldlayoutfields_tabId_fk` FOREIGN KEY (`tabId`) REFERENCES `fieldlayouttabs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=346 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fieldlayouts`
--

DROP TABLE IF EXISTS `fieldlayouts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fieldlayouts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fieldlayouts_dateDeleted_idx` (`dateDeleted`),
  KEY `fieldlayouts_type_idx` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fieldlayouttabs`
--

DROP TABLE IF EXISTS `fieldlayouttabs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fieldlayouttabs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `layoutId` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fieldlayouttabs_sortOrder_idx` (`sortOrder`),
  KEY `fieldlayouttabs_layoutId_idx` (`layoutId`),
  CONSTRAINT `fieldlayouttabs_layoutId_fk` FOREIGN KEY (`layoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=192 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fields`
--

DROP TABLE IF EXISTS `fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(64) NOT NULL,
  `context` varchar(255) NOT NULL DEFAULT 'global',
  `instructions` text DEFAULT NULL,
  `searchable` tinyint(1) NOT NULL DEFAULT 1,
  `translationMethod` varchar(255) NOT NULL DEFAULT 'none',
  `translationKeyFormat` text DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `settings` text DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `fields_handle_context_unq_idx` (`handle`,`context`),
  KEY `fields_groupId_idx` (`groupId`),
  KEY `fields_context_idx` (`context`),
  CONSTRAINT `fields_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `fieldgroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `globalsets`
--

DROP TABLE IF EXISTS `globalsets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `globalsets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `globalsets_name_idx` (`name`),
  KEY `globalsets_handle_idx` (`handle`),
  KEY `globalsets_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `globalsets_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `globalsets_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gqlschemas`
--

DROP TABLE IF EXISTS `gqlschemas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gqlschemas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `scope` text DEFAULT NULL,
  `isPublic` tinyint(1) NOT NULL DEFAULT 0,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gqltokens`
--

DROP TABLE IF EXISTS `gqltokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gqltokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `accessToken` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
  `expiryDate` datetime DEFAULT NULL,
  `lastUsed` datetime DEFAULT NULL,
  `schemaId` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `gqltokens_accessToken_unq_idx` (`accessToken`),
  UNIQUE KEY `gqltokens_name_unq_idx` (`name`),
  KEY `gqltokens_schemaId_fk` (`schemaId`),
  CONSTRAINT `gqltokens_schemaId_fk` FOREIGN KEY (`schemaId`) REFERENCES `gqlschemas` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `info`
--

DROP TABLE IF EXISTS `info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `version` varchar(50) NOT NULL,
  `schemaVersion` varchar(15) NOT NULL,
  `maintenance` tinyint(1) NOT NULL DEFAULT 0,
  `configMap` mediumtext DEFAULT NULL,
  `fieldVersion` char(12) NOT NULL DEFAULT '000000000000',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `knockknock_logins`
--

DROP TABLE IF EXISTS `knockknock_logins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `knockknock_logins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ipAddress` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `loginPath` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `matrixblocks`
--

DROP TABLE IF EXISTS `matrixblocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matrixblocks` (
  `id` int(11) NOT NULL,
  `ownerId` int(11) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `typeId` int(11) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `deletedWithOwner` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `matrixblocks_ownerId_idx` (`ownerId`),
  KEY `matrixblocks_fieldId_idx` (`fieldId`),
  KEY `matrixblocks_typeId_idx` (`typeId`),
  KEY `matrixblocks_sortOrder_idx` (`sortOrder`),
  CONSTRAINT `matrixblocks_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocks_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocks_ownerId_fk` FOREIGN KEY (`ownerId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocks_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `matrixblocktypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `matrixblocktypes`
--

DROP TABLE IF EXISTS `matrixblocktypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matrixblocktypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `matrixblocktypes_name_fieldId_unq_idx` (`name`,`fieldId`),
  UNIQUE KEY `matrixblocktypes_handle_fieldId_unq_idx` (`handle`,`fieldId`),
  KEY `matrixblocktypes_fieldId_idx` (`fieldId`),
  KEY `matrixblocktypes_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `matrixblocktypes_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocktypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `matrixcontent_panels`
--

DROP TABLE IF EXISTS `matrixcontent_panels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matrixcontent_panels` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `field_text_text` text DEFAULT NULL,
  `field_text_padding` varchar(255) DEFAULT NULL,
  `field_text_margin` varchar(255) DEFAULT NULL,
  `field_embed_embed` text DEFAULT NULL,
  `field_image_width` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `matrixcontent_panels_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `matrixcontent_panels_siteId_fk` (`siteId`),
  CONSTRAINT `matrixcontent_panels_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixcontent_panels_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=75 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pluginId` int(11) DEFAULT NULL,
  `type` enum('app','plugin','content') NOT NULL DEFAULT 'app',
  `name` varchar(255) NOT NULL,
  `applyTime` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `migrations_pluginId_idx` (`pluginId`),
  KEY `migrations_type_pluginId_idx` (`type`,`pluginId`),
  CONSTRAINT `migrations_pluginId_fk` FOREIGN KEY (`pluginId`) REFERENCES `plugins` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=186 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `plugins`
--

DROP TABLE IF EXISTS `plugins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plugins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `handle` varchar(255) NOT NULL,
  `version` varchar(255) NOT NULL,
  `schemaVersion` varchar(255) NOT NULL,
  `licenseKeyStatus` enum('valid','invalid','mismatched','astray','unknown') NOT NULL DEFAULT 'unknown',
  `licensedEdition` varchar(255) DEFAULT NULL,
  `installDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `plugins_handle_unq_idx` (`handle`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `projectconfig`
--

DROP TABLE IF EXISTS `projectconfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `projectconfig` (
  `path` varchar(255) NOT NULL,
  `value` text NOT NULL,
  PRIMARY KEY (`path`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `queue`
--

DROP TABLE IF EXISTS `queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `channel` varchar(255) NOT NULL DEFAULT 'queue',
  `job` longblob NOT NULL,
  `description` text DEFAULT NULL,
  `timePushed` int(11) NOT NULL,
  `ttr` int(11) NOT NULL,
  `delay` int(11) NOT NULL DEFAULT 0,
  `priority` int(11) unsigned NOT NULL DEFAULT 1024,
  `dateReserved` datetime DEFAULT NULL,
  `timeUpdated` int(11) DEFAULT NULL,
  `progress` smallint(6) NOT NULL DEFAULT 0,
  `progressLabel` varchar(255) DEFAULT NULL,
  `attempt` int(11) DEFAULT NULL,
  `fail` tinyint(1) DEFAULT 0,
  `dateFailed` datetime DEFAULT NULL,
  `error` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `queue_channel_fail_timeUpdated_timePushed_idx` (`channel`,`fail`,`timeUpdated`,`timePushed`),
  KEY `queue_channel_fail_timeUpdated_delay_idx` (`channel`,`fail`,`timeUpdated`,`delay`)
) ENGINE=InnoDB AUTO_INCREMENT=279 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `relations`
--

DROP TABLE IF EXISTS `relations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `relations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldId` int(11) NOT NULL,
  `sourceId` int(11) NOT NULL,
  `sourceSiteId` int(11) DEFAULT NULL,
  `targetId` int(11) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `relations_fieldId_sourceId_sourceSiteId_targetId_unq_idx` (`fieldId`,`sourceId`,`sourceSiteId`,`targetId`),
  KEY `relations_sourceId_idx` (`sourceId`),
  KEY `relations_targetId_idx` (`targetId`),
  KEY `relations_sourceSiteId_idx` (`sourceSiteId`),
  CONSTRAINT `relations_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `relations_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `relations_sourceSiteId_fk` FOREIGN KEY (`sourceSiteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `relations_targetId_fk` FOREIGN KEY (`targetId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resourcepaths`
--

DROP TABLE IF EXISTS `resourcepaths`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resourcepaths` (
  `hash` varchar(255) NOT NULL,
  `path` varchar(255) NOT NULL,
  PRIMARY KEY (`hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `revisions`
--

DROP TABLE IF EXISTS `revisions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `revisions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sourceId` int(11) NOT NULL,
  `creatorId` int(11) DEFAULT NULL,
  `num` int(11) NOT NULL,
  `notes` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `revisions_sourceId_num_unq_idx` (`sourceId`,`num`),
  KEY `revisions_creatorId_fk` (`creatorId`),
  CONSTRAINT `revisions_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `revisions_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `searchindex`
--

DROP TABLE IF EXISTS `searchindex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `searchindex` (
  `elementId` int(11) NOT NULL,
  `attribute` varchar(25) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `keywords` text NOT NULL,
  PRIMARY KEY (`elementId`,`attribute`,`fieldId`,`siteId`),
  FULLTEXT KEY `searchindex_keywords_idx` (`keywords`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sections`
--

DROP TABLE IF EXISTS `sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sections` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` enum('single','channel','structure') NOT NULL DEFAULT 'channel',
  `enableVersioning` tinyint(1) NOT NULL DEFAULT 0,
  `propagationMethod` varchar(255) NOT NULL DEFAULT 'all',
  `previewTargets` text DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sections_handle_idx` (`handle`),
  KEY `sections_name_idx` (`name`),
  KEY `sections_structureId_idx` (`structureId`),
  KEY `sections_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `sections_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sections_sites`
--

DROP TABLE IF EXISTS `sections_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sections_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sectionId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT 1,
  `uriFormat` text DEFAULT NULL,
  `template` varchar(500) DEFAULT NULL,
  `enabledByDefault` tinyint(1) NOT NULL DEFAULT 1,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sections_sites_sectionId_siteId_unq_idx` (`sectionId`,`siteId`),
  KEY `sections_sites_siteId_idx` (`siteId`),
  CONSTRAINT `sections_sites_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sections_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sequences`
--

DROP TABLE IF EXISTS `sequences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sequences` (
  `name` varchar(255) NOT NULL,
  `next` int(11) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sessions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `token` char(100) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sessions_uid_idx` (`uid`),
  KEY `sessions_token_idx` (`token`),
  KEY `sessions_dateUpdated_idx` (`dateUpdated`),
  KEY `sessions_userId_idx` (`userId`),
  CONSTRAINT `sessions_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `shunnedmessages`
--

DROP TABLE IF EXISTS `shunnedmessages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shunnedmessages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `message` varchar(255) NOT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `shunnedmessages_userId_message_unq_idx` (`userId`,`message`),
  CONSTRAINT `shunnedmessages_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sitegroups`
--

DROP TABLE IF EXISTS `sitegroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sitegroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sitegroups_name_idx` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sites`
--

DROP TABLE IF EXISTS `sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `primary` tinyint(1) NOT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `language` varchar(12) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT 0,
  `baseUrl` varchar(255) DEFAULT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sites_dateDeleted_idx` (`dateDeleted`),
  KEY `sites_handle_idx` (`handle`),
  KEY `sites_sortOrder_idx` (`sortOrder`),
  KEY `sites_groupId_fk` (`groupId`),
  CONSTRAINT `sites_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `sitegroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `structureelements`
--

DROP TABLE IF EXISTS `structureelements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `structureelements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) NOT NULL,
  `elementId` int(11) DEFAULT NULL,
  `root` int(11) unsigned DEFAULT NULL,
  `lft` int(11) unsigned NOT NULL,
  `rgt` int(11) unsigned NOT NULL,
  `level` smallint(6) unsigned NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `structureelements_structureId_elementId_unq_idx` (`structureId`,`elementId`),
  KEY `structureelements_root_idx` (`root`),
  KEY `structureelements_lft_idx` (`lft`),
  KEY `structureelements_rgt_idx` (`rgt`),
  KEY `structureelements_level_idx` (`level`),
  KEY `structureelements_elementId_idx` (`elementId`),
  CONSTRAINT `structureelements_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `structureelements_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `structures`
--

DROP TABLE IF EXISTS `structures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `structures` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `maxLevels` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `structures_dateDeleted_idx` (`dateDeleted`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `systemmessages`
--

DROP TABLE IF EXISTS `systemmessages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `systemmessages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `language` varchar(255) NOT NULL,
  `key` varchar(255) NOT NULL,
  `subject` text NOT NULL,
  `body` text NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `systemmessages_key_language_unq_idx` (`key`,`language`),
  KEY `systemmessages_language_idx` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `taggroups`
--

DROP TABLE IF EXISTS `taggroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `taggroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `taggroups_name_idx` (`name`),
  KEY `taggroups_handle_idx` (`handle`),
  KEY `taggroups_dateDeleted_idx` (`dateDeleted`),
  KEY `taggroups_fieldLayoutId_fk` (`fieldLayoutId`),
  CONSTRAINT `taggroups_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tags` (
  `id` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `deletedWithGroup` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `tags_groupId_idx` (`groupId`),
  CONSTRAINT `tags_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `taggroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `tags_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `templatecacheelements`
--

DROP TABLE IF EXISTS `templatecacheelements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `templatecacheelements` (
  `cacheId` int(11) NOT NULL,
  `elementId` int(11) NOT NULL,
  KEY `templatecacheelements_cacheId_idx` (`cacheId`),
  KEY `templatecacheelements_elementId_idx` (`elementId`),
  CONSTRAINT `templatecacheelements_cacheId_fk` FOREIGN KEY (`cacheId`) REFERENCES `templatecaches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `templatecacheelements_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `templatecachequeries`
--

DROP TABLE IF EXISTS `templatecachequeries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `templatecachequeries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cacheId` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `query` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `templatecachequeries_cacheId_idx` (`cacheId`),
  KEY `templatecachequeries_type_idx` (`type`),
  CONSTRAINT `templatecachequeries_cacheId_fk` FOREIGN KEY (`cacheId`) REFERENCES `templatecaches` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `templatecaches`
--

DROP TABLE IF EXISTS `templatecaches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `templatecaches` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `siteId` int(11) NOT NULL,
  `cacheKey` varchar(255) NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  `expiryDate` datetime NOT NULL,
  `body` mediumtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `templatecaches_cacheKey_siteId_expiryDate_path_idx` (`cacheKey`,`siteId`,`expiryDate`,`path`),
  KEY `templatecaches_cacheKey_siteId_expiryDate_idx` (`cacheKey`,`siteId`,`expiryDate`),
  KEY `templatecaches_siteId_idx` (`siteId`),
  CONSTRAINT `templatecaches_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tokens`
--

DROP TABLE IF EXISTS `tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `token` char(32) NOT NULL,
  `route` text DEFAULT NULL,
  `usageLimit` tinyint(3) unsigned DEFAULT NULL,
  `usageCount` tinyint(3) unsigned DEFAULT NULL,
  `expiryDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `tokens_token_unq_idx` (`token`),
  KEY `tokens_expiryDate_idx` (`expiryDate`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `usergroups`
--

DROP TABLE IF EXISTS `usergroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usergroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `usergroups_handle_unq_idx` (`handle`),
  UNIQUE KEY `usergroups_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `usergroups_users`
--

DROP TABLE IF EXISTS `usergroups_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usergroups_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `usergroups_users_groupId_userId_unq_idx` (`groupId`,`userId`),
  KEY `usergroups_users_userId_idx` (`userId`),
  CONSTRAINT `usergroups_users_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `usergroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `usergroups_users_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `userpermissions`
--

DROP TABLE IF EXISTS `userpermissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userpermissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userpermissions_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `userpermissions_usergroups`
--

DROP TABLE IF EXISTS `userpermissions_usergroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userpermissions_usergroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permissionId` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userpermissions_usergroups_permissionId_groupId_unq_idx` (`permissionId`,`groupId`),
  KEY `userpermissions_usergroups_groupId_idx` (`groupId`),
  CONSTRAINT `userpermissions_usergroups_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `usergroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `userpermissions_usergroups_permissionId_fk` FOREIGN KEY (`permissionId`) REFERENCES `userpermissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `userpermissions_users`
--

DROP TABLE IF EXISTS `userpermissions_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userpermissions_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permissionId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userpermissions_users_permissionId_userId_unq_idx` (`permissionId`,`userId`),
  KEY `userpermissions_users_userId_idx` (`userId`),
  CONSTRAINT `userpermissions_users_permissionId_fk` FOREIGN KEY (`permissionId`) REFERENCES `userpermissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `userpermissions_users_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `userpreferences`
--

DROP TABLE IF EXISTS `userpreferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userpreferences` (
  `userId` int(11) NOT NULL AUTO_INCREMENT,
  `preferences` text DEFAULT NULL,
  PRIMARY KEY (`userId`),
  CONSTRAINT `userpreferences_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `photoId` int(11) DEFAULT NULL,
  `firstName` varchar(100) DEFAULT NULL,
  `lastName` varchar(100) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `admin` tinyint(1) NOT NULL DEFAULT 0,
  `locked` tinyint(1) NOT NULL DEFAULT 0,
  `suspended` tinyint(1) NOT NULL DEFAULT 0,
  `pending` tinyint(1) NOT NULL DEFAULT 0,
  `lastLoginDate` datetime DEFAULT NULL,
  `lastLoginAttemptIp` varchar(45) DEFAULT NULL,
  `invalidLoginWindowStart` datetime DEFAULT NULL,
  `invalidLoginCount` tinyint(3) unsigned DEFAULT NULL,
  `lastInvalidLoginDate` datetime DEFAULT NULL,
  `lockoutDate` datetime DEFAULT NULL,
  `hasDashboard` tinyint(1) NOT NULL DEFAULT 0,
  `verificationCode` varchar(255) DEFAULT NULL,
  `verificationCodeIssuedDate` datetime DEFAULT NULL,
  `unverifiedEmail` varchar(255) DEFAULT NULL,
  `passwordResetRequired` tinyint(1) NOT NULL DEFAULT 0,
  `lastPasswordChangeDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `users_uid_idx` (`uid`),
  KEY `users_verificationCode_idx` (`verificationCode`),
  KEY `users_email_idx` (`email`),
  KEY `users_username_idx` (`username`),
  KEY `users_photoId_fk` (`photoId`),
  CONSTRAINT `users_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `users_photoId_fk` FOREIGN KEY (`photoId`) REFERENCES `assets` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `volumefolders`
--

DROP TABLE IF EXISTS `volumefolders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `volumefolders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parentId` int(11) DEFAULT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `volumefolders_name_parentId_volumeId_unq_idx` (`name`,`parentId`,`volumeId`),
  KEY `volumefolders_parentId_idx` (`parentId`),
  KEY `volumefolders_volumeId_idx` (`volumeId`),
  CONSTRAINT `volumefolders_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `volumefolders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `volumefolders_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `volumes`
--

DROP TABLE IF EXISTS `volumes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `volumes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT 1,
  `url` varchar(255) DEFAULT NULL,
  `settings` text DEFAULT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `volumes_name_idx` (`name`),
  KEY `volumes_handle_idx` (`handle`),
  KEY `volumes_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `volumes_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `volumes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `widgets`
--

DROP TABLE IF EXISTS `widgets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `widgets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `colspan` tinyint(3) DEFAULT NULL,
  `settings` text DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `widgets_userId_idx` (`userId`),
  CONSTRAINT `widgets_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping routines for database 'sandbox_starter'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-05-23 13:06:47
-- MariaDB dump 10.17  Distrib 10.4.11-MariaDB, for osx10.14 (x86_64)
--
-- Host: 127.0.0.1    Database: sandbox_starter
-- ------------------------------------------------------
-- Server version	10.4.11-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Dumping data for table `assets`
--

LOCK TABLES `assets` WRITE;
/*!40000 ALTER TABLE `assets` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `assets` VALUES (82,1,3,NULL,'kat-9.jpg','image',600,600,50227,NULL,NULL,NULL,'2020-04-10 07:08:39','2020-05-03 04:22:32','2020-05-03 04:22:32','ea708b5f-4296-45e1-88c2-0832b978eeed'),(83,1,3,1,'yosemite-5.jpg','image',4166,2343,909242,NULL,NULL,NULL,'2020-05-03 04:45:11','2020-05-03 04:45:11','2020-05-03 04:45:11','23aa4eb4-1bb3-42f7-aaab-3cb83d502287'),(100,2,5,1,'kitteh.jpeg','image',752,360,30087,NULL,NULL,NULL,'2020-05-17 05:05:01','2020-05-17 05:05:01','2020-05-17 05:05:01','4aeded47-9f9a-4685-9d30-bca028661854'),(124,2,5,1,'6e4bfcdf133e0bdfca57226c81d7558b.jpg','image',2300,908,404102,NULL,NULL,NULL,'2020-05-17 05:45:32','2020-05-17 05:45:32','2020-05-17 05:45:32','de7f14d7-f032-465e-bb26-4bbf9a564e38'),(125,2,5,1,'950223-top-harry-potter-book-wallpapers-1920x1080-for-samsung-galaxy.jpg','image',1920,1080,354302,NULL,NULL,NULL,'2020-05-17 05:45:32','2020-05-17 05:45:32','2020-05-17 05:45:32','07ed72bb-3019-4de2-bf82-effb77745d3c'),(126,2,5,1,'chamber-of-secrets-full-jacket.jpg','image',1740,727,322969,NULL,NULL,NULL,'2020-05-17 05:45:33','2020-05-17 05:45:33','2020-05-17 05:45:33','db71afea-23db-4bec-bc96-f6009bb06931'),(127,2,5,1,'half-blood-prince-full-jacket-1024x459.jpg','image',1024,459,87613,NULL,NULL,NULL,'2020-05-17 05:45:33','2020-05-17 05:45:33','2020-05-17 05:45:33','85aa3d9a-9078-403a-9946-ae7c977eef33'),(128,2,5,1,'harry-hallow.jpg','image',1200,443,74992,NULL,NULL,NULL,'2020-05-17 05:45:33','2020-05-17 05:45:33','2020-05-17 05:45:33','27bff413-d3b1-438f-b952-018151257d53'),(129,2,5,1,'harry-potter-and-the-order-of-the-phoenix-cover.jpg','image',578,221,47735,NULL,NULL,NULL,'2020-05-17 05:45:34','2020-05-17 05:45:34','2020-05-17 05:45:34','3fa280d0-4415-4105-b86e-ee01be6fc75f'),(130,2,5,1,'md_4b37c5837b6a-harry-potter-quotes_feature-prisoner-of-azkaban-cover.jpg','image',710,287,36768,NULL,NULL,NULL,'2020-05-17 05:45:34','2020-05-17 05:45:34','2020-05-17 05:45:34','cd5b663d-0fee-48a8-ad90-97e9ea50abff');
/*!40000 ALTER TABLE `assets` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `assettransforms`
--

LOCK TABLES `assettransforms` WRITE;
/*!40000 ALTER TABLE `assettransforms` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `assettransforms` VALUES (2,'Image with wrapping text','imageWithWrappingText','fit','center-center',360,360,NULL,NULL,'none','2020-04-30 06:14:07','2020-04-30 06:14:07','2020-05-02 05:00:51','2d645b41-72a4-4f60-a394-8a23532182be'),(3,'Panel - Centered','panelCentered','fit','center-center',800,600,NULL,NULL,'none','2020-05-02 04:54:53','2020-04-30 06:14:20','2020-05-02 05:04:37','b93b65d5-8f07-4336-9076-50380ebd3125'),(4,'News - Full','newsFull','fit','center-center',1500,NULL,NULL,NULL,'none','2020-05-02 05:06:02','2020-04-30 06:19:11','2020-05-02 05:06:21','0b9df5d0-d595-4817-913b-d88deb15e24c'),(5,'News - Thumbnail','newsThumbnail','crop','center-center',740,440,NULL,NULL,'none','2020-05-02 05:06:59','2020-04-30 06:19:55','2020-05-02 05:06:59','88f6b708-b03e-4757-bb34-1a3b378ff3c8'),(6,'Panel - Full','panelFull','crop','center-center',1500,NULL,NULL,NULL,'none','2020-05-02 04:59:38','2020-05-02 04:59:38','2020-05-02 05:00:27','67c4c4c3-a551-4f40-9e6a-a1069402e483');
/*!40000 ALTER TABLE `assettransforms` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `categorygroups`
--

LOCK TABLES `categorygroups` WRITE;
/*!40000 ALTER TABLE `categorygroups` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `categorygroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `categorygroups_sites`
--

LOCK TABLES `categorygroups_sites` WRITE;
/*!40000 ALTER TABLE `categorygroups_sites` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `categorygroups_sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `changedattributes`
--

LOCK TABLES `changedattributes` WRITE;
/*!40000 ALTER TABLE `changedattributes` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `changedattributes` VALUES (37,1,'fieldLayoutId','2020-04-17 04:24:47',0,1),(37,1,'slug','2020-04-13 08:01:30',0,1),(37,1,'title','2020-04-13 08:01:30',0,1),(37,1,'typeId','2020-04-17 04:24:47',0,1),(37,1,'uri','2020-04-13 08:01:30',0,1),(60,1,'slug','2020-04-19 04:57:05',0,1),(60,1,'title','2020-04-19 04:57:05',0,1),(60,1,'uri','2020-04-19 04:57:05',0,1),(73,1,'fieldLayoutId','2020-04-13 08:04:41',0,1),(73,1,'typeId','2020-04-13 08:04:41',0,1),(76,1,'title','2020-04-25 18:38:57',0,1),(78,1,'typeId','2020-04-18 20:32:35',0,1),(91,1,'fieldLayoutId','2020-05-03 07:08:47',0,1);
/*!40000 ALTER TABLE `changedattributes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `changedfields`
--

LOCK TABLES `changedfields` WRITE;
/*!40000 ALTER TABLE `changedfields` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `changedfields` VALUES (37,1,1,'2020-05-03 06:32:51',0,1),(45,1,1,'2020-05-03 07:04:16',0,1),(60,1,1,'2020-05-03 07:03:57',0,1),(60,1,19,'2020-05-03 07:03:45',0,1),(73,1,1,'2020-05-02 04:52:06',0,1),(91,1,1,'2020-05-03 07:09:42',0,1),(91,1,20,'2020-05-17 05:06:03',0,1),(99,1,20,'2020-05-17 06:24:04',0,1),(104,1,1,'2020-05-17 05:54:34',0,1),(104,1,20,'2020-05-17 05:46:43',0,1),(107,1,1,'2020-05-17 05:54:07',0,1),(107,1,20,'2020-05-17 05:46:28',0,1),(110,1,1,'2020-05-17 05:53:47',0,1),(110,1,20,'2020-05-17 05:45:44',0,1),(113,1,1,'2020-05-17 05:53:18',0,1),(113,1,20,'2020-05-17 05:46:20',0,1),(116,1,1,'2020-05-17 05:50:02',0,1),(116,1,20,'2020-05-17 05:46:02',0,1),(119,1,1,'2020-05-17 05:51:35',0,1),(119,1,20,'2020-05-17 05:46:09',0,1),(122,1,1,'2020-05-17 05:52:11',0,1),(122,1,20,'2020-05-17 05:45:52',0,1);
/*!40000 ALTER TABLE `changedfields` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `content`
--

LOCK TABLES `content` WRITE;
/*!40000 ALTER TABLE `content` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `content` VALUES (1,1,1,NULL,'2020-02-05 21:43:45','2020-05-15 22:04:44','4d29c7db-1296-4966-9acb-9a9ea7ecfe65',NULL),(2,2,1,NULL,'2020-02-05 22:50:05','2020-02-05 22:50:09','748a7aad-02aa-4305-9aef-dd66a94e2096',NULL),(3,4,1,NULL,'2020-02-05 22:50:46','2020-02-05 22:51:10','ef840b66-a893-4f45-b85d-6fcc19ef97b2',NULL),(4,14,1,NULL,'2020-02-05 22:52:06','2020-02-05 22:52:10','ba671378-45cd-4589-8710-5fd09da935dc',NULL),(5,16,1,NULL,'2020-02-05 22:52:42','2020-02-05 22:52:44','4ed9e5e6-4718-4c19-8a34-3e5487eab1a3',NULL),(6,18,1,NULL,'2020-02-05 23:21:09','2020-02-05 23:21:09','1c4b3dce-18be-4c83-a018-9452f91bf241',NULL),(7,19,1,NULL,'2020-02-05 23:25:26','2020-02-05 23:27:19','5291d0c8-8768-4fa4-86b6-7c176a0a3e10',NULL),(8,29,1,'E','2020-02-05 23:33:22','2020-02-05 23:33:27','e40bde1a-a472-49db-ae8b-546336f243d1',NULL),(10,37,1,'Homepage','2020-02-05 23:34:00','2020-05-03 07:04:31','24fb4f9a-da53-45b2-be81-877aa787f657',NULL),(12,45,1,'404','2020-04-09 22:55:25','2020-05-03 07:04:16','a3f4c14a-c7ad-40f5-8047-e0283a74edf2',NULL),(13,47,1,NULL,'2020-04-10 05:05:37','2020-04-10 05:05:43','c2284390-fd45-4fd5-a73d-61182a5d7f86',NULL),(14,49,1,NULL,'2020-04-10 05:07:58','2020-04-10 05:08:01','0b886be1-edc4-4e0f-8631-7b30f368f7f9',NULL),(16,58,1,'Kat 9','2020-04-10 07:08:18','2020-04-10 07:08:39','3bc8ec07-447a-41bb-a255-3383b270be67',NULL),(18,60,1,'About','2020-04-11 21:59:02','2020-05-03 07:03:57','4532dcd9-07b1-460f-86ac-033f05ea40d1','89'),(22,73,1,'Contact','2020-04-13 08:00:40','2020-05-02 04:52:06','94038d96-b3e7-41b9-b7df-12aaab0bca70',NULL),(24,76,1,'Homepage - 3 icons at top','2020-04-18 19:50:57','2020-05-02 04:51:10','9dbfc442-5aab-4987-877d-49192e45de6a',NULL),(26,78,1,'Featured Products','2020-04-18 19:57:05','2020-05-02 04:51:11','c168a751-dd6e-4a4e-826c-dd334fd09fa5',NULL),(27,81,1,NULL,'2020-04-19 04:46:48','2020-04-19 04:46:48','85211eaf-3dc6-4b05-a8f7-11ac17a99e0e',NULL),(28,82,1,'Kat 9','2020-05-03 04:22:32','2020-05-03 04:22:32','56901645-6234-4267-a724-58c63d74326c',NULL),(29,83,1,'Yosemite 5','2020-05-03 04:45:10','2020-05-03 04:45:10','d9fa63c9-647a-4782-9a97-d393ba75392d',NULL),(30,86,1,NULL,'2020-05-03 05:06:58','2020-05-03 05:07:02','6f4421ae-8aa0-4a08-9743-726c6acbd12b',NULL),(31,87,1,NULL,'2020-05-03 06:41:08','2020-05-03 06:41:08','1c5f73c8-0b92-472c-8d3b-32f66564c13e',NULL),(33,89,1,'Latest News','2020-05-03 07:03:22','2020-05-03 07:03:22','27d47113-9873-4b11-af8d-3314163ff177',NULL),(35,91,1,'Lorem Ipsum','2020-05-03 07:08:30','2020-05-17 05:06:03','92645249-6798-4391-b487-23e2c18cd9ca',NULL),(36,92,1,'Lorem Ipsum','2020-05-03 07:08:30','2020-05-03 07:08:30','c2c7627e-5b5c-43b0-9910-4f51326db52a',NULL),(37,94,1,'Lorem Ipsum','2020-05-03 07:09:42','2020-05-03 07:09:42','8a6f45fb-4276-43fd-95ce-b980f9047930',NULL),(38,96,1,'Lorem Ipsum','2020-05-03 07:12:14','2020-05-03 07:12:14','b99e6764-74f7-406f-afb4-496017176714',NULL),(40,99,1,'News','2020-05-17 04:55:59','2020-05-17 06:24:04','dea9a985-3a9a-45d3-b256-9615e8e970a2',NULL),(41,100,1,'Kitteh','2020-05-17 05:05:01','2020-05-17 05:05:01','7adb9c8b-7d75-412d-b239-f45cec5935cd',NULL),(42,101,1,'Lorem Ipsum','2020-05-17 05:06:03','2020-05-17 05:06:03','5f95553a-a734-4ea8-9ec4-50a17917654f',NULL),(44,104,1,'The Sorcerer\'s Stone','2020-05-17 05:35:27','2020-05-17 05:54:34','b2300416-e0c9-4155-a6b1-031763967c1b',NULL),(45,105,1,'The Sorcerer\'s Stone','2020-05-17 05:35:27','2020-05-17 05:35:27','7cf6f598-cc6a-499c-ab2c-8c237768e5c4',NULL),(47,107,1,'The Chamber of Secrets','2020-05-17 05:35:53','2020-05-17 05:54:06','43cafbb1-45a6-412d-8d16-83d7eadb1706',NULL),(48,108,1,'The Chamber of Secrets','2020-05-17 05:35:53','2020-05-17 05:35:53','aefbbfa1-ff73-40c0-b907-f41d477f55a2',NULL),(50,110,1,'The Prisoner of Azkaban','2020-05-17 05:36:16','2020-05-17 05:53:47','c7010640-3236-48e3-88de-9a1074719e76',NULL),(51,111,1,'The Prisoner of Azkaban','2020-05-17 05:36:16','2020-05-17 05:36:16','5f710786-0e4c-4e3a-bf5b-2b5f22d17f31',NULL),(53,113,1,'The Goblet of Fire','2020-05-17 05:36:31','2020-05-17 05:53:18','c84a1e1d-088b-4bb1-86e7-4674c51a76c1',NULL),(54,114,1,'The Goblet of Fire','2020-05-17 05:36:31','2020-05-17 05:36:31','e4fdefbe-a4d0-4f3c-b874-e90918a64d14',NULL),(56,116,1,'The Order of the Phoenix','2020-05-17 05:36:48','2020-05-17 05:50:02','201ae6bf-2756-4a28-a8a5-306f073b7602',NULL),(57,117,1,'The Order of the Phoenix','2020-05-17 05:36:48','2020-05-17 05:36:48','2e4a9c83-7865-49ff-b27d-aba1500eb3c4',NULL),(59,119,1,'The Half-Blood Prince','2020-05-17 05:37:05','2020-05-17 05:51:35','220afbee-814e-4dfd-8cd9-5f53ae2c8ff8',NULL),(60,120,1,'The Half-Blood Prince','2020-05-17 05:37:05','2020-05-17 05:37:05','15e24a36-1612-42a2-bdd4-510d8db0f361',NULL),(62,122,1,'The Deathly Hallows','2020-05-17 05:37:23','2020-05-17 05:52:10','d279af2e-51e1-4180-956c-e384aed925c6',NULL),(63,123,1,'The Deathly Hallows','2020-05-17 05:37:23','2020-05-17 05:37:23','269eb45e-4dfd-4f11-aa75-a3bb2065d052',NULL),(64,124,1,'6e4bfcdf133e0bdfca57226c81d7558b','2020-05-17 05:45:31','2020-05-17 05:45:31','07493fae-a390-40f3-8d94-44c57525cc2e',NULL),(65,125,1,'950223 top harry potter book wallpapers 1920x1080 for samsung galaxy','2020-05-17 05:45:32','2020-05-17 05:45:32','f1287d9f-512e-4509-aad7-77173894d7ba',NULL),(66,126,1,'Chamber of secrets full jacket','2020-05-17 05:45:33','2020-05-17 05:45:33','ae28e3e3-bc89-401d-bbea-6824f12ebd94',NULL),(67,127,1,'Half blood prince full jacket 1024x459','2020-05-17 05:45:33','2020-05-17 05:45:33','4ec326b5-5a02-4283-9f36-edaef8e66963',NULL),(68,128,1,'Harry hallow','2020-05-17 05:45:33','2020-05-17 05:45:33','7d26d8e1-bb10-47e1-bb49-bb0318424de4',NULL),(69,129,1,'Harry potter and the order of the phoenix cover','2020-05-17 05:45:34','2020-05-17 05:45:34','accca605-bb46-48ed-83d2-44bc3d838d70',NULL),(70,130,1,'Md 4b37c5837b6a harry potter quotes feature prisoner of azkaban cover','2020-05-17 05:45:34','2020-05-17 05:45:34','da045fc8-8a92-4e68-a4bd-2133aade7f29',NULL),(71,131,1,'The Prisoner of Azkaban','2020-05-17 05:45:44','2020-05-17 05:45:44','2319fa4e-dd1a-4e07-9c06-6d44a245304e',NULL),(72,132,1,'The Deathly Hallows','2020-05-17 05:45:52','2020-05-17 05:45:52','4dec01e0-3f21-4f8e-b4b8-23458141fd6e',NULL),(73,133,1,'The Order of the Phoenix','2020-05-17 05:46:02','2020-05-17 05:46:02','d687647d-36f2-4853-8f1c-c2bab1edb61f',NULL),(74,134,1,'The Half-Blood Prince','2020-05-17 05:46:09','2020-05-17 05:46:09','26a186e5-82c7-44ec-9e49-5862f04dbf2c',NULL),(75,135,1,'The Goblet of Fire','2020-05-17 05:46:20','2020-05-17 05:46:20','80ac0768-f5f8-45ca-89ed-1291cbbaaf29',NULL),(76,136,1,'The Chamber of Secrets','2020-05-17 05:46:28','2020-05-17 05:46:28','a4da7210-45c8-42a8-9cad-b64723b59c97',NULL),(77,137,1,'The Sorcerer\'s Stone','2020-05-17 05:46:43','2020-05-17 05:46:43','a503bd24-8208-46aa-9de6-59976e15f2a2',NULL),(78,139,1,'The Order of the Phoenix','2020-05-17 05:50:02','2020-05-17 05:50:02','8b983c4b-f9c4-4c8c-aa57-bc9dbc562800',NULL),(79,142,1,'The Half-Blood Prince','2020-05-17 05:51:35','2020-05-17 05:51:35','7ca3c616-e012-473c-a9a2-20b97126d144',NULL),(80,145,1,'The Deathly Hallows','2020-05-17 05:52:11','2020-05-17 05:52:11','3ff3b049-8af3-4321-aca1-f3e4ba75fe6b',NULL),(81,148,1,'The Goblet of Fire','2020-05-17 05:53:18','2020-05-17 05:53:18','23aee88b-8abb-40af-95bb-d7e8517a0764',NULL),(82,151,1,'The Prisoner of Azkaban','2020-05-17 05:53:47','2020-05-17 05:53:47','b05075e2-f9bb-4747-a3f0-9c49d6eee725',NULL),(83,154,1,'The Chamber of Secrets','2020-05-17 05:54:06','2020-05-17 05:54:06','43319262-24b0-4d94-90a9-2f7465fee7f3',NULL),(84,157,1,'The Sorcerer\'s Stone','2020-05-17 05:54:34','2020-05-17 05:54:34','31997c19-5d24-4ce8-a859-0929bcb2d383',NULL);
/*!40000 ALTER TABLE `content` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craftidtokens`
--

LOCK TABLES `craftidtokens` WRITE;
/*!40000 ALTER TABLE `craftidtokens` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craftidtokens` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `deprecationerrors`
--

LOCK TABLES `deprecationerrors` WRITE;
/*!40000 ALTER TABLE `deprecationerrors` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `deprecationerrors` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `drafts`
--

LOCK TABLES `drafts` WRITE;
/*!40000 ALTER TABLE `drafts` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `drafts` VALUES (1,NULL,1,'First draft','',0,NULL),(2,NULL,1,'First draft','',0,NULL),(3,NULL,1,'First draft','',0,NULL),(4,NULL,1,'First draft','',0,NULL),(5,NULL,1,'First draft',NULL,0,NULL),(6,NULL,1,'First draft','',0,NULL),(7,NULL,1,'First draft','',0,NULL),(10,NULL,1,'First draft','',0,NULL),(11,NULL,1,'First draft','',0,NULL),(19,NULL,1,'First draft',NULL,0,NULL),(20,NULL,1,'First draft','',0,NULL),(21,NULL,1,'First draft',NULL,0,NULL);
/*!40000 ALTER TABLE `drafts` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `elementindexsettings`
--

LOCK TABLES `elementindexsettings` WRITE;
/*!40000 ALTER TABLE `elementindexsettings` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `elementindexsettings` VALUES (1,'craft\\elements\\Entry','{\"sources\":{\"section:b0ac9541-cb53-4dc6-86e4-56cb0604c874\":{\"tableAttributes\":{\"1\":\"uri\",\"2\":\"type\",\"3\":\"field:19\"}},\"section:34bba139-c036-4e65-a8c0-bf6c451a4e12\":{\"tableAttributes\":{\"1\":\"type\"}},\"section:5deeb93f-33f2-42e4-ba35-4b9afe03c4b3\":{\"tableAttributes\":{\"1\":\"type\"}},\"section:f52621ed-e4a9-4525-93f8-a804b6e72dfc\":{\"tableAttributes\":{\"1\":\"field:20\",\"2\":\"uri\"}}},\"sourceOrder\":[[\"heading\",\"Main Content\"],[\"key\",\"section:b0ac9541-cb53-4dc6-86e4-56cb0604c874\"],[\"key\",\"section:34bba139-c036-4e65-a8c0-bf6c451a4e12\"],[\"key\",\"section:5deeb93f-33f2-42e4-ba35-4b9afe03c4b3\"],[\"heading\",\"Additional Content\"],[\"key\",\"section:f52621ed-e4a9-4525-93f8-a804b6e72dfc\"]]}','2020-05-17 05:37:47','2020-05-17 05:37:47','0fbba64a-d2d3-401e-8ee4-07b55b19acd7'),(6,'craft\\elements\\Asset','{\"sources\":{\"folder:6a965c82-81dd-44ca-a170-1445d0e9d33f\":{\"tableAttributes\":{\"1\":\"filename\",\"2\":\"link\",\"3\":\"imageSize\",\"4\":\"size\"}},\"folder:1d0fa6c4-5bdd-4af8-b18f-f3b1ceb0813e\":{\"tableAttributes\":{\"1\":\"filename\",\"2\":\"link\",\"3\":\"imageSize\",\"4\":\"size\"}},\"folder:64389f66-a9e7-40b4-bf43-faa712d8b430\":{\"tableAttributes\":{\"1\":\"filename\",\"2\":\"link\",\"3\":\"imageSize\",\"4\":\"size\"}}}}','2020-05-03 04:46:52','2020-05-03 04:46:52','bec3bad2-41a6-45d6-91d5-66b82b77d000');
/*!40000 ALTER TABLE `elementindexsettings` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `elements`
--

LOCK TABLES `elements` WRITE;
/*!40000 ALTER TABLE `elements` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `elements` VALUES (1,NULL,NULL,NULL,'craft\\elements\\User',1,0,'2020-02-05 21:43:45','2020-05-15 22:04:44',NULL,'4c876527-4467-449e-b53b-a0bef475edd9'),(2,1,NULL,3,'craft\\elements\\Entry',1,0,'2020-02-05 22:50:05','2020-02-05 22:50:09',NULL,'eefdb1c9-cab5-445b-b8f8-0d187a40d276'),(3,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-02-05 22:50:09','2020-02-05 22:50:09',NULL,'7bf2ed3f-53f2-429f-993b-22c71ffd3563'),(4,2,NULL,3,'craft\\elements\\Entry',1,0,'2020-02-05 22:50:46','2020-02-05 22:51:10',NULL,'80d0c265-efcb-4768-92e4-4f5ab560e1e2'),(5,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-02-05 22:50:49','2020-02-05 22:50:49','2020-02-05 22:50:59','67a86fc8-4851-4543-99d0-de40d9b8393a'),(6,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-02-05 22:50:59','2020-02-05 22:50:59','2020-02-05 22:51:00','16587711-9f52-4981-9494-e86f1b629c9e'),(7,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-02-05 22:51:00','2020-02-05 22:51:00','2020-02-05 22:51:02','c60e2468-588f-4a00-a9ca-6c358b26e3ba'),(8,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-02-05 22:51:02','2020-02-05 22:51:02','2020-02-05 22:51:03','4279fd60-b679-4685-ac2f-fcd8d13dcd35'),(9,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-02-05 22:51:03','2020-02-05 22:51:03','2020-02-05 22:51:05','87f95247-60ea-4ff2-86cc-c9b96239e074'),(10,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-02-05 22:51:05','2020-02-05 22:51:05','2020-02-05 22:51:07','d35fd5f1-0437-41a3-9c29-7404d7dad313'),(11,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-02-05 22:51:07','2020-02-05 22:51:07','2020-02-05 22:51:09','241ade6b-f18a-4da2-8fff-5e5f7912db47'),(12,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-02-05 22:51:09','2020-02-05 22:51:09','2020-02-05 22:51:10','90b739e6-936d-44b4-bcb2-43bf17914433'),(13,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-02-05 22:51:10','2020-02-05 22:51:10',NULL,'577b0675-1e0b-4a7c-9b50-92898466f03c'),(14,3,NULL,3,'craft\\elements\\Entry',1,0,'2020-02-05 22:52:06','2020-02-05 22:52:10',NULL,'05a0bb71-49f9-47be-87a4-54a978ec0960'),(15,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-02-05 22:52:10','2020-02-05 22:52:10',NULL,'04f8dceb-52ed-43e2-bd11-3ba42abc2e78'),(16,4,NULL,3,'craft\\elements\\Entry',1,0,'2020-02-05 22:52:42','2020-02-05 22:52:44',NULL,'b0931fa0-bc0b-44a6-a645-307085127020'),(17,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-02-05 22:52:44','2020-02-05 22:52:44',NULL,'b5682ca0-136c-40c1-8a57-dee2c61ddaa2'),(18,5,NULL,3,'craft\\elements\\Entry',1,0,'2020-02-05 23:21:09','2020-02-05 23:21:09',NULL,'3012a4aa-2aa5-41e9-81b5-0cc80046ceab'),(19,6,NULL,3,'craft\\elements\\Entry',1,0,'2020-02-05 23:25:26','2020-02-05 23:27:19',NULL,'e13466e4-61ce-4069-b8b4-427489a8c32b'),(20,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-02-05 23:25:29','2020-02-05 23:25:29','2020-02-05 23:25:31','0f751371-9d00-4a38-9302-84555406e867'),(21,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-02-05 23:25:31','2020-02-05 23:25:31','2020-02-05 23:27:09','e2b82e95-3019-4624-94f6-2d3ee0251ee3'),(22,NULL,NULL,5,'craft\\elements\\MatrixBlock',1,0,'2020-02-05 23:25:31','2020-02-05 23:25:31','2020-02-05 23:27:09','b31a173c-1bec-43f7-9a61-052b4019f279'),(23,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-02-05 23:27:09','2020-02-05 23:27:09','2020-02-05 23:27:18','6cca0825-a208-43f0-a8d0-c45daa9ea762'),(24,NULL,NULL,5,'craft\\elements\\MatrixBlock',1,0,'2020-02-05 23:27:09','2020-02-05 23:27:09','2020-02-05 23:27:18','8bfbf9b7-9cc8-4068-ae4e-38883e22dc34'),(25,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-02-05 23:27:17','2020-02-05 23:27:17','2020-02-05 23:27:19','9e0127dd-b0b4-452e-b39e-2feb3949d67b'),(26,NULL,NULL,5,'craft\\elements\\MatrixBlock',1,0,'2020-02-05 23:27:17','2020-02-05 23:27:17','2020-02-05 23:27:19','c3af2bc8-476c-4152-a726-d99cfd83d064'),(27,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-02-05 23:27:19','2020-02-05 23:27:19',NULL,'eb4aa375-e4b8-4d4e-b883-6fa93ddfd8e0'),(28,NULL,NULL,5,'craft\\elements\\MatrixBlock',1,0,'2020-02-05 23:27:19','2020-02-05 23:27:19',NULL,'f3501799-7a32-4ba9-a135-fdd9c4b50f93'),(29,7,NULL,3,'craft\\elements\\Entry',1,0,'2020-02-05 23:33:22','2020-02-05 23:33:27',NULL,'01da47e4-61a9-4064-a2a5-deda56c31c6c'),(31,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-02-05 23:33:42','2020-02-05 23:33:42','2020-02-05 23:33:45','fd283086-413e-4184-8d08-fc31f90ce927'),(32,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-02-05 23:33:45','2020-02-05 23:33:45','2020-02-05 23:33:47','b17f40bc-1fcf-4458-b722-45e11183bb99'),(33,NULL,NULL,5,'craft\\elements\\MatrixBlock',1,0,'2020-02-05 23:33:45','2020-02-05 23:33:45','2020-02-05 23:33:47','b7796cdb-371e-48b4-914b-d7f47c6e49c9'),(37,NULL,NULL,10,'craft\\elements\\Entry',1,0,'2020-02-05 23:34:00','2020-05-03 07:04:31',NULL,'c2c319a1-8865-4b2f-bd7e-fddcb876b011'),(38,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-02-05 23:34:00','2020-04-10 04:20:51','2020-04-10 07:03:10','3a64f542-c06c-4d4c-a202-700789042351'),(39,NULL,NULL,5,'craft\\elements\\MatrixBlock',1,0,'2020-02-05 23:34:00','2020-04-09 06:29:56','2020-04-10 07:03:10','c1640def-0865-4ecd-a689-4a7553730783'),(40,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-05 23:34:00','2020-04-09 06:29:56','2020-04-10 07:03:10','8230b28a-861d-4ee6-b07d-e310b98db060'),(42,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-04-09 22:55:14','2020-04-09 22:55:14','2020-04-09 22:55:21','d765478e-24b5-48eb-95a0-e47f30fb3894'),(43,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-04-09 22:55:20','2020-04-09 22:55:20','2020-04-09 22:55:25','2c348f39-70a2-4ecd-b652-258f308d84f5'),(45,NULL,NULL,3,'craft\\elements\\Entry',1,0,'2020-04-09 22:55:25','2020-05-03 07:04:16',NULL,'4149858d-556e-4103-8b20-9c806d45fe09'),(46,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-04-09 22:55:25','2020-05-03 07:04:16',NULL,'a3a97ce4-5dcf-47b6-b38d-4c09aa29163a'),(47,10,NULL,3,'craft\\elements\\Entry',1,0,'2020-04-10 05:05:37','2020-04-10 05:05:43',NULL,'2bdfad91-5d4e-47a7-a0a6-f0d50e2f8914'),(48,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-04-10 05:05:43','2020-04-10 05:05:43',NULL,'7e04d997-4876-4a78-8063-84ff2cf59803'),(49,11,NULL,3,'craft\\elements\\Entry',1,0,'2020-04-10 05:07:58','2020-04-10 05:08:01',NULL,'fda9bf53-aa03-46a6-9cf8-5d7a7b4f5e35'),(50,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-04-10 05:08:01','2020-04-10 05:08:01',NULL,'36931d73-cc0e-44a1-b290-cb73205914f1'),(55,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-04-10 07:03:10','2020-05-03 04:48:20',NULL,'8109750e-ab30-4129-9efc-9c893443334f'),(56,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-04-10 07:03:10','2020-05-03 04:51:49',NULL,'54bd9ec9-a2ee-470a-b6e8-f309dc6533c0'),(57,NULL,NULL,5,'craft\\elements\\MatrixBlock',0,0,'2020-04-10 07:03:10','2020-05-02 04:52:06',NULL,'bea379b9-1d15-445e-8f55-18b7eed33d06'),(58,NULL,NULL,NULL,'craft\\elements\\Asset',1,0,'2020-04-10 07:08:18','2020-04-10 07:08:39','2020-05-03 04:22:37','75dd88cd-7014-4675-826a-2c4b5e30889f'),(60,NULL,NULL,3,'craft\\elements\\Entry',1,0,'2020-04-11 21:59:02','2020-05-03 07:03:57',NULL,'a207a9b4-4f44-4bb7-9fd9-453ad6ec7e1b'),(63,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-04-12 05:00:35','2020-04-12 05:00:35','2020-04-12 05:00:48','c5d30c0e-d83a-49b6-844f-1d18bdc6ce79'),(64,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-04-12 05:00:47','2020-04-12 05:00:47','2020-04-12 05:00:48','e9ffafb5-b74f-46b1-9ae2-c9f6bfd8f696'),(65,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-04-12 05:00:48','2020-04-12 05:00:48','2020-04-12 05:00:50','74ac1c50-3a2b-41ba-8326-7cadbec109ed'),(66,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-04-12 05:00:50','2020-04-12 05:00:50','2020-04-12 05:00:53','ca388e91-6b38-4317-ac5d-c7b6e84fe21b'),(67,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-04-12 05:00:53','2020-04-12 05:00:53','2020-04-12 05:00:57','8e41cad4-de85-4979-8acc-489d990a3843'),(68,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-04-12 05:00:57','2020-04-12 05:00:57','2020-04-12 05:00:57','08595842-9a61-43ec-8ea4-71b360192f48'),(69,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-04-12 05:00:57','2020-04-12 05:00:57','2020-04-12 05:01:03','7b496441-875c-4a48-8960-bb05e4e4d5f7'),(71,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-04-12 05:01:03','2020-05-03 07:03:57',NULL,'dbced2e0-fd99-42c4-85e9-d14864f49660'),(73,NULL,NULL,9,'craft\\elements\\Entry',1,0,'2020-04-13 08:00:40','2020-04-13 08:04:41',NULL,'0f26f18c-004d-46ff-8743-a6f13b544283'),(74,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-04-17 04:10:08','2020-04-17 04:10:08','2020-04-17 04:10:36','149dcfdd-a6cd-4fcd-a371-36a15827a280'),(76,NULL,NULL,NULL,'craft\\elements\\Entry',1,0,'2020-04-18 19:50:57','2020-04-25 18:38:57',NULL,'ab0a2d7f-5677-46d6-9046-f2bd87564270'),(78,NULL,NULL,NULL,'craft\\elements\\Entry',1,0,'2020-04-18 19:57:05','2020-04-18 20:32:35','2020-05-03 05:04:38','8b2a4c87-cc0b-4e51-922a-02523454961e'),(79,NULL,NULL,11,'craft\\elements\\MatrixBlock',1,0,'2020-04-18 19:58:33','2020-05-02 04:52:06',NULL,'7719424f-56d2-4f8a-9af6-dffe61a786c8'),(80,NULL,NULL,11,'craft\\elements\\MatrixBlock',1,0,'2020-04-18 20:33:18','2020-05-02 04:52:06',NULL,'b3a91594-5863-4044-8806-ab6ea4cde387'),(81,19,NULL,3,'craft\\elements\\Entry',1,0,'2020-04-19 04:46:48','2020-04-19 04:46:48',NULL,'940d8243-2909-4db7-a287-cdc118beb469'),(82,NULL,NULL,NULL,'craft\\elements\\Asset',1,0,'2020-05-03 04:22:32','2020-05-03 04:22:32',NULL,'c7281c0f-7e89-4dc5-bc11-cf69e50a2df6'),(83,NULL,NULL,NULL,'craft\\elements\\Asset',1,0,'2020-05-03 04:45:10','2020-05-03 04:45:10',NULL,'bc8ba83b-2d97-4783-9731-32c1b25fcb02'),(84,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-05-03 04:51:06','2020-05-03 04:54:35',NULL,'116d4765-533a-4b38-8e9f-9c9ad24c9149'),(85,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-05-03 04:51:49','2020-05-03 06:32:51',NULL,'84507938-eb34-4e14-beb5-c93ee70d15fa'),(86,20,NULL,NULL,'craft\\elements\\Entry',1,0,'2020-05-03 05:06:58','2020-05-03 05:07:01',NULL,'8701aede-71e2-4c7b-8193-74254835ca02'),(87,21,NULL,NULL,'craft\\elements\\Entry',1,0,'2020-05-03 06:41:08','2020-05-03 06:41:08',NULL,'db3fda7f-0d03-4acb-b0c3-c89c5b0e9652'),(89,NULL,NULL,NULL,'craft\\elements\\Entry',1,0,'2020-05-03 07:03:22','2020-05-03 07:03:22',NULL,'34d40ca5-39f6-4e9e-8737-204e29501078'),(91,NULL,NULL,13,'craft\\elements\\Entry',1,0,'2020-05-03 07:08:30','2020-05-17 05:06:03','2020-05-17 05:47:05','d3ab6892-082d-4675-bd71-685a7b2704ce'),(92,NULL,1,NULL,'craft\\elements\\Entry',1,0,'2020-05-03 07:08:30','2020-05-03 07:08:30','2020-05-17 05:47:05','41c35e19-5f62-4853-9757-733b6255cbc6'),(93,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-05-03 07:09:42','2020-05-03 07:09:42','2020-05-17 05:47:05','ffff0991-0e54-4acf-83da-5c08439d5f38'),(94,NULL,2,13,'craft\\elements\\Entry',1,0,'2020-05-03 07:09:42','2020-05-03 07:09:42','2020-05-17 05:47:05','355c0fb3-0fb7-4e4f-85d9-156827376984'),(95,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-05-03 07:09:42','2020-05-03 07:09:42',NULL,'6d2fe444-7a2a-417b-abe9-1069495f2e0b'),(96,NULL,3,13,'craft\\elements\\Entry',1,0,'2020-05-03 07:12:14','2020-05-03 07:12:14','2020-05-17 05:47:05','a14284f4-5134-41e4-83a6-8e03ba832294'),(97,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-05-03 07:12:14','2020-05-03 07:09:42',NULL,'d4f6eb25-64a9-4d27-812d-1638f9960c51'),(99,NULL,NULL,14,'craft\\elements\\Entry',1,0,'2020-05-17 04:55:59','2020-05-17 06:24:04',NULL,'8db08030-3582-4fe5-9556-75796a4acae5'),(100,NULL,NULL,NULL,'craft\\elements\\Asset',1,0,'2020-05-17 05:05:01','2020-05-17 05:05:01',NULL,'24cb5b96-b566-46fd-a649-0f0b84518a46'),(101,NULL,4,13,'craft\\elements\\Entry',1,0,'2020-05-17 05:06:03','2020-05-17 05:06:03','2020-05-17 05:47:05','14e87c09-ca47-465e-9794-3689c4377a4b'),(102,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-05-17 05:06:03','2020-05-03 07:09:42',NULL,'b73c3151-042b-43b8-969f-497ce8e20030'),(104,NULL,NULL,13,'craft\\elements\\Entry',1,0,'2020-05-17 05:35:27','2020-05-17 05:54:34',NULL,'e8c5a7e6-9644-4512-8fb9-9d4859c2a493'),(105,NULL,5,13,'craft\\elements\\Entry',1,0,'2020-05-17 05:35:27','2020-05-17 05:35:27',NULL,'a42c2ad0-43f7-4035-98ad-48fff39cbf9f'),(107,NULL,NULL,13,'craft\\elements\\Entry',1,0,'2020-05-17 05:35:53','2020-05-17 05:54:06',NULL,'9f10198f-6096-427d-a08e-0588218ebbfd'),(108,NULL,6,13,'craft\\elements\\Entry',1,0,'2020-05-17 05:35:53','2020-05-17 05:35:53',NULL,'1d3a6091-096f-4ae6-b4c4-18982407d913'),(110,NULL,NULL,13,'craft\\elements\\Entry',1,0,'2020-05-17 05:36:16','2020-05-17 05:53:47',NULL,'2bd69218-7102-45c4-98c4-e75deda7c0cd'),(111,NULL,7,13,'craft\\elements\\Entry',1,0,'2020-05-17 05:36:16','2020-05-17 05:36:16',NULL,'3afd0914-03ed-4b69-97c7-95c68adc1f49'),(113,NULL,NULL,13,'craft\\elements\\Entry',1,0,'2020-05-17 05:36:31','2020-05-17 05:53:18',NULL,'9231b56e-3195-419f-85f6-c1b061f4eb46'),(114,NULL,8,13,'craft\\elements\\Entry',1,0,'2020-05-17 05:36:31','2020-05-17 05:36:31',NULL,'d90ec163-5d66-436c-96eb-2b1c069ed131'),(116,NULL,NULL,13,'craft\\elements\\Entry',1,0,'2020-05-17 05:36:48','2020-05-17 05:50:02',NULL,'f00db32e-769e-4b68-8272-5364e53ce673'),(117,NULL,9,13,'craft\\elements\\Entry',1,0,'2020-05-17 05:36:48','2020-05-17 05:36:48',NULL,'cd0ba579-3cc6-4037-a69c-2412dc9c07bb'),(119,NULL,NULL,13,'craft\\elements\\Entry',1,0,'2020-05-17 05:37:05','2020-05-17 05:51:35',NULL,'965546fe-cd00-4733-8029-bab092c7bf3d'),(120,NULL,10,13,'craft\\elements\\Entry',1,0,'2020-05-17 05:37:05','2020-05-17 05:37:05',NULL,'b290ddcc-9172-4332-87ee-210d08f01752'),(122,NULL,NULL,13,'craft\\elements\\Entry',1,0,'2020-05-17 05:37:23','2020-05-17 05:52:10',NULL,'d81ad5ff-94e4-4179-b74b-5b8f5a9f3007'),(123,NULL,11,13,'craft\\elements\\Entry',1,0,'2020-05-17 05:37:23','2020-05-17 05:37:23',NULL,'930ba8b1-42c9-4104-a41e-96deaf992ce0'),(124,NULL,NULL,NULL,'craft\\elements\\Asset',1,0,'2020-05-17 05:45:31','2020-05-17 05:45:31',NULL,'aa66da03-5b6d-494d-b745-f268809b8568'),(125,NULL,NULL,NULL,'craft\\elements\\Asset',1,0,'2020-05-17 05:45:32','2020-05-17 05:45:32',NULL,'b0e61651-2ea4-48fc-ad3d-c912bf9e3359'),(126,NULL,NULL,NULL,'craft\\elements\\Asset',1,0,'2020-05-17 05:45:33','2020-05-17 05:45:33',NULL,'8c2b3909-785f-45f3-8948-008703625714'),(127,NULL,NULL,NULL,'craft\\elements\\Asset',1,0,'2020-05-17 05:45:33','2020-05-17 05:45:33',NULL,'99a63538-3b37-4947-a3b6-f090eb858fcd'),(128,NULL,NULL,NULL,'craft\\elements\\Asset',1,0,'2020-05-17 05:45:33','2020-05-17 05:45:33',NULL,'584f6b6f-c97b-44df-9284-f586ce462300'),(129,NULL,NULL,NULL,'craft\\elements\\Asset',1,0,'2020-05-17 05:45:34','2020-05-17 05:45:34',NULL,'ff8dc5a1-9eb5-4344-9ed8-b60274952994'),(130,NULL,NULL,NULL,'craft\\elements\\Asset',1,0,'2020-05-17 05:45:34','2020-05-17 05:45:34',NULL,'e35ed371-4401-44c5-a18a-33073d7d470f'),(131,NULL,12,13,'craft\\elements\\Entry',1,0,'2020-05-17 05:45:44','2020-05-17 05:45:44',NULL,'7f3b62df-3eca-4cd0-ad92-6c53845d1960'),(132,NULL,13,13,'craft\\elements\\Entry',1,0,'2020-05-17 05:45:52','2020-05-17 05:45:52',NULL,'3bd29c7b-9f4d-45d3-94e4-2598aec50317'),(133,NULL,14,13,'craft\\elements\\Entry',1,0,'2020-05-17 05:46:02','2020-05-17 05:46:02',NULL,'85d9d586-087a-4cc8-b689-fd403763e4ee'),(134,NULL,15,13,'craft\\elements\\Entry',1,0,'2020-05-17 05:46:09','2020-05-17 05:46:09',NULL,'1773a59c-ad75-4b9b-8cab-2244569636a2'),(135,NULL,16,13,'craft\\elements\\Entry',1,0,'2020-05-17 05:46:20','2020-05-17 05:46:20',NULL,'0dc2d201-1fd6-44a5-80ce-d74234177fde'),(136,NULL,17,13,'craft\\elements\\Entry',1,0,'2020-05-17 05:46:28','2020-05-17 05:46:28',NULL,'2bb1157a-c4cf-4772-b622-e961676c7585'),(137,NULL,18,13,'craft\\elements\\Entry',1,0,'2020-05-17 05:46:43','2020-05-17 05:46:43',NULL,'e21bbc9d-af5c-4612-b3bc-1b3260d4dbd8'),(138,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-05-17 05:50:02','2020-05-17 05:50:02',NULL,'fa7f3adf-ec33-4508-99f5-fdf4a0ace59f'),(139,NULL,19,13,'craft\\elements\\Entry',1,0,'2020-05-17 05:50:02','2020-05-17 05:50:02',NULL,'1cbf0d58-4cdf-4040-810d-cfedbe0f01ba'),(140,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-05-17 05:50:02','2020-05-17 05:50:02',NULL,'cd7317e6-3a25-4dca-8b73-79b0ae193bee'),(141,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-05-17 05:51:35','2020-05-17 05:51:35',NULL,'0234c318-746c-4900-aae7-432518d90172'),(142,NULL,20,13,'craft\\elements\\Entry',1,0,'2020-05-17 05:51:35','2020-05-17 05:51:35',NULL,'bf534245-7b5f-4102-8534-42853cee1b2b'),(143,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-05-17 05:51:35','2020-05-17 05:51:35',NULL,'49593977-fceb-4358-88c2-6ee9c3c94916'),(144,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-05-17 05:52:11','2020-05-17 05:52:11',NULL,'0a98c56e-905b-46c2-9574-7bb17de3c2b0'),(145,NULL,21,13,'craft\\elements\\Entry',1,0,'2020-05-17 05:52:10','2020-05-17 05:52:10',NULL,'ff539b55-621a-4617-803f-214191664c45'),(146,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-05-17 05:52:11','2020-05-17 05:52:11',NULL,'75481e5a-324c-4572-8934-0d5ecadf83b4'),(147,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-05-17 05:53:18','2020-05-17 05:53:18',NULL,'addf8eb7-bc65-4e4d-b18d-755ef8cf6ffc'),(148,NULL,22,13,'craft\\elements\\Entry',1,0,'2020-05-17 05:53:18','2020-05-17 05:53:18',NULL,'6171388a-f409-4149-a076-a5afe1a7a394'),(149,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-05-17 05:53:18','2020-05-17 05:53:18',NULL,'440c1531-84a0-4e06-921a-9d67b457403d'),(150,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-05-17 05:53:47','2020-05-17 05:53:47',NULL,'f2cdd04e-4415-41a6-98ec-a93d1030eee5'),(151,NULL,23,13,'craft\\elements\\Entry',1,0,'2020-05-17 05:53:47','2020-05-17 05:53:47',NULL,'98bbf5e0-96f8-4892-b7ca-848f96ec0359'),(152,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-05-17 05:53:47','2020-05-17 05:53:47',NULL,'fce5848b-df28-4fba-87c7-2b84f226e68c'),(153,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-05-17 05:54:06','2020-05-17 05:54:06',NULL,'2d596956-203c-4274-a5df-e6fa586507c8'),(154,NULL,24,13,'craft\\elements\\Entry',1,0,'2020-05-17 05:54:06','2020-05-17 05:54:06',NULL,'1adfec6a-f919-45f0-a229-4871402c5441'),(155,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-05-17 05:54:06','2020-05-17 05:54:06',NULL,'f2706c25-70e6-45df-821c-2381b6c6e86a'),(156,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-05-17 05:54:34','2020-05-17 05:54:34',NULL,'5ca5a0dc-539f-447f-997f-30509bd5b01e'),(157,NULL,25,13,'craft\\elements\\Entry',1,0,'2020-05-17 05:54:34','2020-05-17 05:54:34',NULL,'1d85f77c-bc6b-471d-bb57-9f5bb8d31050'),(158,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-05-17 05:54:34','2020-05-17 05:54:34',NULL,'1179c8e6-8a18-4b9e-a239-7b972c17ddf2');
/*!40000 ALTER TABLE `elements` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `elements_sites`
--

LOCK TABLES `elements_sites` WRITE;
/*!40000 ALTER TABLE `elements_sites` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `elements_sites` VALUES (1,1,1,NULL,NULL,1,'2020-02-05 21:43:45','2020-02-05 21:43:45','36c4adcb-519e-4ba7-8d65-16bc7c5a87ca'),(2,2,1,'__temp_mUYmBKyWLn4FjcspJqXd5yCGG4z1lJRMQCG0','articles/__temp_mUYmBKyWLn4FjcspJqXd5yCGG4z1lJRMQCG0',1,'2020-02-05 22:50:05','2020-02-05 22:50:05','29a90317-3f14-4bb4-b855-c2df0d3968e2'),(3,3,1,NULL,NULL,1,'2020-02-05 22:50:09','2020-02-05 22:50:09','446ce34a-bd67-4f42-80e5-0f4f6b3004a2'),(4,4,1,'__temp_zadVDdeB5DtE1PbEkRBQjp0707qud8pcIH6S','articles/__temp_zadVDdeB5DtE1PbEkRBQjp0707qud8pcIH6S',1,'2020-02-05 22:50:46','2020-02-05 22:50:46','06b3646e-3448-4742-85b8-4e80bd2b68ae'),(5,5,1,NULL,NULL,1,'2020-02-05 22:50:49','2020-02-05 22:50:49','37ba3049-dfd6-4cfd-ab86-b253f3dd44c1'),(6,6,1,NULL,NULL,1,'2020-02-05 22:50:59','2020-02-05 22:50:59','4a86a6bf-510c-4b6b-b0f8-fa719dee5c81'),(7,7,1,NULL,NULL,1,'2020-02-05 22:51:00','2020-02-05 22:51:00','58ed740b-4b85-4c49-88e2-a671ebd5269c'),(8,8,1,NULL,NULL,1,'2020-02-05 22:51:02','2020-02-05 22:51:02','ee60dabb-dd87-4bd4-bc7f-a3f2a951ac7c'),(9,9,1,NULL,NULL,1,'2020-02-05 22:51:03','2020-02-05 22:51:03','fbed8a47-fb96-4008-8d0b-284395e8c5c3'),(10,10,1,NULL,NULL,1,'2020-02-05 22:51:05','2020-02-05 22:51:05','41bb8554-7a20-47ea-8d16-5e3858836430'),(11,11,1,NULL,NULL,1,'2020-02-05 22:51:07','2020-02-05 22:51:07','4903d9db-2d55-4a6c-ae93-9a3cc075accb'),(12,12,1,NULL,NULL,1,'2020-02-05 22:51:09','2020-02-05 22:51:09','15f429d4-6ee5-41fe-bef5-c88983101c57'),(13,13,1,NULL,NULL,1,'2020-02-05 22:51:10','2020-02-05 22:51:10','35f5bbed-bd7b-4e8a-99a2-05a1543cd38f'),(14,14,1,'__temp_J0Pl9McXcguxswliNuBMdrqMUmkoUcT0sGjk','articles/__temp_J0Pl9McXcguxswliNuBMdrqMUmkoUcT0sGjk',1,'2020-02-05 22:52:06','2020-02-05 22:52:06','6be9176e-1b0a-4a67-a084-d90c27a3f23e'),(15,15,1,NULL,NULL,1,'2020-02-05 22:52:10','2020-02-05 22:52:10','e9be5f17-14fc-4ea3-836f-968d4a34cc98'),(16,16,1,'__temp_oZxhD4MNt8AAjWtgdXEvFAATS9kNjBHOiH2O','articles/__temp_oZxhD4MNt8AAjWtgdXEvFAATS9kNjBHOiH2O',1,'2020-02-05 22:52:42','2020-02-05 22:52:42','770f39f2-6b4a-4362-b2f1-3944a68f46ab'),(17,17,1,NULL,NULL,1,'2020-02-05 22:52:44','2020-02-05 22:52:44','48d3b8e4-44b2-47d8-95e1-5f15ec5e7de2'),(18,18,1,'__temp_UTK8A6P8jvoO13v4jxuoVmfyCupcHlstjmge','articles/__temp_UTK8A6P8jvoO13v4jxuoVmfyCupcHlstjmge',1,'2020-02-05 23:21:09','2020-02-05 23:21:09','f85137de-cfe9-436f-9513-95776e35c7fb'),(19,19,1,'__temp_6JqsktBc1you6Tb3Dirql3nb4gGqJbe2HP99','articles/__temp_6JqsktBc1you6Tb3Dirql3nb4gGqJbe2HP99',1,'2020-02-05 23:25:26','2020-02-05 23:25:26','ed991591-ebad-47e0-8228-8292e5adbbbe'),(20,20,1,NULL,NULL,1,'2020-02-05 23:25:29','2020-02-05 23:25:29','0377712b-00a5-449d-b6be-0ec6fe6f7608'),(21,21,1,NULL,NULL,1,'2020-02-05 23:25:31','2020-02-05 23:25:31','27332f6d-bc1a-4dc5-ab5b-a592d2704c31'),(22,22,1,NULL,NULL,1,'2020-02-05 23:25:31','2020-02-05 23:25:31','9753e7d2-72c6-4233-95aa-9ec46e4e5ab5'),(23,23,1,NULL,NULL,1,'2020-02-05 23:27:09','2020-02-05 23:27:09','177c9de8-c4f8-41a1-88be-67b4c1185ade'),(24,24,1,NULL,NULL,1,'2020-02-05 23:27:09','2020-02-05 23:27:09','b559e441-73fe-438d-ada1-a462f2f91abe'),(25,25,1,NULL,NULL,1,'2020-02-05 23:27:17','2020-02-05 23:27:17','166dc6e9-03e4-4ee0-bd85-cee43082ef00'),(26,26,1,NULL,NULL,1,'2020-02-05 23:27:17','2020-02-05 23:27:17','cfcd6465-619c-4a66-baa5-e340d9ad9601'),(27,27,1,NULL,NULL,1,'2020-02-05 23:27:19','2020-02-05 23:27:19','c071e048-ece0-4d41-a564-95362df7b04d'),(28,28,1,NULL,NULL,1,'2020-02-05 23:27:19','2020-02-05 23:27:19','7f6b330e-3fa6-4a1b-a2c0-0de548857a47'),(29,29,1,'__temp_1qmY2OeSQ1HVeYfPj3JklG50U6H2u2CfXXx0','articles/__temp_1qmY2OeSQ1HVeYfPj3JklG50U6H2u2CfXXx0',1,'2020-02-05 23:33:22','2020-02-05 23:33:27','765558b6-8007-4f9b-9624-388ea0861a8b'),(31,31,1,NULL,NULL,1,'2020-02-05 23:33:42','2020-02-05 23:33:42','1e386722-ee6d-4aab-8df5-403cf545e718'),(32,32,1,NULL,NULL,1,'2020-02-05 23:33:45','2020-02-05 23:33:45','d345fd29-8645-445b-94a2-d85bc8f17d43'),(33,33,1,NULL,NULL,1,'2020-02-05 23:33:45','2020-02-05 23:33:45','904e1b95-5035-4987-b0e3-7990dbb75f72'),(37,37,1,'__home__','__home__',1,'2020-02-05 23:34:00','2020-05-02 04:52:06','7d70a09d-3789-4e9e-b66c-9305d2eaf4ac'),(38,38,1,NULL,NULL,1,'2020-02-05 23:34:00','2020-02-05 23:34:00','65db8e1f-fd6d-4685-9265-1228b726a649'),(39,39,1,NULL,NULL,1,'2020-02-05 23:34:00','2020-02-05 23:34:00','c39465c2-6cd5-4b32-a53d-82fc18c15b67'),(40,40,1,NULL,NULL,1,'2020-02-05 23:34:00','2020-02-05 23:34:00','fa722f0b-4c1e-4b3d-8647-68c1c9913c81'),(42,42,1,NULL,NULL,1,'2020-04-09 22:55:14','2020-04-09 22:55:14','11ebad25-890c-41bd-b184-44a0486e4abd'),(43,43,1,NULL,NULL,1,'2020-04-09 22:55:20','2020-04-09 22:55:20','141223a6-a481-4e69-8b15-96b9a48da32f'),(45,45,1,'404','404',1,'2020-04-09 22:55:25','2020-05-03 07:25:09','bef15886-143d-48d4-a230-62599cc9d2c3'),(46,46,1,NULL,NULL,1,'2020-04-09 22:55:25','2020-04-09 22:55:25','449a5d60-472f-4d83-a33e-4d19f7f70f09'),(47,47,1,'__temp_wdLCL2TRs5hB7QW9KmMkn94EVP5CiY2QKBAU','__temp_wdLCL2TRs5hB7QW9KmMkn94EVP5CiY2QKBAU',1,'2020-04-10 05:05:37','2020-04-10 05:05:37','f94af37c-8674-4e8e-8f9e-08f179ed5793'),(48,48,1,NULL,NULL,1,'2020-04-10 05:05:43','2020-04-10 05:05:43','535c1b7e-8b30-41f5-84ea-5bc2396f1600'),(49,49,1,'__temp_lOMBKiPzKTppWsvMcKdmMHAXsAJug74Y0CEs','__temp_lOMBKiPzKTppWsvMcKdmMHAXsAJug74Y0CEs',1,'2020-04-10 05:07:58','2020-04-10 05:07:58','11884794-e3a1-4021-b798-62bb147cda25'),(50,50,1,NULL,NULL,1,'2020-04-10 05:08:01','2020-04-10 05:08:01','5bf6f496-6fbf-462b-bbc1-7eb3241218f2'),(55,55,1,NULL,NULL,1,'2020-04-10 07:03:10','2020-04-10 07:03:10','afbd5adc-8c6d-44b1-960e-6682439b1d53'),(56,56,1,NULL,NULL,1,'2020-04-10 07:03:10','2020-04-10 07:03:10','4a0423df-5e9b-4672-8edf-98db39fbc7bf'),(57,57,1,NULL,NULL,1,'2020-04-10 07:03:10','2020-04-10 07:03:10','a0fab050-55d9-4c79-a484-a57e3464ef83'),(58,58,1,NULL,NULL,1,'2020-04-10 07:08:18','2020-04-10 07:08:18','2d547231-1668-413a-9dc4-9c83da2f0b6f'),(60,60,1,'about','about',1,'2020-04-11 21:59:02','2020-05-02 04:52:06','9e4aff67-d96a-49b7-ad9c-50b36e0a1315'),(63,63,1,NULL,NULL,1,'2020-04-12 05:00:35','2020-04-12 05:00:35','23490e59-331c-42b9-a155-466f457f1e4f'),(64,64,1,NULL,NULL,1,'2020-04-12 05:00:47','2020-04-12 05:00:47','55a2cc8e-1749-4398-a17e-386a8f82bd56'),(65,65,1,NULL,NULL,1,'2020-04-12 05:00:48','2020-04-12 05:00:48','724b936e-c700-4d21-9864-1d0b8d7f96db'),(66,66,1,NULL,NULL,1,'2020-04-12 05:00:50','2020-04-12 05:00:50','1fb6e508-6c60-4868-a2c8-20a21d8f41f8'),(67,67,1,NULL,NULL,1,'2020-04-12 05:00:53','2020-04-12 05:00:53','c4a89aec-3b91-495d-bf7f-d4f5f803a3d9'),(68,68,1,NULL,NULL,1,'2020-04-12 05:00:57','2020-04-12 05:00:57','a94534d9-1abd-435f-9fb6-6c70ad9f841c'),(69,69,1,NULL,NULL,1,'2020-04-12 05:00:57','2020-04-12 05:00:57','206d7fb2-79b2-47ae-82c9-0a42abdaf767'),(71,71,1,NULL,NULL,1,'2020-04-12 05:01:03','2020-04-12 05:01:03','230559b7-960f-44f2-8125-326d39a3d0e3'),(73,73,1,'contact','contact',1,'2020-04-13 08:00:40','2020-05-02 04:52:06','361de679-a49c-42c0-853d-a8714caf1548'),(74,74,1,NULL,NULL,1,'2020-04-17 04:10:08','2020-04-17 04:10:08','6fa2b503-8670-4a79-974b-7c79ac3881e3'),(76,76,1,'icons-on-homepage',NULL,1,'2020-04-18 19:50:57','2020-04-25 18:38:14','e98a413c-b93d-42a3-bc9a-cc53a96a869e'),(78,78,1,'featured-products',NULL,1,'2020-04-18 19:57:05','2020-04-25 18:39:19','f59ebdd0-0e64-4a30-ae28-7ac9e7f40663'),(79,79,1,NULL,NULL,1,'2020-04-18 19:58:33','2020-04-18 19:58:33','c1f9432a-80d4-41f1-96e3-7a3aebe19313'),(80,80,1,NULL,NULL,1,'2020-04-18 20:33:18','2020-04-18 20:33:18','0b9b3e18-b239-43b6-aff3-9dd1e2ff7a60'),(81,81,1,'__temp_2k4iiXV70VwtzMW0wYWObSO7KDeORA2mMkrI','__temp_2k4iiXV70VwtzMW0wYWObSO7KDeORA2mMkrI',1,'2020-04-19 04:46:48','2020-04-19 04:46:48','fb8ddf3c-4572-43f3-8a9f-48e8660ea2d9'),(82,82,1,NULL,NULL,1,'2020-05-03 04:22:32','2020-05-03 04:22:32','497cee45-8a57-4b47-ad8d-8466a2972581'),(83,83,1,NULL,NULL,1,'2020-05-03 04:45:10','2020-05-03 04:45:10','39522571-74a5-46aa-9dbb-af39c98bac6f'),(84,84,1,NULL,NULL,1,'2020-05-03 04:51:06','2020-05-03 04:51:06','55e5a64a-0ce0-4838-a4f7-c477f16aecf9'),(85,85,1,NULL,NULL,1,'2020-05-03 04:51:49','2020-05-03 04:51:49','efc19b1e-da32-44d3-b9c0-68f790d5a541'),(86,86,1,'__temp_N7IWSyYeX4SegbBhbosGuZPaiBFTO0u0geQ1',NULL,1,'2020-05-03 05:06:58','2020-05-03 05:06:58','5eb37ed1-0db3-43ff-b3bf-acca9cf770fb'),(87,87,1,'__temp_IATPgQV8mi7PeZi4YliHz7rHkwzueKMHQXV1',NULL,1,'2020-05-03 06:41:08','2020-05-03 06:41:08','cbdc1a02-1d28-483f-8dfa-c6ceedaccb3c'),(89,89,1,'latest-news',NULL,1,'2020-05-03 07:03:22','2020-05-03 07:03:22','94e15038-83c4-4475-a7ff-627b1286332d'),(91,91,1,'lorem-ipsum','news/lorem-ipsum',1,'2020-05-03 07:08:30','2020-05-03 07:08:30','5dfc13e4-8054-4b7d-a113-4d0aa81c287c'),(92,92,1,'lorem-ipsum','news/lorem-ipsum',1,'2020-05-03 07:08:30','2020-05-03 07:08:30','f186a2e9-d8fd-418e-a14c-e99d1a63aa8a'),(93,93,1,NULL,NULL,1,'2020-05-03 07:09:42','2020-05-03 07:09:42','9a15f060-3591-4299-aa2a-e661bf9b9b7c'),(94,94,1,'lorem-ipsum','news/lorem-ipsum',1,'2020-05-03 07:09:42','2020-05-03 07:09:42','d1983af3-edd6-480a-8df5-04fb6282191c'),(95,95,1,NULL,NULL,1,'2020-05-03 07:09:42','2020-05-03 07:09:42','b92e4d3c-becc-4f93-a9e9-269e7c2d20c1'),(96,96,1,'lorem-ipsum','news/lorem-ipsum',1,'2020-05-03 07:12:14','2020-05-03 07:12:14','798b706c-ddee-4e39-8590-742d5d9044e2'),(97,97,1,NULL,NULL,1,'2020-05-03 07:12:14','2020-05-03 07:12:14','7ccc1852-4b9e-4be8-b64f-83c874bdb429'),(99,99,1,'news','news',1,'2020-05-17 04:55:59','2020-05-17 06:29:58','ad106ca3-2841-40fd-95db-651c8e20c7f4'),(100,100,1,NULL,NULL,1,'2020-05-17 05:05:01','2020-05-17 05:05:01','56da1c6f-9606-4c0a-8002-3e87f6eb4a84'),(101,101,1,'lorem-ipsum','news/lorem-ipsum',1,'2020-05-17 05:06:03','2020-05-17 05:06:03','d592f14c-a51d-4a8e-91e7-43d62edfe693'),(102,102,1,NULL,NULL,1,'2020-05-17 05:06:03','2020-05-17 05:06:03','dd6ad479-38eb-4ef5-b108-a08699227b77'),(104,104,1,'the-sorcerers-stone','news/the-sorcerers-stone',1,'2020-05-17 05:35:27','2020-05-17 05:35:27','96bd24e3-58f0-43ef-a5a8-8553b7e72700'),(105,105,1,'the-sorcerers-stone','news/the-sorcerers-stone',1,'2020-05-17 05:35:27','2020-05-17 05:35:27','71db3770-a849-4932-b53e-a171aedce485'),(107,107,1,'the-chamber-of-secrets','news/the-chamber-of-secrets',1,'2020-05-17 05:35:53','2020-05-17 05:35:53','9f44bdb6-c24b-4b1f-a378-b2fda4c85eb9'),(108,108,1,'the-chamber-of-secrets','news/the-chamber-of-secrets',1,'2020-05-17 05:35:53','2020-05-17 05:35:53','9f0c0ac7-8a64-4255-922a-82f6442c1b54'),(110,110,1,'the-prisoner-of-azkaban','news/the-prisoner-of-azkaban',1,'2020-05-17 05:36:16','2020-05-17 05:36:16','70d09f64-fc43-4c80-8125-f2fdf4460254'),(111,111,1,'the-prisoner-of-azkaban','news/the-prisoner-of-azkaban',1,'2020-05-17 05:36:16','2020-05-17 05:36:16','91701f3b-5851-419a-9add-a984c42b1b50'),(113,113,1,'the-goblet-of-fire','news/the-goblet-of-fire',1,'2020-05-17 05:36:31','2020-05-17 05:36:31','f7cf3b2a-d42f-434b-bf94-7fe9ce4bb976'),(114,114,1,'the-goblet-of-fire','news/the-goblet-of-fire',1,'2020-05-17 05:36:31','2020-05-17 05:36:31','f8f5a49f-92e4-4af4-9a9d-b763703b7d9e'),(116,116,1,'the-order-of-the-phoenix','news/the-order-of-the-phoenix',1,'2020-05-17 05:36:48','2020-05-17 05:36:48','bcd76140-6136-43c1-b516-92f3e92ca226'),(117,117,1,'the-order-of-the-phoenix','news/the-order-of-the-phoenix',1,'2020-05-17 05:36:48','2020-05-17 05:36:48','1e84dbf7-2502-4efb-978b-3b8dc15bb86a'),(119,119,1,'the-half-blood-prince','news/the-half-blood-prince',1,'2020-05-17 05:37:05','2020-05-17 05:37:05','91e8d4aa-c925-419d-9010-10468f4242a1'),(120,120,1,'the-half-blood-prince','news/the-half-blood-prince',1,'2020-05-17 05:37:05','2020-05-17 05:37:05','dc8620d3-59a9-48b5-95d3-4cd5def5d0c4'),(122,122,1,'the-deathly-hallows','news/the-deathly-hallows',1,'2020-05-17 05:37:23','2020-05-17 05:37:23','1304dd14-9673-46ed-bd68-6a06c6bbc662'),(123,123,1,'the-deathly-hallows','news/the-deathly-hallows',1,'2020-05-17 05:37:23','2020-05-17 05:37:23','6785e91b-2979-45ec-bf0d-5990f1c47402'),(124,124,1,NULL,NULL,1,'2020-05-17 05:45:31','2020-05-17 05:45:31','5446cebd-a012-42bf-9026-314975c0fb7a'),(125,125,1,NULL,NULL,1,'2020-05-17 05:45:32','2020-05-17 05:45:32','a76e3157-833b-42a0-a000-6b0fa123c1af'),(126,126,1,NULL,NULL,1,'2020-05-17 05:45:33','2020-05-17 05:45:33','5671364a-a4f7-4e91-928e-0399c530b84f'),(127,127,1,NULL,NULL,1,'2020-05-17 05:45:33','2020-05-17 05:45:33','75e5d9e2-ba50-4124-83e7-9dfbdecc5ef0'),(128,128,1,NULL,NULL,1,'2020-05-17 05:45:33','2020-05-17 05:45:33','02cd6074-cdbf-4cd6-a05a-cabf23df3122'),(129,129,1,NULL,NULL,1,'2020-05-17 05:45:34','2020-05-17 05:45:34','a4bf918c-e0a2-45c9-8e2a-cc75999e6586'),(130,130,1,NULL,NULL,1,'2020-05-17 05:45:34','2020-05-17 05:45:34','2b1f1864-8971-4e21-b630-3243a10d49a6'),(131,131,1,'the-prisoner-of-azkaban','news/the-prisoner-of-azkaban',1,'2020-05-17 05:45:44','2020-05-17 05:45:44','b96b0503-214d-4495-8c1e-93cc732f00e9'),(132,132,1,'the-deathly-hallows','news/the-deathly-hallows',1,'2020-05-17 05:45:52','2020-05-17 05:45:52','973cabe0-e39c-430d-ba65-61b37bfbcd1f'),(133,133,1,'the-order-of-the-phoenix','news/the-order-of-the-phoenix',1,'2020-05-17 05:46:02','2020-05-17 05:46:02','be52c7de-e2b2-44a9-92a2-c504dd671bd6'),(134,134,1,'the-half-blood-prince','news/the-half-blood-prince',1,'2020-05-17 05:46:09','2020-05-17 05:46:09','b8cce192-c170-4b31-bc3a-1c69ac5ce8b2'),(135,135,1,'the-goblet-of-fire','news/the-goblet-of-fire',1,'2020-05-17 05:46:20','2020-05-17 05:46:20','158b1378-a634-4b69-92a6-bc560080bfc8'),(136,136,1,'the-chamber-of-secrets','news/the-chamber-of-secrets',1,'2020-05-17 05:46:28','2020-05-17 05:46:28','c2374bbf-6466-443b-aaef-bc03a4bc4ca5'),(137,137,1,'the-sorcerers-stone','news/the-sorcerers-stone',1,'2020-05-17 05:46:43','2020-05-17 05:46:43','d4b558ac-459a-4529-9407-625397230f71'),(138,138,1,NULL,NULL,1,'2020-05-17 05:50:02','2020-05-17 05:50:02','d280e9db-cac0-4645-b6e2-c56298378cce'),(139,139,1,'the-order-of-the-phoenix','news/the-order-of-the-phoenix',1,'2020-05-17 05:50:02','2020-05-17 05:50:02','e5b3492e-20d1-4570-ae84-0baca2fda7b4'),(140,140,1,NULL,NULL,1,'2020-05-17 05:50:02','2020-05-17 05:50:02','82cb62a7-e5dc-43c7-9981-cc2c04d9aa47'),(141,141,1,NULL,NULL,1,'2020-05-17 05:51:35','2020-05-17 05:51:35','9d3fcc0a-4c23-4fd9-bed1-0998f3b58a25'),(142,142,1,'the-half-blood-prince','news/the-half-blood-prince',1,'2020-05-17 05:51:35','2020-05-17 05:51:35','74c2732b-67a5-49e9-9860-35e691bc4fe8'),(143,143,1,NULL,NULL,1,'2020-05-17 05:51:35','2020-05-17 05:51:35','a5975ef8-51f3-4dc1-9db2-89804a49291f'),(144,144,1,NULL,NULL,1,'2020-05-17 05:52:11','2020-05-17 05:52:11','3b73ad01-f9f3-4d4b-8653-2325d099a258'),(145,145,1,'the-deathly-hallows','news/the-deathly-hallows',1,'2020-05-17 05:52:11','2020-05-17 05:52:11','098b87e9-df75-4fb6-80f2-98c300b307ee'),(146,146,1,NULL,NULL,1,'2020-05-17 05:52:11','2020-05-17 05:52:11','d99d2a14-75fb-4073-8524-9d6eb44f6779'),(147,147,1,NULL,NULL,1,'2020-05-17 05:53:18','2020-05-17 05:53:18','636ccadf-c842-454a-b0ed-7556ba6e3b93'),(148,148,1,'the-goblet-of-fire','news/the-goblet-of-fire',1,'2020-05-17 05:53:18','2020-05-17 05:53:18','e82c1c88-5ec3-4ae2-b694-d76de9e41701'),(149,149,1,NULL,NULL,1,'2020-05-17 05:53:18','2020-05-17 05:53:18','ac4fbf11-999b-4001-ab67-095fcd1bff94'),(150,150,1,NULL,NULL,1,'2020-05-17 05:53:47','2020-05-17 05:53:47','6a6f20c0-037d-4347-9b10-c1b5f0538f8e'),(151,151,1,'the-prisoner-of-azkaban','news/the-prisoner-of-azkaban',1,'2020-05-17 05:53:47','2020-05-17 05:53:47','ddaf750c-dba0-4c3f-b4d5-334741ef5114'),(152,152,1,NULL,NULL,1,'2020-05-17 05:53:47','2020-05-17 05:53:47','b145fd64-277d-484e-8df7-b890afe2c11c'),(153,153,1,NULL,NULL,1,'2020-05-17 05:54:06','2020-05-17 05:54:06','89f9bd41-4a91-4d69-87bb-13e25f44a934'),(154,154,1,'the-chamber-of-secrets','news/the-chamber-of-secrets',1,'2020-05-17 05:54:06','2020-05-17 05:54:06','a73c07c3-05c7-448c-b711-20e51f8d190a'),(155,155,1,NULL,NULL,1,'2020-05-17 05:54:06','2020-05-17 05:54:06','97f89395-dbf8-4742-9592-c0c9d7b7518f'),(156,156,1,NULL,NULL,1,'2020-05-17 05:54:34','2020-05-17 05:54:34','4e639b8c-7aec-4223-897c-2fb768faa979'),(157,157,1,'the-sorcerers-stone','news/the-sorcerers-stone',1,'2020-05-17 05:54:34','2020-05-17 05:54:34','dc1946a6-c99b-4cc8-81ab-6f8338e5851c'),(158,158,1,NULL,NULL,1,'2020-05-17 05:54:34','2020-05-17 05:54:34','f553ce05-e03c-4514-9be7-28d8dfc2ed85');
/*!40000 ALTER TABLE `elements_sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `entries`
--

LOCK TABLES `entries` WRITE;
/*!40000 ALTER TABLE `entries` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `entries` VALUES (2,1,NULL,1,1,'2020-02-05 22:50:00',NULL,NULL,'2020-02-05 22:50:05','2020-02-05 22:50:05','d64a4852-2d66-4155-8362-5c9b1678f651'),(4,1,NULL,1,1,'2020-02-05 22:50:00',NULL,NULL,'2020-02-05 22:50:46','2020-02-05 22:50:46','68916d02-f7a7-427a-bbac-b79fe27378a9'),(14,1,NULL,1,1,'2020-02-05 22:52:00',NULL,NULL,'2020-02-05 22:52:06','2020-02-05 22:52:06','59fe9c91-1f90-43b2-9da5-322909d18fd5'),(16,1,NULL,1,1,'2020-02-05 22:52:00',NULL,NULL,'2020-02-05 22:52:42','2020-02-05 22:52:42','c6866448-e2fa-440a-b204-b9ac5cc0375b'),(18,1,NULL,1,1,'2020-02-05 23:21:00',NULL,NULL,'2020-02-05 23:21:09','2020-02-05 23:21:09','dde37ec1-af91-47c1-98b2-91e622333460'),(19,1,NULL,1,1,'2020-02-05 23:25:00',NULL,NULL,'2020-02-05 23:25:26','2020-02-05 23:25:26','b533cd31-b029-4e03-a02f-4a68a71b1abf'),(29,1,NULL,1,1,'2020-02-05 23:33:00',NULL,NULL,'2020-02-05 23:33:22','2020-02-05 23:33:22','e224d332-5b84-4904-8a68-eb1e8a5e191c'),(37,1,NULL,3,1,'2020-02-05 23:33:00',NULL,NULL,'2020-02-05 23:34:00','2020-04-17 04:24:47','60ceb163-cda9-4c7c-874d-f9a00d6ebed0'),(45,1,NULL,1,1,'2020-04-09 22:55:00',NULL,NULL,'2020-04-09 22:55:25','2020-04-09 22:55:25','cc81d826-0359-4ffa-b1ef-6b004cea4e97'),(47,1,NULL,1,1,'2020-04-10 05:05:00',NULL,NULL,'2020-04-10 05:05:37','2020-04-10 05:05:37','d3f4b4dc-0b93-4363-9925-ba40ef53c448'),(49,1,NULL,1,1,'2020-04-10 05:07:00',NULL,NULL,'2020-04-10 05:07:59','2020-04-10 05:07:59','22afdf7f-4e14-4f71-a825-6130acca3a58'),(60,1,NULL,1,1,'2020-04-11 21:58:00',NULL,NULL,'2020-04-11 21:59:02','2020-04-11 21:59:02','b2776b6c-9ca7-4ca9-8298-2d79d1433f6d'),(73,1,NULL,2,1,'2020-04-13 08:00:00',NULL,NULL,'2020-04-13 08:00:40','2020-04-13 08:04:41','d704634d-b2a6-49b5-9327-7e03e5f61de9'),(76,2,NULL,4,1,'2020-04-18 19:50:00',NULL,NULL,'2020-04-18 19:50:57','2020-04-18 19:50:57','9a74ae04-6c76-4255-9eab-c78b7b2b3039'),(78,2,NULL,5,1,'2020-04-18 19:56:00',NULL,0,'2020-04-18 19:57:05','2020-04-18 20:32:35','8db7aa08-2c4a-4668-9329-b3963db0f358'),(81,1,NULL,1,1,'2020-04-19 04:46:00',NULL,NULL,'2020-04-19 04:46:48','2020-04-19 04:46:48','5c91bdb5-4584-48b2-a97f-2f229e317d2a'),(86,2,NULL,7,1,'2020-05-03 05:06:00',NULL,NULL,'2020-05-03 05:06:58','2020-05-03 05:07:02','94d3c1b1-3373-48f8-ab63-fba8a78ab8e6'),(87,3,NULL,6,1,'2020-05-03 06:41:00',NULL,NULL,'2020-05-03 06:41:08','2020-05-03 06:41:08','5ffc3431-63f1-4a0a-9c17-af9f8b6b594e'),(89,3,NULL,6,1,'2020-05-03 07:03:00',NULL,NULL,'2020-05-03 07:03:22','2020-05-03 07:03:22','acbb1656-2d4a-4c06-a098-a3695e9fec0c'),(91,4,NULL,8,1,'2020-05-03 07:07:00',NULL,0,'2020-05-03 07:08:30','2020-05-03 07:08:30','72a44f98-9a26-4b93-856a-a6479bd6d6b1'),(92,4,NULL,8,1,'2020-05-03 07:07:00',NULL,NULL,'2020-05-03 07:08:30','2020-05-03 07:08:30','cc62d6dc-4bd7-4d34-b854-3d4312fb9af5'),(94,4,NULL,8,1,'2020-05-03 07:07:00',NULL,NULL,'2020-05-03 07:09:42','2020-05-03 07:09:42','05ccf064-c192-4ebc-9082-94dfd0759666'),(96,4,NULL,8,1,'2020-05-03 07:07:00',NULL,NULL,'2020-05-03 07:12:14','2020-05-03 07:12:14','1bc47a77-cdd0-4ab3-b2b0-b5dd750858ec'),(99,1,NULL,10,1,'2020-05-17 04:55:00',NULL,NULL,'2020-05-17 04:55:59','2020-05-17 04:55:59','df9c197a-bfd6-4cd1-a5de-a365a508da2a'),(101,4,NULL,8,1,'2020-05-03 07:07:00',NULL,NULL,'2020-05-17 05:06:03','2020-05-17 05:06:03','6ec08353-1392-4419-b537-e0d142b9d94c'),(104,4,NULL,8,1,'2020-05-17 05:34:00',NULL,NULL,'2020-05-17 05:35:27','2020-05-17 05:35:27','5f927f98-f2f9-4cfe-88a7-0938d858cba9'),(105,4,NULL,8,1,'2020-05-17 05:34:00',NULL,NULL,'2020-05-17 05:35:27','2020-05-17 05:35:27','883e68e8-813a-488e-bcf1-2e4b288893db'),(107,4,NULL,8,1,'2020-05-17 05:35:00',NULL,NULL,'2020-05-17 05:35:53','2020-05-17 05:35:53','65f2b10c-c48b-412c-aade-021e17c0332f'),(108,4,NULL,8,1,'2020-05-17 05:35:00',NULL,NULL,'2020-05-17 05:35:53','2020-05-17 05:35:53','170c3792-f5a9-48dc-a4b9-6a3d3ddf3e1e'),(110,4,NULL,8,1,'2020-05-17 05:35:00',NULL,NULL,'2020-05-17 05:36:16','2020-05-17 05:36:16','b0591570-2337-4c5f-b79f-9c786907fe38'),(111,4,NULL,8,1,'2020-05-17 05:35:00',NULL,NULL,'2020-05-17 05:36:16','2020-05-17 05:36:16','17daedba-d249-4984-9baa-01ee127ca077'),(113,4,NULL,8,1,'2020-05-17 05:36:00',NULL,NULL,'2020-05-17 05:36:31','2020-05-17 05:36:31','dfc64cff-c55e-4ecc-8f34-d9c118b652f1'),(114,4,NULL,8,1,'2020-05-17 05:36:00',NULL,NULL,'2020-05-17 05:36:31','2020-05-17 05:36:31','4707f6f7-d23b-414e-960b-3ffebe8debf6'),(116,4,NULL,8,1,'2020-05-17 05:36:00',NULL,NULL,'2020-05-17 05:36:48','2020-05-17 05:36:48','b94b9cc5-9005-41ea-b66c-1e46b9bec82e'),(117,4,NULL,8,1,'2020-05-17 05:36:00',NULL,NULL,'2020-05-17 05:36:48','2020-05-17 05:36:48','f0703fd6-ec59-4e96-95c3-d70600b6fa9c'),(119,4,NULL,8,1,'2020-05-17 05:36:00',NULL,NULL,'2020-05-17 05:37:05','2020-05-17 05:37:05','9b66042e-9263-4af1-9a0a-4e6ce1a89029'),(120,4,NULL,8,1,'2020-05-17 05:36:00',NULL,NULL,'2020-05-17 05:37:05','2020-05-17 05:37:05','d8109bba-a2e6-4916-bbc2-6fe9549a5512'),(122,4,NULL,8,1,'2020-05-17 05:37:00',NULL,NULL,'2020-05-17 05:37:23','2020-05-17 05:37:23','8ecabee5-e88b-4df5-bf13-675f4c736214'),(123,4,NULL,8,1,'2020-05-17 05:37:00',NULL,NULL,'2020-05-17 05:37:23','2020-05-17 05:37:23','9f130f67-9868-4b56-ada3-c74c80447cd9'),(131,4,NULL,8,1,'2020-05-17 05:35:00',NULL,NULL,'2020-05-17 05:45:44','2020-05-17 05:45:44','c7ce89c8-c526-489e-9687-5dcc6944e333'),(132,4,NULL,8,1,'2020-05-17 05:37:00',NULL,NULL,'2020-05-17 05:45:52','2020-05-17 05:45:52','257de42a-dd84-41c7-b078-6b35a31bc3bf'),(133,4,NULL,8,1,'2020-05-17 05:36:00',NULL,NULL,'2020-05-17 05:46:02','2020-05-17 05:46:02','eeadb2c6-722c-49c6-9ab3-855744384a1d'),(134,4,NULL,8,1,'2020-05-17 05:36:00',NULL,NULL,'2020-05-17 05:46:09','2020-05-17 05:46:09','b27b6b87-a1ed-4773-b953-7a38acc84e9a'),(135,4,NULL,8,1,'2020-05-17 05:36:00',NULL,NULL,'2020-05-17 05:46:20','2020-05-17 05:46:20','7ed3250c-a931-429c-b95e-0b570c255fb5'),(136,4,NULL,8,1,'2020-05-17 05:35:00',NULL,NULL,'2020-05-17 05:46:28','2020-05-17 05:46:28','a2cc8739-7d6f-4271-9737-427f0f8b8f2f'),(137,4,NULL,8,1,'2020-05-17 05:34:00',NULL,NULL,'2020-05-17 05:46:43','2020-05-17 05:46:43','7c58bbd7-6c94-4609-9fb3-6f804f0a6851'),(139,4,NULL,8,1,'2020-05-17 05:36:00',NULL,NULL,'2020-05-17 05:50:02','2020-05-17 05:50:02','cbf3f9eb-f6e0-46ec-af8a-0d192976a2a0'),(142,4,NULL,8,1,'2020-05-17 05:36:00',NULL,NULL,'2020-05-17 05:51:35','2020-05-17 05:51:35','53db73a8-6fbf-4c4f-92c4-d1679bbcb618'),(145,4,NULL,8,1,'2020-05-17 05:37:00',NULL,NULL,'2020-05-17 05:52:11','2020-05-17 05:52:11','df0b0588-7042-4fc7-9e60-849590e2b0db'),(148,4,NULL,8,1,'2020-05-17 05:36:00',NULL,NULL,'2020-05-17 05:53:18','2020-05-17 05:53:18','7ae92b5c-e3f2-4637-b647-be72a6ded4c7'),(151,4,NULL,8,1,'2020-05-17 05:35:00',NULL,NULL,'2020-05-17 05:53:47','2020-05-17 05:53:47','eceb5856-bc90-456e-a0ea-e8aeb4c3c505'),(154,4,NULL,8,1,'2020-05-17 05:35:00',NULL,NULL,'2020-05-17 05:54:06','2020-05-17 05:54:06','b40e2415-3b28-4c0a-9715-ed387ac5f5e5'),(157,4,NULL,8,1,'2020-05-17 05:34:00',NULL,NULL,'2020-05-17 05:54:34','2020-05-17 05:54:34','269f2023-654c-4448-ad8b-aadc98546b86');
/*!40000 ALTER TABLE `entries` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `entrytypes`
--

LOCK TABLES `entrytypes` WRITE;
/*!40000 ALTER TABLE `entrytypes` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `entrytypes` VALUES (1,1,3,'Default','default',1,'Title','',1,'2020-02-05 22:49:39','2020-04-09 06:29:56',NULL,'e8ee1969-bc9d-4366-919d-bd9d88737188'),(2,1,9,'Contact','contact',1,'Title','',2,'2020-04-13 08:04:19','2020-04-13 08:04:19',NULL,'e601d9ea-ea4e-4ce5-9bfe-3c1be3dfadf2'),(3,1,10,'Homepage','homepage',0,'Title','Homepage',4,'2020-04-17 04:24:22','2020-05-17 04:55:20',NULL,'97ac79eb-4923-4dda-a871-7751921c6f89'),(4,2,NULL,'3 icons with text','threeIconsWithText',1,'Panel Name','',1,'2020-04-18 19:49:33','2020-04-18 20:31:41',NULL,'86e37e1b-6060-4ecf-b5cd-08eed4c992a8'),(5,2,NULL,'2 rows of 3 icons','twoRowsOfThreeIcons',1,'Panel Name','',2,'2020-04-18 20:31:02','2020-04-18 20:31:02','2020-05-03 05:05:14','f52eaff4-a75e-4730-86ec-d96ea649b13e'),(6,3,NULL,'News','news',1,'Sidebar Name','',1,'2020-05-02 04:51:34','2020-05-03 06:47:37',NULL,'f46ae148-68cf-48b4-9d9f-c24e3522e388'),(7,2,NULL,'FAQ','faq',1,'Panel Name','',3,'2020-05-02 04:52:56','2020-05-02 04:52:56',NULL,'5be2622b-1b56-4fda-9320-b08614cf0b40'),(8,4,13,'News','news',1,'Title','',1,'2020-05-03 04:19:03','2020-05-03 07:08:47',NULL,'77d059ad-3d3f-4ced-9f30-0c2b13f3b60d'),(9,3,NULL,'Siblings','siblings',1,'Sidebar Name','',2,'2020-05-03 06:47:14','2020-05-03 06:47:49',NULL,'e964deb3-bd04-47f0-a8cf-37d4bf040a5e'),(10,1,14,'News','news',0,'Title','News',3,'2020-05-17 04:55:02','2020-05-17 04:55:20',NULL,'357d4858-eada-4a76-aeb0-4304636ea734');
/*!40000 ALTER TABLE `entrytypes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `fieldgroups`
--

LOCK TABLES `fieldgroups` WRITE;
/*!40000 ALTER TABLE `fieldgroups` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `fieldgroups` VALUES (1,'Assets','2020-02-05 21:43:45','2020-05-03 07:12:37','a49a5b87-47ff-421f-94c5-d11727a48206'),(2,'Matrix','2020-02-05 21:45:50','2020-02-05 21:45:50','18d36d4e-9c72-4fcf-97a1-a668b70fd249'),(3,'Business Logic','2020-04-18 19:52:15','2020-05-03 06:48:31','34f047fc-a5a1-4ea3-b134-fe21cdc31f89');
/*!40000 ALTER TABLE `fieldgroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `fieldlayoutfields`
--

LOCK TABLES `fieldlayoutfields` WRITE;
/*!40000 ALTER TABLE `fieldlayoutfields` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `fieldlayoutfields` VALUES (5,2,3,2,0,1,'2020-02-05 22:49:07','2020-02-05 22:49:07','d68fe417-543c-420d-8ef9-74c117a0d01b'),(6,2,4,4,0,1,'2020-02-05 22:49:07','2020-02-05 22:49:07','fb4e8bdf-e66e-42d5-a87d-dd946f79291a'),(7,2,4,5,0,2,'2020-02-05 22:49:07','2020-02-05 22:49:07','3c11eee6-916f-44cd-b6fc-a9c61793d8dc'),(160,9,84,1,0,1,'2020-04-19 04:57:59','2020-04-19 04:57:59','ba5c88ee-667d-4557-aab3-31e47114bcc4'),(269,4,148,2,0,1,'2020-04-30 06:32:10','2020-04-30 06:32:10','1a309a8a-296a-428b-8309-93a92d51dfd8'),(270,4,149,4,0,1,'2020-04-30 06:32:10','2020-04-30 06:32:10','3d240e94-0f6d-4bf0-aa78-a56170e51cf8'),(271,4,149,5,0,2,'2020-04-30 06:32:10','2020-04-30 06:32:10','d90f4a0f-76d7-4ee3-ae95-3ed22f605ba5'),(273,8,150,9,0,1,'2020-04-30 06:32:10','2020-04-30 06:32:10','58a714c9-f496-47bb-9f9f-e52523233ca0'),(277,6,152,6,0,1,'2020-04-30 06:32:10','2020-04-30 06:32:10','5ec9903e-8bd3-4123-b5ee-db122f895509'),(280,12,154,14,0,1,'2020-04-30 06:32:10','2020-04-30 06:32:10','4e4a812c-0e04-4cb7-b234-6e7ac99893d5'),(331,13,182,1,0,2,'2020-05-03 07:13:39','2020-05-03 07:13:39','83355984-ccce-4c21-ab78-06eff92c7e0e'),(332,13,182,20,0,1,'2020-05-03 07:13:39','2020-05-03 07:13:39','e58c06a6-b265-4add-835e-344a45f6a6a3'),(333,3,183,1,0,2,'2020-05-03 07:13:57','2020-05-03 07:13:57','c3c03848-5212-4b0a-bbf1-5d0add4013f3'),(334,3,183,20,0,1,'2020-05-03 07:13:57','2020-05-03 07:13:57','aaa6a70d-d7ec-41f6-baab-39cf81382510'),(335,3,184,19,0,1,'2020-05-03 07:13:57','2020-05-03 07:13:57','36a2352d-929b-438a-b609-d4aac4dd9f88'),(337,14,186,20,0,1,'2020-05-17 04:55:20','2020-05-17 04:55:20','f9bc106c-781f-4358-a6bc-00bf3a622113'),(338,10,187,1,0,1,'2020-05-17 04:55:20','2020-05-17 04:55:20','a545879f-89b1-4d07-b8bc-baccbc452f20'),(339,1,188,2,0,1,'2020-05-17 05:05:56','2020-05-17 05:05:56','06cc6bb7-6b63-4877-bfcb-ad46971050fd'),(340,1,188,4,0,2,'2020-05-17 05:05:56','2020-05-17 05:05:56','854190fe-9857-4bd1-8398-c0c44c37b3e5'),(341,1,188,5,0,3,'2020-05-17 05:05:56','2020-05-17 05:05:56','da0a6bc3-459e-40f0-ba6f-dba0f0354474'),(342,7,189,18,0,2,'2020-05-17 05:05:56','2020-05-17 05:05:56','56a11e5d-c8a8-415f-87b8-163802567b1b'),(343,7,189,9,0,1,'2020-05-17 05:05:56','2020-05-17 05:05:56','c9e1eb9f-ab1e-4c34-ba62-0dbf42965cf6'),(344,5,190,6,0,1,'2020-05-17 05:05:56','2020-05-17 05:05:56','c10fc128-7528-44a4-b57d-f0671911197d'),(345,11,191,14,0,1,'2020-05-17 05:05:56','2020-05-17 05:05:56','695b3713-207d-4553-b58a-92114dc73c28');
/*!40000 ALTER TABLE `fieldlayoutfields` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `fieldlayouts`
--

LOCK TABLES `fieldlayouts` WRITE;
/*!40000 ALTER TABLE `fieldlayouts` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `fieldlayouts` VALUES (1,'craft\\elements\\MatrixBlock','2020-02-05 21:47:13','2020-02-05 21:47:13',NULL,'cc16cc83-8470-48b8-bbaa-fcda87beb1ea'),(2,'angellco\\spoon\\models\\BlockType','2020-02-05 22:49:07','2020-02-05 22:49:07',NULL,'21bf98ed-d17a-4918-be8a-7df2aab7776d'),(3,'craft\\elements\\Entry','2020-02-05 22:49:59','2020-02-05 22:49:59',NULL,'47f51c95-5f9f-4a34-900c-e4301d1cffcf'),(4,'angellco\\spoon\\models\\BlockType','2020-02-05 22:50:40','2020-04-19 04:58:54',NULL,'345a2cf7-e3fe-4b2e-a1b8-a214ea39d1db'),(5,'craft\\elements\\MatrixBlock','2020-02-05 23:24:30','2020-02-05 23:24:30',NULL,'3c6f922b-8c79-41b1-a050-c921a89d41de'),(6,'angellco\\spoon\\models\\BlockType','2020-02-05 23:25:20','2020-04-19 04:59:04',NULL,'e22ea983-4143-4f18-a0b3-2232a3070717'),(7,'craft\\elements\\MatrixBlock','2020-02-05 23:29:34','2020-02-05 23:29:34',NULL,'fe6d1ad7-77ef-4195-8592-4dfc70bc03ed'),(8,'angellco\\spoon\\models\\BlockType','2020-02-05 23:33:16','2020-04-30 06:31:33',NULL,'e88465b0-8f22-40f8-946f-19e8fb958903'),(9,'craft\\elements\\Entry','2020-04-13 08:04:19','2020-04-13 08:04:19',NULL,'e6f6a307-7c97-4343-92ae-d7590e0adb9f'),(10,'craft\\elements\\Entry','2020-04-17 04:24:22','2020-04-17 04:24:22',NULL,'7828717f-697d-414f-a62f-210094daea3e'),(11,'craft\\elements\\MatrixBlock','2020-04-18 19:54:57','2020-04-18 19:54:57',NULL,'4aed05d2-26e8-4f56-87c6-2ce81caf63a8'),(12,'angellco\\spoon\\models\\BlockType','2020-04-18 19:56:00','2020-04-18 19:56:00',NULL,'42907acc-20b1-4350-a898-b1834a7a0dc2'),(13,'craft\\elements\\Entry','2020-05-03 07:08:47','2020-05-03 07:08:47',NULL,'0afc2d60-e7cb-43d2-b0f6-68b68417025a'),(14,'craft\\elements\\Entry','2020-05-17 04:55:02','2020-05-17 04:55:02',NULL,'cee0e0f7-766d-4377-ada2-ffaee7236338');
/*!40000 ALTER TABLE `fieldlayouts` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `fieldlayouttabs`
--

LOCK TABLES `fieldlayouttabs` WRITE;
/*!40000 ALTER TABLE `fieldlayouttabs` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `fieldlayouttabs` VALUES (3,2,'Content',1,'2020-02-05 22:49:07','2020-02-05 22:49:07','cfd32dde-f867-4f2f-a316-027315847835'),(4,2,'Layout',2,'2020-02-05 22:49:07','2020-02-05 22:49:07','0cab0072-7cef-4413-989e-605a3d364499'),(84,9,'Content',1,'2020-04-19 04:57:58','2020-04-19 04:57:58','3c5dd575-c3d8-4fa3-a18a-dc64a3069c39'),(85,9,'Page',2,'2020-04-19 04:57:59','2020-04-19 04:57:59','e763a25a-ad71-4854-b108-6def8fa3cb4d'),(148,4,'Content',1,'2020-04-30 06:32:10','2020-04-30 06:32:10','7383941d-23f8-4147-94e0-9108b4b843df'),(149,4,'Panel',2,'2020-04-30 06:32:10','2020-04-30 06:32:10','46821cb0-7afb-4482-9c71-27c93be892c9'),(150,8,'Content',1,'2020-04-30 06:32:10','2020-04-30 06:32:10','07f9ee1a-6c82-46a6-9dec-7534d35e955b'),(151,8,'Panel',2,'2020-04-30 06:32:10','2020-04-30 06:32:10','46fdff21-38ec-4a50-ab9c-c8148c8df8da'),(152,6,'Content',1,'2020-04-30 06:32:10','2020-04-30 06:32:10','343ae1a0-4d52-4075-81f8-7d53f79df07c'),(153,6,'Panel',2,'2020-04-30 06:32:10','2020-04-30 06:32:10','d85ce8cb-2fee-4e64-b1aa-a675b883b2b1'),(154,12,'Content',1,'2020-04-30 06:32:10','2020-04-30 06:32:10','33a8a25a-5009-4f65-9bf7-ce29ca7e9fe6'),(182,13,'Content',1,'2020-05-03 07:13:39','2020-05-03 07:13:39','ebd665fa-90b4-41f3-937f-85c808616973'),(183,3,'Content',1,'2020-05-03 07:13:57','2020-05-03 07:13:57','f5e7b2d8-68be-46f5-898b-6649af4246f1'),(184,3,'Page',2,'2020-05-03 07:13:57','2020-05-03 07:13:57','1c412ae1-b487-417f-b914-1ad5f87e6190'),(186,14,'Content',1,'2020-05-17 04:55:20','2020-05-17 04:55:20','d49b6aed-b0df-4d2a-8772-84d07c8a3a2b'),(187,10,'Content',1,'2020-05-17 04:55:20','2020-05-17 04:55:20','da07b4c2-c85c-4c41-8d22-f782826e1ee3'),(188,1,'Content',1,'2020-05-17 05:05:56','2020-05-17 05:05:56','a213fe30-16ea-4323-91af-823e8c74d29d'),(189,7,'Content',1,'2020-05-17 05:05:56','2020-05-17 05:05:56','75e0b9f7-a52c-4fe0-be3f-63a0d75b3ce1'),(190,5,'Content',1,'2020-05-17 05:05:56','2020-05-17 05:05:56','76261c28-a968-406d-a6ba-aaab61860ea6'),(191,11,'Content',1,'2020-05-17 05:05:56','2020-05-17 05:05:56','6fa9bc01-9af9-45da-acc5-cf36cec480b4');
/*!40000 ALTER TABLE `fieldlayouttabs` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `fields`
--

LOCK TABLES `fields` WRITE;
/*!40000 ALTER TABLE `fields` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `fields` VALUES (1,2,'Panels','panels','global','',0,'site',NULL,'craft\\fields\\Matrix','{\"contentTable\":\"{{%matrixcontent_panels}}\",\"maxBlocks\":\"\",\"minBlocks\":\"\",\"propagationMethod\":\"all\"}','2020-02-05 21:47:13','2020-02-05 21:47:13','57439ba8-7b9a-4a6f-925c-791faec8269a'),(2,NULL,'__blank__','text','matrixBlockType:bd566221-af4b-40b9-a950-8f04d2c59b8c','',1,'none',NULL,'craft\\redactor\\Field','{\"availableTransforms\":[\"2d645b41-72a4-4f60-a394-8a23532182be\"],\"availableVolumes\":[\"5ebe069f-09ab-4250-8880-37a3a169ab68\"],\"cleanupHtml\":true,\"columnType\":\"text\",\"purifierConfig\":\"\",\"purifyHtml\":\"1\",\"redactorConfig\":\"ADVANCED.json\",\"removeEmptyTags\":\"1\",\"removeInlineStyles\":\"1\",\"removeNbsp\":\"1\",\"showUnpermittedFiles\":false,\"showUnpermittedVolumes\":false}','2020-02-05 21:47:13','2020-05-03 04:36:16','03b34141-8ace-49bf-83cd-070779334bac'),(4,NULL,'Padding','padding','matrixBlockType:bd566221-af4b-40b9-a950-8f04d2c59b8c','',0,'none',NULL,'craft\\fields\\Dropdown','{\"optgroups\":true,\"options\":[{\"label\":\"None\",\"value\":\"\",\"default\":\"1\"},{\"label\":\"Light\",\"value\":\"light\",\"default\":\"\"},{\"label\":\"Heavy\",\"value\":\"heavy\",\"default\":\"\"}]}','2020-02-05 22:48:06','2020-05-03 04:33:35','10777443-a139-4a09-a2d1-dcf4c8c93597'),(5,NULL,'Margin','margin','matrixBlockType:bd566221-af4b-40b9-a950-8f04d2c59b8c','',0,'none',NULL,'craft\\fields\\Dropdown','{\"optgroups\":true,\"options\":[{\"label\":\"None\",\"value\":\"\",\"default\":\"1\"},{\"label\":\"Light\",\"value\":\"light\",\"default\":\"\"},{\"label\":\"Heavy\",\"value\":\"heavy\",\"default\":\"\"}]}','2020-02-05 22:48:06','2020-05-03 04:33:36','27854c4e-fdce-42da-b6c2-85f68395135f'),(6,NULL,'__blank__','embed','matrixBlockType:ca4a9a7e-193b-499a-88cd-b1f889361bc0','',0,'none',NULL,'craft\\fields\\PlainText','{\"byteLimit\":null,\"charLimit\":null,\"code\":\"1\",\"columnType\":null,\"initialRows\":\"4\",\"multiline\":\"1\",\"placeholder\":\"Paste code snippet here...\"}','2020-02-05 23:24:30','2020-05-17 05:05:56','5d36ed79-72af-4edb-b06b-3c9acab5044e'),(9,NULL,'__blank__','image','matrixBlockType:909cb47c-43ec-42b7-a7c0-c62dca2bbb08','',0,'site',NULL,'craft\\fields\\Assets','{\"allowedKinds\":[\"image\"],\"defaultUploadLocationSource\":\"volume:5ebe069f-09ab-4250-8880-37a3a169ab68\",\"defaultUploadLocationSubpath\":\"\",\"limit\":\"1\",\"localizeRelations\":false,\"restrictFiles\":\"1\",\"selectionLabel\":\"Select an image\",\"showUnpermittedFiles\":false,\"showUnpermittedVolumes\":false,\"singleUploadLocationSource\":\"volume:5ebe069f-09ab-4250-8880-37a3a169ab68\",\"singleUploadLocationSubpath\":\"\",\"source\":null,\"sources\":[\"volume:5ebe069f-09ab-4250-8880-37a3a169ab68\"],\"targetSiteId\":null,\"useSingleFolder\":false,\"validateRelatedElements\":\"\",\"viewMode\":\"large\"}','2020-02-05 23:29:34','2020-05-03 04:35:20','d8193927-d011-4f5e-a6f2-244e8be9de3c'),(14,NULL,'__blank__','panel','matrixBlockType:387fd742-7369-4e7e-88bf-c7d26f7eec40','',0,'site',NULL,'craft\\fields\\Entries','{\"limit\":\"1\",\"localizeRelations\":false,\"selectionLabel\":\"Select a custom panel\",\"source\":null,\"sources\":[\"section:34bba139-c036-4e65-a8c0-bf6c451a4e12\"],\"targetSiteId\":null,\"validateRelatedElements\":\"1\",\"viewMode\":null}','2020-04-18 19:54:57','2020-04-18 20:02:17','110489c0-bfa0-4b2e-8b4c-a5f5de78a131'),(18,NULL,'__blank__','width','matrixBlockType:909cb47c-43ec-42b7-a7c0-c62dca2bbb08','',0,'none',NULL,'craft\\fields\\Dropdown','{\"optgroups\":true,\"options\":[{\"label\":\"Centered\",\"value\":\"centered\",\"default\":\"1\"},{\"label\":\"Full Width\",\"value\":\"fullWidth\",\"default\":\"\"}]}','2020-05-03 04:33:36','2020-05-03 04:33:36','619de457-107b-4d61-827d-b7acada9a0f9'),(19,3,'Sidebar','sidebar','global','',0,'none',NULL,'modules\\businesslogic\\fields\\Sidebars',NULL,'2020-05-03 06:55:19','2020-05-03 06:55:19','062f9f55-3f65-4fcd-81b2-eb83e6ce1de0'),(20,1,'Hero Image','heroImage','global','',0,'site',NULL,'craft\\fields\\Assets','{\"allowedKinds\":[\"image\"],\"defaultUploadLocationSource\":\"volume:5ebe069f-09ab-4250-8880-37a3a169ab68\",\"defaultUploadLocationSubpath\":\"\",\"limit\":\"1\",\"localizeRelations\":false,\"restrictFiles\":\"1\",\"selectionLabel\":\"Select an image\",\"showUnpermittedFiles\":false,\"showUnpermittedVolumes\":false,\"singleUploadLocationSource\":\"volume:1ca271c4-3b66-436a-a488-8a678cda224f\",\"singleUploadLocationSubpath\":\"\",\"source\":null,\"sources\":\"*\",\"targetSiteId\":null,\"useSingleFolder\":true,\"validateRelatedElements\":\"\",\"viewMode\":\"large\"}','2020-05-03 07:13:25','2020-05-03 07:13:25','63ecb9f3-46e5-4108-88d6-bbe79e8a6022');
/*!40000 ALTER TABLE `fields` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `globalsets`
--

LOCK TABLES `globalsets` WRITE;
/*!40000 ALTER TABLE `globalsets` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `globalsets` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `gqlschemas`
--

LOCK TABLES `gqlschemas` WRITE;
/*!40000 ALTER TABLE `gqlschemas` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `gqlschemas` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `gqltokens`
--

LOCK TABLES `gqltokens` WRITE;
/*!40000 ALTER TABLE `gqltokens` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `gqltokens` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `info`
--

LOCK TABLES `info` WRITE;
/*!40000 ALTER TABLE `info` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `info` VALUES (1,'3.4.20','3.4.10',0,'[]','bNarNiijlBr5','2020-02-05 21:43:45','2020-05-23 20:02:20','26775f8e-f8fd-416d-a58e-68ba19457018');
/*!40000 ALTER TABLE `info` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `knockknock_logins`
--

LOCK TABLES `knockknock_logins` WRITE;
/*!40000 ALTER TABLE `knockknock_logins` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `knockknock_logins` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `matrixblocks`
--

LOCK TABLES `matrixblocks` WRITE;
/*!40000 ALTER TABLE `matrixblocks` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `matrixblocks` VALUES (3,2,1,1,1,NULL,'2020-02-05 22:50:09','2020-02-05 22:50:09','bc424181-5ece-4ff8-9981-58a73fa3e035'),(5,4,1,1,1,0,'2020-02-05 22:50:49','2020-02-05 22:50:49','22593083-7b96-47fa-a51d-5a6b09303185'),(6,4,1,1,1,0,'2020-02-05 22:50:59','2020-02-05 22:50:59','36429b92-efac-4045-a7b5-4f37dc327865'),(7,4,1,1,1,0,'2020-02-05 22:51:00','2020-02-05 22:51:00','1d7a1a9e-ccb9-43cd-9d70-52ceff7eeba4'),(8,4,1,1,1,0,'2020-02-05 22:51:02','2020-02-05 22:51:02','e53fe283-49e3-46a0-9b9d-c6256c8bebe9'),(9,4,1,1,1,0,'2020-02-05 22:51:03','2020-02-05 22:51:03','97774553-7f60-44e7-8c89-1ffc89b80ae2'),(10,4,1,1,1,0,'2020-02-05 22:51:05','2020-02-05 22:51:05','695688dd-8a2d-4088-9e39-ca7f05db5a4b'),(11,4,1,1,1,0,'2020-02-05 22:51:07','2020-02-05 22:51:07','dd2ca0fb-4ab5-45b2-9a4f-83cb27e0c587'),(12,4,1,1,1,0,'2020-02-05 22:51:09','2020-02-05 22:51:09','4605ca0d-09bd-46ac-ad5e-3c0574256628'),(13,4,1,1,1,NULL,'2020-02-05 22:51:10','2020-02-05 22:51:10','4a392e63-b880-4e19-87ad-a598a57414a3'),(15,14,1,1,1,NULL,'2020-02-05 22:52:10','2020-02-05 22:52:10','b9f94131-a04e-4270-8eba-211d4a12df42'),(17,16,1,1,1,NULL,'2020-02-05 22:52:44','2020-02-05 22:52:44','167422c5-91ef-4135-87d1-15f0a7a74261'),(20,19,1,1,1,0,'2020-02-05 23:25:29','2020-02-05 23:25:29','273167a7-d107-4600-b22e-32dabe40fb4b'),(21,19,1,1,1,0,'2020-02-05 23:25:31','2020-02-05 23:25:31','49449dc9-6b96-4d3a-8209-74f7fce8ad8c'),(22,19,1,2,2,0,'2020-02-05 23:25:31','2020-02-05 23:25:31','2e623c22-3955-43e8-94c9-b1dc09f5f624'),(23,19,1,1,1,0,'2020-02-05 23:27:09','2020-02-05 23:27:09','069cd0d1-62c0-4796-8d83-ac3432151a21'),(24,19,1,2,2,0,'2020-02-05 23:27:09','2020-02-05 23:27:09','5e584eae-e0e0-4307-8009-6acc354c9b73'),(25,19,1,1,1,0,'2020-02-05 23:27:17','2020-02-05 23:27:17','3a08c8a5-f4ff-4fd0-9c28-3909c32e6fbd'),(26,19,1,2,2,0,'2020-02-05 23:27:18','2020-02-05 23:27:18','261de8bf-f910-49f0-9cf3-9852276dc1e5'),(27,19,1,1,1,NULL,'2020-02-05 23:27:19','2020-02-05 23:27:19','e0cca440-170b-4711-ba6b-cb13901b957d'),(28,19,1,2,2,NULL,'2020-02-05 23:27:19','2020-02-05 23:27:19','bf4d4d07-0d4a-42d9-8baa-a64e0504f45c'),(38,37,1,1,2,0,'2020-02-05 23:34:00','2020-02-05 23:34:00','cbcf7992-d2c6-40ff-9689-429a3be6697c'),(39,37,1,2,3,0,'2020-02-05 23:34:00','2020-02-05 23:34:00','758788fb-4118-4bcb-8bd6-7d4164b31d3d'),(40,37,1,3,1,0,'2020-02-05 23:34:00','2020-02-05 23:34:00','d72d8c7e-40df-4ebe-b232-9591caacd62b'),(46,45,1,1,1,NULL,'2020-04-09 22:55:25','2020-04-09 22:55:25','71d820cf-d0ac-4607-8022-7a42a514cd97'),(48,47,1,1,1,NULL,'2020-04-10 05:05:43','2020-04-10 05:05:43','c715fabd-2145-47df-b213-837fe2fb1f01'),(50,49,1,1,1,NULL,'2020-04-10 05:08:01','2020-04-10 05:08:01','fc7c0910-2267-49e6-9e33-edae7cbf61b4'),(55,37,1,3,3,NULL,'2020-04-10 07:03:10','2020-04-10 07:03:10','e84e0965-f789-4df9-b0b8-a5bc547a3291'),(56,37,1,1,5,NULL,'2020-04-10 07:03:10','2020-05-03 04:51:49','3d370af6-f5ac-4fb2-b1eb-d8f47bc81952'),(57,37,1,2,6,NULL,'2020-04-10 07:03:10','2020-04-10 07:03:10','9b1b8ed8-a387-4edc-96bb-2ebde3ceab48'),(71,60,1,1,1,NULL,'2020-04-12 05:01:03','2020-04-12 05:01:03','445b17cf-05ca-437d-a31f-ed11aba433d5'),(74,60,1,1,1,0,'2020-04-17 04:10:08','2020-04-17 04:10:08','27a1bd8f-c623-462b-a0a9-3eb13afb8f4e'),(79,37,1,4,7,NULL,'2020-04-18 19:58:33','2020-04-18 19:58:33','e0de95c7-36bc-46a9-89a9-7163b92009e1'),(80,37,1,4,4,NULL,'2020-04-18 20:33:18','2020-04-18 20:33:18','5b7f5344-4af0-4a71-bf13-311fb9480c73'),(84,37,1,1,2,NULL,'2020-05-03 04:51:06','2020-05-03 04:51:06','8199ff37-59e3-4f22-b5a0-e698b6dfbeb0'),(85,37,1,1,1,NULL,'2020-05-03 04:51:49','2020-05-03 04:51:49','41f40be5-3e78-481a-baab-3a4baca5ae42'),(93,91,1,1,1,1,'2020-05-03 07:09:42','2020-05-03 07:09:42','c0643ebc-8fcb-4427-b197-1d473e2cb1b0'),(95,94,1,1,1,NULL,'2020-05-03 07:09:42','2020-05-03 07:09:42','eea6540d-659c-468e-9e47-84abe7878eb3'),(97,96,1,1,1,NULL,'2020-05-03 07:12:14','2020-05-03 07:12:14','dbbc5d15-40b1-4cf5-a1e8-55ebf25ff746'),(102,101,1,1,1,NULL,'2020-05-17 05:06:03','2020-05-17 05:06:03','38bb9b18-2b8a-488d-8a4d-40b8adac1428'),(138,116,1,1,1,NULL,'2020-05-17 05:50:02','2020-05-17 05:50:02','793aefb9-9f86-4a01-a4de-4b795c1bf133'),(140,139,1,1,1,NULL,'2020-05-17 05:50:02','2020-05-17 05:50:02','bcb33839-37e3-4448-bd0c-1d2aefc87a35'),(141,119,1,1,1,NULL,'2020-05-17 05:51:35','2020-05-17 05:51:35','ac8e0735-6de4-48f0-99e5-e617a70dfc56'),(143,142,1,1,1,NULL,'2020-05-17 05:51:35','2020-05-17 05:51:35','3c6541bd-0271-49f3-82a7-15f899fd1472'),(144,122,1,1,1,NULL,'2020-05-17 05:52:11','2020-05-17 05:52:11','2c55dbd6-0110-4185-9e85-606596551881'),(146,145,1,1,1,NULL,'2020-05-17 05:52:11','2020-05-17 05:52:11','8ea8050b-0fdc-4ff8-9d53-ba415120d3a5'),(147,113,1,1,1,NULL,'2020-05-17 05:53:18','2020-05-17 05:53:18','86925a47-a929-47f5-9c62-833a79cb77f5'),(149,148,1,1,1,NULL,'2020-05-17 05:53:18','2020-05-17 05:53:18','26b146cc-b986-4c44-bba5-399b11acb77a'),(150,110,1,1,1,NULL,'2020-05-17 05:53:47','2020-05-17 05:53:47','4e5694cb-0166-4eae-ba7a-07d8764a826c'),(152,151,1,1,1,NULL,'2020-05-17 05:53:47','2020-05-17 05:53:47','2f2f88ba-9cd3-40f0-95c5-d05e404060ba'),(153,107,1,1,1,NULL,'2020-05-17 05:54:06','2020-05-17 05:54:06','d843f798-9521-45f9-a191-16aaf2d8535a'),(155,154,1,1,1,NULL,'2020-05-17 05:54:07','2020-05-17 05:54:07','e1f06c21-705c-44bc-9468-c12f649252b6'),(156,104,1,1,1,NULL,'2020-05-17 05:54:34','2020-05-17 05:54:34','ca8e74d2-5343-4b2c-b0cd-af69357da457'),(158,157,1,1,1,NULL,'2020-05-17 05:54:34','2020-05-17 05:54:34','a5ad8879-2bcc-4d13-8e3e-4c079b94a02e');
/*!40000 ALTER TABLE `matrixblocks` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `matrixblocktypes`
--

LOCK TABLES `matrixblocktypes` WRITE;
/*!40000 ALTER TABLE `matrixblocktypes` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `matrixblocktypes` VALUES (1,1,1,'Text','text',1,'2020-02-05 21:47:13','2020-02-05 21:47:13','bd566221-af4b-40b9-a950-8f04d2c59b8c'),(2,1,5,'Embed','embed',3,'2020-02-05 23:24:30','2020-04-30 06:13:24','ca4a9a7e-193b-499a-88cd-b1f889361bc0'),(3,1,7,'Image','image',2,'2020-02-05 23:29:34','2020-04-30 06:13:24','909cb47c-43ec-42b7-a7c0-c62dca2bbb08'),(4,1,11,'Custom','custom',4,'2020-04-18 19:54:57','2020-04-18 20:01:50','387fd742-7369-4e7e-88bf-c7d26f7eec40');
/*!40000 ALTER TABLE `matrixblocktypes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `matrixcontent_panels`
--

LOCK TABLES `matrixcontent_panels` WRITE;
/*!40000 ALTER TABLE `matrixcontent_panels` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `matrixcontent_panels` VALUES (1,3,1,'2020-02-05 22:50:09','2020-02-05 22:50:09','85387d0b-4c11-4f82-9dad-1c212bccfc28',NULL,'p-0','m-0',NULL,NULL),(2,5,1,'2020-02-05 22:50:49','2020-02-05 22:50:49','97cf75c9-a312-400e-9828-8e4595940cc9',NULL,'p-0','m-0',NULL,NULL),(3,6,1,'2020-02-05 22:50:59','2020-02-05 22:50:59','f4e2a06b-5876-4561-aa3b-f65468c4a21b',NULL,'p-2','m-0',NULL,NULL),(4,7,1,'2020-02-05 22:51:00','2020-02-05 22:51:00','867768cb-b088-4c9a-a7a7-bdbd042aad6c',NULL,'p-1','m-0',NULL,NULL),(5,8,1,'2020-02-05 22:51:02','2020-02-05 22:51:02','847f1d60-9c04-482b-b0ee-1f6a09782381',NULL,'p-3','m-0',NULL,NULL),(6,9,1,'2020-02-05 22:51:03','2020-02-05 22:51:03','40891f62-e566-4451-832b-a485bed5978d',NULL,'p-3','m-2',NULL,NULL),(7,10,1,'2020-02-05 22:51:05','2020-02-05 22:51:05','abc400a7-e37a-4110-86ac-d043ca6cafe5',NULL,'p-3','m-0',NULL,NULL),(8,11,1,'2020-02-05 22:51:07','2020-02-05 22:51:07','cff91892-d9de-4ba3-98eb-f70b1e6b9c45',NULL,'p-3','m-1',NULL,NULL),(9,12,1,'2020-02-05 22:51:09','2020-02-05 22:51:09','55303dc4-6b18-41cb-848d-0b8c5745ea8a',NULL,'p-0','m-1',NULL,NULL),(10,13,1,'2020-02-05 22:51:10','2020-02-05 22:51:10','0830a669-0536-49a5-a6a7-ef29ec21ca1b',NULL,'p-1','m-1',NULL,NULL),(11,15,1,'2020-02-05 22:52:10','2020-02-05 22:52:10','581eea4c-e123-4aef-aa34-aaa058c41889',NULL,'p-0','m-0',NULL,NULL),(12,17,1,'2020-02-05 22:52:44','2020-02-05 22:52:44','3c3a13cb-9d26-4d40-a0f2-87bd7853fecd',NULL,'p-0','m-0',NULL,NULL),(13,20,1,'2020-02-05 23:25:29','2020-02-05 23:25:29','41f0b665-d31b-49c7-88c8-864825bd475a',NULL,'p-0','m-0',NULL,NULL),(14,21,1,'2020-02-05 23:25:31','2020-02-05 23:25:31','14071c1a-9c65-4256-a0e7-f7e1d6705e1a',NULL,'p-0','m-0',NULL,NULL),(15,22,1,'2020-02-05 23:25:31','2020-02-05 23:25:31','a3f5b713-c9eb-4ea2-83ab-3a22376971eb',NULL,NULL,NULL,NULL,NULL),(16,23,1,'2020-02-05 23:27:09','2020-02-05 23:27:09','a90aa5d5-61e8-4912-9442-d6bf22e5e3f2',NULL,'p-0','m-0',NULL,NULL),(17,24,1,'2020-02-05 23:27:09','2020-02-05 23:27:09','2dcbb01a-0ebe-4b82-983a-d9d231502fbb',NULL,NULL,NULL,NULL,NULL),(18,25,1,'2020-02-05 23:27:17','2020-02-05 23:27:17','e488fbf6-7f2f-44f3-8ce3-08ee87e9137d',NULL,'p-2','m-0',NULL,NULL),(19,26,1,'2020-02-05 23:27:18','2020-02-05 23:27:18','6d0082c3-0805-4340-a533-e1fdbfce8428',NULL,NULL,NULL,NULL,NULL),(20,27,1,'2020-02-05 23:27:19','2020-02-05 23:27:19','569204de-bfe1-434b-8076-8868d54a86ca',NULL,'p-2','m-2',NULL,NULL),(21,28,1,'2020-02-05 23:27:19','2020-02-05 23:27:19','893419a5-4774-47d3-87da-592b52aa33aa',NULL,NULL,NULL,NULL,NULL),(22,31,1,'2020-02-05 23:33:42','2020-02-05 23:33:42','4506f68a-c4be-4987-979e-45e138af44f3',NULL,'p-0','m-0',NULL,NULL),(23,32,1,'2020-02-05 23:33:45','2020-02-05 23:33:45','3db99dc1-8df9-4fa1-9e50-771cf937cd04',NULL,'p-0','m-0',NULL,NULL),(24,33,1,'2020-02-05 23:33:45','2020-02-05 23:33:45','a09fe405-727a-4f0f-a915-04798c2099b5',NULL,NULL,NULL,NULL,NULL),(28,38,1,'2020-02-05 23:34:00','2020-04-10 04:20:51','d62ecccf-0ec4-4245-8ffc-425e4f77ed2e','<h2>Lorem ipsum dolor sit amet</h2>\n<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis a risus feugiat, malesuada nisi sed, pulvinar ligula. Integer quis urna at lacus tincidunt viverra. Aenean sollicitudin enim ultricies libero vulputate, in hendrerit odio faucibus. Nam eu consectetur quam.</p><p>Nunc orci lectus, accumsan eu augue eget, tristique vestibulum tortor. Mauris sodales turpis orci, ac blandit libero consectetur in. Sed efficitur enim ligula, et sagittis neque cursus in.</p><p>Phasellus eu dui facilisis, bibendum libero id, elementum ante. In hac habitasse platea dictumst. Phasellus eget magna ut libero semper egestas. Aliquam ornare volutpat posuere.</p>\n<h2>Integer dapibus urna</h2>\n<p>Integer dapibus urna ut neque ornare, vel feugiat eros interdum. Duis cursus commodo convallis. Donec lectus ipsum, pulvinar eu dui in, venenatis molestie risus. Curabitur mollis risus risus, eu finibus est venenatis id. Donec sit amet libero a mi sagittis luctus et non nibh. Nullam non rhoncus massa. Mauris lacinia bibendum lectus, pharetra fermentum diam consequat vel. Nam id purus rutrum, molestie mi dignissim, rhoncus mi. Pellentesque nec auctor nulla.</p>\n<h2>Donec justo ipsum</h2>\n<p>Donec justo ipsum, pretium in ornare ut, rhoncus eget risus. Nam tempus finibus magna, non ultricies urna gravida ac. Cras id lectus suscipit, imperdiet tellus in, pretium ante. Maecenas nibh erat, laoreet fermentum volutpat quis, finibus sed dui. Nullam dolor arcu, mattis vitae lectus vel, vulputate dictum velit. Donec commodo accumsan justo ut tempor. Quisque enim erat, dapibus sit amet lectus sit amet, tincidunt interdum arcu. Vivamus vitae ex ligula. Praesent vel ipsum id nunc tempor tincidunt. Integer non euismod urna. Duis non urna non lectus feugiat iaculis. Quisque elit elit, porttitor vitae lacus et, consectetur fringilla urna.</p>','p-0','m-0',NULL,NULL),(29,39,1,'2020-02-05 23:34:00','2020-04-09 06:29:56','2e6769d5-e763-4f79-8cb6-5c4c6ec5e360',NULL,NULL,NULL,'<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/k7s1sr4JdlI\" frameborder=\"0\" allow=\"accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture\" allowfullscreen></iframe>',NULL),(30,40,1,'2020-02-05 23:34:00','2020-04-09 06:29:56','f6ec9dca-04c0-447f-8bdb-63ea7d462cd1',NULL,NULL,NULL,NULL,NULL),(31,42,1,'2020-04-09 22:55:14','2020-04-09 22:55:14','4f4ab003-d6ba-439a-979d-19191632741e',NULL,'p-0','m-0',NULL,NULL),(32,43,1,'2020-04-09 22:55:21','2020-04-09 22:55:21','b54738c5-b2c6-4bee-9ebd-ee33c15d6d7a','<p>Will this actually work?</p>','p-0','m-0',NULL,NULL),(34,46,1,'2020-04-09 22:55:25','2020-05-03 07:04:16','bfa98cf2-d92c-4cd3-b9ed-0c958a4cd305','<p>Will this actually work?</p>',NULL,NULL,NULL,NULL),(35,48,1,'2020-04-10 05:05:43','2020-04-10 05:05:43','42757457-ae90-424c-a7c4-68c8a9211792',NULL,'p-0','m-0',NULL,NULL),(36,50,1,'2020-04-10 05:08:01','2020-04-10 05:08:01','9fb6c21d-8192-4d42-9983-e48157c37317',NULL,'p-0','m-0',NULL,NULL),(40,55,1,'2020-04-10 07:03:10','2020-05-03 04:48:20','b86a2961-c632-4f72-b57a-05efef24cbce',NULL,NULL,NULL,NULL,'centered'),(41,56,1,'2020-04-10 07:03:10','2020-05-03 04:51:49','a6c7d01a-25ae-44f9-aea6-266eef1c33d1','<figure class=\"image-right\"><img src=\"{asset:82:transform:imageWithWrappingText}\" alt=\"\" /></figure>\n<h3 class=\"font-bold text-lg text-blue-600\">Integer dapibus urna</h3>\n<p>Integer dapibus urna ut neque ornare, vel feugiat eros interdum. Duis cursus commodo convallis. Donec lectus ipsum, pulvinar eu dui in, venenatis molestie risus. Curabitur mollis risus risus, eu finibus est venenatis id. Donec sit amet libero a mi sagittis luctus et non nibh. Nullam non rhoncus massa. Mauris lacinia bibendum lectus, pharetra fermentum diam consequat vel. Nam id purus rutrum, molestie mi dignissim, rhoncus mi. Pellentesque nec auctor nulla.<br /></p>\n',NULL,NULL,NULL,NULL),(42,57,1,'2020-04-10 07:03:10','2020-05-02 04:52:06','766dc3e1-0cf0-4003-af35-69d2150c24a9',NULL,NULL,NULL,'<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/k7s1sr4JdlI\" frameborder=\"0\" allow=\"accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture\" allowfullscreen></iframe>',NULL),(43,63,1,'2020-04-12 05:00:35','2020-04-12 05:00:35','cf4fd68e-c98a-439c-b2bc-4cd3bb2aea52',NULL,'p-0','m-0',NULL,NULL),(44,64,1,'2020-04-12 05:00:48','2020-04-12 05:00:48','e64d192e-327f-411d-a135-54d7b5888b3c','<p><a class=\"text-lg bg-blue-500 hover:bg-blue-700 text-white hover:text-white font-bold py-2 px-8 mx-2 my-1 inline-block cursor-pointer rounded\" href=\"#\">Larg</a></p>','p-0','m-0',NULL,NULL),(45,65,1,'2020-04-12 05:00:48','2020-04-12 05:00:48','f1e0e5d5-3513-4e42-8fa8-45e37adb7a00','<p><a class=\"text-lg bg-blue-500 hover:bg-blue-700 text-white hover:text-white font-bold py-2 px-8 mx-2 my-1 inline-block cursor-pointer rounded\" href=\"#\">La</a></p>','p-0','m-0',NULL,NULL),(46,66,1,'2020-04-12 05:00:50','2020-04-12 05:00:50','191a2678-a418-4e8e-bc98-50f6ccc0aad1','<p><a class=\"text-lg bg-blue-500 hover:bg-blue-700 text-white hover:text-white font-bold py-2 px-8 mx-2 my-1 inline-block cursor-pointer rounded\" href=\"#\">La</a>Nic</p>','p-0','m-0',NULL,NULL),(47,67,1,'2020-04-12 05:00:53','2020-04-12 05:00:53','cb56d8c4-f20e-4c27-aadc-92ebb56f1047','<p><a class=\"text-lg bg-blue-500 hover:bg-blue-700 text-white hover:text-white font-bold py-2 px-8 mx-2 my-1 inline-block cursor-pointer rounded\" href=\"#\">LNicear</a></p>','p-0','m-0',NULL,NULL),(48,68,1,'2020-04-12 05:00:57','2020-04-12 05:00:57','b1b69331-1503-4c5c-9fd8-37c42b0dcbd2','<p><a class=\"text-lg bg-blue-500 hover:bg-blue-700 text-white hover:text-white font-bold py-2 px-8 mx-2 my-1 inline-block cursor-pointer rounded\" href=\"#\">LNice!!</a></p>','p-0','m-0',NULL,NULL),(49,69,1,'2020-04-12 05:00:57','2020-04-12 05:00:57','dbc2402a-59e9-45e1-9fab-10149e97921c','<p><a class=\"text-lg bg-blue-500 hover:bg-blue-700 text-white hover:text-white font-bold py-2 px-8 mx-2 my-1 inline-block cursor-pointer rounded\" href=\"#\">Nice!!</a></p>','p-0','m-0',NULL,NULL),(51,71,1,'2020-04-12 05:01:03','2020-05-03 07:03:57','d6c0fb02-ddc8-4b0d-b164-a14a6899c971','<p>All of the following tags were added via Redactor...</p>\n<h2 class=\"font-bold text-2xl text-red-600\">Header is a red h2</h2>\n<h3 class=\"font-bold text-lg text-blue-600\">Subheader is a blue h3</h3>\n<p style=\"text-align: center\"><a class=\"text-sm bg-blue-500 hover:bg-blue-700 text-white hover:text-white font-bold py-1 px-4 mx-1 my-1 inline-block cursor-pointer rounded shadow\" href=\"#\">Small Button</a><br /></p>\n<p style=\"text-align: center\"><a class=\"text-lg bg-blue-500 hover:bg-blue-700 text-white hover:text-white font-bold py-2 px-8 mx-2 my-1 inline-block cursor-pointer rounded shadow\" href=\"#\">Large Button</a></p>',NULL,NULL,NULL,NULL),(52,74,1,'2020-04-17 04:10:08','2020-04-17 04:10:08','f53f5973-92b6-4d51-851d-3b81e3bb5c2d','<p>Have a button: <a class=\"text-sm bg-blue-500 hover:bg-blue-700 text-white hover:text-white font-bold py-1 px-4 mx-1 my-1 inline-block cursor-pointer rounded shadow\" href=\"#\">Small Button</a></p>','p-0','m-0',NULL,NULL),(53,79,1,'2020-04-18 19:58:33','2020-05-02 04:52:06','0115ed6f-7e4a-4d0c-b2de-270e82f207da',NULL,NULL,NULL,NULL,NULL),(54,80,1,'2020-04-18 20:33:18','2020-05-02 04:52:06','473b8486-09db-4228-a5d4-b2606d1f00b6',NULL,NULL,NULL,NULL,NULL),(55,84,1,'2020-05-03 04:51:06','2020-05-03 04:54:35','b1a4f31e-06d6-4b95-870f-58fa0d70d54f','<h2 class=\"font-bold text-2xl text-red-600\">Lorem ipsum dolor sit amet</h2>\n<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis a risus feugiat, malesuada nisi sed, pulvinar ligula. Integer quis urna at lacus tincidunt viverra. Aenean sollicitudin enim ultricies libero vulputate, in hendrerit odio faucibus. Nam eu consectetur quam.</p>\n<p>Nunc orci lectus, accumsan eu augue eget, tristique vestibulum tortor. Mauris sodales turpis orci, ac blandit libero consectetur in. Sed efficitur enim ligula, et sagittis neque cursus in.</p>\n<p>Phasellus eu dui facilisis, bibendum libero id, elementum ante. In hac habitasse platea dictumst. Phasellus eget magna ut libero semper egestas. Aliquam ornare volutpat posuere.</p>',NULL,NULL,NULL,NULL),(56,85,1,'2020-05-03 04:51:49','2020-05-03 06:32:51','df2f71e0-5c86-44a1-ad8d-c821a41aceb4','<figure class=\"float-right\"><img src=\"{asset:83:transform:imageWithWrappingText}\" alt=\"\" /></figure>\n<p class=\"font-bold text-lg text-blue-600\">Donec ipsum</p>\n<p>Donec justo ipsum, pretium in ornare ut, rhoncus eget risus. Nam tempus finibus magna, non ultricies urna gravida ac. Cras id lectus suscipit, imperdiet tellus in, pretium ante. Maecenas nibh erat, laoreet fermentum volutpat quis, finibus sed dui. Nullam dolor arcu, mattis vitae lectus vel, vulputate dictum velit. Donec commodo accumsan justo ut tempor. Quisque enim erat, dapibus sit amet lectus sit amet, tincidunt interdum arcu. Vivamus vitae ex ligula. Praesent vel ipsum id nunc tempor tincidunt. Integer non euismod urna. Duis non urna non lectus feugiat iaculis. Quisque elit elit, porttitor vitae lacus et, consectetur fringilla urna.</p>',NULL,NULL,NULL,NULL),(57,93,1,'2020-05-03 07:09:42','2020-05-03 07:09:42','9310d8ba-b0d7-4e3e-bf8a-80c3684920aa','<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean gravida sem eget tortor malesuada accumsan nec quis leo. Maecenas at tincidunt felis. Ut sed lacus pellentesque, scelerisque ipsum id, vehicula erat. Vestibulum ultricies lorem eget dui semper, et rutrum sapien ullamcorper. Etiam dapibus nibh interdum pulvinar sollicitudin. Mauris tempus condimentum justo, nec dignissim risus tempor ac. Suspendisse ac urna eget metus efficitur mattis. Praesent sollicitudin semper augue, ac condimentum nulla efficitur et. Donec ante nisl, pulvinar at sem sed, accumsan dignissim tortor. Phasellus semper quam ac dolor vestibulum ultricies. Duis eu turpis dolor.</p>\n<p>Vestibulum ultricies lobortis tempus. Maecenas feugiat, arcu id convallis sollicitudin, odio nunc aliquam quam, nec fringilla lectus ex vel velit. Nam placerat neque at enim hendrerit ullamcorper. Nunc augue ipsum, vehicula ac mi ac, molestie gravida leo. Ut venenatis ante quis arcu venenatis egestas. In nec efficitur ex. Nulla ornare eros non sem egestas ornare. Praesent semper tempor mollis. Aliquam urna purus, porttitor eget aliquet a, fermentum vitae leo.</p>',NULL,NULL,NULL,NULL),(58,95,1,'2020-05-03 07:09:42','2020-05-03 07:09:42','4ee72c8c-377f-47d8-bbf6-a13efe966139','<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean gravida sem eget tortor malesuada accumsan nec quis leo. Maecenas at tincidunt felis. Ut sed lacus pellentesque, scelerisque ipsum id, vehicula erat. Vestibulum ultricies lorem eget dui semper, et rutrum sapien ullamcorper. Etiam dapibus nibh interdum pulvinar sollicitudin. Mauris tempus condimentum justo, nec dignissim risus tempor ac. Suspendisse ac urna eget metus efficitur mattis. Praesent sollicitudin semper augue, ac condimentum nulla efficitur et. Donec ante nisl, pulvinar at sem sed, accumsan dignissim tortor. Phasellus semper quam ac dolor vestibulum ultricies. Duis eu turpis dolor.</p>\n<p>Vestibulum ultricies lobortis tempus. Maecenas feugiat, arcu id convallis sollicitudin, odio nunc aliquam quam, nec fringilla lectus ex vel velit. Nam placerat neque at enim hendrerit ullamcorper. Nunc augue ipsum, vehicula ac mi ac, molestie gravida leo. Ut venenatis ante quis arcu venenatis egestas. In nec efficitur ex. Nulla ornare eros non sem egestas ornare. Praesent semper tempor mollis. Aliquam urna purus, porttitor eget aliquet a, fermentum vitae leo.</p>',NULL,NULL,NULL,NULL),(59,97,1,'2020-05-03 07:12:14','2020-05-03 07:12:14','20bba84b-b783-4fff-9b1d-261b22177821','<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean gravida sem eget tortor malesuada accumsan nec quis leo. Maecenas at tincidunt felis. Ut sed lacus pellentesque, scelerisque ipsum id, vehicula erat. Vestibulum ultricies lorem eget dui semper, et rutrum sapien ullamcorper. Etiam dapibus nibh interdum pulvinar sollicitudin. Mauris tempus condimentum justo, nec dignissim risus tempor ac. Suspendisse ac urna eget metus efficitur mattis. Praesent sollicitudin semper augue, ac condimentum nulla efficitur et. Donec ante nisl, pulvinar at sem sed, accumsan dignissim tortor. Phasellus semper quam ac dolor vestibulum ultricies. Duis eu turpis dolor.</p>\n<p>Vestibulum ultricies lobortis tempus. Maecenas feugiat, arcu id convallis sollicitudin, odio nunc aliquam quam, nec fringilla lectus ex vel velit. Nam placerat neque at enim hendrerit ullamcorper. Nunc augue ipsum, vehicula ac mi ac, molestie gravida leo. Ut venenatis ante quis arcu venenatis egestas. In nec efficitur ex. Nulla ornare eros non sem egestas ornare. Praesent semper tempor mollis. Aliquam urna purus, porttitor eget aliquet a, fermentum vitae leo.</p>',NULL,NULL,NULL,NULL),(60,102,1,'2020-05-17 05:06:03','2020-05-17 05:06:03','c09e5130-50dc-4cdc-9d0c-36c076e5c980','<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean gravida sem eget tortor malesuada accumsan nec quis leo. Maecenas at tincidunt felis. Ut sed lacus pellentesque, scelerisque ipsum id, vehicula erat. Vestibulum ultricies lorem eget dui semper, et rutrum sapien ullamcorper. Etiam dapibus nibh interdum pulvinar sollicitudin. Mauris tempus condimentum justo, nec dignissim risus tempor ac. Suspendisse ac urna eget metus efficitur mattis. Praesent sollicitudin semper augue, ac condimentum nulla efficitur et. Donec ante nisl, pulvinar at sem sed, accumsan dignissim tortor. Phasellus semper quam ac dolor vestibulum ultricies. Duis eu turpis dolor.</p>\n<p>Vestibulum ultricies lobortis tempus. Maecenas feugiat, arcu id convallis sollicitudin, odio nunc aliquam quam, nec fringilla lectus ex vel velit. Nam placerat neque at enim hendrerit ullamcorper. Nunc augue ipsum, vehicula ac mi ac, molestie gravida leo. Ut venenatis ante quis arcu venenatis egestas. In nec efficitur ex. Nulla ornare eros non sem egestas ornare. Praesent semper tempor mollis. Aliquam urna purus, porttitor eget aliquet a, fermentum vitae leo.</p>',NULL,NULL,NULL,NULL),(61,138,1,'2020-05-17 05:50:02','2020-05-17 05:50:02','fcbddf58-3091-4d2e-91c0-e2dee523f3f3','<p>During the summer holidays with his aunt <a href=\"https://en.wikipedia.org/wiki/Petunia_Dursley\" title=\"Petunia Dursley\">Petunia</a> and uncle <a href=\"https://en.wikipedia.org/wiki/Vernon_Dursley\" title=\"Vernon Dursley\">Vernon</a>, 15-year-old <a href=\"https://en.wikipedia.org/wiki/Harry_Potter_(character)\" title=\"Harry Potter (character)\">Harry Potter</a> and his cousin <a href=\"https://en.wikipedia.org/wiki/Dudley_Dursley\" title=\"Dudley Dursley\">Dudley</a> are attacked by <a href=\"https://en.wikipedia.org/wiki/Dementors\" title=\"Dementors\">Dementors</a>. After openly using magic to save Dudley and himself, Harry is expelled from Hogwarts, but his expulsion is postponed pending a hearing at the Ministry of Magic. Harry is whisked off by a group of wizards including <a href=\"https://en.wikipedia.org/wiki/%22Mad-Eye%22_Moody\" title=\"&quot;Mad-Eye&quot; Moody\">Mad-Eye Moody</a>, <a href=\"https://en.wikipedia.org/wiki/Remus_Lupin\" title=\"Remus Lupin\">Remus Lupin</a>, and several new faces, including <a href=\"https://en.wikipedia.org/wiki/Nymphadora_Tonks\" title=\"Nymphadora Tonks\">Nymphadora Tonks</a>, a bubbly young Metamorphmagus (a witch or wizard who can change his or her appearance without a potion or spell), and <a href=\"https://en.wikipedia.org/wiki/Kingsley_Shacklebolt\" title=\"Kingsley Shacklebolt\">Kingsley Shacklebolt</a>, a senior Auror, to <a href=\"https://en.wikipedia.org/wiki/Number_12,_Grimmauld_Place\" title=\"Number 12, Grimmauld Place\">Number 12, Grimmauld Place</a>, the childhood home of <a href=\"https://en.wikipedia.org/wiki/Sirius_Black\" title=\"Sirius Black\">Sirius Black</a>. The building also serves as the headquarters of the <a href=\"https://en.wikipedia.org/wiki/Order_of_the_Phoenix_(fictional_organisation)\" title=\"Order of the Phoenix (fictional organisation)\">Order of the Phoenix</a>, of which Mr. and Mrs. Weasley and Sirius are also members. <a href=\"https://en.wikipedia.org/wiki/Ron_Weasley\" title=\"Ron Weasley\">Ron Weasley</a> and <a href=\"https://en.wikipedia.org/wiki/Hermione_Granger\" title=\"Hermione Granger\">Hermione Granger</a> explain that the Order is a secret organisation led by Hogwarts headmaster <a href=\"https://en.wikipedia.org/wiki/Albus_Dumbledore\" title=\"Albus Dumbledore\">Albus Dumbledore</a> dedicated to fighting <a href=\"https://en.wikipedia.org/wiki/Lord_Voldemort\" title=\"Lord Voldemort\">Lord Voldemort</a> and his followers, the <a href=\"https://en.wikipedia.org/wiki/Death_Eaters\" title=\"Death Eaters\">Death Eaters</a>. From the members of the Order, Harry, Ron, Hermione, <a href=\"https://en.wikipedia.org/wiki/Ginny_Weasley\" title=\"Ginny Weasley\">Ginny Weasley</a> and <a href=\"https://en.wikipedia.org/wiki/Fred_and_George_Weasley\" title=\"Fred and George Weasley\">Fred and George Weasley</a> learn that Voldemort is seeking an object he did not have prior to his first defeat and assume this object to be a weapon of some sort. Harry learns the <a href=\"https://en.wikipedia.org/wiki/Ministry_of_Magic\" title=\"Ministry of Magic\">Ministry of Magic</a>, led by <a href=\"https://en.wikipedia.org/wiki/Cornelius_Fudge\" title=\"Cornelius Fudge\">Cornelius Fudge</a>, is refusing to acknowledge Voldemort\'s return because of the panic and chaos doing so would cause. Harry also learns <a href=\"https://en.wikipedia.org/wiki/The_Daily_Prophet\" title=\"The Daily Prophet\">the Daily Prophet</a> has been running a smear campaign against him and Dumbledore. At the hearing, Harry is cleared when Dumbledore provides evidence that Harry was fully within his rights to use magic against the Dementors, with Dumbledore calling into question how the creatures (normally Azkaban guards) were let loose in suburban Britain.</p>',NULL,NULL,NULL,NULL),(62,140,1,'2020-05-17 05:50:02','2020-05-17 05:50:02','100183bc-7491-4acc-9279-34575bca5048','<p>During the summer holidays with his aunt <a href=\"https://en.wikipedia.org/wiki/Petunia_Dursley\" title=\"Petunia Dursley\">Petunia</a> and uncle <a href=\"https://en.wikipedia.org/wiki/Vernon_Dursley\" title=\"Vernon Dursley\">Vernon</a>, 15-year-old <a href=\"https://en.wikipedia.org/wiki/Harry_Potter_(character)\" title=\"Harry Potter (character)\">Harry Potter</a> and his cousin <a href=\"https://en.wikipedia.org/wiki/Dudley_Dursley\" title=\"Dudley Dursley\">Dudley</a> are attacked by <a href=\"https://en.wikipedia.org/wiki/Dementors\" title=\"Dementors\">Dementors</a>. After openly using magic to save Dudley and himself, Harry is expelled from Hogwarts, but his expulsion is postponed pending a hearing at the Ministry of Magic. Harry is whisked off by a group of wizards including <a href=\"https://en.wikipedia.org/wiki/%22Mad-Eye%22_Moody\" title=\"&quot;Mad-Eye&quot; Moody\">Mad-Eye Moody</a>, <a href=\"https://en.wikipedia.org/wiki/Remus_Lupin\" title=\"Remus Lupin\">Remus Lupin</a>, and several new faces, including <a href=\"https://en.wikipedia.org/wiki/Nymphadora_Tonks\" title=\"Nymphadora Tonks\">Nymphadora Tonks</a>, a bubbly young Metamorphmagus (a witch or wizard who can change his or her appearance without a potion or spell), and <a href=\"https://en.wikipedia.org/wiki/Kingsley_Shacklebolt\" title=\"Kingsley Shacklebolt\">Kingsley Shacklebolt</a>, a senior Auror, to <a href=\"https://en.wikipedia.org/wiki/Number_12,_Grimmauld_Place\" title=\"Number 12, Grimmauld Place\">Number 12, Grimmauld Place</a>, the childhood home of <a href=\"https://en.wikipedia.org/wiki/Sirius_Black\" title=\"Sirius Black\">Sirius Black</a>. The building also serves as the headquarters of the <a href=\"https://en.wikipedia.org/wiki/Order_of_the_Phoenix_(fictional_organisation)\" title=\"Order of the Phoenix (fictional organisation)\">Order of the Phoenix</a>, of which Mr. and Mrs. Weasley and Sirius are also members. <a href=\"https://en.wikipedia.org/wiki/Ron_Weasley\" title=\"Ron Weasley\">Ron Weasley</a> and <a href=\"https://en.wikipedia.org/wiki/Hermione_Granger\" title=\"Hermione Granger\">Hermione Granger</a> explain that the Order is a secret organisation led by Hogwarts headmaster <a href=\"https://en.wikipedia.org/wiki/Albus_Dumbledore\" title=\"Albus Dumbledore\">Albus Dumbledore</a> dedicated to fighting <a href=\"https://en.wikipedia.org/wiki/Lord_Voldemort\" title=\"Lord Voldemort\">Lord Voldemort</a> and his followers, the <a href=\"https://en.wikipedia.org/wiki/Death_Eaters\" title=\"Death Eaters\">Death Eaters</a>. From the members of the Order, Harry, Ron, Hermione, <a href=\"https://en.wikipedia.org/wiki/Ginny_Weasley\" title=\"Ginny Weasley\">Ginny Weasley</a> and <a href=\"https://en.wikipedia.org/wiki/Fred_and_George_Weasley\" title=\"Fred and George Weasley\">Fred and George Weasley</a> learn that Voldemort is seeking an object he did not have prior to his first defeat and assume this object to be a weapon of some sort. Harry learns the <a href=\"https://en.wikipedia.org/wiki/Ministry_of_Magic\" title=\"Ministry of Magic\">Ministry of Magic</a>, led by <a href=\"https://en.wikipedia.org/wiki/Cornelius_Fudge\" title=\"Cornelius Fudge\">Cornelius Fudge</a>, is refusing to acknowledge Voldemort\'s return because of the panic and chaos doing so would cause. Harry also learns <a href=\"https://en.wikipedia.org/wiki/The_Daily_Prophet\" title=\"The Daily Prophet\">the Daily Prophet</a> has been running a smear campaign against him and Dumbledore. At the hearing, Harry is cleared when Dumbledore provides evidence that Harry was fully within his rights to use magic against the Dementors, with Dumbledore calling into question how the creatures (normally Azkaban guards) were let loose in suburban Britain.</p>',NULL,NULL,NULL,NULL),(63,141,1,'2020-05-17 05:51:35','2020-05-17 05:51:35','34cc8f62-789c-4acb-8ee1-d2e8b897b7cc','<p><a href=\"https://en.wikipedia.org/wiki/Albus_Dumbledore\" title=\"Albus Dumbledore\">Dumbledore</a> picks Harry up from his aunt and uncle\'s house to escort him to the Burrow, home of Harry\'s best friend <a href=\"https://en.wikipedia.org/wiki/Ron_Weasley\" title=\"Ron Weasley\">Ron Weasley</a>. They detour to the home of <a href=\"https://en.wikipedia.org/wiki/Hogwarts_staff#Horace_Slughorn\" title=\"Hogwarts staff\">Horace Slughorn</a>, former <a href=\"https://en.wikipedia.org/wiki/Magic_in_Harry_Potter#Potions\" title=\"Magic in Harry Potter\">Potions</a> teacher at <a href=\"https://en.wikipedia.org/wiki/Hogwarts\" title=\"Hogwarts\">Hogwarts</a>, and Harry unwittingly helps persuade Slughorn to teach. Harry and Dumbledore proceed to the Burrow, where <a href=\"https://en.wikipedia.org/wiki/Hermione_Granger\" title=\"Hermione Granger\">Hermione Granger</a> has already arrived.</p>\n<p><a href=\"https://en.wikipedia.org/wiki/Severus_Snape\" title=\"Severus Snape\">Severus Snape</a>, a member of the <a href=\"https://en.wikipedia.org/wiki/Order_of_the_Phoenix_(organisation)\" title=\"Order of the Phoenix (organisation)\">Order of the Phoenix</a>, meets with <a href=\"https://en.wikipedia.org/wiki/List_of_supporting_Harry_Potter_characters#Narcissa_Malfoy\" title=\"List of supporting Harry Potter characters\">Narcissa Malfoy</a>, <a href=\"https://en.wikipedia.org/wiki/Draco_Malfoy\" title=\"Draco Malfoy\">Draco</a>\'s mother, and her sister <a href=\"https://en.wikipedia.org/wiki/Death_Eater#Bellatrix_Lestrange\" title=\"Death Eater\">Bellatrix Lestrange</a>, <a href=\"https://en.wikipedia.org/wiki/Lord_Voldemort\" title=\"Lord Voldemort\">Lord Voldemort</a>\'s faithful supporter. Narcissa expresses concern that her son might not survive a dangerous mission given to him by <a href=\"https://en.wikipedia.org/wiki/Lord_Voldemort\" title=\"Lord Voldemort\">Lord Voldemort</a>. Bellatrix believes Snape will not help until he makes an <a href=\"https://en.wikipedia.org/wiki/Magic_in_Harry_Potter#Unbreakable_Vow\" title=\"Magic in Harry Potter\">Unbreakable Vow</a> with Narcissa, swearing to assist Draco.</p>\n<p>On the <a href=\"https://en.wikipedia.org/wiki/Hogwarts_Express\" title=\"Hogwarts Express\">Hogwarts Express</a>, Harry discusses his suspicions of Draco’s allegiance with Voldemort, however Ron and Hermione are dubious. Harry dons his invisibility cloak and hides in the carriage that Malfoy is seated in. He overhears Draco bragging to his friends about the mission Voldemort has assigned him. Malfoy becomes suspicious that someone else is in the carriage and discovers Harry. He petrifies him and breaks his nose. <a href=\"https://en.wikipedia.org/wiki/Nymphadora_Tonks\" title=\"Nymphadora Tonks\">Nymphadora Tonks</a> finds Harry and escorts him to the castle.</p>\n<p><a href=\"https://en.wikipedia.org/wiki/Dumbledore\" title=\"Dumbledore\">Dumbledore</a> announces that Snape will be teaching <a href=\"https://en.wikipedia.org/wiki/Magic_in_Harry_Potter#Defence_Against_the_Dark_Arts\" title=\"Magic in Harry Potter\">Defence Against the Dark Arts</a> and Slughorn will be Potions master. Harry excels in Potions using a textbook that once belonged to \"The Half-Blood Prince\", who wrote tips and spells in the book. The Half-Blood Prince\'s tips help Harry win a bottle of Felix Felicis, or \"Liquid Luck\". Though Harry\'s success pleases Slughorn, his newfound brilliance in potions angers Hermione, who feels he is not earning his grades.</p>\n<p>Believing Harry needs to learn Voldemort\'s past to gain advantage in a foretold battle, Dumbledore and Harry use Dumbledore\'s <a href=\"https://en.wikipedia.org/wiki/Magical_objects_in_Harry_Potter#Pensieve\" title=\"Magical objects in Harry Potter\">Pensieve</a> to look at the memories of those who had direct contact with Voldemort. Harry learns about <a href=\"https://en.wikipedia.org/wiki/Lord_Voldemort#Family\" title=\"Lord Voldemort\">Voldemort\'s family</a> and his foe\'s evolution into a murderer, obsessed with power and immortality. Dumbledore shows Harry a memory involving Slughorn conversing with the young Tom Riddle at Hogwarts, which has been tampered with. He asks Harry to convince Slughorn to give him the true memory so that Dumbledore can confirm his suspicions about Voldemort.</p>',NULL,NULL,NULL,NULL),(64,143,1,'2020-05-17 05:51:35','2020-05-17 05:51:35','a24c56e4-2faa-4ea3-8803-b1e707e92e2a','<p><a href=\"https://en.wikipedia.org/wiki/Albus_Dumbledore\" title=\"Albus Dumbledore\">Dumbledore</a> picks Harry up from his aunt and uncle\'s house to escort him to the Burrow, home of Harry\'s best friend <a href=\"https://en.wikipedia.org/wiki/Ron_Weasley\" title=\"Ron Weasley\">Ron Weasley</a>. They detour to the home of <a href=\"https://en.wikipedia.org/wiki/Hogwarts_staff#Horace_Slughorn\" title=\"Hogwarts staff\">Horace Slughorn</a>, former <a href=\"https://en.wikipedia.org/wiki/Magic_in_Harry_Potter#Potions\" title=\"Magic in Harry Potter\">Potions</a> teacher at <a href=\"https://en.wikipedia.org/wiki/Hogwarts\" title=\"Hogwarts\">Hogwarts</a>, and Harry unwittingly helps persuade Slughorn to teach. Harry and Dumbledore proceed to the Burrow, where <a href=\"https://en.wikipedia.org/wiki/Hermione_Granger\" title=\"Hermione Granger\">Hermione Granger</a> has already arrived.</p>\n<p><a href=\"https://en.wikipedia.org/wiki/Severus_Snape\" title=\"Severus Snape\">Severus Snape</a>, a member of the <a href=\"https://en.wikipedia.org/wiki/Order_of_the_Phoenix_(organisation)\" title=\"Order of the Phoenix (organisation)\">Order of the Phoenix</a>, meets with <a href=\"https://en.wikipedia.org/wiki/List_of_supporting_Harry_Potter_characters#Narcissa_Malfoy\" title=\"List of supporting Harry Potter characters\">Narcissa Malfoy</a>, <a href=\"https://en.wikipedia.org/wiki/Draco_Malfoy\" title=\"Draco Malfoy\">Draco</a>\'s mother, and her sister <a href=\"https://en.wikipedia.org/wiki/Death_Eater#Bellatrix_Lestrange\" title=\"Death Eater\">Bellatrix Lestrange</a>, <a href=\"https://en.wikipedia.org/wiki/Lord_Voldemort\" title=\"Lord Voldemort\">Lord Voldemort</a>\'s faithful supporter. Narcissa expresses concern that her son might not survive a dangerous mission given to him by <a href=\"https://en.wikipedia.org/wiki/Lord_Voldemort\" title=\"Lord Voldemort\">Lord Voldemort</a>. Bellatrix believes Snape will not help until he makes an <a href=\"https://en.wikipedia.org/wiki/Magic_in_Harry_Potter#Unbreakable_Vow\" title=\"Magic in Harry Potter\">Unbreakable Vow</a> with Narcissa, swearing to assist Draco.</p>\n<p>On the <a href=\"https://en.wikipedia.org/wiki/Hogwarts_Express\" title=\"Hogwarts Express\">Hogwarts Express</a>, Harry discusses his suspicions of Draco’s allegiance with Voldemort, however Ron and Hermione are dubious. Harry dons his invisibility cloak and hides in the carriage that Malfoy is seated in. He overhears Draco bragging to his friends about the mission Voldemort has assigned him. Malfoy becomes suspicious that someone else is in the carriage and discovers Harry. He petrifies him and breaks his nose. <a href=\"https://en.wikipedia.org/wiki/Nymphadora_Tonks\" title=\"Nymphadora Tonks\">Nymphadora Tonks</a> finds Harry and escorts him to the castle.</p>\n<p><a href=\"https://en.wikipedia.org/wiki/Dumbledore\" title=\"Dumbledore\">Dumbledore</a> announces that Snape will be teaching <a href=\"https://en.wikipedia.org/wiki/Magic_in_Harry_Potter#Defence_Against_the_Dark_Arts\" title=\"Magic in Harry Potter\">Defence Against the Dark Arts</a> and Slughorn will be Potions master. Harry excels in Potions using a textbook that once belonged to \"The Half-Blood Prince\", who wrote tips and spells in the book. The Half-Blood Prince\'s tips help Harry win a bottle of Felix Felicis, or \"Liquid Luck\". Though Harry\'s success pleases Slughorn, his newfound brilliance in potions angers Hermione, who feels he is not earning his grades.</p>\n<p>Believing Harry needs to learn Voldemort\'s past to gain advantage in a foretold battle, Dumbledore and Harry use Dumbledore\'s <a href=\"https://en.wikipedia.org/wiki/Magical_objects_in_Harry_Potter#Pensieve\" title=\"Magical objects in Harry Potter\">Pensieve</a> to look at the memories of those who had direct contact with Voldemort. Harry learns about <a href=\"https://en.wikipedia.org/wiki/Lord_Voldemort#Family\" title=\"Lord Voldemort\">Voldemort\'s family</a> and his foe\'s evolution into a murderer, obsessed with power and immortality. Dumbledore shows Harry a memory involving Slughorn conversing with the young Tom Riddle at Hogwarts, which has been tampered with. He asks Harry to convince Slughorn to give him the true memory so that Dumbledore can confirm his suspicions about Voldemort.</p>',NULL,NULL,NULL,NULL),(65,144,1,'2020-05-17 05:52:11','2020-05-17 05:52:11','fb724a17-eac7-4085-9f53-d8ee2165985c','<p>Following Albus Dumbledore\'s death, Voldemort consolidates support and power, including attempting to take control of the Ministry of Magic. Meanwhile, Harry is about to turn seventeen, at which time he will lose the protection of his home. Members of the <a href=\"https://en.wikipedia.org/wiki/Order_of_the_Phoenix_(fictional_organisation)\" title=\"Order of the Phoenix (fictional organisation)\">Order of the Phoenix</a> explain the situation to the Dursleys and move them to a new location for protection. Using several of Harry\'s peers and friends as decoys, the Order plans to move Harry to the Burrow under protection, by flying him there. However, the Death Eaters have been tipped off about this plan, and the group is attacked upon departure. In the ensuing battle, <a href=\"https://en.wikipedia.org/wiki/Alastor_Moody\" title=\"Alastor Moody\">\"Mad-Eye\" Moody</a> and Hedwig are killed and <a href=\"https://en.wikipedia.org/wiki/George_Weasley\" title=\"George Weasley\">George Weasley</a> severely wounded. Voldemort himself arrives to kill Harry, but Harry\'s wand fends him off of its own.</p>\n<p>At the Burrow, Harry, Ron, and Hermione make preparations to abandon Hogwarts and hunt down Voldemort\'s four remaining <a href=\"https://en.wikipedia.org/wiki/Horcrux\" title=\"Horcrux\">Horcruxes</a> but have few clues as to their identities and locations. They also inherit strange bequests from among Dumbledore\'s possessions: a <a href=\"https://en.wikipedia.org/wiki/Golden_Snitch\" title=\"Golden Snitch\">Golden Snitch</a> for Harry, a <a href=\"https://en.wikipedia.org/wiki/Deluminator\" title=\"Deluminator\">Deluminator</a> for Ron, and a book of short tales collectively called <a href=\"https://en.wikipedia.org/wiki/The_Tales_of_Beedle_the_Bard\" title=\"The Tales of Beedle the Bard\">The Tales of Beedle the Bard</a> for Hermione. They are also bequeathed the <a href=\"https://en.wikipedia.org/wiki/Godric_Gryffindor%27s_Sword\" title=\"Godric Gryffindor\'s Sword\">Sword of Hogwarts co-founder Godric Gryffindor</a>, which they learn has the power to destroy Horcruxes, but the Ministry prevents them from receiving it. During Bill Weasley and Fleur Delacour\'s wedding, the <a href=\"https://en.wikipedia.org/wiki/Ministry_of_Magic\" title=\"Ministry of Magic\">Ministry of Magic</a> finally falls to Voldemort, with a Death Eater assuming the position of Minister for Magic, and the wedding is attacked by Death Eaters. Harry, Ron, and Hermione flee to 12 Grimmauld Place in London, the family home of <a href=\"https://en.wikipedia.org/wiki/Sirius_Black\" title=\"Sirius Black\">Sirius Black</a> that Harry inherited a year before.</p>\n<p>Harry realizes that Sirius\'s late brother Regulus was the person who had stolen the real Horcrux necklace, and had hid it in the Black house, where it was stolen by the criminal and Order associate Mundungus Fletcher. With the help of the house-elves <a href=\"https://en.wikipedia.org/wiki/Dobby_(Harry_Potter)\" title=\"Dobby (Harry Potter)\">Dobby</a> and <a href=\"https://en.wikipedia.org/wiki/Kreacher\" title=\"Kreacher\">Kreacher</a>, the trio locate Fletcher, who had since had the locket taken from him by <a href=\"https://en.wikipedia.org/wiki/Dolores_Umbridge\" title=\"Dolores Umbridge\">Dolores Umbridge</a>, a Ministry official and Harry\'s old nemesis.</p>\n<p>Harry, Ron and Hermione infiltrate the Ministry of Magic and successfully steal the locket from Umbridge, but, as they escape, Ron is injured and the Grimmauld Place safehouse is compromised, forcing the three to hide out in the Forest of Dean. There, with no way to destroy the Horcrux locket and no further leads, they pass many weeks on the run, living in fear and hearing little news from the outside world. The piece of Voldemort\'s soul within the locket exerts a negative emotional influence on all of them, especially Ron; his injury, fears for his family, and existing insecurities are amplified, leading him to abandon Harry and Hermione in a fit of rage.</p>',NULL,NULL,NULL,NULL),(66,146,1,'2020-05-17 05:52:11','2020-05-17 05:52:11','c77fed20-a058-4efb-8afc-b8cfe0b34c72','<p>Following Albus Dumbledore\'s death, Voldemort consolidates support and power, including attempting to take control of the Ministry of Magic. Meanwhile, Harry is about to turn seventeen, at which time he will lose the protection of his home. Members of the <a href=\"https://en.wikipedia.org/wiki/Order_of_the_Phoenix_(fictional_organisation)\" title=\"Order of the Phoenix (fictional organisation)\">Order of the Phoenix</a> explain the situation to the Dursleys and move them to a new location for protection. Using several of Harry\'s peers and friends as decoys, the Order plans to move Harry to the Burrow under protection, by flying him there. However, the Death Eaters have been tipped off about this plan, and the group is attacked upon departure. In the ensuing battle, <a href=\"https://en.wikipedia.org/wiki/Alastor_Moody\" title=\"Alastor Moody\">\"Mad-Eye\" Moody</a> and Hedwig are killed and <a href=\"https://en.wikipedia.org/wiki/George_Weasley\" title=\"George Weasley\">George Weasley</a> severely wounded. Voldemort himself arrives to kill Harry, but Harry\'s wand fends him off of its own.</p>\n<p>At the Burrow, Harry, Ron, and Hermione make preparations to abandon Hogwarts and hunt down Voldemort\'s four remaining <a href=\"https://en.wikipedia.org/wiki/Horcrux\" title=\"Horcrux\">Horcruxes</a> but have few clues as to their identities and locations. They also inherit strange bequests from among Dumbledore\'s possessions: a <a href=\"https://en.wikipedia.org/wiki/Golden_Snitch\" title=\"Golden Snitch\">Golden Snitch</a> for Harry, a <a href=\"https://en.wikipedia.org/wiki/Deluminator\" title=\"Deluminator\">Deluminator</a> for Ron, and a book of short tales collectively called <a href=\"https://en.wikipedia.org/wiki/The_Tales_of_Beedle_the_Bard\" title=\"The Tales of Beedle the Bard\">The Tales of Beedle the Bard</a> for Hermione. They are also bequeathed the <a href=\"https://en.wikipedia.org/wiki/Godric_Gryffindor%27s_Sword\" title=\"Godric Gryffindor\'s Sword\">Sword of Hogwarts co-founder Godric Gryffindor</a>, which they learn has the power to destroy Horcruxes, but the Ministry prevents them from receiving it. During Bill Weasley and Fleur Delacour\'s wedding, the <a href=\"https://en.wikipedia.org/wiki/Ministry_of_Magic\" title=\"Ministry of Magic\">Ministry of Magic</a> finally falls to Voldemort, with a Death Eater assuming the position of Minister for Magic, and the wedding is attacked by Death Eaters. Harry, Ron, and Hermione flee to 12 Grimmauld Place in London, the family home of <a href=\"https://en.wikipedia.org/wiki/Sirius_Black\" title=\"Sirius Black\">Sirius Black</a> that Harry inherited a year before.</p>\n<p>Harry realizes that Sirius\'s late brother Regulus was the person who had stolen the real Horcrux necklace, and had hid it in the Black house, where it was stolen by the criminal and Order associate Mundungus Fletcher. With the help of the house-elves <a href=\"https://en.wikipedia.org/wiki/Dobby_(Harry_Potter)\" title=\"Dobby (Harry Potter)\">Dobby</a> and <a href=\"https://en.wikipedia.org/wiki/Kreacher\" title=\"Kreacher\">Kreacher</a>, the trio locate Fletcher, who had since had the locket taken from him by <a href=\"https://en.wikipedia.org/wiki/Dolores_Umbridge\" title=\"Dolores Umbridge\">Dolores Umbridge</a>, a Ministry official and Harry\'s old nemesis.</p>\n<p>Harry, Ron and Hermione infiltrate the Ministry of Magic and successfully steal the locket from Umbridge, but, as they escape, Ron is injured and the Grimmauld Place safehouse is compromised, forcing the three to hide out in the Forest of Dean. There, with no way to destroy the Horcrux locket and no further leads, they pass many weeks on the run, living in fear and hearing little news from the outside world. The piece of Voldemort\'s soul within the locket exerts a negative emotional influence on all of them, especially Ron; his injury, fears for his family, and existing insecurities are amplified, leading him to abandon Harry and Hermione in a fit of rage.</p>',NULL,NULL,NULL,NULL),(67,147,1,'2020-05-17 05:53:18','2020-05-17 05:53:18','4eeaf94f-86f6-47a2-a682-8e2738df3e3a','<p>In a prologue, which Harry sees through a dream, the 3 <a href=\"https://en.wikipedia.org/wiki/Riddles\" title=\"Riddles\">Riddles</a> are murdered. But they weren\'t poisoned or hurt in anyway. They were in perfect health but when they died, they had a petrified face. Everyone suspects the caretaker Frank Bryce. But he was released. Later on (in Harry\'s dream) <a href=\"https://en.wikipedia.org/wiki/Frank_Bryce\" title=\"Frank Bryce\">Frank Bryce</a>, Muggle caretaker of an abandoned mansion known as the Riddle House, is murdered by <a href=\"https://en.wikipedia.org/wiki/Lord_Voldemort\" title=\"Lord Voldemort\">Lord Voldemort</a> after stumbling upon him and <a href=\"https://en.wikipedia.org/wiki/Wormtail\" title=\"Wormtail\">Wormtail</a>. Harry is awoken by his scar hurting.</p>\n<p>The <a href=\"https://en.wikipedia.org/wiki/Weasleys\" title=\"Weasleys\">Weasleys</a> invite Harry and <a href=\"https://en.wikipedia.org/wiki/Hermione_Granger\" title=\"Hermione Granger\">Hermione Granger</a> to the <a href=\"https://en.wikipedia.org/wiki/Quidditch_World_Cup\" title=\"Quidditch World Cup\">Quidditch World Cup</a>, to which they travel using a <a href=\"https://en.wikipedia.org/wiki/Portkey\" title=\"Portkey\">Portkey</a>, meeting <a href=\"https://en.wikipedia.org/wiki/Cedric_Diggory\" title=\"Cedric Diggory\">Cedric Diggory</a>, a Hufflepuff sixth-year, on the way. In the match, Ireland triumph over Bulgaria, despite the skill of Bulgaria\'s star seeker, <a href=\"https://en.wikipedia.org/wiki/Viktor_Krum\" title=\"Viktor Krum\">Viktor Krum</a>. Various Ministry of Magic employees at the World Cup discuss <a href=\"https://en.wikipedia.org/wiki/Bertha_Jorkins\" title=\"Bertha Jorkins\">Bertha Jorkins</a>, a Ministry worker who has gone missing. Her head-of-department, the charismatic <a href=\"https://en.wikipedia.org/wiki/Ludo_Bagman\" title=\"Ludo Bagman\">Ludo Bagman</a>, is unconcerned.</p>\n<p>After the match, men wearing the masks of <a href=\"https://en.wikipedia.org/wiki/Death_Eater\" title=\"Death Eater\">Death Eaters</a>, followers of Voldemort, attack the camp site, causing terror and abusing the Muggle campsite owners. The <a href=\"https://en.wikipedia.org/wiki/Dark_Mark\" title=\"Dark Mark\">Dark Mark</a> is fired into the sky, causing mass panic. Harry discovers that his wand is missing. It is later found in the possession of <a href=\"https://en.wikipedia.org/wiki/Magical_creatures_in_Harry_Potter#Winky\" title=\"Magical creatures in Harry Potter\">Winky</a>, <a href=\"https://en.wikipedia.org/wiki/Barty_Crouch_Senior\" title=\"Barty Crouch Senior\">Barty Crouch</a>\'s house elf, and the wand is found to have been used to cast the Mark. Although very few believe Winky could have conjured the Mark, Barty Crouch dismisses Winky from his service. Hermione, angry at this injustice, forms a society to promote house elf rights, known as <a href=\"https://en.wikipedia.org/wiki/S.P.E.W.\" title=\"S.P.E.W.\">S.P.E.W.</a> (Society for the Promotion of Elfish Welfare).</p>\n<p>At Hogwarts, <a href=\"https://en.wikipedia.org/wiki/Professor_Dumbledore\" title=\"Professor Dumbledore\">Professor Dumbledore</a> announces that <a href=\"https://en.wikipedia.org/wiki/Alastor_Moody\" title=\"Alastor Moody\">Alastor \"Mad-Eye\" Moody</a> will be the <a href=\"https://en.wikipedia.org/wiki/Defence_Against_the_Dark_Arts\" title=\"Defence Against the Dark Arts\">Defence Against the Dark Arts</a> teacher for the year. Dumbledore also announces that Hogwarts will host a revival of the Triwizard Tournament, in which a champion of Hogwarts will compete against champions from two other European wizarding schools: Beauxbatons Academy, and Durmstrang Institute. The champions are chosen by the Goblet of Fire from names dropped into it. Because Harry is under 17 (the <a href=\"https://en.wikipedia.org/wiki/Age_of_majority\" title=\"Age of majority\">age of majority</a> in the wizarding world), he is disallowed from entering.</p>',NULL,NULL,NULL,NULL),(68,149,1,'2020-05-17 05:53:18','2020-05-17 05:53:18','dcc6edfe-ac8a-41b8-aa77-1d9246e3c8f9','<p>In a prologue, which Harry sees through a dream, the 3 <a href=\"https://en.wikipedia.org/wiki/Riddles\" title=\"Riddles\">Riddles</a> are murdered. But they weren\'t poisoned or hurt in anyway. They were in perfect health but when they died, they had a petrified face. Everyone suspects the caretaker Frank Bryce. But he was released. Later on (in Harry\'s dream) <a href=\"https://en.wikipedia.org/wiki/Frank_Bryce\" title=\"Frank Bryce\">Frank Bryce</a>, Muggle caretaker of an abandoned mansion known as the Riddle House, is murdered by <a href=\"https://en.wikipedia.org/wiki/Lord_Voldemort\" title=\"Lord Voldemort\">Lord Voldemort</a> after stumbling upon him and <a href=\"https://en.wikipedia.org/wiki/Wormtail\" title=\"Wormtail\">Wormtail</a>. Harry is awoken by his scar hurting.</p>\n<p>The <a href=\"https://en.wikipedia.org/wiki/Weasleys\" title=\"Weasleys\">Weasleys</a> invite Harry and <a href=\"https://en.wikipedia.org/wiki/Hermione_Granger\" title=\"Hermione Granger\">Hermione Granger</a> to the <a href=\"https://en.wikipedia.org/wiki/Quidditch_World_Cup\" title=\"Quidditch World Cup\">Quidditch World Cup</a>, to which they travel using a <a href=\"https://en.wikipedia.org/wiki/Portkey\" title=\"Portkey\">Portkey</a>, meeting <a href=\"https://en.wikipedia.org/wiki/Cedric_Diggory\" title=\"Cedric Diggory\">Cedric Diggory</a>, a Hufflepuff sixth-year, on the way. In the match, Ireland triumph over Bulgaria, despite the skill of Bulgaria\'s star seeker, <a href=\"https://en.wikipedia.org/wiki/Viktor_Krum\" title=\"Viktor Krum\">Viktor Krum</a>. Various Ministry of Magic employees at the World Cup discuss <a href=\"https://en.wikipedia.org/wiki/Bertha_Jorkins\" title=\"Bertha Jorkins\">Bertha Jorkins</a>, a Ministry worker who has gone missing. Her head-of-department, the charismatic <a href=\"https://en.wikipedia.org/wiki/Ludo_Bagman\" title=\"Ludo Bagman\">Ludo Bagman</a>, is unconcerned.</p>\n<p>After the match, men wearing the masks of <a href=\"https://en.wikipedia.org/wiki/Death_Eater\" title=\"Death Eater\">Death Eaters</a>, followers of Voldemort, attack the camp site, causing terror and abusing the Muggle campsite owners. The <a href=\"https://en.wikipedia.org/wiki/Dark_Mark\" title=\"Dark Mark\">Dark Mark</a> is fired into the sky, causing mass panic. Harry discovers that his wand is missing. It is later found in the possession of <a href=\"https://en.wikipedia.org/wiki/Magical_creatures_in_Harry_Potter#Winky\" title=\"Magical creatures in Harry Potter\">Winky</a>, <a href=\"https://en.wikipedia.org/wiki/Barty_Crouch_Senior\" title=\"Barty Crouch Senior\">Barty Crouch</a>\'s house elf, and the wand is found to have been used to cast the Mark. Although very few believe Winky could have conjured the Mark, Barty Crouch dismisses Winky from his service. Hermione, angry at this injustice, forms a society to promote house elf rights, known as <a href=\"https://en.wikipedia.org/wiki/S.P.E.W.\" title=\"S.P.E.W.\">S.P.E.W.</a> (Society for the Promotion of Elfish Welfare).</p>\n<p>At Hogwarts, <a href=\"https://en.wikipedia.org/wiki/Professor_Dumbledore\" title=\"Professor Dumbledore\">Professor Dumbledore</a> announces that <a href=\"https://en.wikipedia.org/wiki/Alastor_Moody\" title=\"Alastor Moody\">Alastor \"Mad-Eye\" Moody</a> will be the <a href=\"https://en.wikipedia.org/wiki/Defence_Against_the_Dark_Arts\" title=\"Defence Against the Dark Arts\">Defence Against the Dark Arts</a> teacher for the year. Dumbledore also announces that Hogwarts will host a revival of the Triwizard Tournament, in which a champion of Hogwarts will compete against champions from two other European wizarding schools: Beauxbatons Academy, and Durmstrang Institute. The champions are chosen by the Goblet of Fire from names dropped into it. Because Harry is under 17 (the <a href=\"https://en.wikipedia.org/wiki/Age_of_majority\" title=\"Age of majority\">age of majority</a> in the wizarding world), he is disallowed from entering.</p>',NULL,NULL,NULL,NULL),(69,150,1,'2020-05-17 05:53:47','2020-05-17 05:53:47','9ff375b6-59a5-4d03-9e55-425879ab1636','<p>Harry is back at the <a href=\"https://en.wikipedia.org/wiki/List_of_supporting_Harry_Potter_characters#The_Dursleys\" title=\"List of supporting Harry Potter characters\">Dursley\'s</a> for the summer holidays, where he sees on Muggle television that a convict named <a href=\"https://en.wikipedia.org/wiki/Sirius_Black\" title=\"Sirius Black\">Sirius Black</a> has escaped from prison. After the Dursley\'s <a href=\"https://en.wikipedia.org/wiki/Aunt_Marge\" title=\"Aunt Marge\">Aunt Marge</a> personally insults Harry, Harry accidentally inflates her, then runs away from home, fearing expulsion from school. After being picked up by the <a href=\"https://en.wikipedia.org/wiki/Knight_Bus\" title=\"Knight Bus\">Knight Bus</a>, meeting <a href=\"https://en.wikipedia.org/wiki/List_of_supporting_Harry_Potter_characters#Stan_Shunpike\" title=\"List of supporting Harry Potter characters\">Stan Shunpike</a>, and encountering a large black dog that seems to be watching him, he travels to the <a href=\"https://en.wikipedia.org/wiki/The_Leaky_Cauldron_(pub)\" title=\"The Leaky Cauldron (pub)\">Leaky Cauldron</a>, where <a href=\"https://en.wikipedia.org/wiki/Cornelius_Fudge\" title=\"Cornelius Fudge\">Cornelius Fudge</a>, the <a href=\"https://en.wikipedia.org/wiki/Minister_for_Magic\" title=\"Minister for Magic\">Minister for Magic</a>, asks Harry to stay in <a href=\"https://en.wikipedia.org/wiki/Diagon_Alley\" title=\"Diagon Alley\">Diagon Alley</a> for his own protection. While there, he meets his best friends <a href=\"https://en.wikipedia.org/wiki/Ron_Weasley\" title=\"Ron Weasley\">Ron Weasley</a> and <a href=\"https://en.wikipedia.org/wiki/Hermione_Granger\" title=\"Hermione Granger\">Hermione Granger</a>.</p>\n<p>Before leaving for <a href=\"https://en.wikipedia.org/wiki/Hogwarts\" title=\"Hogwarts\">Hogwarts</a>, Harry learns from <a href=\"https://en.wikipedia.org/wiki/Arthur_Weasley\" title=\"Arthur Weasley\">Arthur Weasley</a> that Sirius Black is a convicted murderer from the wizarding world and that Black has escaped from the wizard prison Azkaban to kill Harry. On the way to Hogwarts, a <a href=\"https://en.wikipedia.org/wiki/Dementor\" title=\"Dementor\">Dementor</a> (an Azkaban prison guard that feeds on positive thoughts) boards the train, causing Harry to relive his parents\' deaths before fainting. The new <a href=\"https://en.wikipedia.org/wiki/Defence_against_the_dark_arts\" title=\"Defence against the dark arts\">Defence Against the Dark Arts</a> teacher, <a href=\"https://en.wikipedia.org/wiki/Professor_Lupin\" title=\"Professor Lupin\">Remus Lupin</a>, protects Harry, Ron, and Hermione from the Dementor. They later learn Dementors will be patrolling the school in an attempt to catch Black. Although Professor Lupin is popular with his students, the Potions master, <a href=\"https://en.wikipedia.org/wiki/Severus_Snape\" title=\"Severus Snape\">Snape</a>, seems to hate him.</p>\n<p>While Third Years are allowed to visit the all-wizarding village of Hogsmeade on holiday, Harry is blocked from going because he has no permission slip from his legal guardian. Fred and George Weasley give him the Marauder\'s Map, which is enchanted to show all passages and people on Hogwarts grounds, to sneak out. Lupin later catches Harry with the map and reveals that it was made by his friend group, the Marauders, back in their school days.</p>',NULL,NULL,NULL,NULL),(70,152,1,'2020-05-17 05:53:47','2020-05-17 05:53:47','49995e47-8866-4697-af0b-61ad692de70b','<p>Harry is back at the <a href=\"https://en.wikipedia.org/wiki/List_of_supporting_Harry_Potter_characters#The_Dursleys\" title=\"List of supporting Harry Potter characters\">Dursley\'s</a> for the summer holidays, where he sees on Muggle television that a convict named <a href=\"https://en.wikipedia.org/wiki/Sirius_Black\" title=\"Sirius Black\">Sirius Black</a> has escaped from prison. After the Dursley\'s <a href=\"https://en.wikipedia.org/wiki/Aunt_Marge\" title=\"Aunt Marge\">Aunt Marge</a> personally insults Harry, Harry accidentally inflates her, then runs away from home, fearing expulsion from school. After being picked up by the <a href=\"https://en.wikipedia.org/wiki/Knight_Bus\" title=\"Knight Bus\">Knight Bus</a>, meeting <a href=\"https://en.wikipedia.org/wiki/List_of_supporting_Harry_Potter_characters#Stan_Shunpike\" title=\"List of supporting Harry Potter characters\">Stan Shunpike</a>, and encountering a large black dog that seems to be watching him, he travels to the <a href=\"https://en.wikipedia.org/wiki/The_Leaky_Cauldron_(pub)\" title=\"The Leaky Cauldron (pub)\">Leaky Cauldron</a>, where <a href=\"https://en.wikipedia.org/wiki/Cornelius_Fudge\" title=\"Cornelius Fudge\">Cornelius Fudge</a>, the <a href=\"https://en.wikipedia.org/wiki/Minister_for_Magic\" title=\"Minister for Magic\">Minister for Magic</a>, asks Harry to stay in <a href=\"https://en.wikipedia.org/wiki/Diagon_Alley\" title=\"Diagon Alley\">Diagon Alley</a> for his own protection. While there, he meets his best friends <a href=\"https://en.wikipedia.org/wiki/Ron_Weasley\" title=\"Ron Weasley\">Ron Weasley</a> and <a href=\"https://en.wikipedia.org/wiki/Hermione_Granger\" title=\"Hermione Granger\">Hermione Granger</a>.</p>\n<p>Before leaving for <a href=\"https://en.wikipedia.org/wiki/Hogwarts\" title=\"Hogwarts\">Hogwarts</a>, Harry learns from <a href=\"https://en.wikipedia.org/wiki/Arthur_Weasley\" title=\"Arthur Weasley\">Arthur Weasley</a> that Sirius Black is a convicted murderer from the wizarding world and that Black has escaped from the wizard prison Azkaban to kill Harry. On the way to Hogwarts, a <a href=\"https://en.wikipedia.org/wiki/Dementor\" title=\"Dementor\">Dementor</a> (an Azkaban prison guard that feeds on positive thoughts) boards the train, causing Harry to relive his parents\' deaths before fainting. The new <a href=\"https://en.wikipedia.org/wiki/Defence_against_the_dark_arts\" title=\"Defence against the dark arts\">Defence Against the Dark Arts</a> teacher, <a href=\"https://en.wikipedia.org/wiki/Professor_Lupin\" title=\"Professor Lupin\">Remus Lupin</a>, protects Harry, Ron, and Hermione from the Dementor. They later learn Dementors will be patrolling the school in an attempt to catch Black. Although Professor Lupin is popular with his students, the Potions master, <a href=\"https://en.wikipedia.org/wiki/Severus_Snape\" title=\"Severus Snape\">Snape</a>, seems to hate him.</p>\n<p>While Third Years are allowed to visit the all-wizarding village of Hogsmeade on holiday, Harry is blocked from going because he has no permission slip from his legal guardian. Fred and George Weasley give him the Marauder\'s Map, which is enchanted to show all passages and people on Hogwarts grounds, to sneak out. Lupin later catches Harry with the map and reveals that it was made by his friend group, the Marauders, back in their school days.</p>',NULL,NULL,NULL,NULL),(71,153,1,'2020-05-17 05:54:06','2020-05-17 05:54:06','3e654cc3-c0c3-4806-9dcc-26b1651a6c6c','<p>On <a href=\"https://en.wikipedia.org/wiki/Harry_Potter_(character)\" title=\"Harry Potter (character)\">Harry Potter</a>\'s twelfth birthday, the Dursley family—Harry\'s uncle <a href=\"https://en.wikipedia.org/wiki/Vernon_Dursley\" title=\"Vernon Dursley\">Vernon</a>, aunt <a href=\"https://en.wikipedia.org/wiki/Petunia_Dursley\" title=\"Petunia Dursley\">Petunia</a>, and cousin <a href=\"https://en.wikipedia.org/wiki/Dudley_Dursley\" title=\"Dudley Dursley\">Dudley</a>—hold a dinner party for a potential client of Vernon\'s drill-manufacturing company. Harry is not invited but is content to spend the evening quietly in his bedroom, although he is confused why his school friends have not sent cards or presents. However, while in his room, a house-elf named <a href=\"https://en.wikipedia.org/wiki/Dobby_(Harry_Potter)\" title=\"Dobby (Harry Potter)\">Dobby</a> shows up at his house and warns him not to return to Hogwarts and admits to intercepting Harry\'s post from his friends. Having failed to persuade Harry to voluntarily give up his place at Hogwarts, Dobby then attempts to get him expelled by using magic to smash Aunt Petunia\'s dessert on the kitchen floor and framing Harry, who is not allowed to use magic outside school. Uncle Vernon\'s business deal falls through, but Harry is given a second chance from the Ministry of Magic and allowed to return at the start of the school year.</p>\n<p>In the meantime, Uncle Vernon punishes Harry, fitting locks to his bedroom door and bars to the windows. However, Harry’s best friend <a href=\"https://en.wikipedia.org/wiki/Ron_Weasley\" title=\"Ron Weasley\">Ron Weasley</a> arrives with his twin brothers <a href=\"https://en.wikipedia.org/wiki/Fred_and_George_Weasley\" title=\"Fred and George Weasley\">Fred and George</a> in their father <a href=\"https://en.wikipedia.org/wiki/Arthur_Weasley\" title=\"Arthur Weasley\">Arthur</a>’s enchanted <a href=\"https://en.wikipedia.org/wiki/Ford_Anglia\" title=\"Ford Anglia\">Ford Anglia</a>. They rescue Harry, who stays at the Weasley\'s family home, the Burrow, for the remainder of his holidays. Harry and the other Weasleys—mother <a href=\"https://en.wikipedia.org/wiki/Molly_Weasley\" title=\"Molly Weasley\">Molly</a>, third-eldest son <a href=\"https://en.wikipedia.org/wiki/Percy_Weasley\" title=\"Percy Weasley\">Percy</a>, and daughter <a href=\"https://en.wikipedia.org/wiki/Ginny_Weasley\" title=\"Ginny Weasley\">Ginny</a> (who has a crush on Harry)—travel to Diagon Alley. They are then reunited with <a href=\"https://en.wikipedia.org/wiki/Hermione_Granger\" title=\"Hermione Granger\">Hermione Granger</a> and introduced to <a href=\"https://en.wikipedia.org/wiki/Lucius_Malfoy\" title=\"Lucius Malfoy\">Lucius Malfoy</a>, father of Harry’s school nemesis <a href=\"https://en.wikipedia.org/wiki/Draco_Malfoy\" title=\"Draco Malfoy\">Draco</a>, and <a href=\"https://en.wikipedia.org/wiki/Gilderoy_Lockhart\" title=\"Gilderoy Lockhart\">Gilderoy Lockhart</a>, a conceited autobiographer who has been appointed Defence Against the Dark Arts professor after the death of <a href=\"https://en.wikipedia.org/wiki/Quirinus_Quirrell\" title=\"Quirinus Quirrell\">Professor Quirrell</a>. When Harry and Ron approach <a href=\"https://en.wikipedia.org/wiki/Platform_9_3/4\" title=\"Platform 9 3/4\">Platform 9<sup>3</sup>⁄<sub>4</sub>.</a> in King\'s Cross station, it refuses to allow them to pass. They decide to fly Arthur’s car to Hogwarts after missing the train when they cannot get through the barrier. Harry and Ron crash into a <a href=\"https://en.wikipedia.org/wiki/Whomping_Willow\" title=\"Whomping Willow\">Whomping Willow</a> on the grounds.</p>\n<p>In punishment for the crash, Ron cleans the school trophies, and Harry helps Professor Lockhart, whose classes are chaotic, with addressing his fan mail. Harry learns of some wizards\' prejudice about blood status in terms of “pure” blood (only wizarding heritage) and those with Muggle (non-magical) parentage. He is alone in hearing an unnerving voice seemingly coming from the walls of the school itself. During a deathday party for Gryffindor House’s ghost <a href=\"https://en.wikipedia.org/wiki/Nearly_Headless_Nick\" title=\"Nearly Headless Nick\">Nearly Headless Nick</a>, Harry, Ron, and Hermione run into the school caretaker <a href=\"https://en.wikipedia.org/wiki/Argus_Filch\" title=\"Argus Filch\">Argus Filch</a>’s petrified cat, Mrs. Norris, along with a warning scrawled on the wall: “The Chamber of Secrets has been opened. Enemies of the heir, beware.”</p>',NULL,NULL,NULL,NULL),(72,155,1,'2020-05-17 05:54:07','2020-05-17 05:54:07','9640b0ca-2471-46a1-a5d0-47badcbe5a1a','<p>On <a href=\"https://en.wikipedia.org/wiki/Harry_Potter_(character)\" title=\"Harry Potter (character)\">Harry Potter</a>\'s twelfth birthday, the Dursley family—Harry\'s uncle <a href=\"https://en.wikipedia.org/wiki/Vernon_Dursley\" title=\"Vernon Dursley\">Vernon</a>, aunt <a href=\"https://en.wikipedia.org/wiki/Petunia_Dursley\" title=\"Petunia Dursley\">Petunia</a>, and cousin <a href=\"https://en.wikipedia.org/wiki/Dudley_Dursley\" title=\"Dudley Dursley\">Dudley</a>—hold a dinner party for a potential client of Vernon\'s drill-manufacturing company. Harry is not invited but is content to spend the evening quietly in his bedroom, although he is confused why his school friends have not sent cards or presents. However, while in his room, a house-elf named <a href=\"https://en.wikipedia.org/wiki/Dobby_(Harry_Potter)\" title=\"Dobby (Harry Potter)\">Dobby</a> shows up at his house and warns him not to return to Hogwarts and admits to intercepting Harry\'s post from his friends. Having failed to persuade Harry to voluntarily give up his place at Hogwarts, Dobby then attempts to get him expelled by using magic to smash Aunt Petunia\'s dessert on the kitchen floor and framing Harry, who is not allowed to use magic outside school. Uncle Vernon\'s business deal falls through, but Harry is given a second chance from the Ministry of Magic and allowed to return at the start of the school year.</p>\n<p>In the meantime, Uncle Vernon punishes Harry, fitting locks to his bedroom door and bars to the windows. However, Harry’s best friend <a href=\"https://en.wikipedia.org/wiki/Ron_Weasley\" title=\"Ron Weasley\">Ron Weasley</a> arrives with his twin brothers <a href=\"https://en.wikipedia.org/wiki/Fred_and_George_Weasley\" title=\"Fred and George Weasley\">Fred and George</a> in their father <a href=\"https://en.wikipedia.org/wiki/Arthur_Weasley\" title=\"Arthur Weasley\">Arthur</a>’s enchanted <a href=\"https://en.wikipedia.org/wiki/Ford_Anglia\" title=\"Ford Anglia\">Ford Anglia</a>. They rescue Harry, who stays at the Weasley\'s family home, the Burrow, for the remainder of his holidays. Harry and the other Weasleys—mother <a href=\"https://en.wikipedia.org/wiki/Molly_Weasley\" title=\"Molly Weasley\">Molly</a>, third-eldest son <a href=\"https://en.wikipedia.org/wiki/Percy_Weasley\" title=\"Percy Weasley\">Percy</a>, and daughter <a href=\"https://en.wikipedia.org/wiki/Ginny_Weasley\" title=\"Ginny Weasley\">Ginny</a> (who has a crush on Harry)—travel to Diagon Alley. They are then reunited with <a href=\"https://en.wikipedia.org/wiki/Hermione_Granger\" title=\"Hermione Granger\">Hermione Granger</a> and introduced to <a href=\"https://en.wikipedia.org/wiki/Lucius_Malfoy\" title=\"Lucius Malfoy\">Lucius Malfoy</a>, father of Harry’s school nemesis <a href=\"https://en.wikipedia.org/wiki/Draco_Malfoy\" title=\"Draco Malfoy\">Draco</a>, and <a href=\"https://en.wikipedia.org/wiki/Gilderoy_Lockhart\" title=\"Gilderoy Lockhart\">Gilderoy Lockhart</a>, a conceited autobiographer who has been appointed Defence Against the Dark Arts professor after the death of <a href=\"https://en.wikipedia.org/wiki/Quirinus_Quirrell\" title=\"Quirinus Quirrell\">Professor Quirrell</a>. When Harry and Ron approach <a href=\"https://en.wikipedia.org/wiki/Platform_9_3/4\" title=\"Platform 9 3/4\">Platform 9<sup>3</sup>⁄<sub>4</sub>.</a> in King\'s Cross station, it refuses to allow them to pass. They decide to fly Arthur’s car to Hogwarts after missing the train when they cannot get through the barrier. Harry and Ron crash into a <a href=\"https://en.wikipedia.org/wiki/Whomping_Willow\" title=\"Whomping Willow\">Whomping Willow</a> on the grounds.</p>\n<p>In punishment for the crash, Ron cleans the school trophies, and Harry helps Professor Lockhart, whose classes are chaotic, with addressing his fan mail. Harry learns of some wizards\' prejudice about blood status in terms of “pure” blood (only wizarding heritage) and those with Muggle (non-magical) parentage. He is alone in hearing an unnerving voice seemingly coming from the walls of the school itself. During a deathday party for Gryffindor House’s ghost <a href=\"https://en.wikipedia.org/wiki/Nearly_Headless_Nick\" title=\"Nearly Headless Nick\">Nearly Headless Nick</a>, Harry, Ron, and Hermione run into the school caretaker <a href=\"https://en.wikipedia.org/wiki/Argus_Filch\" title=\"Argus Filch\">Argus Filch</a>’s petrified cat, Mrs. Norris, along with a warning scrawled on the wall: “The Chamber of Secrets has been opened. Enemies of the heir, beware.”</p>',NULL,NULL,NULL,NULL),(73,156,1,'2020-05-17 05:54:34','2020-05-17 05:54:34','225b8dcc-d5df-4f17-a4fe-716ae503e918','<p>Harry Potter has been living an ordinary life, constantly abused by his surly and cold aunt and uncle, <a href=\"https://en.wikipedia.org/wiki/Dursley_family\" title=\"Dursley family\">Vernon and Petunia Dursley</a> and bullied by their spoiled son Dudley since the death of his parents ten years prior. His life changes on the day of his eleventh birthday when he receives a letter of acceptance into <a href=\"https://en.wikipedia.org/wiki/Hogwarts_School_of_Witchcraft_and_Wizardry\" title=\"Hogwarts School of Witchcraft and Wizardry\">Hogwarts School of Witchcraft and Wizardry</a>, delivered by a half-giant named <a href=\"https://en.wikipedia.org/wiki/Rubeus_Hagrid\" title=\"Rubeus Hagrid\">Rubeus Hagrid</a> after previous letters had been destroyed by Vernon and Petunia. Hagrid details Harry\'s past as the son of <a href=\"https://en.wikipedia.org/wiki/James_Potter_(character)\" title=\"James Potter (character)\">James</a> and <a href=\"https://en.wikipedia.org/wiki/Lily_Potter\" title=\"Lily Potter\">Lily Potter</a>, who were a wizard and witch respectively, and how they were murdered by the most evil and powerful dark wizard of all time, <a href=\"https://en.wikipedia.org/wiki/Lord_Voldemort\" title=\"Lord Voldemort\">Lord Voldemort</a>, which resulted in the one-year-old Harry being sent to live with his aunt and uncle. Voldemort was not only unable to kill Harry, but his powers were also destroyed in the attempt, forcing him into exile and sparking Harry\'s immense fame among the magical community.</p>\n<p>Hagrid introduces Harry to the <a href=\"https://en.wikipedia.org/wiki/Wizarding_world\" title=\"Wizarding world\">wizarding world</a> by bringing him to <a href=\"https://en.wikipedia.org/wiki/Diagon_Alley\" title=\"Diagon Alley\">Diagon Alley</a>, a hidden street in London where Harry uncovers a fortune left to him by his parents at <a href=\"https://en.wikipedia.org/wiki/Gringotts_Wizarding_Bank\" title=\"Gringotts Wizarding Bank\">Gringotts Wizarding Bank</a>, receives a pet owl, Hedwig, various school supplies, and a wand (which he learns shares a core from the same source as Voldemort\'s wand). There, he is surprised to discover how famous he truly is among witches and wizards as \"The Boy Who Lived\". A month later, Harry leaves the Dursleys\' home to catch the <a href=\"https://en.wikipedia.org/wiki/Hogwarts_Express\" title=\"Hogwarts Express\">Hogwarts Express</a> from <a href=\"https://en.wikipedia.org/wiki/London_King%27s_Cross_railway_station\" title=\"London King\'s Cross railway station\">King\'s Cross railway station</a>\'s secret Hogwarts platform, <a href=\"https://en.wikipedia.org/wiki/Platform_9%C2%BE\" title=\"Platform 9¾\">Platform ​9 <sup>3</sup>⁄<sub>4</sub></a>. On the train, he quickly befriends fellow first-year <a href=\"https://en.wikipedia.org/wiki/Ronald_Weasley\" title=\"Ronald Weasley\">Ronald Weasley</a> and the two boys meet <a href=\"https://en.wikipedia.org/wiki/Hermione_Granger\" title=\"Hermione Granger\">Hermione Granger</a>, whose snobbiness and affinity for spells initially causes the two boys to dislike her. There, Harry also makes an enemy of yet another first-year, <a href=\"https://en.wikipedia.org/wiki/Draco_Malfoy\" title=\"Draco Malfoy\">Draco Malfoy</a>, who shows prejudice against Ron for his family\'s financial difficulties.</p>',NULL,NULL,NULL,NULL),(74,158,1,'2020-05-17 05:54:34','2020-05-17 05:54:34','973c4b91-ebce-4f68-826a-c6875f57f168','<p>Harry Potter has been living an ordinary life, constantly abused by his surly and cold aunt and uncle, <a href=\"https://en.wikipedia.org/wiki/Dursley_family\" title=\"Dursley family\">Vernon and Petunia Dursley</a> and bullied by their spoiled son Dudley since the death of his parents ten years prior. His life changes on the day of his eleventh birthday when he receives a letter of acceptance into <a href=\"https://en.wikipedia.org/wiki/Hogwarts_School_of_Witchcraft_and_Wizardry\" title=\"Hogwarts School of Witchcraft and Wizardry\">Hogwarts School of Witchcraft and Wizardry</a>, delivered by a half-giant named <a href=\"https://en.wikipedia.org/wiki/Rubeus_Hagrid\" title=\"Rubeus Hagrid\">Rubeus Hagrid</a> after previous letters had been destroyed by Vernon and Petunia. Hagrid details Harry\'s past as the son of <a href=\"https://en.wikipedia.org/wiki/James_Potter_(character)\" title=\"James Potter (character)\">James</a> and <a href=\"https://en.wikipedia.org/wiki/Lily_Potter\" title=\"Lily Potter\">Lily Potter</a>, who were a wizard and witch respectively, and how they were murdered by the most evil and powerful dark wizard of all time, <a href=\"https://en.wikipedia.org/wiki/Lord_Voldemort\" title=\"Lord Voldemort\">Lord Voldemort</a>, which resulted in the one-year-old Harry being sent to live with his aunt and uncle. Voldemort was not only unable to kill Harry, but his powers were also destroyed in the attempt, forcing him into exile and sparking Harry\'s immense fame among the magical community.</p>\n<p>Hagrid introduces Harry to the <a href=\"https://en.wikipedia.org/wiki/Wizarding_world\" title=\"Wizarding world\">wizarding world</a> by bringing him to <a href=\"https://en.wikipedia.org/wiki/Diagon_Alley\" title=\"Diagon Alley\">Diagon Alley</a>, a hidden street in London where Harry uncovers a fortune left to him by his parents at <a href=\"https://en.wikipedia.org/wiki/Gringotts_Wizarding_Bank\" title=\"Gringotts Wizarding Bank\">Gringotts Wizarding Bank</a>, receives a pet owl, Hedwig, various school supplies, and a wand (which he learns shares a core from the same source as Voldemort\'s wand). There, he is surprised to discover how famous he truly is among witches and wizards as \"The Boy Who Lived\". A month later, Harry leaves the Dursleys\' home to catch the <a href=\"https://en.wikipedia.org/wiki/Hogwarts_Express\" title=\"Hogwarts Express\">Hogwarts Express</a> from <a href=\"https://en.wikipedia.org/wiki/London_King%27s_Cross_railway_station\" title=\"London King\'s Cross railway station\">King\'s Cross railway station</a>\'s secret Hogwarts platform, <a href=\"https://en.wikipedia.org/wiki/Platform_9%C2%BE\" title=\"Platform 9¾\">Platform ​9 <sup>3</sup>⁄<sub>4</sub></a>. On the train, he quickly befriends fellow first-year <a href=\"https://en.wikipedia.org/wiki/Ronald_Weasley\" title=\"Ronald Weasley\">Ronald Weasley</a> and the two boys meet <a href=\"https://en.wikipedia.org/wiki/Hermione_Granger\" title=\"Hermione Granger\">Hermione Granger</a>, whose snobbiness and affinity for spells initially causes the two boys to dislike her. There, Harry also makes an enemy of yet another first-year, <a href=\"https://en.wikipedia.org/wiki/Draco_Malfoy\" title=\"Draco Malfoy\">Draco Malfoy</a>, who shows prejudice against Ron for his family\'s financial difficulties.</p>',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `matrixcontent_panels` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `migrations` VALUES (1,NULL,'app','Install','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','5d0b7fb8-6e3e-4592-aa97-abce8c5c8c8e'),(2,NULL,'app','m150403_183908_migrations_table_changes','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','3bf726dd-017c-4903-985e-17d75dbe9f08'),(3,NULL,'app','m150403_184247_plugins_table_changes','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','e09ea518-7cc1-4f57-9fbb-3c8a81f6b7d0'),(4,NULL,'app','m150403_184533_field_version','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','9f8c5fea-3c8e-4925-b13a-dae29ea3df96'),(5,NULL,'app','m150403_184729_type_columns','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','f320eee9-3daa-4149-9f92-6d3e239814a5'),(6,NULL,'app','m150403_185142_volumes','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','22c152d5-f79b-493a-93c0-c74fdac438cd'),(7,NULL,'app','m150428_231346_userpreferences','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','02d9cfd8-73b4-4be2-9923-9c8d85ec9136'),(8,NULL,'app','m150519_150900_fieldversion_conversion','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','ce41c1eb-d14c-4614-8dfd-ba515ed4636a'),(9,NULL,'app','m150617_213829_update_email_settings','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','50cdc6d1-9c3e-44e1-8bb3-6bb3ccb06b90'),(10,NULL,'app','m150721_124739_templatecachequeries','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','8d1724df-249e-4280-a982-abd22f5b5c03'),(11,NULL,'app','m150724_140822_adjust_quality_settings','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','4fc3cdc6-1a5f-4917-b818-73fc8ff05173'),(12,NULL,'app','m150815_133521_last_login_attempt_ip','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','75374f18-6a3c-4256-912e-348ab2bc9778'),(13,NULL,'app','m151002_095935_volume_cache_settings','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','edbed53f-4e02-4497-b8c0-9090b059cac9'),(14,NULL,'app','m151005_142750_volume_s3_storage_settings','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','42bd1485-eaa1-4f32-ba73-c2a960c78c4a'),(15,NULL,'app','m151016_133600_delete_asset_thumbnails','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','13cb5348-8390-41cb-bc41-04046e2932a1'),(16,NULL,'app','m151209_000000_move_logo','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','5cde5ecc-55e4-4dde-a4c7-a3b31c485723'),(17,NULL,'app','m151211_000000_rename_fileId_to_assetId','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','a43d70bf-d64a-4a42-aae2-26062a90a52f'),(18,NULL,'app','m151215_000000_rename_asset_permissions','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','1f24453c-ba38-40f3-a7e0-321a61ccdcec'),(19,NULL,'app','m160707_000001_rename_richtext_assetsource_setting','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','0288095d-38bd-4fca-ab12-9da4bd8580f7'),(20,NULL,'app','m160708_185142_volume_hasUrls_setting','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','53f9bc3f-c9d4-4713-8e27-f6c1e0c6a859'),(21,NULL,'app','m160714_000000_increase_max_asset_filesize','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','dd546277-1ab1-4071-9a82-d627b0098802'),(22,NULL,'app','m160727_194637_column_cleanup','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','b224de3b-62c1-4c7d-9660-95ac4ec9273a'),(23,NULL,'app','m160804_110002_userphotos_to_assets','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','8a12b4a2-eeb4-4065-a00c-8b69fc8a770a'),(24,NULL,'app','m160807_144858_sites','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','822ec139-09fa-411c-b008-7a77f11fc29a'),(25,NULL,'app','m160829_000000_pending_user_content_cleanup','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','c086186e-94f5-4e05-a492-655b5552b62f'),(26,NULL,'app','m160830_000000_asset_index_uri_increase','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','d4cd1b5b-6b2d-41a5-8a7c-1ca698dba5ae'),(27,NULL,'app','m160912_230520_require_entry_type_id','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','25bf6087-33b8-4220-8525-b75fc5bcd7b7'),(28,NULL,'app','m160913_134730_require_matrix_block_type_id','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','abb9788a-1402-4ef5-91cb-3f912a5f68c2'),(29,NULL,'app','m160920_174553_matrixblocks_owner_site_id_nullable','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','21d6d25c-00a3-4b6c-afcc-427642e2cba7'),(30,NULL,'app','m160920_231045_usergroup_handle_title_unique','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','761dfa7c-27d8-4e92-aab4-383692f8df79'),(31,NULL,'app','m160925_113941_route_uri_parts','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','8bd8f28e-0f1b-446e-8577-3893664f5f50'),(32,NULL,'app','m161006_205918_schemaVersion_not_null','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','eec0b481-c6c2-454e-9f54-f3fe20756657'),(33,NULL,'app','m161007_130653_update_email_settings','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','8ab17f81-2010-4a87-b74d-530d3f3cf568'),(34,NULL,'app','m161013_175052_newParentId','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','2e229a0a-d414-4203-9c4d-fc43845f1688'),(35,NULL,'app','m161021_102916_fix_recent_entries_widgets','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','9cfe8e40-7bac-4527-ab6c-1a7779e714f1'),(36,NULL,'app','m161021_182140_rename_get_help_widget','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','b4a10981-a843-4146-8776-51d3d46f1c91'),(37,NULL,'app','m161025_000000_fix_char_columns','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','3c099f1a-558b-4a4c-9af9-29de72d0cfe0'),(38,NULL,'app','m161029_124145_email_message_languages','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','e1e9a282-131c-4feb-9edf-d0ee78e71871'),(39,NULL,'app','m161108_000000_new_version_format','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','3a17dca3-05c6-44b5-9039-f600a9bec13b'),(40,NULL,'app','m161109_000000_index_shuffle','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','d4b0c07b-70cb-4f37-99e2-7ee235dda473'),(41,NULL,'app','m161122_185500_no_craft_app','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','598281ea-2dca-48c8-bc4b-9bbde47e4c8b'),(42,NULL,'app','m161125_150752_clear_urlmanager_cache','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','7af2f65f-2f20-4204-a522-f4986aa15077'),(43,NULL,'app','m161220_000000_volumes_hasurl_notnull','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','defc6244-9990-4c96-b8b1-0b9ff629b833'),(44,NULL,'app','m170114_161144_udates_permission','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','0fb82fd4-660a-407b-b6e3-14b8c8088f84'),(45,NULL,'app','m170120_000000_schema_cleanup','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','08e917c8-3fc6-4054-b600-5a93994a783a'),(46,NULL,'app','m170126_000000_assets_focal_point','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','bdd9e538-b113-4ee1-9d20-7639d9b1210b'),(47,NULL,'app','m170206_142126_system_name','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','ac4f3753-f0e9-4d47-ab04-47950bb5aad8'),(48,NULL,'app','m170217_044740_category_branch_limits','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','88069097-c453-45bd-8fd5-7e3d5b6f4710'),(49,NULL,'app','m170217_120224_asset_indexing_columns','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','0fe92297-f9c7-411c-a901-f9427a5c6dc4'),(50,NULL,'app','m170223_224012_plain_text_settings','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','7f5f092b-bcfb-4f9e-9c56-886a71e7aa0e'),(51,NULL,'app','m170227_120814_focal_point_percentage','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','b204ec51-c25f-4789-b53a-c7c885222eef'),(52,NULL,'app','m170228_171113_system_messages','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','3b617d42-f238-4596-b064-4079553c6c0b'),(53,NULL,'app','m170303_140500_asset_field_source_settings','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','a5e68bfa-ef48-408d-b468-9516c441f719'),(54,NULL,'app','m170306_150500_asset_temporary_uploads','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','a5452eeb-15bb-42d9-be5a-045b0d9ae0fd'),(55,NULL,'app','m170523_190652_element_field_layout_ids','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','352a9b11-3bf5-4379-b4c5-4617e9865d0b'),(56,NULL,'app','m170612_000000_route_index_shuffle','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','c379f01d-fdd0-4034-964a-4028299f77fb'),(57,NULL,'app','m170621_195237_format_plugin_handles','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','f786d32c-70d2-487a-ae12-8d968daa185f'),(58,NULL,'app','m170630_161027_deprecation_line_nullable','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','02bc5622-4b55-409b-b001-75e03800a7b8'),(59,NULL,'app','m170630_161028_deprecation_changes','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','91dc1a52-828e-4d74-bc28-54605eed69d4'),(60,NULL,'app','m170703_181539_plugins_table_tweaks','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','6bce21c5-34e5-44b3-98a3-a44d7e6c6a03'),(61,NULL,'app','m170704_134916_sites_tables','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','ac1656b3-b657-4a54-aa39-e59f3bdfb493'),(62,NULL,'app','m170706_183216_rename_sequences','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','f1d298d6-985f-4a09-8e58-f00d99b3d3ee'),(63,NULL,'app','m170707_094758_delete_compiled_traits','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','2ff00e56-70a0-4c6c-b9e7-7cd682d357e9'),(64,NULL,'app','m170731_190138_drop_asset_packagist','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','ababdf5e-e2a0-49fa-b95a-5b7fcfd8283a'),(65,NULL,'app','m170810_201318_create_queue_table','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','90ee2d64-f7fa-4ede-b775-5f11aa854336'),(66,NULL,'app','m170903_192801_longblob_for_queue_jobs','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','2768477d-0e83-4457-bb81-5c2b74c20608'),(67,NULL,'app','m170914_204621_asset_cache_shuffle','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','9ae2fd43-e8be-4866-a4b0-0feb8e294cb8'),(68,NULL,'app','m171011_214115_site_groups','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','c9f00cea-86b1-4163-9f99-fc0c961ff015'),(69,NULL,'app','m171012_151440_primary_site','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','2a7e2ec0-a357-42aa-87a1-8db6e49e6a6e'),(70,NULL,'app','m171013_142500_transform_interlace','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','3aa782e4-260c-4d57-822d-dfbc9d15c67c'),(71,NULL,'app','m171016_092553_drop_position_select','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','cfd795b2-1d0a-4bf1-afc9-7089db4fe7a5'),(72,NULL,'app','m171016_221244_less_strict_translation_method','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','1f661017-1ba2-435f-8a62-d9e4e215dca7'),(73,NULL,'app','m171107_000000_assign_group_permissions','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','c3bc7039-9e6c-4fb8-aff1-311c56fe83fa'),(74,NULL,'app','m171117_000001_templatecache_index_tune','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','25e27e1f-259f-4309-bca3-578311b91e28'),(75,NULL,'app','m171126_105927_disabled_plugins','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','6a3d44a4-ea9d-4115-909c-5025f65ffb80'),(76,NULL,'app','m171130_214407_craftidtokens_table','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','a18ecc03-67a0-4ec5-af69-d0aa94a95769'),(77,NULL,'app','m171202_004225_update_email_settings','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','bee9c871-4826-4acf-8851-6edc4269d33e'),(78,NULL,'app','m171204_000001_templatecache_index_tune_deux','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','5bcd42d0-b90c-49bd-8f03-fd4bb4385ade'),(79,NULL,'app','m171205_130908_remove_craftidtokens_refreshtoken_column','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','496b96de-82dd-4082-afc3-f06f3ca4f088'),(80,NULL,'app','m171218_143135_longtext_query_column','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','d3cb0111-440f-4288-b50e-797fabf75274'),(81,NULL,'app','m171231_055546_environment_variables_to_aliases','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','a49f4e20-dab2-41ca-9d94-13fcc702a8ef'),(82,NULL,'app','m180113_153740_drop_users_archived_column','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','cb58c6b7-98ac-4bbe-9eed-d9145f8765ed'),(83,NULL,'app','m180122_213433_propagate_entries_setting','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','f4df6cbc-da2f-46f4-a689-38310ed47587'),(84,NULL,'app','m180124_230459_fix_propagate_entries_values','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','a35cf311-f239-4482-89f3-07837867ed8c'),(85,NULL,'app','m180128_235202_set_tag_slugs','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','304774e5-5f3e-427f-879f-691efdb39448'),(86,NULL,'app','m180202_185551_fix_focal_points','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','4cfcba6e-c10d-4e15-8863-c0e85a11afc2'),(87,NULL,'app','m180217_172123_tiny_ints','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','e30a7bc4-152b-43d6-89ef-6be69f6431ef'),(88,NULL,'app','m180321_233505_small_ints','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','d8045fb2-75e7-4b7b-867e-99c6edff8f7b'),(89,NULL,'app','m180328_115523_new_license_key_statuses','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','95cb2ffe-a56c-4286-9b25-e5b28381f89c'),(90,NULL,'app','m180404_182320_edition_changes','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','e3f5f924-2c83-4fb4-b756-af80d0dd2b16'),(91,NULL,'app','m180411_102218_fix_db_routes','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','43463487-540f-48a9-b694-e06da2abe4d4'),(92,NULL,'app','m180416_205628_resourcepaths_table','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','ad7ab175-8f85-485f-8348-4c5177582aea'),(93,NULL,'app','m180418_205713_widget_cleanup','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','24cb2211-e8f1-44fa-8957-285122cba846'),(94,NULL,'app','m180425_203349_searchable_fields','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','729af053-35df-45b2-9bdf-27111a022a6c'),(95,NULL,'app','m180516_153000_uids_in_field_settings','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','fb34446e-bb3b-498e-a108-7c0132f2d5a4'),(96,NULL,'app','m180517_173000_user_photo_volume_to_uid','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','2a344094-5f0e-4bf1-8013-a1636f472e9b'),(97,NULL,'app','m180518_173000_permissions_to_uid','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','d26d4527-50e8-4410-8afd-5a1219bbe472'),(98,NULL,'app','m180520_173000_matrix_context_to_uids','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','d526a21a-80f8-4daf-96f7-e2a727a27264'),(99,NULL,'app','m180521_172900_project_config_table','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','56152982-6dbc-4229-874a-f46a47a87ed3'),(100,NULL,'app','m180521_173000_initial_yml_and_snapshot','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','c7e1cf75-57ee-4da2-bfe6-89dec134dab8'),(101,NULL,'app','m180731_162030_soft_delete_sites','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','11a875bf-8433-4131-9e4e-b7aa17a2a60b'),(102,NULL,'app','m180810_214427_soft_delete_field_layouts','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','3df9a1b6-daa2-4d07-863c-b013251e6fd8'),(103,NULL,'app','m180810_214439_soft_delete_elements','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','688b4f6c-c941-44c2-a30e-34d2203d6843'),(104,NULL,'app','m180824_193422_case_sensitivity_fixes','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','b38558f6-4ec9-409e-a08b-10f66ba0d981'),(105,NULL,'app','m180901_151639_fix_matrixcontent_tables','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','44d7c4ac-b826-48a6-b9f6-e666944c7b3c'),(106,NULL,'app','m180904_112109_permission_changes','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','9566cc35-135b-4184-9f26-b4a28a5e5d4e'),(107,NULL,'app','m180910_142030_soft_delete_sitegroups','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','8ce57f0d-c55f-498f-bc5e-ba9a4313ab8e'),(108,NULL,'app','m181011_160000_soft_delete_asset_support','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','6d4c3b9f-7402-4aec-9931-c1a31313527a'),(109,NULL,'app','m181016_183648_set_default_user_settings','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','a82db187-e0b0-407f-be9c-dfd20db001a9'),(110,NULL,'app','m181017_225222_system_config_settings','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','b52f5d55-0838-47f1-a420-b3f70e23f654'),(111,NULL,'app','m181018_222343_drop_userpermissions_from_config','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','a2b8ca7f-06c9-40bd-b477-55d411cb751a'),(112,NULL,'app','m181029_130000_add_transforms_routes_to_config','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','4b1d3261-b079-4b23-96fc-075cd59c1ae5'),(113,NULL,'app','m181112_203955_sequences_table','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','f721cae9-4b22-4484-9ce0-921fb77c42f1'),(114,NULL,'app','m181121_001712_cleanup_field_configs','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','735633c1-7124-4243-a0c1-417bba9d0ec6'),(115,NULL,'app','m181128_193942_fix_project_config','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','9446842c-39f8-44d9-a622-83f803fcd5e9'),(116,NULL,'app','m181130_143040_fix_schema_version','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','c082cda4-5d32-4ec3-abbd-04eff6bd99db'),(117,NULL,'app','m181211_143040_fix_entry_type_uids','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','d8c58482-be49-4c52-aa84-fc8aff7a4158'),(118,NULL,'app','m181213_102500_config_map_aliases','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','6d75162e-429a-44e1-bd35-7b877a4c08e2'),(119,NULL,'app','m181217_153000_fix_structure_uids','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','966b8d5a-035f-4f8b-b092-16416b90ddf3'),(120,NULL,'app','m190104_152725_store_licensed_plugin_editions','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','2e2d04f7-7d4e-4ce3-a566-1fa632119fb8'),(121,NULL,'app','m190108_110000_cleanup_project_config','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','ee637f68-b939-412a-aedf-740aad6b8b61'),(122,NULL,'app','m190108_113000_asset_field_setting_change','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','6c77eac4-d752-4483-9163-3a5ab84c0a14'),(123,NULL,'app','m190109_172845_fix_colspan','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','eec7695b-9ed9-4951-a28e-a118dc9e9ea3'),(124,NULL,'app','m190110_150000_prune_nonexisting_sites','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','0ab871e9-44a4-44fe-b003-a3939b7b95d3'),(125,NULL,'app','m190110_214819_soft_delete_volumes','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','4354bd44-eaa1-4491-a8f8-6e9101eb4898'),(126,NULL,'app','m190112_124737_fix_user_settings','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','8ba11d12-4299-4148-8a09-c3114feb6fd3'),(127,NULL,'app','m190112_131225_fix_field_layouts','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','49095efe-7c10-49a1-a4fc-ca5187cfaf3d'),(128,NULL,'app','m190112_201010_more_soft_deletes','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','540e3b36-3ea3-4261-8faa-79a761ec83ab'),(129,NULL,'app','m190114_143000_more_asset_field_setting_changes','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','ebd08408-1789-4383-bc39-ef2b90a21d6b'),(130,NULL,'app','m190121_120000_rich_text_config_setting','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','2df362a6-1d90-4422-9671-ee13816b81ca'),(131,NULL,'app','m190125_191628_fix_email_transport_password','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','79d98337-fe98-4e3e-a95f-ec5176055953'),(132,NULL,'app','m190128_181422_cleanup_volume_folders','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','21db3382-eb5a-4d50-9cbe-1d71534d1220'),(133,NULL,'app','m190205_140000_fix_asset_soft_delete_index','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','4183083d-bd61-4f7e-ad98-65bfba00b3cc'),(134,NULL,'app','m190208_140000_reset_project_config_mapping','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','2b461898-0bfc-41a1-9a63-78969c2a090e'),(135,NULL,'app','m190218_143000_element_index_settings_uid','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','f6971417-1864-4c1a-a0d6-7e62679e6fb3'),(136,NULL,'app','m190312_152740_element_revisions','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','60d5f8d8-b25e-48ad-b580-17ec5a52a059'),(137,NULL,'app','m190327_235137_propagation_method','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','8c9e668e-25c1-49f3-815a-27e26a5c2ce4'),(138,NULL,'app','m190401_223843_drop_old_indexes','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','d1154865-97de-433b-92fc-7e8b9f8f9dff'),(139,NULL,'app','m190416_014525_drop_unique_global_indexes','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','139b5371-f166-4a69-9541-b3735c76e524'),(140,NULL,'app','m190417_085010_add_image_editor_permissions','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','0a07ce10-34d2-4033-bf53-66a845a8b254'),(141,NULL,'app','m190502_122019_store_default_user_group_uid','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','ff74bcf7-3a21-4916-ac8d-72ee21ee071b'),(142,NULL,'app','m190504_150349_preview_targets','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','fd1664c2-6286-4ac6-af37-92927f917694'),(143,NULL,'app','m190516_184711_job_progress_label','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','b92217dc-b6aa-4e86-887b-cbb12dd5bca9'),(144,NULL,'app','m190523_190303_optional_revision_creators','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','9f0a869a-b705-42df-8da1-9daa492b8351'),(145,NULL,'app','m190529_204501_fix_duplicate_uids','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','b06385aa-1e92-4262-be4e-09108dcee200'),(146,NULL,'app','m190605_223807_unsaved_drafts','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','a04295ef-18d0-418d-9ac3-ffd59e74db5b'),(147,NULL,'app','m190607_230042_entry_revision_error_tables','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','92203902-9ba7-48a6-901a-1ba580182246'),(148,NULL,'app','m190608_033429_drop_elements_uid_idx','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','27e4baa3-39a8-45bb-9e6b-a7d060b54475'),(149,NULL,'app','m190617_164400_add_gqlschemas_table','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','1df500e5-a6a3-4ba7-9c1a-573471392442'),(150,NULL,'app','m190624_234204_matrix_propagation_method','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','cd06b155-a033-42f0-a229-2f4de665b2c2'),(151,NULL,'app','m190711_153020_drop_snapshots','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','b3ab6504-c8f4-4d6c-92fa-6723e9f264a7'),(152,NULL,'app','m190712_195914_no_draft_revisions','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','bfa9334c-5646-48c8-a86e-cc0eb3ec14d8'),(153,NULL,'app','m190723_140314_fix_preview_targets_column','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','b5924921-5e55-468e-a213-16014b8f5d68'),(154,NULL,'app','m190820_003519_flush_compiled_templates','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','7675fc9f-911a-4248-98d7-3370c8a404ab'),(155,NULL,'app','m190823_020339_optional_draft_creators','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','50f329f3-8167-4b4b-a0bb-249575a664e6'),(156,NULL,'app','m190913_152146_update_preview_targets','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','484838de-84d2-4ff6-be64-dd0a48a5f160'),(157,NULL,'app','m191107_122000_add_gql_project_config_support','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','f7c6ddf3-980e-4a15-b33e-76f4b36b04af'),(158,NULL,'app','m191204_085100_pack_savable_component_settings','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','13d03f70-9dac-4751-a507-b699eb6e7930'),(159,NULL,'app','m191206_001148_change_tracking','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','68d2e1d3-cadb-4f41-a397-111b35e5814d'),(160,NULL,'app','m191216_191635_asset_upload_tracking','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','25fefb76-44d3-4995-929a-9405ae04be30'),(161,NULL,'app','m191222_002848_peer_asset_permissions','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','4905a582-607f-437e-83a5-de9ddabc0516'),(162,NULL,'app','m200127_172522_queue_channels','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','a43cda8a-55d1-446b-a96b-eb52778556db'),(168,2,'plugin','m180430_204710_remove_old_plugins','2020-02-05 21:45:03','2020-02-05 21:45:03','2020-02-05 21:45:03','c83d2bdc-b07f-451e-b3de-4d30770794db'),(169,2,'plugin','Install','2020-02-05 21:45:03','2020-02-05 21:45:03','2020-02-05 21:45:03','e1244dbd-1e3c-4d85-ab4b-753b636ab4b2'),(170,2,'plugin','m190225_003922_split_cleanup_html_settings','2020-02-05 21:45:03','2020-02-05 21:45:03','2020-02-05 21:45:03','70bb853d-4433-4116-a5d4-ce26f4de520c'),(171,NULL,'app','m200211_175048_truncate_element_query_cache','2020-04-08 22:19:10','2020-04-08 22:19:10','2020-04-08 22:19:10','08e4725e-3851-4ae5-97ff-faae073561c6'),(172,NULL,'app','m200213_172522_new_elements_index','2020-04-08 22:19:11','2020-04-08 22:19:11','2020-04-08 22:19:11','6abdce38-b60a-4df0-9c7d-bc17d83f64fd'),(173,NULL,'app','m200228_195211_long_deprecation_messages','2020-04-08 22:19:11','2020-04-08 22:19:11','2020-04-08 22:19:11','41a9606a-25eb-4bdf-86e4-11f456aa8599'),(174,10,'plugin','Install','2020-04-09 20:24:16','2020-04-09 20:24:16','2020-04-09 20:24:16','945c44ed-65cf-44ac-ada1-cb1312e8c927'),(175,10,'plugin','m190605_000000_add_db','2020-04-09 20:24:16','2020-04-09 20:24:16','2020-04-09 20:24:16','6cb35a76-0989-46a9-90fd-339d7306d2be');
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `plugins`
--

LOCK TABLES `plugins` WRITE;
/*!40000 ALTER TABLE `plugins` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `plugins` VALUES (2,'redactor','2.6.1','2.3.0','unknown',NULL,'2020-02-05 21:45:03','2020-02-05 21:45:03','2020-05-23 20:03:28','a1217d16-e982-46fe-9e45-e86b0b72b8ce'),(3,'redactor-tweaks','2.0.4','1.0.0','unknown',NULL,'2020-02-05 21:45:06','2020-02-05 21:45:06','2020-05-23 20:03:28','a0187e66-db3e-4686-a0aa-347810491209'),(4,'redactor-custom-styles','3.0.3','1.0.0','unknown',NULL,'2020-02-05 21:45:12','2020-02-05 21:45:12','2020-05-23 20:03:28','3209926a-ff09-4591-8cef-9a9a1ebdb776'),(5,'matrix-colors','2.0.1','2.0.0','unknown',NULL,'2020-02-05 21:45:15','2020-02-05 21:45:15','2020-05-23 20:03:28','d3c007bd-41ce-4008-a24c-a3b231972379'),(6,'cp-field-inspect','1.1.3','1.0.0','unknown',NULL,'2020-02-05 23:20:13','2020-02-05 23:20:13','2020-05-23 20:03:28','15281d6c-3ffd-4d28-8e43-2221d50ebfca'),(8,'cp-css','2.2.1','2.0.0','unknown',NULL,'2020-04-09 20:24:02','2020-04-09 20:24:02','2020-05-23 20:03:28','4d4ef38e-b19b-4b21-b527-5526a586b5b1'),(9,'dashboard-begone','1.0.1','1.0.0','unknown',NULL,'2020-04-09 20:24:09','2020-04-09 20:24:09','2020-05-23 20:03:28','2e913135-8202-4536-a628-2539259a5ecf'),(10,'knock-knock','1.2.8','1.1.1','unknown',NULL,'2020-04-09 20:24:16','2020-04-09 20:24:16','2020-05-23 20:03:28','2548feb1-4216-4df5-b511-731484d9da2c'),(11,'mailgun','1.4.3','1.0.0','unknown',NULL,'2020-04-09 20:24:20','2020-04-09 20:24:20','2020-05-23 20:03:28','e541f2f8-7d59-4c6d-8e1a-3cd1e43806a9'),(16,'twigpack','1.2.1','1.0.0','unknown',NULL,'2020-05-14 21:35:30','2020-05-14 21:35:30','2020-05-23 20:03:28','b3b38a9f-bccb-40ec-8e8c-b54d86dac96f');
/*!40000 ALTER TABLE `plugins` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `projectconfig`
--

LOCK TABLES `projectconfig` WRITE;
/*!40000 ALTER TABLE `projectconfig` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `projectconfig` VALUES ('dateModified','1590263681'),('email.fromEmail','\"support@doublesecretagency.com\"'),('email.fromName','\"Prototype\"'),('email.transportType','\"craft\\\\mail\\\\transportadapters\\\\Sendmail\"'),('fieldGroups.18d36d4e-9c72-4fcf-97a1-a668b70fd249.name','\"Matrix\"'),('fieldGroups.34f047fc-a5a1-4ea3-b134-fe21cdc31f89.name','\"Business Logic\"'),('fieldGroups.a49a5b87-47ff-421f-94c5-d11727a48206.name','\"Assets\"'),('fields.062f9f55-3f65-4fcd-81b2-eb83e6ce1de0.contentColumnType','\"text\"'),('fields.062f9f55-3f65-4fcd-81b2-eb83e6ce1de0.fieldGroup','\"34f047fc-a5a1-4ea3-b134-fe21cdc31f89\"'),('fields.062f9f55-3f65-4fcd-81b2-eb83e6ce1de0.handle','\"sidebar\"'),('fields.062f9f55-3f65-4fcd-81b2-eb83e6ce1de0.instructions','\"\"'),('fields.062f9f55-3f65-4fcd-81b2-eb83e6ce1de0.name','\"Sidebar\"'),('fields.062f9f55-3f65-4fcd-81b2-eb83e6ce1de0.searchable','false'),('fields.062f9f55-3f65-4fcd-81b2-eb83e6ce1de0.translationKeyFormat','null'),('fields.062f9f55-3f65-4fcd-81b2-eb83e6ce1de0.translationMethod','\"none\"'),('fields.062f9f55-3f65-4fcd-81b2-eb83e6ce1de0.type','\"modules\\\\businesslogic\\\\fields\\\\Sidebars\"'),('fields.57439ba8-7b9a-4a6f-925c-791faec8269a.contentColumnType','\"string\"'),('fields.57439ba8-7b9a-4a6f-925c-791faec8269a.fieldGroup','\"18d36d4e-9c72-4fcf-97a1-a668b70fd249\"'),('fields.57439ba8-7b9a-4a6f-925c-791faec8269a.handle','\"panels\"'),('fields.57439ba8-7b9a-4a6f-925c-791faec8269a.instructions','\"\"'),('fields.57439ba8-7b9a-4a6f-925c-791faec8269a.name','\"Panels\"'),('fields.57439ba8-7b9a-4a6f-925c-791faec8269a.searchable','false'),('fields.57439ba8-7b9a-4a6f-925c-791faec8269a.settings.contentTable','\"{{%matrixcontent_panels}}\"'),('fields.57439ba8-7b9a-4a6f-925c-791faec8269a.settings.maxBlocks','\"\"'),('fields.57439ba8-7b9a-4a6f-925c-791faec8269a.settings.minBlocks','\"\"'),('fields.57439ba8-7b9a-4a6f-925c-791faec8269a.settings.propagationMethod','\"all\"'),('fields.57439ba8-7b9a-4a6f-925c-791faec8269a.translationKeyFormat','null'),('fields.57439ba8-7b9a-4a6f-925c-791faec8269a.translationMethod','\"site\"'),('fields.57439ba8-7b9a-4a6f-925c-791faec8269a.type','\"craft\\\\fields\\\\Matrix\"'),('fields.63ecb9f3-46e5-4108-88d6-bbe79e8a6022.contentColumnType','\"string\"'),('fields.63ecb9f3-46e5-4108-88d6-bbe79e8a6022.fieldGroup','\"a49a5b87-47ff-421f-94c5-d11727a48206\"'),('fields.63ecb9f3-46e5-4108-88d6-bbe79e8a6022.handle','\"heroImage\"'),('fields.63ecb9f3-46e5-4108-88d6-bbe79e8a6022.instructions','\"\"'),('fields.63ecb9f3-46e5-4108-88d6-bbe79e8a6022.name','\"Hero Image\"'),('fields.63ecb9f3-46e5-4108-88d6-bbe79e8a6022.searchable','false'),('fields.63ecb9f3-46e5-4108-88d6-bbe79e8a6022.settings.allowedKinds.0','\"image\"'),('fields.63ecb9f3-46e5-4108-88d6-bbe79e8a6022.settings.defaultUploadLocationSource','\"volume:5ebe069f-09ab-4250-8880-37a3a169ab68\"'),('fields.63ecb9f3-46e5-4108-88d6-bbe79e8a6022.settings.defaultUploadLocationSubpath','\"\"'),('fields.63ecb9f3-46e5-4108-88d6-bbe79e8a6022.settings.limit','\"1\"'),('fields.63ecb9f3-46e5-4108-88d6-bbe79e8a6022.settings.localizeRelations','false'),('fields.63ecb9f3-46e5-4108-88d6-bbe79e8a6022.settings.restrictFiles','\"1\"'),('fields.63ecb9f3-46e5-4108-88d6-bbe79e8a6022.settings.selectionLabel','\"Select an image\"'),('fields.63ecb9f3-46e5-4108-88d6-bbe79e8a6022.settings.showUnpermittedFiles','false'),('fields.63ecb9f3-46e5-4108-88d6-bbe79e8a6022.settings.showUnpermittedVolumes','false'),('fields.63ecb9f3-46e5-4108-88d6-bbe79e8a6022.settings.singleUploadLocationSource','\"volume:1ca271c4-3b66-436a-a488-8a678cda224f\"'),('fields.63ecb9f3-46e5-4108-88d6-bbe79e8a6022.settings.singleUploadLocationSubpath','\"\"'),('fields.63ecb9f3-46e5-4108-88d6-bbe79e8a6022.settings.source','null'),('fields.63ecb9f3-46e5-4108-88d6-bbe79e8a6022.settings.sources','\"*\"'),('fields.63ecb9f3-46e5-4108-88d6-bbe79e8a6022.settings.targetSiteId','null'),('fields.63ecb9f3-46e5-4108-88d6-bbe79e8a6022.settings.useSingleFolder','true'),('fields.63ecb9f3-46e5-4108-88d6-bbe79e8a6022.settings.validateRelatedElements','\"\"'),('fields.63ecb9f3-46e5-4108-88d6-bbe79e8a6022.settings.viewMode','\"large\"'),('fields.63ecb9f3-46e5-4108-88d6-bbe79e8a6022.translationKeyFormat','null'),('fields.63ecb9f3-46e5-4108-88d6-bbe79e8a6022.translationMethod','\"site\"'),('fields.63ecb9f3-46e5-4108-88d6-bbe79e8a6022.type','\"craft\\\\fields\\\\Assets\"'),('imageTransforms.0b9df5d0-d595-4817-913b-d88deb15e24c.format','null'),('imageTransforms.0b9df5d0-d595-4817-913b-d88deb15e24c.handle','\"newsFull\"'),('imageTransforms.0b9df5d0-d595-4817-913b-d88deb15e24c.height','null'),('imageTransforms.0b9df5d0-d595-4817-913b-d88deb15e24c.interlace','\"none\"'),('imageTransforms.0b9df5d0-d595-4817-913b-d88deb15e24c.mode','\"fit\"'),('imageTransforms.0b9df5d0-d595-4817-913b-d88deb15e24c.name','\"News - Full\"'),('imageTransforms.0b9df5d0-d595-4817-913b-d88deb15e24c.position','\"center-center\"'),('imageTransforms.0b9df5d0-d595-4817-913b-d88deb15e24c.quality','null'),('imageTransforms.0b9df5d0-d595-4817-913b-d88deb15e24c.width','1500'),('imageTransforms.2d645b41-72a4-4f60-a394-8a23532182be.format','null'),('imageTransforms.2d645b41-72a4-4f60-a394-8a23532182be.handle','\"imageWithWrappingText\"'),('imageTransforms.2d645b41-72a4-4f60-a394-8a23532182be.height','360'),('imageTransforms.2d645b41-72a4-4f60-a394-8a23532182be.interlace','\"none\"'),('imageTransforms.2d645b41-72a4-4f60-a394-8a23532182be.mode','\"fit\"'),('imageTransforms.2d645b41-72a4-4f60-a394-8a23532182be.name','\"Image with wrapping text\"'),('imageTransforms.2d645b41-72a4-4f60-a394-8a23532182be.position','\"center-center\"'),('imageTransforms.2d645b41-72a4-4f60-a394-8a23532182be.quality','null'),('imageTransforms.2d645b41-72a4-4f60-a394-8a23532182be.width','360'),('imageTransforms.67c4c4c3-a551-4f40-9e6a-a1069402e483.format','null'),('imageTransforms.67c4c4c3-a551-4f40-9e6a-a1069402e483.handle','\"panelFull\"'),('imageTransforms.67c4c4c3-a551-4f40-9e6a-a1069402e483.height','null'),('imageTransforms.67c4c4c3-a551-4f40-9e6a-a1069402e483.interlace','\"none\"'),('imageTransforms.67c4c4c3-a551-4f40-9e6a-a1069402e483.mode','\"crop\"'),('imageTransforms.67c4c4c3-a551-4f40-9e6a-a1069402e483.name','\"Panel - Full\"'),('imageTransforms.67c4c4c3-a551-4f40-9e6a-a1069402e483.position','\"center-center\"'),('imageTransforms.67c4c4c3-a551-4f40-9e6a-a1069402e483.quality','null'),('imageTransforms.67c4c4c3-a551-4f40-9e6a-a1069402e483.width','1500'),('imageTransforms.88f6b708-b03e-4757-bb34-1a3b378ff3c8.format','null'),('imageTransforms.88f6b708-b03e-4757-bb34-1a3b378ff3c8.handle','\"newsThumbnail\"'),('imageTransforms.88f6b708-b03e-4757-bb34-1a3b378ff3c8.height','440'),('imageTransforms.88f6b708-b03e-4757-bb34-1a3b378ff3c8.interlace','\"none\"'),('imageTransforms.88f6b708-b03e-4757-bb34-1a3b378ff3c8.mode','\"crop\"'),('imageTransforms.88f6b708-b03e-4757-bb34-1a3b378ff3c8.name','\"News - Thumbnail\"'),('imageTransforms.88f6b708-b03e-4757-bb34-1a3b378ff3c8.position','\"center-center\"'),('imageTransforms.88f6b708-b03e-4757-bb34-1a3b378ff3c8.quality','null'),('imageTransforms.88f6b708-b03e-4757-bb34-1a3b378ff3c8.width','740'),('imageTransforms.b93b65d5-8f07-4336-9076-50380ebd3125.format','null'),('imageTransforms.b93b65d5-8f07-4336-9076-50380ebd3125.handle','\"panelCentered\"'),('imageTransforms.b93b65d5-8f07-4336-9076-50380ebd3125.height','600'),('imageTransforms.b93b65d5-8f07-4336-9076-50380ebd3125.interlace','\"none\"'),('imageTransforms.b93b65d5-8f07-4336-9076-50380ebd3125.mode','\"fit\"'),('imageTransforms.b93b65d5-8f07-4336-9076-50380ebd3125.name','\"Panel - Centered\"'),('imageTransforms.b93b65d5-8f07-4336-9076-50380ebd3125.position','\"center-center\"'),('imageTransforms.b93b65d5-8f07-4336-9076-50380ebd3125.quality','null'),('imageTransforms.b93b65d5-8f07-4336-9076-50380ebd3125.width','800'),('matrixBlockTypes.387fd742-7369-4e7e-88bf-c7d26f7eec40.field','\"57439ba8-7b9a-4a6f-925c-791faec8269a\"'),('matrixBlockTypes.387fd742-7369-4e7e-88bf-c7d26f7eec40.fieldLayouts.4aed05d2-26e8-4f56-87c6-2ce81caf63a8.tabs.0.fields.110489c0-bfa0-4b2e-8b4c-a5f5de78a131.required','false'),('matrixBlockTypes.387fd742-7369-4e7e-88bf-c7d26f7eec40.fieldLayouts.4aed05d2-26e8-4f56-87c6-2ce81caf63a8.tabs.0.fields.110489c0-bfa0-4b2e-8b4c-a5f5de78a131.sortOrder','1'),('matrixBlockTypes.387fd742-7369-4e7e-88bf-c7d26f7eec40.fieldLayouts.4aed05d2-26e8-4f56-87c6-2ce81caf63a8.tabs.0.name','\"Content\"'),('matrixBlockTypes.387fd742-7369-4e7e-88bf-c7d26f7eec40.fieldLayouts.4aed05d2-26e8-4f56-87c6-2ce81caf63a8.tabs.0.sortOrder','1'),('matrixBlockTypes.387fd742-7369-4e7e-88bf-c7d26f7eec40.fields.110489c0-bfa0-4b2e-8b4c-a5f5de78a131.contentColumnType','\"string\"'),('matrixBlockTypes.387fd742-7369-4e7e-88bf-c7d26f7eec40.fields.110489c0-bfa0-4b2e-8b4c-a5f5de78a131.fieldGroup','null'),('matrixBlockTypes.387fd742-7369-4e7e-88bf-c7d26f7eec40.fields.110489c0-bfa0-4b2e-8b4c-a5f5de78a131.handle','\"panel\"'),('matrixBlockTypes.387fd742-7369-4e7e-88bf-c7d26f7eec40.fields.110489c0-bfa0-4b2e-8b4c-a5f5de78a131.instructions','\"\"'),('matrixBlockTypes.387fd742-7369-4e7e-88bf-c7d26f7eec40.fields.110489c0-bfa0-4b2e-8b4c-a5f5de78a131.name','\"__blank__\"'),('matrixBlockTypes.387fd742-7369-4e7e-88bf-c7d26f7eec40.fields.110489c0-bfa0-4b2e-8b4c-a5f5de78a131.searchable','false'),('matrixBlockTypes.387fd742-7369-4e7e-88bf-c7d26f7eec40.fields.110489c0-bfa0-4b2e-8b4c-a5f5de78a131.settings.limit','\"1\"'),('matrixBlockTypes.387fd742-7369-4e7e-88bf-c7d26f7eec40.fields.110489c0-bfa0-4b2e-8b4c-a5f5de78a131.settings.localizeRelations','false'),('matrixBlockTypes.387fd742-7369-4e7e-88bf-c7d26f7eec40.fields.110489c0-bfa0-4b2e-8b4c-a5f5de78a131.settings.selectionLabel','\"Select a custom panel\"'),('matrixBlockTypes.387fd742-7369-4e7e-88bf-c7d26f7eec40.fields.110489c0-bfa0-4b2e-8b4c-a5f5de78a131.settings.source','null'),('matrixBlockTypes.387fd742-7369-4e7e-88bf-c7d26f7eec40.fields.110489c0-bfa0-4b2e-8b4c-a5f5de78a131.settings.sources.0','\"section:34bba139-c036-4e65-a8c0-bf6c451a4e12\"'),('matrixBlockTypes.387fd742-7369-4e7e-88bf-c7d26f7eec40.fields.110489c0-bfa0-4b2e-8b4c-a5f5de78a131.settings.targetSiteId','null'),('matrixBlockTypes.387fd742-7369-4e7e-88bf-c7d26f7eec40.fields.110489c0-bfa0-4b2e-8b4c-a5f5de78a131.settings.validateRelatedElements','\"1\"'),('matrixBlockTypes.387fd742-7369-4e7e-88bf-c7d26f7eec40.fields.110489c0-bfa0-4b2e-8b4c-a5f5de78a131.settings.viewMode','null'),('matrixBlockTypes.387fd742-7369-4e7e-88bf-c7d26f7eec40.fields.110489c0-bfa0-4b2e-8b4c-a5f5de78a131.translationKeyFormat','null'),('matrixBlockTypes.387fd742-7369-4e7e-88bf-c7d26f7eec40.fields.110489c0-bfa0-4b2e-8b4c-a5f5de78a131.translationMethod','\"site\"'),('matrixBlockTypes.387fd742-7369-4e7e-88bf-c7d26f7eec40.fields.110489c0-bfa0-4b2e-8b4c-a5f5de78a131.type','\"craft\\\\fields\\\\Entries\"'),('matrixBlockTypes.387fd742-7369-4e7e-88bf-c7d26f7eec40.handle','\"custom\"'),('matrixBlockTypes.387fd742-7369-4e7e-88bf-c7d26f7eec40.name','\"Custom\"'),('matrixBlockTypes.387fd742-7369-4e7e-88bf-c7d26f7eec40.sortOrder','4'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.field','\"57439ba8-7b9a-4a6f-925c-791faec8269a\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fieldLayouts.fe6d1ad7-77ef-4195-8592-4dfc70bc03ed.tabs.0.fields.619de457-107b-4d61-827d-b7acada9a0f9.required','false'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fieldLayouts.fe6d1ad7-77ef-4195-8592-4dfc70bc03ed.tabs.0.fields.619de457-107b-4d61-827d-b7acada9a0f9.sortOrder','2'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fieldLayouts.fe6d1ad7-77ef-4195-8592-4dfc70bc03ed.tabs.0.fields.d8193927-d011-4f5e-a6f2-244e8be9de3c.required','false'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fieldLayouts.fe6d1ad7-77ef-4195-8592-4dfc70bc03ed.tabs.0.fields.d8193927-d011-4f5e-a6f2-244e8be9de3c.sortOrder','1'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fieldLayouts.fe6d1ad7-77ef-4195-8592-4dfc70bc03ed.tabs.0.name','\"Content\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fieldLayouts.fe6d1ad7-77ef-4195-8592-4dfc70bc03ed.tabs.0.sortOrder','1'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.619de457-107b-4d61-827d-b7acada9a0f9.contentColumnType','\"string\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.619de457-107b-4d61-827d-b7acada9a0f9.fieldGroup','null'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.619de457-107b-4d61-827d-b7acada9a0f9.handle','\"width\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.619de457-107b-4d61-827d-b7acada9a0f9.instructions','\"\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.619de457-107b-4d61-827d-b7acada9a0f9.name','\"__blank__\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.619de457-107b-4d61-827d-b7acada9a0f9.searchable','false'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.619de457-107b-4d61-827d-b7acada9a0f9.settings.optgroups','true'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.619de457-107b-4d61-827d-b7acada9a0f9.settings.options.0.__assoc__.0.0','\"label\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.619de457-107b-4d61-827d-b7acada9a0f9.settings.options.0.__assoc__.0.1','\"Centered\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.619de457-107b-4d61-827d-b7acada9a0f9.settings.options.0.__assoc__.1.0','\"value\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.619de457-107b-4d61-827d-b7acada9a0f9.settings.options.0.__assoc__.1.1','\"centered\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.619de457-107b-4d61-827d-b7acada9a0f9.settings.options.0.__assoc__.2.0','\"default\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.619de457-107b-4d61-827d-b7acada9a0f9.settings.options.0.__assoc__.2.1','\"1\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.619de457-107b-4d61-827d-b7acada9a0f9.settings.options.1.__assoc__.0.0','\"label\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.619de457-107b-4d61-827d-b7acada9a0f9.settings.options.1.__assoc__.0.1','\"Full Width\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.619de457-107b-4d61-827d-b7acada9a0f9.settings.options.1.__assoc__.1.0','\"value\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.619de457-107b-4d61-827d-b7acada9a0f9.settings.options.1.__assoc__.1.1','\"fullWidth\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.619de457-107b-4d61-827d-b7acada9a0f9.settings.options.1.__assoc__.2.0','\"default\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.619de457-107b-4d61-827d-b7acada9a0f9.settings.options.1.__assoc__.2.1','\"\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.619de457-107b-4d61-827d-b7acada9a0f9.translationKeyFormat','null'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.619de457-107b-4d61-827d-b7acada9a0f9.translationMethod','\"none\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.619de457-107b-4d61-827d-b7acada9a0f9.type','\"craft\\\\fields\\\\Dropdown\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.d8193927-d011-4f5e-a6f2-244e8be9de3c.contentColumnType','\"string\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.d8193927-d011-4f5e-a6f2-244e8be9de3c.fieldGroup','null'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.d8193927-d011-4f5e-a6f2-244e8be9de3c.handle','\"image\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.d8193927-d011-4f5e-a6f2-244e8be9de3c.instructions','\"\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.d8193927-d011-4f5e-a6f2-244e8be9de3c.name','\"__blank__\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.d8193927-d011-4f5e-a6f2-244e8be9de3c.searchable','false'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.d8193927-d011-4f5e-a6f2-244e8be9de3c.settings.allowedKinds.0','\"image\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.d8193927-d011-4f5e-a6f2-244e8be9de3c.settings.defaultUploadLocationSource','\"volume:5ebe069f-09ab-4250-8880-37a3a169ab68\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.d8193927-d011-4f5e-a6f2-244e8be9de3c.settings.defaultUploadLocationSubpath','\"\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.d8193927-d011-4f5e-a6f2-244e8be9de3c.settings.limit','\"1\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.d8193927-d011-4f5e-a6f2-244e8be9de3c.settings.localizeRelations','false'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.d8193927-d011-4f5e-a6f2-244e8be9de3c.settings.restrictFiles','\"1\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.d8193927-d011-4f5e-a6f2-244e8be9de3c.settings.selectionLabel','\"Select an image\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.d8193927-d011-4f5e-a6f2-244e8be9de3c.settings.showUnpermittedFiles','false'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.d8193927-d011-4f5e-a6f2-244e8be9de3c.settings.showUnpermittedVolumes','false'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.d8193927-d011-4f5e-a6f2-244e8be9de3c.settings.singleUploadLocationSource','\"volume:5ebe069f-09ab-4250-8880-37a3a169ab68\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.d8193927-d011-4f5e-a6f2-244e8be9de3c.settings.singleUploadLocationSubpath','\"\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.d8193927-d011-4f5e-a6f2-244e8be9de3c.settings.source','null'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.d8193927-d011-4f5e-a6f2-244e8be9de3c.settings.sources.0','\"volume:5ebe069f-09ab-4250-8880-37a3a169ab68\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.d8193927-d011-4f5e-a6f2-244e8be9de3c.settings.targetSiteId','null'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.d8193927-d011-4f5e-a6f2-244e8be9de3c.settings.useSingleFolder','false'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.d8193927-d011-4f5e-a6f2-244e8be9de3c.settings.validateRelatedElements','\"\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.d8193927-d011-4f5e-a6f2-244e8be9de3c.settings.viewMode','\"large\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.d8193927-d011-4f5e-a6f2-244e8be9de3c.translationKeyFormat','null'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.d8193927-d011-4f5e-a6f2-244e8be9de3c.translationMethod','\"site\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.d8193927-d011-4f5e-a6f2-244e8be9de3c.type','\"craft\\\\fields\\\\Assets\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.handle','\"image\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.name','\"Image\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.sortOrder','2'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.field','\"57439ba8-7b9a-4a6f-925c-791faec8269a\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fieldLayouts.cc16cc83-8470-48b8-bbaa-fcda87beb1ea.tabs.0.fields.03b34141-8ace-49bf-83cd-070779334bac.required','false'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fieldLayouts.cc16cc83-8470-48b8-bbaa-fcda87beb1ea.tabs.0.fields.03b34141-8ace-49bf-83cd-070779334bac.sortOrder','1'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fieldLayouts.cc16cc83-8470-48b8-bbaa-fcda87beb1ea.tabs.0.fields.10777443-a139-4a09-a2d1-dcf4c8c93597.required','false'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fieldLayouts.cc16cc83-8470-48b8-bbaa-fcda87beb1ea.tabs.0.fields.10777443-a139-4a09-a2d1-dcf4c8c93597.sortOrder','2'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fieldLayouts.cc16cc83-8470-48b8-bbaa-fcda87beb1ea.tabs.0.fields.27854c4e-fdce-42da-b6c2-85f68395135f.required','false'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fieldLayouts.cc16cc83-8470-48b8-bbaa-fcda87beb1ea.tabs.0.fields.27854c4e-fdce-42da-b6c2-85f68395135f.sortOrder','3'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fieldLayouts.cc16cc83-8470-48b8-bbaa-fcda87beb1ea.tabs.0.name','\"Content\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fieldLayouts.cc16cc83-8470-48b8-bbaa-fcda87beb1ea.tabs.0.sortOrder','1'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.03b34141-8ace-49bf-83cd-070779334bac.contentColumnType','\"text\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.03b34141-8ace-49bf-83cd-070779334bac.fieldGroup','null'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.03b34141-8ace-49bf-83cd-070779334bac.handle','\"text\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.03b34141-8ace-49bf-83cd-070779334bac.instructions','\"\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.03b34141-8ace-49bf-83cd-070779334bac.name','\"__blank__\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.03b34141-8ace-49bf-83cd-070779334bac.searchable','true'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.03b34141-8ace-49bf-83cd-070779334bac.settings.availableTransforms.0','\"2d645b41-72a4-4f60-a394-8a23532182be\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.03b34141-8ace-49bf-83cd-070779334bac.settings.availableVolumes.0','\"5ebe069f-09ab-4250-8880-37a3a169ab68\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.03b34141-8ace-49bf-83cd-070779334bac.settings.cleanupHtml','true'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.03b34141-8ace-49bf-83cd-070779334bac.settings.columnType','\"text\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.03b34141-8ace-49bf-83cd-070779334bac.settings.purifierConfig','\"\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.03b34141-8ace-49bf-83cd-070779334bac.settings.purifyHtml','\"1\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.03b34141-8ace-49bf-83cd-070779334bac.settings.redactorConfig','\"ADVANCED.json\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.03b34141-8ace-49bf-83cd-070779334bac.settings.removeEmptyTags','\"1\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.03b34141-8ace-49bf-83cd-070779334bac.settings.removeInlineStyles','\"1\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.03b34141-8ace-49bf-83cd-070779334bac.settings.removeNbsp','\"1\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.03b34141-8ace-49bf-83cd-070779334bac.settings.showUnpermittedFiles','false'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.03b34141-8ace-49bf-83cd-070779334bac.settings.showUnpermittedVolumes','false'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.03b34141-8ace-49bf-83cd-070779334bac.translationKeyFormat','null'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.03b34141-8ace-49bf-83cd-070779334bac.translationMethod','\"none\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.03b34141-8ace-49bf-83cd-070779334bac.type','\"craft\\\\redactor\\\\Field\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.10777443-a139-4a09-a2d1-dcf4c8c93597.contentColumnType','\"string\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.10777443-a139-4a09-a2d1-dcf4c8c93597.fieldGroup','null'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.10777443-a139-4a09-a2d1-dcf4c8c93597.handle','\"padding\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.10777443-a139-4a09-a2d1-dcf4c8c93597.instructions','\"\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.10777443-a139-4a09-a2d1-dcf4c8c93597.name','\"Padding\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.10777443-a139-4a09-a2d1-dcf4c8c93597.searchable','false'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.10777443-a139-4a09-a2d1-dcf4c8c93597.settings.optgroups','true'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.10777443-a139-4a09-a2d1-dcf4c8c93597.settings.options.0.__assoc__.0.0','\"label\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.10777443-a139-4a09-a2d1-dcf4c8c93597.settings.options.0.__assoc__.0.1','\"None\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.10777443-a139-4a09-a2d1-dcf4c8c93597.settings.options.0.__assoc__.1.0','\"value\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.10777443-a139-4a09-a2d1-dcf4c8c93597.settings.options.0.__assoc__.1.1','\"\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.10777443-a139-4a09-a2d1-dcf4c8c93597.settings.options.0.__assoc__.2.0','\"default\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.10777443-a139-4a09-a2d1-dcf4c8c93597.settings.options.0.__assoc__.2.1','\"1\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.10777443-a139-4a09-a2d1-dcf4c8c93597.settings.options.1.__assoc__.0.0','\"label\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.10777443-a139-4a09-a2d1-dcf4c8c93597.settings.options.1.__assoc__.0.1','\"Light\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.10777443-a139-4a09-a2d1-dcf4c8c93597.settings.options.1.__assoc__.1.0','\"value\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.10777443-a139-4a09-a2d1-dcf4c8c93597.settings.options.1.__assoc__.1.1','\"light\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.10777443-a139-4a09-a2d1-dcf4c8c93597.settings.options.1.__assoc__.2.0','\"default\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.10777443-a139-4a09-a2d1-dcf4c8c93597.settings.options.1.__assoc__.2.1','\"\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.10777443-a139-4a09-a2d1-dcf4c8c93597.settings.options.2.__assoc__.0.0','\"label\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.10777443-a139-4a09-a2d1-dcf4c8c93597.settings.options.2.__assoc__.0.1','\"Heavy\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.10777443-a139-4a09-a2d1-dcf4c8c93597.settings.options.2.__assoc__.1.0','\"value\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.10777443-a139-4a09-a2d1-dcf4c8c93597.settings.options.2.__assoc__.1.1','\"heavy\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.10777443-a139-4a09-a2d1-dcf4c8c93597.settings.options.2.__assoc__.2.0','\"default\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.10777443-a139-4a09-a2d1-dcf4c8c93597.settings.options.2.__assoc__.2.1','\"\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.10777443-a139-4a09-a2d1-dcf4c8c93597.translationKeyFormat','null'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.10777443-a139-4a09-a2d1-dcf4c8c93597.translationMethod','\"none\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.10777443-a139-4a09-a2d1-dcf4c8c93597.type','\"craft\\\\fields\\\\Dropdown\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.27854c4e-fdce-42da-b6c2-85f68395135f.contentColumnType','\"string\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.27854c4e-fdce-42da-b6c2-85f68395135f.fieldGroup','null'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.27854c4e-fdce-42da-b6c2-85f68395135f.handle','\"margin\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.27854c4e-fdce-42da-b6c2-85f68395135f.instructions','\"\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.27854c4e-fdce-42da-b6c2-85f68395135f.name','\"Margin\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.27854c4e-fdce-42da-b6c2-85f68395135f.searchable','false'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.27854c4e-fdce-42da-b6c2-85f68395135f.settings.optgroups','true'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.27854c4e-fdce-42da-b6c2-85f68395135f.settings.options.0.__assoc__.0.0','\"label\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.27854c4e-fdce-42da-b6c2-85f68395135f.settings.options.0.__assoc__.0.1','\"None\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.27854c4e-fdce-42da-b6c2-85f68395135f.settings.options.0.__assoc__.1.0','\"value\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.27854c4e-fdce-42da-b6c2-85f68395135f.settings.options.0.__assoc__.1.1','\"\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.27854c4e-fdce-42da-b6c2-85f68395135f.settings.options.0.__assoc__.2.0','\"default\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.27854c4e-fdce-42da-b6c2-85f68395135f.settings.options.0.__assoc__.2.1','\"1\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.27854c4e-fdce-42da-b6c2-85f68395135f.settings.options.1.__assoc__.0.0','\"label\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.27854c4e-fdce-42da-b6c2-85f68395135f.settings.options.1.__assoc__.0.1','\"Light\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.27854c4e-fdce-42da-b6c2-85f68395135f.settings.options.1.__assoc__.1.0','\"value\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.27854c4e-fdce-42da-b6c2-85f68395135f.settings.options.1.__assoc__.1.1','\"light\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.27854c4e-fdce-42da-b6c2-85f68395135f.settings.options.1.__assoc__.2.0','\"default\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.27854c4e-fdce-42da-b6c2-85f68395135f.settings.options.1.__assoc__.2.1','\"\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.27854c4e-fdce-42da-b6c2-85f68395135f.settings.options.2.__assoc__.0.0','\"label\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.27854c4e-fdce-42da-b6c2-85f68395135f.settings.options.2.__assoc__.0.1','\"Heavy\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.27854c4e-fdce-42da-b6c2-85f68395135f.settings.options.2.__assoc__.1.0','\"value\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.27854c4e-fdce-42da-b6c2-85f68395135f.settings.options.2.__assoc__.1.1','\"heavy\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.27854c4e-fdce-42da-b6c2-85f68395135f.settings.options.2.__assoc__.2.0','\"default\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.27854c4e-fdce-42da-b6c2-85f68395135f.settings.options.2.__assoc__.2.1','\"\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.27854c4e-fdce-42da-b6c2-85f68395135f.translationKeyFormat','null'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.27854c4e-fdce-42da-b6c2-85f68395135f.translationMethod','\"none\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.27854c4e-fdce-42da-b6c2-85f68395135f.type','\"craft\\\\fields\\\\Dropdown\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.handle','\"text\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.name','\"Text\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.sortOrder','1'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.field','\"57439ba8-7b9a-4a6f-925c-791faec8269a\"'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fieldLayouts.3c6f922b-8c79-41b1-a050-c921a89d41de.tabs.0.fields.5d36ed79-72af-4edb-b06b-3c9acab5044e.required','false'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fieldLayouts.3c6f922b-8c79-41b1-a050-c921a89d41de.tabs.0.fields.5d36ed79-72af-4edb-b06b-3c9acab5044e.sortOrder','1'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fieldLayouts.3c6f922b-8c79-41b1-a050-c921a89d41de.tabs.0.name','\"Content\"'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fieldLayouts.3c6f922b-8c79-41b1-a050-c921a89d41de.tabs.0.sortOrder','1'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.5d36ed79-72af-4edb-b06b-3c9acab5044e.contentColumnType','\"text\"'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.5d36ed79-72af-4edb-b06b-3c9acab5044e.fieldGroup','null'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.5d36ed79-72af-4edb-b06b-3c9acab5044e.handle','\"embed\"'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.5d36ed79-72af-4edb-b06b-3c9acab5044e.instructions','\"\"'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.5d36ed79-72af-4edb-b06b-3c9acab5044e.name','\"__blank__\"'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.5d36ed79-72af-4edb-b06b-3c9acab5044e.searchable','false'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.5d36ed79-72af-4edb-b06b-3c9acab5044e.settings.byteLimit','null'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.5d36ed79-72af-4edb-b06b-3c9acab5044e.settings.charLimit','null'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.5d36ed79-72af-4edb-b06b-3c9acab5044e.settings.code','\"1\"'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.5d36ed79-72af-4edb-b06b-3c9acab5044e.settings.columnType','null'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.5d36ed79-72af-4edb-b06b-3c9acab5044e.settings.initialRows','\"4\"'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.5d36ed79-72af-4edb-b06b-3c9acab5044e.settings.multiline','\"1\"'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.5d36ed79-72af-4edb-b06b-3c9acab5044e.settings.placeholder','\"Paste code snippet here...\"'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.5d36ed79-72af-4edb-b06b-3c9acab5044e.translationKeyFormat','null'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.5d36ed79-72af-4edb-b06b-3c9acab5044e.translationMethod','\"none\"'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.5d36ed79-72af-4edb-b06b-3c9acab5044e.type','\"craft\\\\fields\\\\PlainText\"'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.handle','\"embed\"'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.name','\"Embed\"'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.sortOrder','3'),('plugins.cp-css.edition','\"standard\"'),('plugins.cp-css.enabled','true'),('plugins.cp-css.schemaVersion','\"2.0.0\"'),('plugins.cp-css.settings.additionalCss','\"\"'),('plugins.cp-css.settings.cssFile','\"@resourcesUrl/css/cp.css\"'),('plugins.cp-field-inspect.edition','\"standard\"'),('plugins.cp-field-inspect.enabled','true'),('plugins.cp-field-inspect.schemaVersion','\"1.0.0\"'),('plugins.dashboard-begone.edition','\"standard\"'),('plugins.dashboard-begone.enabled','true'),('plugins.dashboard-begone.schemaVersion','\"1.0.0\"'),('plugins.knock-knock.edition','\"standard\"'),('plugins.knock-knock.enabled','true'),('plugins.knock-knock.schemaVersion','\"1.1.1\"'),('plugins.mailgun.edition','\"standard\"'),('plugins.mailgun.enabled','true'),('plugins.mailgun.schemaVersion','\"1.0.0\"'),('plugins.matrix-colors.edition','\"standard\"'),('plugins.matrix-colors.enabled','true'),('plugins.matrix-colors.schemaVersion','\"2.0.0\"'),('plugins.matrix-colors.settings.matrixBlockColors.__assoc__.0.0','0'),('plugins.matrix-colors.settings.matrixBlockColors.__assoc__.0.1.__assoc__.0.0','\"blockType\"'),('plugins.matrix-colors.settings.matrixBlockColors.__assoc__.0.1.__assoc__.0.1','\"text\"'),('plugins.matrix-colors.settings.matrixBlockColors.__assoc__.0.1.__assoc__.1.0','\"backgroundColor\"'),('plugins.matrix-colors.settings.matrixBlockColors.__assoc__.0.1.__assoc__.1.1','\"#deecd5\"'),('plugins.matrix-colors.settings.matrixBlockColors.__assoc__.1.0','2'),('plugins.matrix-colors.settings.matrixBlockColors.__assoc__.1.1.__assoc__.0.0','\"blockType\"'),('plugins.matrix-colors.settings.matrixBlockColors.__assoc__.1.1.__assoc__.0.1','\"image\"'),('plugins.matrix-colors.settings.matrixBlockColors.__assoc__.1.1.__assoc__.1.0','\"backgroundColor\"'),('plugins.matrix-colors.settings.matrixBlockColors.__assoc__.1.1.__assoc__.1.1','\"#ecebd5\"'),('plugins.matrix-colors.settings.matrixBlockColors.__assoc__.2.0','1'),('plugins.matrix-colors.settings.matrixBlockColors.__assoc__.2.1.__assoc__.0.0','\"blockType\"'),('plugins.matrix-colors.settings.matrixBlockColors.__assoc__.2.1.__assoc__.0.1','\"embed\"'),('plugins.matrix-colors.settings.matrixBlockColors.__assoc__.2.1.__assoc__.1.0','\"backgroundColor\"'),('plugins.matrix-colors.settings.matrixBlockColors.__assoc__.2.1.__assoc__.1.1','\"#d5dfec\"'),('plugins.matrix-colors.settings.matrixBlockColors.__assoc__.3.0','3'),('plugins.matrix-colors.settings.matrixBlockColors.__assoc__.3.1.__assoc__.0.0','\"blockType\"'),('plugins.matrix-colors.settings.matrixBlockColors.__assoc__.3.1.__assoc__.0.1','\"custom\"'),('plugins.matrix-colors.settings.matrixBlockColors.__assoc__.3.1.__assoc__.1.0','\"backgroundColor\"'),('plugins.matrix-colors.settings.matrixBlockColors.__assoc__.3.1.__assoc__.1.1','\"#ecddd5\"'),('plugins.redactor-custom-styles.edition','\"standard\"'),('plugins.redactor-custom-styles.enabled','true'),('plugins.redactor-custom-styles.schemaVersion','\"1.0.0\"'),('plugins.redactor-tweaks.edition','\"standard\"'),('plugins.redactor-tweaks.enabled','true'),('plugins.redactor-tweaks.schemaVersion','\"1.0.0\"'),('plugins.redactor.edition','\"standard\"'),('plugins.redactor.enabled','true'),('plugins.redactor.schemaVersion','\"2.3.0\"'),('plugins.twigpack.edition','\"standard\"'),('plugins.twigpack.enabled','true'),('plugins.twigpack.schemaVersion','\"1.0.0\"'),('sections.34bba139-c036-4e65-a8c0-bf6c451a4e12.enableVersioning','false'),('sections.34bba139-c036-4e65-a8c0-bf6c451a4e12.entryTypes.5be2622b-1b56-4fda-9320-b08614cf0b40.handle','\"faq\"'),('sections.34bba139-c036-4e65-a8c0-bf6c451a4e12.entryTypes.5be2622b-1b56-4fda-9320-b08614cf0b40.hasTitleField','true'),('sections.34bba139-c036-4e65-a8c0-bf6c451a4e12.entryTypes.5be2622b-1b56-4fda-9320-b08614cf0b40.name','\"FAQ\"'),('sections.34bba139-c036-4e65-a8c0-bf6c451a4e12.entryTypes.5be2622b-1b56-4fda-9320-b08614cf0b40.sortOrder','3'),('sections.34bba139-c036-4e65-a8c0-bf6c451a4e12.entryTypes.5be2622b-1b56-4fda-9320-b08614cf0b40.titleFormat','\"\"'),('sections.34bba139-c036-4e65-a8c0-bf6c451a4e12.entryTypes.5be2622b-1b56-4fda-9320-b08614cf0b40.titleLabel','\"Panel Name\"'),('sections.34bba139-c036-4e65-a8c0-bf6c451a4e12.entryTypes.86e37e1b-6060-4ecf-b5cd-08eed4c992a8.handle','\"threeIconsWithText\"'),('sections.34bba139-c036-4e65-a8c0-bf6c451a4e12.entryTypes.86e37e1b-6060-4ecf-b5cd-08eed4c992a8.hasTitleField','true'),('sections.34bba139-c036-4e65-a8c0-bf6c451a4e12.entryTypes.86e37e1b-6060-4ecf-b5cd-08eed4c992a8.name','\"3 icons with text\"'),('sections.34bba139-c036-4e65-a8c0-bf6c451a4e12.entryTypes.86e37e1b-6060-4ecf-b5cd-08eed4c992a8.sortOrder','1'),('sections.34bba139-c036-4e65-a8c0-bf6c451a4e12.entryTypes.86e37e1b-6060-4ecf-b5cd-08eed4c992a8.titleFormat','\"\"'),('sections.34bba139-c036-4e65-a8c0-bf6c451a4e12.entryTypes.86e37e1b-6060-4ecf-b5cd-08eed4c992a8.titleLabel','\"Panel Name\"'),('sections.34bba139-c036-4e65-a8c0-bf6c451a4e12.handle','\"panels\"'),('sections.34bba139-c036-4e65-a8c0-bf6c451a4e12.name','\"Panels\"'),('sections.34bba139-c036-4e65-a8c0-bf6c451a4e12.propagationMethod','\"all\"'),('sections.34bba139-c036-4e65-a8c0-bf6c451a4e12.siteSettings.1891a55f-7f04-4fc8-abfd-3fd84207d90b.enabledByDefault','true'),('sections.34bba139-c036-4e65-a8c0-bf6c451a4e12.siteSettings.1891a55f-7f04-4fc8-abfd-3fd84207d90b.hasUrls','false'),('sections.34bba139-c036-4e65-a8c0-bf6c451a4e12.siteSettings.1891a55f-7f04-4fc8-abfd-3fd84207d90b.template','null'),('sections.34bba139-c036-4e65-a8c0-bf6c451a4e12.siteSettings.1891a55f-7f04-4fc8-abfd-3fd84207d90b.uriFormat','\"\"'),('sections.34bba139-c036-4e65-a8c0-bf6c451a4e12.structure.maxLevels','1'),('sections.34bba139-c036-4e65-a8c0-bf6c451a4e12.structure.uid','\"0ced5d36-9bb5-4ff3-b633-c9f7f03b2d87\"'),('sections.34bba139-c036-4e65-a8c0-bf6c451a4e12.type','\"structure\"'),('sections.5deeb93f-33f2-42e4-ba35-4b9afe03c4b3.enableVersioning','false'),('sections.5deeb93f-33f2-42e4-ba35-4b9afe03c4b3.entryTypes.e964deb3-bd04-47f0-a8cf-37d4bf040a5e.handle','\"siblings\"'),('sections.5deeb93f-33f2-42e4-ba35-4b9afe03c4b3.entryTypes.e964deb3-bd04-47f0-a8cf-37d4bf040a5e.hasTitleField','true'),('sections.5deeb93f-33f2-42e4-ba35-4b9afe03c4b3.entryTypes.e964deb3-bd04-47f0-a8cf-37d4bf040a5e.name','\"Siblings\"'),('sections.5deeb93f-33f2-42e4-ba35-4b9afe03c4b3.entryTypes.e964deb3-bd04-47f0-a8cf-37d4bf040a5e.sortOrder','2'),('sections.5deeb93f-33f2-42e4-ba35-4b9afe03c4b3.entryTypes.e964deb3-bd04-47f0-a8cf-37d4bf040a5e.titleFormat','\"\"'),('sections.5deeb93f-33f2-42e4-ba35-4b9afe03c4b3.entryTypes.e964deb3-bd04-47f0-a8cf-37d4bf040a5e.titleLabel','\"Sidebar Name\"'),('sections.5deeb93f-33f2-42e4-ba35-4b9afe03c4b3.entryTypes.f46ae148-68cf-48b4-9d9f-c24e3522e388.handle','\"news\"'),('sections.5deeb93f-33f2-42e4-ba35-4b9afe03c4b3.entryTypes.f46ae148-68cf-48b4-9d9f-c24e3522e388.hasTitleField','true'),('sections.5deeb93f-33f2-42e4-ba35-4b9afe03c4b3.entryTypes.f46ae148-68cf-48b4-9d9f-c24e3522e388.name','\"News\"'),('sections.5deeb93f-33f2-42e4-ba35-4b9afe03c4b3.entryTypes.f46ae148-68cf-48b4-9d9f-c24e3522e388.sortOrder','1'),('sections.5deeb93f-33f2-42e4-ba35-4b9afe03c4b3.entryTypes.f46ae148-68cf-48b4-9d9f-c24e3522e388.titleFormat','\"\"'),('sections.5deeb93f-33f2-42e4-ba35-4b9afe03c4b3.entryTypes.f46ae148-68cf-48b4-9d9f-c24e3522e388.titleLabel','\"Sidebar Name\"'),('sections.5deeb93f-33f2-42e4-ba35-4b9afe03c4b3.handle','\"sidebars\"'),('sections.5deeb93f-33f2-42e4-ba35-4b9afe03c4b3.name','\"Sidebars\"'),('sections.5deeb93f-33f2-42e4-ba35-4b9afe03c4b3.propagationMethod','\"all\"'),('sections.5deeb93f-33f2-42e4-ba35-4b9afe03c4b3.siteSettings.1891a55f-7f04-4fc8-abfd-3fd84207d90b.enabledByDefault','true'),('sections.5deeb93f-33f2-42e4-ba35-4b9afe03c4b3.siteSettings.1891a55f-7f04-4fc8-abfd-3fd84207d90b.hasUrls','false'),('sections.5deeb93f-33f2-42e4-ba35-4b9afe03c4b3.siteSettings.1891a55f-7f04-4fc8-abfd-3fd84207d90b.template','null'),('sections.5deeb93f-33f2-42e4-ba35-4b9afe03c4b3.siteSettings.1891a55f-7f04-4fc8-abfd-3fd84207d90b.uriFormat','\"\"'),('sections.5deeb93f-33f2-42e4-ba35-4b9afe03c4b3.structure.maxLevels','1'),('sections.5deeb93f-33f2-42e4-ba35-4b9afe03c4b3.structure.uid','\"8db9bbbb-3fc5-4f53-bf3d-3860898519fd\"'),('sections.5deeb93f-33f2-42e4-ba35-4b9afe03c4b3.type','\"structure\"'),('sections.b0ac9541-cb53-4dc6-86e4-56cb0604c874.enableVersioning','false'),('sections.b0ac9541-cb53-4dc6-86e4-56cb0604c874.entryTypes.357d4858-eada-4a76-aeb0-4304636ea734.fieldLayouts.cee0e0f7-766d-4377-ada2-ffaee7236338.tabs.0.fields.63ecb9f3-46e5-4108-88d6-bbe79e8a6022.required','false'),('sections.b0ac9541-cb53-4dc6-86e4-56cb0604c874.entryTypes.357d4858-eada-4a76-aeb0-4304636ea734.fieldLayouts.cee0e0f7-766d-4377-ada2-ffaee7236338.tabs.0.fields.63ecb9f3-46e5-4108-88d6-bbe79e8a6022.sortOrder','1'),('sections.b0ac9541-cb53-4dc6-86e4-56cb0604c874.entryTypes.357d4858-eada-4a76-aeb0-4304636ea734.fieldLayouts.cee0e0f7-766d-4377-ada2-ffaee7236338.tabs.0.name','\"Content\"'),('sections.b0ac9541-cb53-4dc6-86e4-56cb0604c874.entryTypes.357d4858-eada-4a76-aeb0-4304636ea734.fieldLayouts.cee0e0f7-766d-4377-ada2-ffaee7236338.tabs.0.sortOrder','1'),('sections.b0ac9541-cb53-4dc6-86e4-56cb0604c874.entryTypes.357d4858-eada-4a76-aeb0-4304636ea734.handle','\"news\"'),('sections.b0ac9541-cb53-4dc6-86e4-56cb0604c874.entryTypes.357d4858-eada-4a76-aeb0-4304636ea734.hasTitleField','false'),('sections.b0ac9541-cb53-4dc6-86e4-56cb0604c874.entryTypes.357d4858-eada-4a76-aeb0-4304636ea734.name','\"News\"'),('sections.b0ac9541-cb53-4dc6-86e4-56cb0604c874.entryTypes.357d4858-eada-4a76-aeb0-4304636ea734.sortOrder','3'),('sections.b0ac9541-cb53-4dc6-86e4-56cb0604c874.entryTypes.357d4858-eada-4a76-aeb0-4304636ea734.titleFormat','\"News\"'),('sections.b0ac9541-cb53-4dc6-86e4-56cb0604c874.entryTypes.357d4858-eada-4a76-aeb0-4304636ea734.titleLabel','\"Title\"'),('sections.b0ac9541-cb53-4dc6-86e4-56cb0604c874.entryTypes.97ac79eb-4923-4dda-a871-7751921c6f89.fieldLayouts.7828717f-697d-414f-a62f-210094daea3e.tabs.0.fields.57439ba8-7b9a-4a6f-925c-791faec8269a.required','false'),('sections.b0ac9541-cb53-4dc6-86e4-56cb0604c874.entryTypes.97ac79eb-4923-4dda-a871-7751921c6f89.fieldLayouts.7828717f-697d-414f-a62f-210094daea3e.tabs.0.fields.57439ba8-7b9a-4a6f-925c-791faec8269a.sortOrder','1'),('sections.b0ac9541-cb53-4dc6-86e4-56cb0604c874.entryTypes.97ac79eb-4923-4dda-a871-7751921c6f89.fieldLayouts.7828717f-697d-414f-a62f-210094daea3e.tabs.0.name','\"Content\"'),('sections.b0ac9541-cb53-4dc6-86e4-56cb0604c874.entryTypes.97ac79eb-4923-4dda-a871-7751921c6f89.fieldLayouts.7828717f-697d-414f-a62f-210094daea3e.tabs.0.sortOrder','1'),('sections.b0ac9541-cb53-4dc6-86e4-56cb0604c874.entryTypes.97ac79eb-4923-4dda-a871-7751921c6f89.handle','\"homepage\"'),('sections.b0ac9541-cb53-4dc6-86e4-56cb0604c874.entryTypes.97ac79eb-4923-4dda-a871-7751921c6f89.hasTitleField','false'),('sections.b0ac9541-cb53-4dc6-86e4-56cb0604c874.entryTypes.97ac79eb-4923-4dda-a871-7751921c6f89.name','\"Homepage\"'),('sections.b0ac9541-cb53-4dc6-86e4-56cb0604c874.entryTypes.97ac79eb-4923-4dda-a871-7751921c6f89.sortOrder','4'),('sections.b0ac9541-cb53-4dc6-86e4-56cb0604c874.entryTypes.97ac79eb-4923-4dda-a871-7751921c6f89.titleFormat','\"Homepage\"'),('sections.b0ac9541-cb53-4dc6-86e4-56cb0604c874.entryTypes.97ac79eb-4923-4dda-a871-7751921c6f89.titleLabel','\"Title\"'),('sections.b0ac9541-cb53-4dc6-86e4-56cb0604c874.entryTypes.e601d9ea-ea4e-4ce5-9bfe-3c1be3dfadf2.fieldLayouts.e6f6a307-7c97-4343-92ae-d7590e0adb9f.tabs.0.fields.57439ba8-7b9a-4a6f-925c-791faec8269a.required','false'),('sections.b0ac9541-cb53-4dc6-86e4-56cb0604c874.entryTypes.e601d9ea-ea4e-4ce5-9bfe-3c1be3dfadf2.fieldLayouts.e6f6a307-7c97-4343-92ae-d7590e0adb9f.tabs.0.fields.57439ba8-7b9a-4a6f-925c-791faec8269a.sortOrder','1'),('sections.b0ac9541-cb53-4dc6-86e4-56cb0604c874.entryTypes.e601d9ea-ea4e-4ce5-9bfe-3c1be3dfadf2.fieldLayouts.e6f6a307-7c97-4343-92ae-d7590e0adb9f.tabs.0.name','\"Content\"'),('sections.b0ac9541-cb53-4dc6-86e4-56cb0604c874.entryTypes.e601d9ea-ea4e-4ce5-9bfe-3c1be3dfadf2.fieldLayouts.e6f6a307-7c97-4343-92ae-d7590e0adb9f.tabs.0.sortOrder','1'),('sections.b0ac9541-cb53-4dc6-86e4-56cb0604c874.entryTypes.e601d9ea-ea4e-4ce5-9bfe-3c1be3dfadf2.fieldLayouts.e6f6a307-7c97-4343-92ae-d7590e0adb9f.tabs.1.name','\"Page\"'),('sections.b0ac9541-cb53-4dc6-86e4-56cb0604c874.entryTypes.e601d9ea-ea4e-4ce5-9bfe-3c1be3dfadf2.fieldLayouts.e6f6a307-7c97-4343-92ae-d7590e0adb9f.tabs.1.sortOrder','2'),('sections.b0ac9541-cb53-4dc6-86e4-56cb0604c874.entryTypes.e601d9ea-ea4e-4ce5-9bfe-3c1be3dfadf2.handle','\"contact\"'),('sections.b0ac9541-cb53-4dc6-86e4-56cb0604c874.entryTypes.e601d9ea-ea4e-4ce5-9bfe-3c1be3dfadf2.hasTitleField','true'),('sections.b0ac9541-cb53-4dc6-86e4-56cb0604c874.entryTypes.e601d9ea-ea4e-4ce5-9bfe-3c1be3dfadf2.name','\"Contact\"'),('sections.b0ac9541-cb53-4dc6-86e4-56cb0604c874.entryTypes.e601d9ea-ea4e-4ce5-9bfe-3c1be3dfadf2.sortOrder','2'),('sections.b0ac9541-cb53-4dc6-86e4-56cb0604c874.entryTypes.e601d9ea-ea4e-4ce5-9bfe-3c1be3dfadf2.titleFormat','\"\"'),('sections.b0ac9541-cb53-4dc6-86e4-56cb0604c874.entryTypes.e601d9ea-ea4e-4ce5-9bfe-3c1be3dfadf2.titleLabel','\"Title\"'),('sections.b0ac9541-cb53-4dc6-86e4-56cb0604c874.entryTypes.e8ee1969-bc9d-4366-919d-bd9d88737188.fieldLayouts.47f51c95-5f9f-4a34-900c-e4301d1cffcf.tabs.0.fields.57439ba8-7b9a-4a6f-925c-791faec8269a.required','false'),('sections.b0ac9541-cb53-4dc6-86e4-56cb0604c874.entryTypes.e8ee1969-bc9d-4366-919d-bd9d88737188.fieldLayouts.47f51c95-5f9f-4a34-900c-e4301d1cffcf.tabs.0.fields.57439ba8-7b9a-4a6f-925c-791faec8269a.sortOrder','2'),('sections.b0ac9541-cb53-4dc6-86e4-56cb0604c874.entryTypes.e8ee1969-bc9d-4366-919d-bd9d88737188.fieldLayouts.47f51c95-5f9f-4a34-900c-e4301d1cffcf.tabs.0.fields.63ecb9f3-46e5-4108-88d6-bbe79e8a6022.required','false'),('sections.b0ac9541-cb53-4dc6-86e4-56cb0604c874.entryTypes.e8ee1969-bc9d-4366-919d-bd9d88737188.fieldLayouts.47f51c95-5f9f-4a34-900c-e4301d1cffcf.tabs.0.fields.63ecb9f3-46e5-4108-88d6-bbe79e8a6022.sortOrder','1'),('sections.b0ac9541-cb53-4dc6-86e4-56cb0604c874.entryTypes.e8ee1969-bc9d-4366-919d-bd9d88737188.fieldLayouts.47f51c95-5f9f-4a34-900c-e4301d1cffcf.tabs.0.name','\"Content\"'),('sections.b0ac9541-cb53-4dc6-86e4-56cb0604c874.entryTypes.e8ee1969-bc9d-4366-919d-bd9d88737188.fieldLayouts.47f51c95-5f9f-4a34-900c-e4301d1cffcf.tabs.0.sortOrder','1'),('sections.b0ac9541-cb53-4dc6-86e4-56cb0604c874.entryTypes.e8ee1969-bc9d-4366-919d-bd9d88737188.fieldLayouts.47f51c95-5f9f-4a34-900c-e4301d1cffcf.tabs.1.fields.062f9f55-3f65-4fcd-81b2-eb83e6ce1de0.required','false'),('sections.b0ac9541-cb53-4dc6-86e4-56cb0604c874.entryTypes.e8ee1969-bc9d-4366-919d-bd9d88737188.fieldLayouts.47f51c95-5f9f-4a34-900c-e4301d1cffcf.tabs.1.fields.062f9f55-3f65-4fcd-81b2-eb83e6ce1de0.sortOrder','1'),('sections.b0ac9541-cb53-4dc6-86e4-56cb0604c874.entryTypes.e8ee1969-bc9d-4366-919d-bd9d88737188.fieldLayouts.47f51c95-5f9f-4a34-900c-e4301d1cffcf.tabs.1.name','\"Page\"'),('sections.b0ac9541-cb53-4dc6-86e4-56cb0604c874.entryTypes.e8ee1969-bc9d-4366-919d-bd9d88737188.fieldLayouts.47f51c95-5f9f-4a34-900c-e4301d1cffcf.tabs.1.sortOrder','2'),('sections.b0ac9541-cb53-4dc6-86e4-56cb0604c874.entryTypes.e8ee1969-bc9d-4366-919d-bd9d88737188.handle','\"default\"'),('sections.b0ac9541-cb53-4dc6-86e4-56cb0604c874.entryTypes.e8ee1969-bc9d-4366-919d-bd9d88737188.hasTitleField','true'),('sections.b0ac9541-cb53-4dc6-86e4-56cb0604c874.entryTypes.e8ee1969-bc9d-4366-919d-bd9d88737188.name','\"Default\"'),('sections.b0ac9541-cb53-4dc6-86e4-56cb0604c874.entryTypes.e8ee1969-bc9d-4366-919d-bd9d88737188.sortOrder','1'),('sections.b0ac9541-cb53-4dc6-86e4-56cb0604c874.entryTypes.e8ee1969-bc9d-4366-919d-bd9d88737188.titleFormat','\"\"'),('sections.b0ac9541-cb53-4dc6-86e4-56cb0604c874.entryTypes.e8ee1969-bc9d-4366-919d-bd9d88737188.titleLabel','\"Title\"'),('sections.b0ac9541-cb53-4dc6-86e4-56cb0604c874.handle','\"pages\"'),('sections.b0ac9541-cb53-4dc6-86e4-56cb0604c874.name','\"Pages\"'),('sections.b0ac9541-cb53-4dc6-86e4-56cb0604c874.propagationMethod','\"all\"'),('sections.b0ac9541-cb53-4dc6-86e4-56cb0604c874.siteSettings.1891a55f-7f04-4fc8-abfd-3fd84207d90b.enabledByDefault','true'),('sections.b0ac9541-cb53-4dc6-86e4-56cb0604c874.siteSettings.1891a55f-7f04-4fc8-abfd-3fd84207d90b.hasUrls','true'),('sections.b0ac9541-cb53-4dc6-86e4-56cb0604c874.siteSettings.1891a55f-7f04-4fc8-abfd-3fd84207d90b.template','\"_pages\"'),('sections.b0ac9541-cb53-4dc6-86e4-56cb0604c874.siteSettings.1891a55f-7f04-4fc8-abfd-3fd84207d90b.uriFormat','\"{slug}\"'),('sections.b0ac9541-cb53-4dc6-86e4-56cb0604c874.structure.maxLevels','1'),('sections.b0ac9541-cb53-4dc6-86e4-56cb0604c874.structure.uid','\"a87223af-56f5-4672-933f-b0f26e915594\"'),('sections.b0ac9541-cb53-4dc6-86e4-56cb0604c874.type','\"structure\"'),('sections.f52621ed-e4a9-4525-93f8-a804b6e72dfc.enableVersioning','true'),('sections.f52621ed-e4a9-4525-93f8-a804b6e72dfc.entryTypes.77d059ad-3d3f-4ced-9f30-0c2b13f3b60d.fieldLayouts.0afc2d60-e7cb-43d2-b0f6-68b68417025a.tabs.0.fields.57439ba8-7b9a-4a6f-925c-791faec8269a.required','false'),('sections.f52621ed-e4a9-4525-93f8-a804b6e72dfc.entryTypes.77d059ad-3d3f-4ced-9f30-0c2b13f3b60d.fieldLayouts.0afc2d60-e7cb-43d2-b0f6-68b68417025a.tabs.0.fields.57439ba8-7b9a-4a6f-925c-791faec8269a.sortOrder','2'),('sections.f52621ed-e4a9-4525-93f8-a804b6e72dfc.entryTypes.77d059ad-3d3f-4ced-9f30-0c2b13f3b60d.fieldLayouts.0afc2d60-e7cb-43d2-b0f6-68b68417025a.tabs.0.fields.63ecb9f3-46e5-4108-88d6-bbe79e8a6022.required','false'),('sections.f52621ed-e4a9-4525-93f8-a804b6e72dfc.entryTypes.77d059ad-3d3f-4ced-9f30-0c2b13f3b60d.fieldLayouts.0afc2d60-e7cb-43d2-b0f6-68b68417025a.tabs.0.fields.63ecb9f3-46e5-4108-88d6-bbe79e8a6022.sortOrder','1'),('sections.f52621ed-e4a9-4525-93f8-a804b6e72dfc.entryTypes.77d059ad-3d3f-4ced-9f30-0c2b13f3b60d.fieldLayouts.0afc2d60-e7cb-43d2-b0f6-68b68417025a.tabs.0.name','\"Content\"'),('sections.f52621ed-e4a9-4525-93f8-a804b6e72dfc.entryTypes.77d059ad-3d3f-4ced-9f30-0c2b13f3b60d.fieldLayouts.0afc2d60-e7cb-43d2-b0f6-68b68417025a.tabs.0.sortOrder','1'),('sections.f52621ed-e4a9-4525-93f8-a804b6e72dfc.entryTypes.77d059ad-3d3f-4ced-9f30-0c2b13f3b60d.handle','\"news\"'),('sections.f52621ed-e4a9-4525-93f8-a804b6e72dfc.entryTypes.77d059ad-3d3f-4ced-9f30-0c2b13f3b60d.hasTitleField','true'),('sections.f52621ed-e4a9-4525-93f8-a804b6e72dfc.entryTypes.77d059ad-3d3f-4ced-9f30-0c2b13f3b60d.name','\"News\"'),('sections.f52621ed-e4a9-4525-93f8-a804b6e72dfc.entryTypes.77d059ad-3d3f-4ced-9f30-0c2b13f3b60d.sortOrder','1'),('sections.f52621ed-e4a9-4525-93f8-a804b6e72dfc.entryTypes.77d059ad-3d3f-4ced-9f30-0c2b13f3b60d.titleFormat','\"\"'),('sections.f52621ed-e4a9-4525-93f8-a804b6e72dfc.entryTypes.77d059ad-3d3f-4ced-9f30-0c2b13f3b60d.titleLabel','\"Title\"'),('sections.f52621ed-e4a9-4525-93f8-a804b6e72dfc.handle','\"news\"'),('sections.f52621ed-e4a9-4525-93f8-a804b6e72dfc.name','\"News\"'),('sections.f52621ed-e4a9-4525-93f8-a804b6e72dfc.propagationMethod','\"all\"'),('sections.f52621ed-e4a9-4525-93f8-a804b6e72dfc.siteSettings.1891a55f-7f04-4fc8-abfd-3fd84207d90b.enabledByDefault','true'),('sections.f52621ed-e4a9-4525-93f8-a804b6e72dfc.siteSettings.1891a55f-7f04-4fc8-abfd-3fd84207d90b.hasUrls','true'),('sections.f52621ed-e4a9-4525-93f8-a804b6e72dfc.siteSettings.1891a55f-7f04-4fc8-abfd-3fd84207d90b.template','\"_pages/news-article\"'),('sections.f52621ed-e4a9-4525-93f8-a804b6e72dfc.siteSettings.1891a55f-7f04-4fc8-abfd-3fd84207d90b.uriFormat','\"news/{slug}\"'),('sections.f52621ed-e4a9-4525-93f8-a804b6e72dfc.type','\"channel\"'),('siteGroups.57cd948a-2dfe-4550-b0f2-053ee01da77c.name','\"Starter Site\"'),('sites.1891a55f-7f04-4fc8-abfd-3fd84207d90b.baseUrl','\"http://$DEFAULT_SITE_URL\"'),('sites.1891a55f-7f04-4fc8-abfd-3fd84207d90b.handle','\"default\"'),('sites.1891a55f-7f04-4fc8-abfd-3fd84207d90b.hasUrls','true'),('sites.1891a55f-7f04-4fc8-abfd-3fd84207d90b.language','\"en-US\"'),('sites.1891a55f-7f04-4fc8-abfd-3fd84207d90b.name','\"Starter Site\"'),('sites.1891a55f-7f04-4fc8-abfd-3fd84207d90b.primary','true'),('sites.1891a55f-7f04-4fc8-abfd-3fd84207d90b.siteGroup','\"57cd948a-2dfe-4550-b0f2-053ee01da77c\"'),('sites.1891a55f-7f04-4fc8-abfd-3fd84207d90b.sortOrder','1'),('system.edition','\"solo\"'),('system.live','true'),('system.name','\"Starter Site\"'),('system.schemaVersion','\"3.4.10\"'),('system.timeZone','\"America/Los_Angeles\"'),('users.allowPublicRegistration','false'),('users.defaultGroup','null'),('users.photoSubpath','\"\"'),('users.photoVolumeUid','null'),('users.requireEmailVerification','true'),('volumes.1ca271c4-3b66-436a-a488-8a678cda224f.handle','\"heroImages\"'),('volumes.1ca271c4-3b66-436a-a488-8a678cda224f.hasUrls','true'),('volumes.1ca271c4-3b66-436a-a488-8a678cda224f.name','\"Hero Images\"'),('volumes.1ca271c4-3b66-436a-a488-8a678cda224f.settings.path','\"@assetsPath/hero-images\"'),('volumes.1ca271c4-3b66-436a-a488-8a678cda224f.sortOrder','2'),('volumes.1ca271c4-3b66-436a-a488-8a678cda224f.type','\"craft\\\\volumes\\\\Local\"'),('volumes.1ca271c4-3b66-436a-a488-8a678cda224f.url','\"@assetsUrl/hero-images\"'),('volumes.5ebe069f-09ab-4250-8880-37a3a169ab68.handle','\"body\"'),('volumes.5ebe069f-09ab-4250-8880-37a3a169ab68.hasUrls','true'),('volumes.5ebe069f-09ab-4250-8880-37a3a169ab68.name','\"Body\"'),('volumes.5ebe069f-09ab-4250-8880-37a3a169ab68.settings.path','\"@assetsPath/body\"'),('volumes.5ebe069f-09ab-4250-8880-37a3a169ab68.sortOrder','1'),('volumes.5ebe069f-09ab-4250-8880-37a3a169ab68.type','\"craft\\\\volumes\\\\Local\"'),('volumes.5ebe069f-09ab-4250-8880-37a3a169ab68.url','\"@assetsUrl/body\"');
/*!40000 ALTER TABLE `projectconfig` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `queue`
--

LOCK TABLES `queue` WRITE;
/*!40000 ALTER TABLE `queue` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `queue` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `relations`
--

LOCK TABLES `relations` WRITE;
/*!40000 ALTER TABLE `relations` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `relations` VALUES (3,14,79,NULL,78,1,'2020-04-18 20:28:58','2020-04-18 20:28:58','3ef3bcc7-0e52-417d-a78f-bec1ab05d209'),(4,14,80,NULL,76,1,'2020-04-18 20:33:18','2020-04-18 20:33:18','d4108d20-f5f3-451e-8f6b-72691184989b'),(6,9,55,NULL,83,1,'2020-05-03 04:45:18','2020-05-03 04:45:18','25e915e2-7375-44fc-914f-d0616de9e3e8'),(7,20,91,NULL,100,1,'2020-05-17 05:06:03','2020-05-17 05:06:03','d17dac6b-1732-4c87-85d6-35872808d688'),(8,20,101,NULL,100,1,'2020-05-17 05:06:03','2020-05-17 05:06:03','d278838f-4cbe-4277-9233-400e1376a31e'),(9,20,110,NULL,130,1,'2020-05-17 05:45:44','2020-05-17 05:45:44','97d5d32d-fd96-4205-a923-86d6069d0e3a'),(10,20,131,NULL,130,1,'2020-05-17 05:45:44','2020-05-17 05:45:44','255f0527-b72c-4987-b194-5074e7bc1855'),(11,20,122,NULL,128,1,'2020-05-17 05:45:52','2020-05-17 05:45:52','55fb2a28-cce1-4287-a891-61279416e002'),(12,20,132,NULL,128,1,'2020-05-17 05:45:52','2020-05-17 05:45:52','795a6f05-1bca-4169-81a2-f71765cc440b'),(13,20,116,NULL,129,1,'2020-05-17 05:46:02','2020-05-17 05:46:02','95f2b670-2965-4a08-91e7-0cdd8e211176'),(14,20,133,NULL,129,1,'2020-05-17 05:46:02','2020-05-17 05:46:02','987d7dbb-b35d-4a57-93c9-14853d4d5821'),(15,20,119,NULL,127,1,'2020-05-17 05:46:09','2020-05-17 05:46:09','2948ca49-693a-434d-b15b-323af7b54d22'),(16,20,134,NULL,127,1,'2020-05-17 05:46:09','2020-05-17 05:46:09','d7e05f2a-c6b2-4029-9951-cefa7a111c7a'),(17,20,113,NULL,124,1,'2020-05-17 05:46:20','2020-05-17 05:46:20','e4a734c9-f0b6-4654-b35e-7d0d7c91ca32'),(18,20,135,NULL,124,1,'2020-05-17 05:46:20','2020-05-17 05:46:20','d60012a8-3601-45ca-b25a-0dc182465ec1'),(19,20,107,NULL,126,1,'2020-05-17 05:46:28','2020-05-17 05:46:28','33b4da07-6668-4d37-8236-119c99b0f950'),(20,20,136,NULL,126,1,'2020-05-17 05:46:28','2020-05-17 05:46:28','35820845-0ce3-4ade-bb13-bb3c884e0f51'),(21,20,104,NULL,125,1,'2020-05-17 05:46:43','2020-05-17 05:46:43','95455407-b046-4024-a446-079230efa96c'),(22,20,137,NULL,125,1,'2020-05-17 05:46:43','2020-05-17 05:46:43','90843af9-e737-4612-85bb-1cad67c4e4d0'),(23,20,139,NULL,129,1,'2020-05-17 05:50:02','2020-05-17 05:50:02','134bcb38-9f0a-48c8-b1ad-5731df83e85d'),(24,20,142,NULL,127,1,'2020-05-17 05:51:35','2020-05-17 05:51:35','92c675d9-1b28-476d-8dca-043483cdc077'),(25,20,145,NULL,128,1,'2020-05-17 05:52:11','2020-05-17 05:52:11','126edb4c-5208-49bb-a9e6-0ccc86545c8d'),(26,20,148,NULL,124,1,'2020-05-17 05:53:18','2020-05-17 05:53:18','d9cb9ad8-1a28-46af-9525-198b4ad89808'),(27,20,151,NULL,130,1,'2020-05-17 05:53:47','2020-05-17 05:53:47','0a215c7f-a9ba-48ba-91b9-9e494518ea26'),(28,20,154,NULL,126,1,'2020-05-17 05:54:06','2020-05-17 05:54:06','eb095fcf-9107-4333-a140-888233a96357'),(29,20,157,NULL,125,1,'2020-05-17 05:54:34','2020-05-17 05:54:34','35559d81-78d9-41e8-807c-aa08d7d96d11'),(30,20,99,NULL,100,1,'2020-05-17 06:24:04','2020-05-17 06:24:04','4ffabda2-1a7f-4b77-b12c-5f224b78ebc3');
/*!40000 ALTER TABLE `relations` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `resourcepaths`
--

LOCK TABLES `resourcepaths` WRITE;
/*!40000 ALTER TABLE `resourcepaths` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `resourcepaths` VALUES ('1103c397','@app/web/assets/utilities/dist'),('11142d57','@verbb/knockknock/resources/dist'),('11c1cba7','@lib/jquery-ui'),('12db81e9','@craft/web/assets/feed/dist'),('133c104a','@craft/web/assets/plugins/dist'),('13f9e4e6','@app/web/assets/cp/dist'),('148b7f02','@lib/fileupload'),('158dd31c','@lib/selectize'),('15d86227','@app/web/assets/updateswidget/dist'),('15e54c58','@craft/web/assets/editsection/dist'),('17c7f198','@app/web/assets/login/dist'),('17f34be1','@bower/jquery/dist'),('1829adc8','@app/web/assets/tablesettings/dist'),('19ce5a44','@app/web/assets/updater/dist'),('1a5b1374','@lib/jquery.payment'),('1a7be9e0','@lib/velocity'),('1b168bee','@lib/axios'),('1b4acee6','@app/web/assets/craftsupport/dist'),('1f994c15','@app/web/assets/installer/dist'),('1fe19796','@lib/xregexp'),('201ecfe3','@lib/timepicker'),('205bd33a','@app/web/assets/updater/dist'),('222bc09f','@app/web/assets/editsection/dist'),('22830290','@lib/axios'),('243d9d15','@lib/fabric'),('2464b568','@lib/element-resize-detector'),('251f667','@app/web/assets/edituser/dist'),('25c80b60','@craft/web/assets/login/dist'),('26841805','@craft/web/assets/updater/dist'),('274fc6d0','@app/web/assets/dashboard/dist'),('28140ba7','@app/web/assets/plugins/dist'),('285442d9','@lib/jquery-ui'),('286ab9cf','@vendor/craftcms/redactor/lib/redactor-plugins/table'),('2a6c6d98','@app/web/assets/cp/dist'),('2abe42c7','@lib/vue'),('2b622049','@app/web/assets/recententries/dist'),('2c65ead','@lib/d3'),('2d174aef','@app/web/assets/pluginstore/dist'),('2dcebcad','@craft/web/assets/craftsupport/dist'),('2e5278e6','@app/web/assets/login/dist'),('2f8f5d8','@craft/web/assets/pluginstore/dist'),('30353857','@app/web/assets/plugins/dist'),('315420b3','@app/web/assets/pluginstore/dist'),('317b492b','@lib/garnishjs'),('318dd6f1','@craft/web/assets/craftsupport/dist'),('321112ba','@app/web/assets/login/dist'),('341a82e4','@app/web/assets/admintable/dist'),('362f07c4','@app/web/assets/cp/dist'),('36fd289b','@lib/vue'),('37214a15','@app/web/assets/recententries/dist'),('3863e014','@lib/element-resize-detector'),('38b209a1','@app/web/assets/updates/dist'),('398b613c','@craft/web/assets/login/dist'),('39b6fbd3','@vendor/craftcms/redactor/lib/redactor-plugins/video'),('3b1af1fd','@craft/web/assets/dbbackup/dist'),('3b2d140e','@doublesecretagency/matrixcolors/resources'),('3ba99ed7','@app/web/assets/matrixsettings/dist'),('3e9c2dc4','@app/web/assets/craftsupport/dist'),('40dab6da','@app/web/assets/updater/dist'),('413acc96','@lib/fileupload'),('413d4156','@app/web/assets/tablesettings/dist'),('41f3fe98','@lib/picturefill'),('432b3a5e','@lib/velocity'),('434fffea','@lib/jquery.payment'),('44331cca','@app/web/assets/sites/dist'),('44d1c8d3','@lib/prismjs'),('455ba680','@app/web/assets/matrix/dist'),('4657c25a','@lib/jquery-touch-events'),('48172f09','@app/web/assets/utilities/dist'),('48d52739','@lib/jquery-ui'),('4a63aec1','@carlcs/redactorcustomstyles/assets/redactorplugin/dist'),('4a7984b4','@app/web/assets/editentry/dist'),('4b3e6522','@craft/web/assets/editentry/dist'),('4e0a9228','@craft/web/assets/updates/dist'),('4ee7a77f','@bower/jquery/dist'),('4f344c7a','@app/web/assets/feed/dist'),('4f56dec9','@lib/d3'),('508fe4e5','@app/web/assets/updateswidget/dist'),('527117f2','@lib/xregexp'),('52a4cd23','@bower/jquery/dist'),('53772626','@app/web/assets/feed/dist'),('54544555','@app/web/assets/utilities/dist'),('5480227d','@verbb/redactortweaks/resources/dist'),('54d27245','@lib/jquery-ui'),('566b9688','@craft/web/assets/plugins/dist'),('5777ed39','@lib/d3'),('577d0f7e','@craft/web/assets/editentry/dist'),('581d5378','@lib/selectize'),('58d3018','@app/web/assets/updater/dist'),('58e285f4','@lib/element-resize-detector'),('591bff66','@lib/fileupload'),('59d2cd68','@lib/picturefill'),('5c122f3a','@app/web/assets/sites/dist'),('5d7e2b0a','@app/web/assets/tablesettings/dist'),('5e05320c','@lib/axios'),('5e1d4824','@app/web/assets/craftsupport/dist'),('5e327631','@craft/web/assets/cp/dist'),('5e76f1aa','@lib/jquery-touch-events'),('5f0c95b6','@lib/jquery.payment'),('5f685002','@lib/velocity'),('61770c8a','@lib/element-resize-detector'),('62bd7249','@app/web/assets/matrixsettings/dist'),('64cafabf','@lib/garnishjs'),('65c4608','@lib/jquery.payment'),('6621004f','@vendor/craftcms/redactor/lib/redactor-plugins/fontcolor'),('66fdd97c','@lib/velocity'),('67cbc9c','@lib/velocity'),('68112e12','@craft/web/assets/matrixsettings/dist'),('69ad1d71','@lib/fabric'),('6adf46b4','@app/web/assets/dashboard/dist'),('6ae2af58','@app/web/assets/feed/dist'),('6b98a722','@craft/web/assets/dashboard/dist'),('6d03ba35','@app/web/assets/updates/dist'),('6e35a68b','@app/web/assets/recententries/dist'),('6f7fd47a','@app/web/assets/cp/dist'),('6fe9c405','@lib/vue'),('709a4ba','@app/web/assets/craftsupport/dist'),('7182a677','@app/web/assets/utilities/dist'),('718c2e81','@lib/fabric'),('72fe7544','@app/web/assets/dashboard/dist'),('7452444e','@craft/web/assets/matrixsettings/dist'),('752289c5','@app/web/assets/updates/dist'),('755e1b2','@lib/axios'),('7568717e','@angellco/spoon/assetbundles/dist'),('75bd401f','@verbb/redactortweaks/resources/dist'),('76e191f0','@vendor/craftcms/redactor/lib/redactor'),('77722e01','@bower/jquery/dist'),('77dbcd7e','@craft/web/assets/dashboard/dist'),('7ada7694','@lib/jquery.payment'),('7c0a466','@lib/xregexp'),('7cebc94f','@lib/garnishjs'),('7d3466d6','@lib/element-resize-detector'),('7efe1815','@app/web/assets/matrixsettings/dist'),('801c98aa','@lib/xregexp'),('8089dd7e','@lib/axios'),('80c9427b','@bower/jquery/dist'),('80fa1ed8','@lib/jquery-touch-events'),('80ff3eec','@verbb/base/resources/dist'),('82510cd4','@app/web/assets/updater/dist'),('827c1451','@lib/prismjs'),('83b17698','@lib/fileupload'),('83f67a02','@app/web/assets/matrix/dist'),('84b7c1da','@app/web/assets/craftsupport/dist'),('8524c914','@craft/web/assets/pluginstore/dist'),('8639ca0d','@app/web/assets/utilities/dist'),('86a032fa','@app/web/assets/generalsettings/dist'),('875e221a','@lib/picturefill'),('8923bc95','@rias/colourswatches/assetbundles/colourswatchesfield/dist'),('89fb024b','@lib/d3'),('8a232636','@mmikkel/cpfieldinspect/resources'),('8a256d1b','@app/web/assets/updateswidget/dist'),('8a5e9d37','@lib/jquery-ui'),('8a624aa4','@craft/web/assets/updateswidget/dist'),('8a70dc20','@lib/selectize'),('8c5ff969','@craft/web/assets/cp/dist'),('8cb26e4','@app/web/assets/matrix/dist'),('8cd45836','@app/web/assets/editentry/dist'),('8d611aee','@lib/jquery.payment'),('8f3d4069','@app/web/assets/dbbackup/dist'),('90b26c18','@vendor/craftcms/redactor/lib/redactor-plugins/clips'),('90d30d4a','@app/web/assets/editentry/dist'),('9146b506','@lib/velocity'),('92045eeb','@app/web/assets/updateswidget/dist'),('923fe7b9','@app/web/assets/plugins/dist'),('927faec7','@lib/jquery-ui'),('933a1515','@app/web/assets/dbbackup/dist'),('941ed5fe','@carlcs/redactorcustomstyles/assets/redactorplugin/dist'),('94e02c86','@craft/web/assets/plugins/dist'),('95fc5737','@lib/d3'),('962120f8','@craft/web/assets/updateswidget/dist'),('9633b67c','@lib/selectize'),('98a8ee8e','@lib/axios'),('9967a348','@craft/web/assets/pluginstore/dist'),('99b087b','@app/web/assets/updateswidget/dist'),('9a3523fd','@lib/timepicker'),('9b219318','@craft/web/assets/matrix/dist'),('9b597766','@lib/picturefill'),('9c5ff2f6','@lib/xregexp'),('9c96f22a','@app/web/assets/craftsupport/dist'),('9cfd4ba4','@lib/jquery-touch-events'),('9d59c322','@app/web/assets/feed/dist'),('9e81010a','@app/web/assets/generalsettings/dist'),('9fb623e4','@lib/fileupload'),('9ff12f7e','@app/web/assets/matrix/dist'),('a195a5ff','@app/web/assets/editsection/dist'),('a3a0aa83','@lib/timepicker'),('a5ca7b88','@lib/xregexp'),('a6130035','@doublesecretagency/adwizard'),('a63cab8','@app/web/assets/feed/dist'),('a64140b1','@lib/garnishjs'),('a6d8719e','@verbb/base/resources/dist'),('a89b6296','@craft/web/assets/recententries/dist'),('a9d208f8','@app/web/assets/cp/dist'),('aacb7623','@app/web/assets/pluginstore/dist'),('abaa6ec7','@app/web/assets/plugins/dist'),('abe78dd8','@app/web/assets/admintable/dist'),('acbe1c85','@app/web/assets/recententries/dist'),('ad10edfc','@mmikkel/cpfieldinspect/resources'),('ad627e0b','@lib/vue'),('adec1d86','@app/web/assets/login/dist'),('af00c1f3','@lib/fabric'),('af59e98e','@lib/element-resize-detector'),('af88003b','@app/web/assets/updates/dist'),('afa63f02','@lib/selectize'),('b075cf4a','@app/web/assets/dashboard/dist'),('b1e9dd4f','@app/web/assets/deprecationerrors/dist'),('b1f33b08','@app/web/assets/cp/dist'),('b307948f','@lib/fabric'),('b333bc45','@vendor/craftcms/redactor/lib/redactor'),('b38f5547','@app/web/assets/updates/dist'),('b49f2f75','@app/web/assets/recententries/dist'),('b4d808ca','@craft/web/assets/recententries/dist'),('b5434dfb','@lib/vue'),('b5cd2e76','@app/web/assets/login/dist'),('b7a4e784','@app/web/assets/admintable/dist'),('b7e9049b','@app/web/assets/plugins/dist'),('ba4615cd','@lib/garnishjs'),('bbb0c70','@craft/redactor/assets/field/dist'),('bc7423e','@lib/jquery-touch-events'),('bd1b4e95','@craft/web/assets/updater/dist'),('bdd6cfa3','@app/web/assets/editsection/dist'),('bf41e9d','@bower/jquery/dist'),('bfe3c0df','@lib/timepicker'),('c0f19a8a','@lib/jquery.payment'),('c2357f86','@craft/web/assets/matrix/dist'),('c24d9bf8','@lib/picturefill'),('c2832436','@app/web/assets/tablesettings/dist'),('c2c40389','@craft/web/assets/tablesettings/dist'),('c4f70692','@lib/velocity'),('c54b1e68','@lib/xregexp'),('c59a7bbf','@lib/axios'),('c5e9a73a','@lib/jquery-touch-events'),('c637efc','@lib/picturefill'),('c6c02551','@lib/garnishjs'),('c6e5c3e0','@app/web/assets/matrix/dist'),('c6e6f05a','@lib/fileupload'),('c7b5ed7f','@app/web/assets/updateswidget/dist'),('c8e870b6','@app/web/assets/feed/dist'),('c9087fab','@craft/web/assets/cp/dist'),('c92741be','@app/web/assets/craftsupport/dist'),('c93d1a7a','@doublesecretagency/cpcss/resources'),('c9c7e1d4','@app/web/assets/editentry/dist'),('ca6ac6ab','@app/web/assets/dbbackup/dist'),('cba94a69','@app/web/assets/utilities/dist'),('cce8bba9','@lib/d3'),('cd59c21f','@bower/jquery/dist'),('ce6921c5','@craft/redactor/assets/field/dist'),('cf0965db','@app/web/assets/updates/dist'),('cf275ae2','@lib/selectize'),('d0496eb','@app/web/assets/utilities/dist'),('d0abd1f5','@lib/d3'),('d0c94346','@app/web/assets/feed/dist'),('d0f4aaaa','@app/web/assets/dashboard/dist'),('d3200f9e','@lib/selectize'),('d386f16f','@lib/fabric'),('d3887999','@app/web/assets/utilities/dist'),('d5386eea','@lib/axios'),('d578f1ef','@bower/jquery/dist'),('d5848b88','@app/web/assets/editentry/dist'),('d6adc1a3','@craft/web/assets/utilities/dist'),('d7e0bf40','@app/web/assets/updater/dist'),('d82a1fb','@lib/jquery-ui'),('d8d0a97a','@lib/jquery.payment'),('d94c4b14','@lib/xregexp'),('d9aacd66','@lib/jquery-touch-events'),('daa59a06','@lib/fileupload'),('daa6a9bc','@app/web/assets/matrix/dist'),('dace0ec','@lib/selectize'),('db2cc7ef','@lib/prismjs'),('dcd63562','@lib/velocity'),('de0ef1a4','@lib/picturefill'),('de7615da','@craft/web/assets/matrix/dist'),('de8769d5','@craft/web/assets/tablesettings/dist'),('dfef2ea3','@lib/jquery-ui'),('e07c9de2','@app/web/assets/login/dist'),('e1031729','@app/web/assets/matrixsettings/dist'),('e2c969ea','@lib/element-resize-detector'),('e316c673','@lib/garnishjs'),('e3301378','@lib/fileupload'),('e3e614b','@craft/web/assets/assetindexes/dist'),('e6b31361','@lib/timepicker'),('e96123d4','@app/web/assets/dashboard/dist'),('e97080e','@craft/web/assets/edittransform/dist'),('e98ebb5','@craft/web/assets/feed/dist'),('ea137811','@lib/fabric'),('eadf86f9','@app/web/assets/updates/dist'),('eb4c36b','@app/web/assets/recententries/dist'),('ee060d9a','@app/web/assets/fields/dist'),('ee30135','@vendor/craftcms/redactor/lib/redactor-plugins/fullscreen'),('eeb00b1a','@app/web/assets/admintable/dist'),('efbc2589','@app/web/assets/dbbackup/dist'),('f05268aa','@app/web/assets/editentry/dist'),('f0f26e59','@vendor/craftcms/redactor/lib/redactor-plugins/alignment'),('f24567c6','@app/web/assets/fields/dist'),('f2be8259','@app/web/assets/plugins/dist'),('f5224988','@app/web/assets/dashboard/dist'),('f57d32d7','@lib/d3'),('f650124d','@lib/fabric'),('f695dba0','@craft/web/assets/fields/dist'),('f69ceca5','@app/web/assets/updates/dist'),('f7f7a16','@craft/web/assets/plugins/dist'),('f8814961','@app/web/assets/editsection/dist'),('f90faf11','@app/web/assets/recententries/dist'),('fab4461d','@lib/timepicker'),('fae85a1a','@lib/element-resize-detector'),('fbd81286','@lib/picturefill'),('fc7c2e44','@lib/jquery-touch-events'),('fd1a62db','@angellco/spoon/assetbundles/dist'),('ff55ac2f','@lib/garnishjs'),('ffbb2375','@craft/web/assets/admintable/dist');
/*!40000 ALTER TABLE `resourcepaths` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `revisions`
--

LOCK TABLES `revisions` WRITE;
/*!40000 ALTER TABLE `revisions` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `revisions` VALUES (1,91,1,1,NULL),(2,91,1,2,NULL),(3,91,1,3,NULL),(4,91,1,4,NULL),(5,104,1,1,NULL),(6,107,1,1,NULL),(7,110,1,1,NULL),(8,113,1,1,NULL),(9,116,1,1,NULL),(10,119,1,1,NULL),(11,122,1,1,NULL),(12,110,1,2,NULL),(13,122,1,2,NULL),(14,116,1,2,NULL),(15,119,1,2,NULL),(16,113,1,2,NULL),(17,107,1,2,NULL),(18,104,1,2,NULL),(19,116,1,3,NULL),(20,119,1,3,NULL),(21,122,1,3,NULL),(22,113,1,3,NULL),(23,110,1,3,NULL),(24,107,1,3,NULL),(25,104,1,3,NULL);
/*!40000 ALTER TABLE `revisions` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `searchindex`
--

LOCK TABLES `searchindex` WRITE;
/*!40000 ALTER TABLE `searchindex` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `searchindex` VALUES (1,'username',0,1,' support doublesecretagency com '),(1,'firstname',0,1,''),(1,'lastname',0,1,''),(1,'fullname',0,1,''),(37,'title',0,1,' homepage '),(38,'slug',0,1,''),(39,'slug',0,1,''),(40,'slug',0,1,''),(37,'slug',0,1,' home '),(38,'field',2,1,' lorem ipsum dolor sit amet lorem ipsum dolor sit amet consectetur adipiscing elit duis a risus feugiat malesuada nisi sed pulvinar ligula integer quis urna at lacus tincidunt viverra aenean sollicitudin enim ultricies libero vulputate in hendrerit odio faucibus nam eu consectetur quam nunc orci lectus accumsan eu augue eget tristique vestibulum tortor mauris sodales turpis orci ac blandit libero consectetur in sed efficitur enim ligula et sagittis neque cursus in phasellus eu dui facilisis bibendum libero id elementum ante in hac habitasse platea dictumst phasellus eget magna ut libero semper egestas aliquam ornare volutpat posuere integer dapibus urna integer dapibus urna ut neque ornare vel feugiat eros interdum duis cursus commodo convallis donec lectus ipsum pulvinar eu dui in venenatis molestie risus curabitur mollis risus risus eu finibus est venenatis id donec sit amet libero a mi sagittis luctus et non nibh nullam non rhoncus massa mauris lacinia bibendum lectus pharetra fermentum diam consequat vel nam id purus rutrum molestie mi dignissim rhoncus mi pellentesque nec auctor nulla donec justo ipsum donec justo ipsum pretium in ornare ut rhoncus eget risus nam tempus finibus magna non ultricies urna gravida ac cras id lectus suscipit imperdiet tellus in pretium ante maecenas nibh erat laoreet fermentum volutpat quis finibus sed dui nullam dolor arcu mattis vitae lectus vel vulputate dictum velit donec commodo accumsan justo ut tempor quisque enim erat dapibus sit amet lectus sit amet tincidunt interdum arcu vivamus vitae ex ligula praesent vel ipsum id nunc tempor tincidunt integer non euismod urna duis non urna non lectus feugiat iaculis quisque elit elit porttitor vitae lacus et consectetur fringilla urna '),(46,'slug',0,1,''),(46,'field',2,1,' will this actually work '),(82,'filename',0,1,' kat 9 jpg '),(55,'slug',0,1,''),(56,'slug',0,1,''),(56,'field',2,1,' integer dapibus urna integer dapibus urna ut neque ornare vel feugiat eros interdum duis cursus commodo convallis donec lectus ipsum pulvinar eu dui in venenatis molestie risus curabitur mollis risus risus eu finibus est venenatis id donec sit amet libero a mi sagittis luctus et non nibh nullam non rhoncus massa mauris lacinia bibendum lectus pharetra fermentum diam consequat vel nam id purus rutrum molestie mi dignissim rhoncus mi pellentesque nec auctor nulla '),(89,'slug',0,1,' latest news '),(89,'title',0,1,' latest news '),(45,'slug',0,1,' 404 '),(45,'title',0,1,' 404 '),(91,'title',0,1,' lorem ipsum '),(91,'slug',0,1,' lorem ipsum '),(93,'slug',0,1,''),(93,'field',2,1,' lorem ipsum dolor sit amet consectetur adipiscing elit aenean gravida sem eget tortor malesuada accumsan nec quis leo maecenas at tincidunt felis ut sed lacus pellentesque scelerisque ipsum id vehicula erat vestibulum ultricies lorem eget dui semper et rutrum sapien ullamcorper etiam dapibus nibh interdum pulvinar sollicitudin mauris tempus condimentum justo nec dignissim risus tempor ac suspendisse ac urna eget metus efficitur mattis praesent sollicitudin semper augue ac condimentum nulla efficitur et donec ante nisl pulvinar at sem sed accumsan dignissim tortor phasellus semper quam ac dolor vestibulum ultricies duis eu turpis dolor vestibulum ultricies lobortis tempus maecenas feugiat arcu id convallis sollicitudin odio nunc aliquam quam nec fringilla lectus ex vel velit nam placerat neque at enim hendrerit ullamcorper nunc augue ipsum vehicula ac mi ac molestie gravida leo ut venenatis ante quis arcu venenatis egestas in nec efficitur ex nulla ornare eros non sem egestas ornare praesent semper tempor mollis aliquam urna purus porttitor eget aliquet a fermentum vitae leo '),(85,'slug',0,1,''),(85,'field',2,1,' donec ipsum donec justo ipsum pretium in ornare ut rhoncus eget risus nam tempus finibus magna non ultricies urna gravida ac cras id lectus suscipit imperdiet tellus in pretium ante maecenas nibh erat laoreet fermentum volutpat quis finibus sed dui nullam dolor arcu mattis vitae lectus vel vulputate dictum velit donec commodo accumsan justo ut tempor quisque enim erat dapibus sit amet lectus sit amet tincidunt interdum arcu vivamus vitae ex ligula praesent vel ipsum id nunc tempor tincidunt integer non euismod urna duis non urna non lectus feugiat iaculis quisque elit elit porttitor vitae lacus et consectetur fringilla urna '),(57,'slug',0,1,''),(58,'kind',0,1,' image '),(58,'extension',0,1,' jpg '),(58,'filename',0,1,' kat 9 jpg '),(58,'slug',0,1,''),(58,'title',0,1,' kat 9 '),(71,'slug',0,1,''),(71,'field',2,1,' all of the following tags were added via redactor header is a red h2 subheader is a blue h3 small button large button '),(80,'slug',0,1,''),(60,'title',0,1,' about '),(60,'slug',0,1,' about '),(73,'title',0,1,' contact '),(73,'slug',0,1,' contact '),(74,'slug',0,1,''),(74,'field',2,1,' have a button small button '),(76,'title',0,1,' homepage 3 icons at top '),(78,'title',0,1,' featured products '),(78,'slug',0,1,' featured products '),(79,'slug',0,1,''),(76,'slug',0,1,' icons on homepage '),(82,'extension',0,1,' jpg '),(82,'kind',0,1,' image '),(82,'slug',0,1,''),(82,'title',0,1,' kat 9 '),(83,'filename',0,1,' yosemite 5 jpg '),(83,'extension',0,1,' jpg '),(83,'kind',0,1,' image '),(83,'slug',0,1,''),(83,'title',0,1,' yosemite 5 '),(84,'slug',0,1,''),(84,'field',2,1,' lorem ipsum dolor sit amet lorem ipsum dolor sit amet consectetur adipiscing elit duis a risus feugiat malesuada nisi sed pulvinar ligula integer quis urna at lacus tincidunt viverra aenean sollicitudin enim ultricies libero vulputate in hendrerit odio faucibus nam eu consectetur quam nunc orci lectus accumsan eu augue eget tristique vestibulum tortor mauris sodales turpis orci ac blandit libero consectetur in sed efficitur enim ligula et sagittis neque cursus in phasellus eu dui facilisis bibendum libero id elementum ante in hac habitasse platea dictumst phasellus eget magna ut libero semper egestas aliquam ornare volutpat posuere '),(1,'email',0,1,' support doublesecretagency com '),(1,'slug',0,1,''),(99,'title',0,1,' news '),(99,'slug',0,1,' news '),(100,'filename',0,1,' kitteh jpeg '),(100,'extension',0,1,' jpeg '),(100,'kind',0,1,' image '),(100,'slug',0,1,''),(100,'title',0,1,' kitteh '),(104,'title',0,1,' the sorcerers stone '),(107,'slug',0,1,' the chamber of secrets '),(110,'title',0,1,' the prisoner of azkaban '),(113,'slug',0,1,' the goblet of fire '),(116,'slug',0,1,' the order of the phoenix '),(116,'title',0,1,' the order of the phoenix '),(119,'slug',0,1,' the half blood prince '),(119,'title',0,1,' the half blood prince '),(122,'title',0,1,' the deathly hallows '),(124,'filename',0,1,' 6e4bfcdf133e0bdfca57226c81d7558b jpg '),(124,'extension',0,1,' jpg '),(124,'kind',0,1,' image '),(124,'slug',0,1,''),(124,'title',0,1,' 6e4bfcdf133e0bdfca57226c81d7558b '),(125,'filename',0,1,' 950223 top harry potter book wallpapers 1920x1080 for samsung galaxy jpg '),(125,'extension',0,1,' jpg '),(125,'kind',0,1,' image '),(125,'slug',0,1,''),(125,'title',0,1,' 950223 top harry potter book wallpapers 1920x1080 for samsung galaxy '),(126,'filename',0,1,' chamber of secrets full jacket jpg '),(126,'extension',0,1,' jpg '),(126,'kind',0,1,' image '),(126,'slug',0,1,''),(126,'title',0,1,' chamber of secrets full jacket '),(127,'filename',0,1,' half blood prince full jacket 1024x459 jpg '),(127,'extension',0,1,' jpg '),(127,'kind',0,1,' image '),(127,'slug',0,1,''),(127,'title',0,1,' half blood prince full jacket 1024x459 '),(128,'filename',0,1,' harry hallow jpg '),(128,'extension',0,1,' jpg '),(128,'kind',0,1,' image '),(128,'slug',0,1,''),(128,'title',0,1,' harry hallow '),(129,'filename',0,1,' harry potter and the order of the phoenix cover jpg '),(129,'extension',0,1,' jpg '),(129,'kind',0,1,' image '),(129,'slug',0,1,''),(129,'title',0,1,' harry potter and the order of the phoenix cover '),(130,'filename',0,1,' md 4b37c5837b6a harry potter quotes feature prisoner of azkaban cover jpg '),(130,'extension',0,1,' jpg '),(130,'kind',0,1,' image '),(130,'slug',0,1,''),(130,'title',0,1,' md 4b37c5837b6a harry potter quotes feature prisoner of azkaban cover '),(110,'slug',0,1,' the prisoner of azkaban '),(122,'slug',0,1,' the deathly hallows '),(104,'slug',0,1,' the sorcerers stone '),(138,'slug',0,1,''),(138,'field',2,1,' during the summer holidays with his aunt petunia and uncle vernon 15 year old harry potter and his cousin dudley are attacked by dementors after openly using magic to save dudley and himself harry is expelled from hogwarts but his expulsion is postponed pending a hearing at the ministry of magic harry is whisked off by a group of wizards including mad eye moody remus lupin and several new faces including nymphadora tonks a bubbly young metamorphmagus a witch or wizard who can change his or her appearance without a potion or spell and kingsley shacklebolt a senior auror to number 12 grimmauld place the childhood home of sirius black the building also serves as the headquarters of the order of the phoenix of which mr and mrs weasley and sirius are also members ron weasley and hermione granger explain that the order is a secret organisation led by hogwarts headmaster albus dumbledore dedicated to fighting lord voldemort and his followers the death eaters from the members of the order harry ron hermione ginny weasley and fred and george weasley learn that voldemort is seeking an object he did not have prior to his first defeat and assume this object to be a weapon of some sort harry learns the ministry of magic led by cornelius fudge is refusing to acknowledge voldemorts return because of the panic and chaos doing so would cause harry also learns the daily prophet has been running a smear campaign against him and dumbledore at the hearing harry is cleared when dumbledore provides evidence that harry was fully within his rights to use magic against the dementors with dumbledore calling into question how the creatures normally azkaban guards were let loose in suburban britain '),(141,'slug',0,1,''),(141,'field',2,1,' dumbledore picks harry up from his aunt and uncles house to escort him to the burrow home of harrys best friend ron weasley they detour to the home of horace slughorn former potions teacher at hogwarts and harry unwittingly helps persuade slughorn to teach harry and dumbledore proceed to the burrow where hermione granger has already arrived severus snape a member of the order of the phoenix meets with narcissa malfoy draco s mother and her sister bellatrix lestrange lord voldemort s faithful supporter narcissa expresses concern that her son might not survive a dangerous mission given to him by lord voldemort bellatrix believes snape will not help until he makes an unbreakable vow with narcissa swearing to assist draco on the hogwarts express harry discusses his suspicions of dracos allegiance with voldemort however ron and hermione are dubious harry dons his invisibility cloak and hides in the carriage that malfoy is seated in he overhears draco bragging to his friends about the mission voldemort has assigned him malfoy becomes suspicious that someone else is in the carriage and discovers harry he petrifies him and breaks his nose nymphadora tonks finds harry and escorts him to the castle dumbledore announces that snape will be teaching defence against the dark arts and slughorn will be potions master harry excels in potions using a textbook that once belonged to the half blood prince who wrote tips and spells in the book the half blood princes tips help harry win a bottle of felix felicis or liquid luck though harrys success pleases slughorn his newfound brilliance in potions angers hermione who feels he is not earning his grades believing harry needs to learn voldemorts past to gain advantage in a foretold battle dumbledore and harry use dumbledores pensieve to look at the memories of those who had direct contact with voldemort harry learns about voldemorts family and his foes evolution into a murderer obsessed with power and immortality dumbledore shows harry a memory involving slughorn conversing with the young tom riddle at hogwarts which has been tampered with he asks harry to convince slughorn to give him the true memory so that dumbledore can confirm his suspicions about voldemort '),(144,'slug',0,1,''),(144,'field',2,1,' following albus dumbledores death voldemort consolidates support and power including attempting to take control of the ministry of magic meanwhile harry is about to turn seventeen at which time he will lose the protection of his home members of the order of the phoenix explain the situation to the dursleys and move them to a new location for protection using several of harrys peers and friends as decoys the order plans to move harry to the burrow under protection by flying him there however the death eaters have been tipped off about this plan and the group is attacked upon departure in the ensuing battle mad eye moody and hedwig are killed and george weasley severely wounded voldemort himself arrives to kill harry but harrys wand fends him off of its own at the burrow harry ron and hermione make preparations to abandon hogwarts and hunt down voldemorts four remaining horcruxes but have few clues as to their identities and locations they also inherit strange bequests from among dumbledores possessions a golden snitch for harry a deluminator for ron and a book of short tales collectively called the tales of beedle the bard for hermione they are also bequeathed the sword of hogwarts co founder godric gryffindor which they learn has the power to destroy horcruxes but the ministry prevents them from receiving it during bill weasley and fleur delacours wedding the ministry of magic finally falls to voldemort with a death eater assuming the position of minister for magic and the wedding is attacked by death eaters harry ron and hermione flee to 12 grimmauld place in london the family home of sirius black that harry inherited a year before harry realizes that siriuss late brother regulus was the person who had stolen the real horcrux necklace and had hid it in the black house where it was stolen by the criminal and order associate mundungus fletcher with the help of the house elves dobby and kreacher the trio locate fletcher who had since had the locket taken from him by dolores umbridge a ministry official and harrys old nemesis harry ron and hermione infiltrate the ministry of magic and successfully steal the locket from umbridge but as they escape ron is injured and the grimmauld place safehouse is compromised forcing the three to hide out in the forest of dean there with no way to destroy the horcrux locket and no further leads they pass many weeks on the run living in fear and hearing little news from the outside world the piece of voldemorts soul within the locket exerts a negative emotional influence on all of them especially ron his injury fears for his family and existing insecurities are amplified leading him to abandon harry and hermione in a fit of rage '),(147,'slug',0,1,''),(147,'field',2,1,' in a prologue which harry sees through a dream the 3 riddles are murdered but they werent poisoned or hurt in anyway they were in perfect health but when they died they had a petrified face everyone suspects the caretaker frank bryce but he was released later on in harrys dream frank bryce muggle caretaker of an abandoned mansion known as the riddle house is murdered by lord voldemort after stumbling upon him and wormtail harry is awoken by his scar hurting the weasleys invite harry and hermione granger to the quidditch world cup to which they travel using a portkey meeting cedric diggory a hufflepuff sixth year on the way in the match ireland triumph over bulgaria despite the skill of bulgarias star seeker viktor krum various ministry of magic employees at the world cup discuss bertha jorkins a ministry worker who has gone missing her head of department the charismatic ludo bagman is unconcerned after the match men wearing the masks of death eaters followers of voldemort attack the camp site causing terror and abusing the muggle campsite owners the dark mark is fired into the sky causing mass panic harry discovers that his wand is missing it is later found in the possession of winky barty crouch s house elf and the wand is found to have been used to cast the mark although very few believe winky could have conjured the mark barty crouch dismisses winky from his service hermione angry at this injustice forms a society to promote house elf rights known as s p e w society for the promotion of elfish welfare at hogwarts professor dumbledore announces that alastor mad eye moody will be the defence against the dark arts teacher for the year dumbledore also announces that hogwarts will host a revival of the triwizard tournament in which a champion of hogwarts will compete against champions from two other european wizarding schools beauxbatons academy and durmstrang institute the champions are chosen by the goblet of fire from names dropped into it because harry is under 17 the age of majority in the wizarding world he is disallowed from entering '),(113,'title',0,1,' the goblet of fire '),(150,'slug',0,1,''),(150,'field',2,1,' harry is back at the dursleys for the summer holidays where he sees on muggle television that a convict named sirius black has escaped from prison after the dursleys aunt marge personally insults harry harry accidentally inflates her then runs away from home fearing expulsion from school after being picked up by the knight bus meeting stan shunpike and encountering a large black dog that seems to be watching him he travels to the leaky cauldron where cornelius fudge the minister for magic asks harry to stay in diagon alley for his own protection while there he meets his best friends ron weasley and hermione granger before leaving for hogwarts harry learns from arthur weasley that sirius black is a convicted murderer from the wizarding world and that black has escaped from the wizard prison azkaban to kill harry on the way to hogwarts a dementor an azkaban prison guard that feeds on positive thoughts boards the train causing harry to relive his parents deaths before fainting the new defence against the dark arts teacher remus lupin protects harry ron and hermione from the dementor they later learn dementors will be patrolling the school in an attempt to catch black although professor lupin is popular with his students the potions master snape seems to hate him while third years are allowed to visit the all wizarding village of hogsmeade on holiday harry is blocked from going because he has no permission slip from his legal guardian fred and george weasley give him the marauders map which is enchanted to show all passages and people on hogwarts grounds to sneak out lupin later catches harry with the map and reveals that it was made by his friend group the marauders back in their school days '),(153,'slug',0,1,''),(153,'field',2,1,' on harry potter s twelfth birthday the dursley family harrys uncle vernon aunt petunia and cousin dudley hold a dinner party for a potential client of vernons drill manufacturing company harry is not invited but is content to spend the evening quietly in his bedroom although he is confused why his school friends have not sent cards or presents however while in his room a house elf named dobby shows up at his house and warns him not to return to hogwarts and admits to intercepting harrys post from his friends having failed to persuade harry to voluntarily give up his place at hogwarts dobby then attempts to get him expelled by using magic to smash aunt petunias dessert on the kitchen floor and framing harry who is not allowed to use magic outside school uncle vernons business deal falls through but harry is given a second chance from the ministry of magic and allowed to return at the start of the school year in the meantime uncle vernon punishes harry fitting locks to his bedroom door and bars to the windows however harrys best friend ron weasley arrives with his twin brothers fred and george in their father arthur s enchanted ford anglia they rescue harry who stays at the weasleys family home the burrow for the remainder of his holidays harry and the other weasleys mother molly third eldest son percy and daughter ginny who has a crush on harry travel to diagon alley they are then reunited with hermione granger and introduced to lucius malfoy father of harrys school nemesis draco and gilderoy lockhart a conceited autobiographer who has been appointed defence against the dark arts professor after the death of professor quirrell when harry and ron approach platform 93 4 in kings cross station it refuses to allow them to pass they decide to fly arthurs car to hogwarts after missing the train when they cannot get through the barrier harry and ron crash into a whomping willow on the grounds in punishment for the crash ron cleans the school trophies and harry helps professor lockhart whose classes are chaotic with addressing his fan mail harry learns of some wizards prejudice about blood status in terms of pure blood only wizarding heritage and those with muggle non magical parentage he is alone in hearing an unnerving voice seemingly coming from the walls of the school itself during a deathday party for gryffindor houses ghost nearly headless nick harry ron and hermione run into the school caretaker argus filch s petrified cat mrs norris along with a warning scrawled on the wall the chamber of secrets has been opened enemies of the heir beware '),(107,'title',0,1,' the chamber of secrets '),(156,'slug',0,1,''),(156,'field',2,1,' harry potter has been living an ordinary life constantly abused by his surly and cold aunt and uncle vernon and petunia dursley and bullied by their spoiled son dudley since the death of his parents ten years prior his life changes on the day of his eleventh birthday when he receives a letter of acceptance into hogwarts school of witchcraft and wizardry delivered by a half giant named rubeus hagrid after previous letters had been destroyed by vernon and petunia hagrid details harrys past as the son of james and lily potter who were a wizard and witch respectively and how they were murdered by the most evil and powerful dark wizard of all time lord voldemort which resulted in the one year old harry being sent to live with his aunt and uncle voldemort was not only unable to kill harry but his powers were also destroyed in the attempt forcing him into exile and sparking harrys immense fame among the magical community hagrid introduces harry to the wizarding world by bringing him to diagon alley a hidden street in london where harry uncovers a fortune left to him by his parents at gringotts wizarding bank receives a pet owl hedwig various school supplies and a wand which he learns shares a core from the same source as voldemorts wand there he is surprised to discover how famous he truly is among witches and wizards as the boy who lived a month later harry leaves the dursleys home to catch the hogwarts express from kings cross railway station s secret hogwarts platform platform ​9 3 4 on the train he quickly befriends fellow first year ronald weasley and the two boys meet hermione granger whose snobbiness and affinity for spells initially causes the two boys to dislike her there harry also makes an enemy of yet another first year draco malfoy who shows prejudice against ron for his familys financial difficulties ');
/*!40000 ALTER TABLE `searchindex` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `sections`
--

LOCK TABLES `sections` WRITE;
/*!40000 ALTER TABLE `sections` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `sections` VALUES (1,3,'Pages','pages','structure',0,'all',NULL,'2020-02-05 22:49:39','2020-05-02 04:52:05',NULL,'b0ac9541-cb53-4dc6-86e4-56cb0604c874'),(2,1,'Panels','panels','structure',0,'all',NULL,'2020-04-18 19:49:33','2020-05-02 04:51:10',NULL,'34bba139-c036-4e65-a8c0-bf6c451a4e12'),(3,2,'Sidebars','sidebars','structure',0,'all',NULL,'2020-05-02 04:51:34','2020-05-02 04:51:34',NULL,'5deeb93f-33f2-42e4-ba35-4b9afe03c4b3'),(4,NULL,'News','news','channel',1,'all',NULL,'2020-05-03 04:19:03','2020-05-03 04:19:03',NULL,'f52621ed-e4a9-4525-93f8-a804b6e72dfc');
/*!40000 ALTER TABLE `sections` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `sections_sites`
--

LOCK TABLES `sections_sites` WRITE;
/*!40000 ALTER TABLE `sections_sites` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `sections_sites` VALUES (1,1,1,1,'{slug}','_pages',1,'2020-02-05 22:49:39','2020-05-03 07:05:15','6ce7b4e4-cc78-4d49-8717-47fe8cddce90'),(2,2,1,0,NULL,NULL,1,'2020-04-18 19:49:33','2020-04-18 19:49:33','e30f6d9f-65db-445f-9593-de7d44fbc21a'),(3,3,1,0,NULL,NULL,1,'2020-05-02 04:51:34','2020-05-02 04:51:34','3f7d1846-9cd8-4397-8a62-c30b494ecf62'),(4,4,1,1,'news/{slug}','_pages/news-article',1,'2020-05-03 04:19:03','2020-05-17 04:49:43','8b6d7a2f-688c-498d-bf1c-25ba8fbdd744');
/*!40000 ALTER TABLE `sections_sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `sequences`
--

LOCK TABLES `sequences` WRITE;
/*!40000 ALTER TABLE `sequences` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `sequences` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `shunnedmessages`
--

LOCK TABLES `shunnedmessages` WRITE;
/*!40000 ALTER TABLE `shunnedmessages` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `shunnedmessages` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `sitegroups`
--

LOCK TABLES `sitegroups` WRITE;
/*!40000 ALTER TABLE `sitegroups` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `sitegroups` VALUES (1,'Starter Site','2020-02-05 21:43:45','2020-05-23 19:54:19',NULL,'57cd948a-2dfe-4550-b0f2-053ee01da77c');
/*!40000 ALTER TABLE `sitegroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `sites`
--

LOCK TABLES `sites` WRITE;
/*!40000 ALTER TABLE `sites` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `sites` VALUES (1,1,1,'Starter Site','default','en-US',1,'http://$DEFAULT_SITE_URL',1,'2020-02-05 21:43:45','2020-05-23 19:54:30',NULL,'1891a55f-7f04-4fc8-abfd-3fd84207d90b');
/*!40000 ALTER TABLE `sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `structureelements`
--

LOCK TABLES `structureelements` WRITE;
/*!40000 ALTER TABLE `structureelements` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `structureelements` VALUES (1,1,NULL,1,1,6,0,'2020-04-25 18:38:13','2020-05-03 05:06:58','975930a5-19d0-4d92-8a75-aef22610d6b2'),(2,1,76,1,2,3,1,'2020-04-25 18:38:13','2020-05-03 05:04:38','faea4e63-97d6-4a8d-9636-a50b207b7759'),(4,3,NULL,4,1,12,0,'2020-05-02 04:52:05','2020-05-17 06:29:58','61d98887-a1d9-4868-bde9-f7c8bfd61336'),(5,3,37,4,2,3,1,'2020-05-02 04:52:05','2020-05-02 04:52:05','5be68846-8769-4e6d-aad8-d0a0e42e84d6'),(6,3,45,4,10,11,1,'2020-05-02 04:52:05','2020-05-17 06:29:58','034009a0-5b1d-471c-8b90-88ab18214149'),(7,3,60,4,4,5,1,'2020-05-02 04:52:05','2020-05-03 07:25:09','3fd941d1-105a-4161-8ed0-cd357c860be1'),(8,3,73,4,8,9,1,'2020-05-02 04:52:05','2020-05-17 06:29:58','cd7e9117-b97c-4c3e-b16d-16a52fff3b5d'),(9,1,86,1,4,5,1,'2020-05-03 05:06:58','2020-05-03 05:06:58','288a454b-ea3d-436e-8c7c-4c4e9146f720'),(10,2,NULL,10,1,6,0,'2020-05-03 06:41:08','2020-05-03 07:03:22','e025a247-0301-4bcf-95da-9d5036c0a369'),(11,2,87,10,2,3,1,'2020-05-03 06:41:08','2020-05-03 06:41:08','e22759b6-e469-425b-9df2-196d8864fe82'),(13,2,89,10,4,5,1,'2020-05-03 07:03:22','2020-05-03 07:03:22','e98e42db-ef7c-40ab-8f2c-d8d2b482e27d'),(15,3,99,4,6,7,1,'2020-05-17 04:55:59','2020-05-17 06:29:58','93a9746e-d321-4e95-b324-cad23ab0649e');
/*!40000 ALTER TABLE `structureelements` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `structures`
--

LOCK TABLES `structures` WRITE;
/*!40000 ALTER TABLE `structures` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `structures` VALUES (1,1,'2020-04-25 18:38:13','2020-04-25 18:38:13',NULL,'0ced5d36-9bb5-4ff3-b633-c9f7f03b2d87'),(2,1,'2020-05-02 04:51:34','2020-05-02 04:51:34',NULL,'8db9bbbb-3fc5-4f53-bf3d-3860898519fd'),(3,1,'2020-05-02 04:52:05','2020-05-02 04:52:05',NULL,'a87223af-56f5-4672-933f-b0f26e915594');
/*!40000 ALTER TABLE `structures` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `systemmessages`
--

LOCK TABLES `systemmessages` WRITE;
/*!40000 ALTER TABLE `systemmessages` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `systemmessages` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `taggroups`
--

LOCK TABLES `taggroups` WRITE;
/*!40000 ALTER TABLE `taggroups` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `taggroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `tags`
--

LOCK TABLES `tags` WRITE;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `tags` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `tokens`
--

LOCK TABLES `tokens` WRITE;
/*!40000 ALTER TABLE `tokens` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `tokens` VALUES (2,'tHuHoLBDzzQOkJtE8zwwr6ZF8-kNseFF','[\"preview/preview\",{\"elementType\":\"craft\\\\elements\\\\Entry\",\"sourceId\":60,\"siteId\":1,\"draftId\":14,\"revisionId\":null}]',NULL,NULL,'2020-04-13 04:59:12','2020-04-12 04:59:12','2020-04-12 04:59:12','50c1f9ca-c58a-4e7f-99fe-ece9ef6526ec'),(3,'FTCdYDZF0HlKcKi583zNQdbgEK1JI8vS','[\"preview/preview\",{\"elementType\":\"craft\\\\elements\\\\Entry\",\"sourceId\":60,\"siteId\":1,\"draftId\":15,\"revisionId\":null}]',NULL,NULL,'2020-04-13 05:00:36','2020-04-12 05:00:36','2020-04-12 05:00:36','6a14047f-249e-404c-9114-6c380a1eddef');
/*!40000 ALTER TABLE `tokens` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `usergroups`
--

LOCK TABLES `usergroups` WRITE;
/*!40000 ALTER TABLE `usergroups` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `usergroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `usergroups_users`
--

LOCK TABLES `usergroups_users` WRITE;
/*!40000 ALTER TABLE `usergroups_users` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `usergroups_users` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `userpermissions`
--

LOCK TABLES `userpermissions` WRITE;
/*!40000 ALTER TABLE `userpermissions` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `userpermissions` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `userpermissions_usergroups`
--

LOCK TABLES `userpermissions_usergroups` WRITE;
/*!40000 ALTER TABLE `userpermissions_usergroups` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `userpermissions_usergroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `userpermissions_users`
--

LOCK TABLES `userpermissions_users` WRITE;
/*!40000 ALTER TABLE `userpermissions_users` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `userpermissions_users` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `userpreferences`
--

LOCK TABLES `userpreferences` WRITE;
/*!40000 ALTER TABLE `userpreferences` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `userpreferences` VALUES (1,'{\"language\":\"en-US\",\"weekStartDay\":\"0\",\"enableDebugToolbarForSite\":false,\"enableDebugToolbarForCp\":false,\"showExceptionView\":true,\"profileTemplates\":true}');
/*!40000 ALTER TABLE `userpreferences` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `users` VALUES (1,'support@doublesecretagency.com',NULL,'','','support@doublesecretagency.com','$2y$13$rQ8/xG8Jz9ZqurEzNBUFcetb0g04Rnob.1xOWqjiBNcnvNxmQ9msS',1,0,0,0,'2020-05-23 20:00:40',NULL,NULL,NULL,'2020-02-05 21:43:56',NULL,1,NULL,NULL,NULL,0,'2020-02-05 21:43:45','2020-02-05 21:43:45','2020-05-23 20:00:40','6fe58302-4703-4c94-ab59-b431c6231623');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `volumefolders`
--

LOCK TABLES `volumefolders` WRITE;
/*!40000 ALTER TABLE `volumefolders` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `volumefolders` VALUES (1,NULL,NULL,'Temporary source',NULL,'2020-04-10 06:44:51','2020-04-10 06:44:51','ec03da59-7e70-422d-8869-e82e0c01b75c'),(2,1,NULL,'user_1','user_1/','2020-04-10 06:44:51','2020-04-10 06:44:51','64389f66-a9e7-40b4-bf43-faa712d8b430'),(3,NULL,1,'Body','','2020-04-10 07:04:44','2020-05-03 04:20:53','6a965c82-81dd-44ca-a170-1445d0e9d33f'),(5,NULL,2,'Hero Images','','2020-05-03 04:20:31','2020-05-03 04:20:31','1d0fa6c4-5bdd-4af8-b18f-f3b1ceb0813e');
/*!40000 ALTER TABLE `volumefolders` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `volumes`
--

LOCK TABLES `volumes` WRITE;
/*!40000 ALTER TABLE `volumes` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `volumes` VALUES (1,NULL,'Body','body','craft\\volumes\\Local',1,'@assetsUrl/body','{\"path\":\"@assetsPath/body\"}',1,'2020-04-10 07:04:44','2020-05-03 04:20:53',NULL,'5ebe069f-09ab-4250-8880-37a3a169ab68'),(2,NULL,'Hero Images','heroImages','craft\\volumes\\Local',1,'@assetsUrl/hero-images','{\"path\":\"@assetsPath/hero-images\"}',2,'2020-05-03 04:20:31','2020-05-03 04:20:31',NULL,'1ca271c4-3b66-436a-a488-8a678cda224f');
/*!40000 ALTER TABLE `volumes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `widgets`
--

LOCK TABLES `widgets` WRITE;
/*!40000 ALTER TABLE `widgets` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `widgets` VALUES (1,1,'craft\\widgets\\RecentEntries',1,NULL,'{\"section\":\"*\",\"siteId\":\"1\",\"limit\":10}',1,'2020-02-05 21:45:26','2020-02-05 21:45:26','fb4fe2e9-4c3b-4856-bbc8-ae2f182fcb7c'),(2,1,'craft\\widgets\\CraftSupport',2,NULL,'[]',1,'2020-02-05 21:45:26','2020-02-05 21:45:26','8f356c6f-fcc9-4545-ab8b-498bb2a8defc'),(3,1,'craft\\widgets\\Updates',3,NULL,'[]',1,'2020-02-05 21:45:26','2020-02-05 21:45:26','80aa0c5e-a559-48eb-9a6d-f8dc85a5c49d'),(4,1,'craft\\widgets\\Feed',4,NULL,'{\"url\":\"https://craftcms.com/news.rss\",\"title\":\"Craft News\",\"limit\":5}',1,'2020-02-05 21:45:26','2020-02-05 21:45:26','8a807d74-ebc9-48e4-8f77-b73fe0651431');
/*!40000 ALTER TABLE `widgets` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping routines for database 'sandbox_starter'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-05-23 13:06:47
