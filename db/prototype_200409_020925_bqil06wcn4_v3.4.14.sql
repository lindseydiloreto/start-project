-- MariaDB dump 10.17  Distrib 10.4.11-MariaDB, for osx10.14 (x86_64)
--
-- Host: 127.0.0.1    Database: support_prototype
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
  PRIMARY KEY (`id`),
  UNIQUE KEY `content_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `content_siteId_idx` (`siteId`),
  KEY `content_title_idx` (`title`),
  CONSTRAINT `content_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `content_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=82 DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
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
  `field_embed_margin` varchar(255) DEFAULT NULL,
  `field_embed_padding` varchar(255) DEFAULT NULL,
  `field_image_margin` varchar(255) DEFAULT NULL,
  `field_image_padding` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `matrixcontent_panels_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `matrixcontent_panels_siteId_fk` (`siteId`),
  CONSTRAINT `matrixcontent_panels_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixcontent_panels_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=174 DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
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
-- Table structure for table `spoon_blocktypes`
--

DROP TABLE IF EXISTS `spoon_blocktypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spoon_blocktypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldId` int(11) NOT NULL,
  `matrixBlockTypeId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `groupName` varchar(255) NOT NULL DEFAULT '',
  `context` varchar(255) NOT NULL DEFAULT '',
  `groupSortOrder` smallint(6) unsigned DEFAULT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `spoon_blocktypes_fieldId_idx` (`fieldId`),
  KEY `spoon_blocktypes_matrixBlockTypeId_idx` (`matrixBlockTypeId`),
  KEY `spoon_blocktypes_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `spoon_blocktypes_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `spoon_blocktypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `spoon_blocktypes_matrixBlockTypeId_fk` FOREIGN KEY (`matrixBlockTypeId`) REFERENCES `matrixblocktypes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
-- Dumping routines for database 'support_prototype'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-04-08 19:09:25
-- MariaDB dump 10.17  Distrib 10.4.11-MariaDB, for osx10.14 (x86_64)
--
-- Host: 127.0.0.1    Database: support_prototype
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
/*!40000 ALTER TABLE `assets` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `assettransforms`
--

LOCK TABLES `assettransforms` WRITE;
/*!40000 ALTER TABLE `assettransforms` DISABLE KEYS */;
set autocommit=0;
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
/*!40000 ALTER TABLE `changedattributes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `changedfields`
--

LOCK TABLES `changedfields` WRITE;
/*!40000 ALTER TABLE `changedfields` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `changedfields` VALUES (37,1,1,'2020-02-05 23:42:26',0,1);
/*!40000 ALTER TABLE `changedfields` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `content`
--

LOCK TABLES `content` WRITE;
/*!40000 ALTER TABLE `content` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `content` VALUES (1,1,1,NULL,'2020-02-05 21:43:45','2020-02-05 21:43:45','4d29c7db-1296-4966-9acb-9a9ea7ecfe65'),(2,2,1,NULL,'2020-02-05 22:50:05','2020-02-05 22:50:09','748a7aad-02aa-4305-9aef-dd66a94e2096'),(3,4,1,NULL,'2020-02-05 22:50:46','2020-02-05 22:51:10','ef840b66-a893-4f45-b85d-6fcc19ef97b2'),(4,14,1,NULL,'2020-02-05 22:52:06','2020-02-05 22:52:10','ba671378-45cd-4589-8710-5fd09da935dc'),(5,16,1,NULL,'2020-02-05 22:52:42','2020-02-05 22:52:44','4ed9e5e6-4718-4c19-8a34-3e5487eab1a3'),(6,18,1,NULL,'2020-02-05 23:21:09','2020-02-05 23:21:09','1c4b3dce-18be-4c83-a018-9452f91bf241'),(7,19,1,NULL,'2020-02-05 23:25:26','2020-02-05 23:27:19','5291d0c8-8768-4fa4-86b6-7c176a0a3e10'),(8,29,1,'E','2020-02-05 23:33:22','2020-02-05 23:33:27','e40bde1a-a472-49db-ae8b-546336f243d1'),(10,37,1,'Lorem Ipsum','2020-02-05 23:34:00','2020-02-05 23:42:26','24fb4f9a-da53-45b2-be81-877aa787f657');
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
INSERT INTO `drafts` VALUES (1,NULL,1,'First draft','',0,NULL),(2,NULL,1,'First draft','',0,NULL),(3,NULL,1,'First draft','',0,NULL),(4,NULL,1,'First draft','',0,NULL),(5,NULL,1,'First draft',NULL,0,NULL),(6,NULL,1,'First draft','',0,NULL),(7,NULL,1,'First draft','',0,NULL);
/*!40000 ALTER TABLE `drafts` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `elementindexsettings`
--

LOCK TABLES `elementindexsettings` WRITE;
/*!40000 ALTER TABLE `elementindexsettings` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `elementindexsettings` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `elements`
--

LOCK TABLES `elements` WRITE;
/*!40000 ALTER TABLE `elements` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `elements` VALUES (1,NULL,NULL,NULL,'craft\\elements\\User',1,0,'2020-02-05 21:43:45','2020-02-05 21:43:45',NULL,'4c876527-4467-449e-b53b-a0bef475edd9'),(2,1,NULL,3,'craft\\elements\\Entry',1,0,'2020-02-05 22:50:05','2020-02-05 22:50:09',NULL,'eefdb1c9-cab5-445b-b8f8-0d187a40d276'),(3,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-02-05 22:50:09','2020-02-05 22:50:09',NULL,'7bf2ed3f-53f2-429f-993b-22c71ffd3563'),(4,2,NULL,3,'craft\\elements\\Entry',1,0,'2020-02-05 22:50:46','2020-02-05 22:51:10',NULL,'80d0c265-efcb-4768-92e4-4f5ab560e1e2'),(5,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-02-05 22:50:49','2020-02-05 22:50:49','2020-02-05 22:50:59','67a86fc8-4851-4543-99d0-de40d9b8393a'),(6,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-02-05 22:50:59','2020-02-05 22:50:59','2020-02-05 22:51:00','16587711-9f52-4981-9494-e86f1b629c9e'),(7,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-02-05 22:51:00','2020-02-05 22:51:00','2020-02-05 22:51:02','c60e2468-588f-4a00-a9ca-6c358b26e3ba'),(8,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-02-05 22:51:02','2020-02-05 22:51:02','2020-02-05 22:51:03','4279fd60-b679-4685-ac2f-fcd8d13dcd35'),(9,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-02-05 22:51:03','2020-02-05 22:51:03','2020-02-05 22:51:05','87f95247-60ea-4ff2-86cc-c9b96239e074'),(10,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-02-05 22:51:05','2020-02-05 22:51:05','2020-02-05 22:51:07','d35fd5f1-0437-41a3-9c29-7404d7dad313'),(11,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-02-05 22:51:07','2020-02-05 22:51:07','2020-02-05 22:51:09','241ade6b-f18a-4da2-8fff-5e5f7912db47'),(12,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-02-05 22:51:09','2020-02-05 22:51:09','2020-02-05 22:51:10','90b739e6-936d-44b4-bcb2-43bf17914433'),(13,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-02-05 22:51:10','2020-02-05 22:51:10',NULL,'577b0675-1e0b-4a7c-9b50-92898466f03c'),(14,3,NULL,3,'craft\\elements\\Entry',1,0,'2020-02-05 22:52:06','2020-02-05 22:52:10',NULL,'05a0bb71-49f9-47be-87a4-54a978ec0960'),(15,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-02-05 22:52:10','2020-02-05 22:52:10',NULL,'04f8dceb-52ed-43e2-bd11-3ba42abc2e78'),(16,4,NULL,3,'craft\\elements\\Entry',1,0,'2020-02-05 22:52:42','2020-02-05 22:52:44',NULL,'b0931fa0-bc0b-44a6-a645-307085127020'),(17,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-02-05 22:52:44','2020-02-05 22:52:44',NULL,'b5682ca0-136c-40c1-8a57-dee2c61ddaa2'),(18,5,NULL,3,'craft\\elements\\Entry',1,0,'2020-02-05 23:21:09','2020-02-05 23:21:09',NULL,'3012a4aa-2aa5-41e9-81b5-0cc80046ceab'),(19,6,NULL,3,'craft\\elements\\Entry',1,0,'2020-02-05 23:25:26','2020-02-05 23:27:19',NULL,'e13466e4-61ce-4069-b8b4-427489a8c32b'),(20,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-02-05 23:25:29','2020-02-05 23:25:29','2020-02-05 23:25:31','0f751371-9d00-4a38-9302-84555406e867'),(21,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-02-05 23:25:31','2020-02-05 23:25:31','2020-02-05 23:27:09','e2b82e95-3019-4624-94f6-2d3ee0251ee3'),(22,NULL,NULL,5,'craft\\elements\\MatrixBlock',1,0,'2020-02-05 23:25:31','2020-02-05 23:25:31','2020-02-05 23:27:09','b31a173c-1bec-43f7-9a61-052b4019f279'),(23,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-02-05 23:27:09','2020-02-05 23:27:09','2020-02-05 23:27:18','6cca0825-a208-43f0-a8d0-c45daa9ea762'),(24,NULL,NULL,5,'craft\\elements\\MatrixBlock',1,0,'2020-02-05 23:27:09','2020-02-05 23:27:09','2020-02-05 23:27:18','8bfbf9b7-9cc8-4068-ae4e-38883e22dc34'),(25,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-02-05 23:27:17','2020-02-05 23:27:17','2020-02-05 23:27:19','9e0127dd-b0b4-452e-b39e-2feb3949d67b'),(26,NULL,NULL,5,'craft\\elements\\MatrixBlock',1,0,'2020-02-05 23:27:17','2020-02-05 23:27:17','2020-02-05 23:27:19','c3af2bc8-476c-4152-a726-d99cfd83d064'),(27,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-02-05 23:27:19','2020-02-05 23:27:19',NULL,'eb4aa375-e4b8-4d4e-b883-6fa93ddfd8e0'),(28,NULL,NULL,5,'craft\\elements\\MatrixBlock',1,0,'2020-02-05 23:27:19','2020-02-05 23:27:19',NULL,'f3501799-7a32-4ba9-a135-fdd9c4b50f93'),(29,7,NULL,3,'craft\\elements\\Entry',1,0,'2020-02-05 23:33:22','2020-02-05 23:33:27',NULL,'01da47e4-61a9-4064-a2a5-deda56c31c6c'),(31,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-02-05 23:33:42','2020-02-05 23:33:42','2020-02-05 23:33:45','fd283086-413e-4184-8d08-fc31f90ce927'),(32,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-02-05 23:33:45','2020-02-05 23:33:45','2020-02-05 23:33:47','b17f40bc-1fcf-4458-b722-45e11183bb99'),(33,NULL,NULL,5,'craft\\elements\\MatrixBlock',1,0,'2020-02-05 23:33:45','2020-02-05 23:33:45','2020-02-05 23:33:47','b7796cdb-371e-48b4-914b-d7f47c6e49c9'),(37,NULL,NULL,3,'craft\\elements\\Entry',1,0,'2020-02-05 23:34:00','2020-02-05 23:42:26',NULL,'c2c319a1-8865-4b2f-bd7e-fddcb876b011'),(38,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2020-02-05 23:34:00','2020-02-05 23:40:14',NULL,'3a64f542-c06c-4d4c-a202-700789042351'),(39,NULL,NULL,5,'craft\\elements\\MatrixBlock',1,0,'2020-02-05 23:34:00','2020-02-05 23:42:26',NULL,'c1640def-0865-4ecd-a689-4a7553730783'),(40,NULL,NULL,7,'craft\\elements\\MatrixBlock',1,0,'2020-02-05 23:34:00','2020-02-05 23:33:47',NULL,'8230b28a-861d-4ee6-b07d-e310b98db060');
/*!40000 ALTER TABLE `elements` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `elements_sites`
--

LOCK TABLES `elements_sites` WRITE;
/*!40000 ALTER TABLE `elements_sites` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `elements_sites` VALUES (1,1,1,NULL,NULL,1,'2020-02-05 21:43:45','2020-02-05 21:43:45','36c4adcb-519e-4ba7-8d65-16bc7c5a87ca'),(2,2,1,'__temp_mUYmBKyWLn4FjcspJqXd5yCGG4z1lJRMQCG0','articles/__temp_mUYmBKyWLn4FjcspJqXd5yCGG4z1lJRMQCG0',1,'2020-02-05 22:50:05','2020-02-05 22:50:05','29a90317-3f14-4bb4-b855-c2df0d3968e2'),(3,3,1,NULL,NULL,1,'2020-02-05 22:50:09','2020-02-05 22:50:09','446ce34a-bd67-4f42-80e5-0f4f6b3004a2'),(4,4,1,'__temp_zadVDdeB5DtE1PbEkRBQjp0707qud8pcIH6S','articles/__temp_zadVDdeB5DtE1PbEkRBQjp0707qud8pcIH6S',1,'2020-02-05 22:50:46','2020-02-05 22:50:46','06b3646e-3448-4742-85b8-4e80bd2b68ae'),(5,5,1,NULL,NULL,1,'2020-02-05 22:50:49','2020-02-05 22:50:49','37ba3049-dfd6-4cfd-ab86-b253f3dd44c1'),(6,6,1,NULL,NULL,1,'2020-02-05 22:50:59','2020-02-05 22:50:59','4a86a6bf-510c-4b6b-b0f8-fa719dee5c81'),(7,7,1,NULL,NULL,1,'2020-02-05 22:51:00','2020-02-05 22:51:00','58ed740b-4b85-4c49-88e2-a671ebd5269c'),(8,8,1,NULL,NULL,1,'2020-02-05 22:51:02','2020-02-05 22:51:02','ee60dabb-dd87-4bd4-bc7f-a3f2a951ac7c'),(9,9,1,NULL,NULL,1,'2020-02-05 22:51:03','2020-02-05 22:51:03','fbed8a47-fb96-4008-8d0b-284395e8c5c3'),(10,10,1,NULL,NULL,1,'2020-02-05 22:51:05','2020-02-05 22:51:05','41bb8554-7a20-47ea-8d16-5e3858836430'),(11,11,1,NULL,NULL,1,'2020-02-05 22:51:07','2020-02-05 22:51:07','4903d9db-2d55-4a6c-ae93-9a3cc075accb'),(12,12,1,NULL,NULL,1,'2020-02-05 22:51:09','2020-02-05 22:51:09','15f429d4-6ee5-41fe-bef5-c88983101c57'),(13,13,1,NULL,NULL,1,'2020-02-05 22:51:10','2020-02-05 22:51:10','35f5bbed-bd7b-4e8a-99a2-05a1543cd38f'),(14,14,1,'__temp_J0Pl9McXcguxswliNuBMdrqMUmkoUcT0sGjk','articles/__temp_J0Pl9McXcguxswliNuBMdrqMUmkoUcT0sGjk',1,'2020-02-05 22:52:06','2020-02-05 22:52:06','6be9176e-1b0a-4a67-a084-d90c27a3f23e'),(15,15,1,NULL,NULL,1,'2020-02-05 22:52:10','2020-02-05 22:52:10','e9be5f17-14fc-4ea3-836f-968d4a34cc98'),(16,16,1,'__temp_oZxhD4MNt8AAjWtgdXEvFAATS9kNjBHOiH2O','articles/__temp_oZxhD4MNt8AAjWtgdXEvFAATS9kNjBHOiH2O',1,'2020-02-05 22:52:42','2020-02-05 22:52:42','770f39f2-6b4a-4362-b2f1-3944a68f46ab'),(17,17,1,NULL,NULL,1,'2020-02-05 22:52:44','2020-02-05 22:52:44','48d3b8e4-44b2-47d8-95e1-5f15ec5e7de2'),(18,18,1,'__temp_UTK8A6P8jvoO13v4jxuoVmfyCupcHlstjmge','articles/__temp_UTK8A6P8jvoO13v4jxuoVmfyCupcHlstjmge',1,'2020-02-05 23:21:09','2020-02-05 23:21:09','f85137de-cfe9-436f-9513-95776e35c7fb'),(19,19,1,'__temp_6JqsktBc1you6Tb3Dirql3nb4gGqJbe2HP99','articles/__temp_6JqsktBc1you6Tb3Dirql3nb4gGqJbe2HP99',1,'2020-02-05 23:25:26','2020-02-05 23:25:26','ed991591-ebad-47e0-8228-8292e5adbbbe'),(20,20,1,NULL,NULL,1,'2020-02-05 23:25:29','2020-02-05 23:25:29','0377712b-00a5-449d-b6be-0ec6fe6f7608'),(21,21,1,NULL,NULL,1,'2020-02-05 23:25:31','2020-02-05 23:25:31','27332f6d-bc1a-4dc5-ab5b-a592d2704c31'),(22,22,1,NULL,NULL,1,'2020-02-05 23:25:31','2020-02-05 23:25:31','9753e7d2-72c6-4233-95aa-9ec46e4e5ab5'),(23,23,1,NULL,NULL,1,'2020-02-05 23:27:09','2020-02-05 23:27:09','177c9de8-c4f8-41a1-88be-67b4c1185ade'),(24,24,1,NULL,NULL,1,'2020-02-05 23:27:09','2020-02-05 23:27:09','b559e441-73fe-438d-ada1-a462f2f91abe'),(25,25,1,NULL,NULL,1,'2020-02-05 23:27:17','2020-02-05 23:27:17','166dc6e9-03e4-4ee0-bd85-cee43082ef00'),(26,26,1,NULL,NULL,1,'2020-02-05 23:27:17','2020-02-05 23:27:17','cfcd6465-619c-4a66-baa5-e340d9ad9601'),(27,27,1,NULL,NULL,1,'2020-02-05 23:27:19','2020-02-05 23:27:19','c071e048-ece0-4d41-a564-95362df7b04d'),(28,28,1,NULL,NULL,1,'2020-02-05 23:27:19','2020-02-05 23:27:19','7f6b330e-3fa6-4a1b-a2c0-0de548857a47'),(29,29,1,'__temp_1qmY2OeSQ1HVeYfPj3JklG50U6H2u2CfXXx0','articles/__temp_1qmY2OeSQ1HVeYfPj3JklG50U6H2u2CfXXx0',1,'2020-02-05 23:33:22','2020-02-05 23:33:27','765558b6-8007-4f9b-9624-388ea0861a8b'),(31,31,1,NULL,NULL,1,'2020-02-05 23:33:42','2020-02-05 23:33:42','1e386722-ee6d-4aab-8df5-403cf545e718'),(32,32,1,NULL,NULL,1,'2020-02-05 23:33:45','2020-02-05 23:33:45','d345fd29-8645-445b-94a2-d85bc8f17d43'),(33,33,1,NULL,NULL,1,'2020-02-05 23:33:45','2020-02-05 23:33:45','904e1b95-5035-4987-b0e3-7990dbb75f72'),(37,37,1,'lorem-ipsum','articles/lorem-ipsum',1,'2020-02-05 23:34:00','2020-02-05 23:34:00','7d70a09d-3789-4e9e-b66c-9305d2eaf4ac'),(38,38,1,NULL,NULL,1,'2020-02-05 23:34:00','2020-02-05 23:34:00','65db8e1f-fd6d-4685-9265-1228b726a649'),(39,39,1,NULL,NULL,1,'2020-02-05 23:34:00','2020-02-05 23:34:00','c39465c2-6cd5-4b32-a53d-82fc18c15b67'),(40,40,1,NULL,NULL,1,'2020-02-05 23:34:00','2020-02-05 23:34:00','fa722f0b-4c1e-4b3d-8647-68c1c9913c81');
/*!40000 ALTER TABLE `elements_sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `entries`
--

LOCK TABLES `entries` WRITE;
/*!40000 ALTER TABLE `entries` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `entries` VALUES (2,1,NULL,1,1,'2020-02-05 22:50:00',NULL,NULL,'2020-02-05 22:50:05','2020-02-05 22:50:05','d64a4852-2d66-4155-8362-5c9b1678f651'),(4,1,NULL,1,1,'2020-02-05 22:50:00',NULL,NULL,'2020-02-05 22:50:46','2020-02-05 22:50:46','68916d02-f7a7-427a-bbac-b79fe27378a9'),(14,1,NULL,1,1,'2020-02-05 22:52:00',NULL,NULL,'2020-02-05 22:52:06','2020-02-05 22:52:06','59fe9c91-1f90-43b2-9da5-322909d18fd5'),(16,1,NULL,1,1,'2020-02-05 22:52:00',NULL,NULL,'2020-02-05 22:52:42','2020-02-05 22:52:42','c6866448-e2fa-440a-b204-b9ac5cc0375b'),(18,1,NULL,1,1,'2020-02-05 23:21:00',NULL,NULL,'2020-02-05 23:21:09','2020-02-05 23:21:09','dde37ec1-af91-47c1-98b2-91e622333460'),(19,1,NULL,1,1,'2020-02-05 23:25:00',NULL,NULL,'2020-02-05 23:25:26','2020-02-05 23:25:26','b533cd31-b029-4e03-a02f-4a68a71b1abf'),(29,1,NULL,1,1,'2020-02-05 23:33:00',NULL,NULL,'2020-02-05 23:33:22','2020-02-05 23:33:22','e224d332-5b84-4904-8a68-eb1e8a5e191c'),(37,1,NULL,1,1,'2020-02-05 23:33:00',NULL,NULL,'2020-02-05 23:34:00','2020-02-05 23:34:00','60ceb163-cda9-4c7c-874d-f9a00d6ebed0');
/*!40000 ALTER TABLE `entries` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `entrytypes`
--

LOCK TABLES `entrytypes` WRITE;
/*!40000 ALTER TABLE `entrytypes` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `entrytypes` VALUES (1,1,3,'Articles','articles',1,'Title','',1,'2020-02-05 22:49:39','2020-02-05 22:49:59',NULL,'e8ee1969-bc9d-4366-919d-bd9d88737188');
/*!40000 ALTER TABLE `entrytypes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `fieldgroups`
--

LOCK TABLES `fieldgroups` WRITE;
/*!40000 ALTER TABLE `fieldgroups` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `fieldgroups` VALUES (1,'Dropdown','2020-02-05 21:43:45','2020-02-05 22:43:29','a49a5b87-47ff-421f-94c5-d11727a48206'),(2,'Matrix','2020-02-05 21:45:50','2020-02-05 21:45:50','18d36d4e-9c72-4fcf-97a1-a668b70fd249');
/*!40000 ALTER TABLE `fieldgroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `fieldlayoutfields`
--

LOCK TABLES `fieldlayoutfields` WRITE;
/*!40000 ALTER TABLE `fieldlayoutfields` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `fieldlayoutfields` VALUES (5,2,3,2,0,1,'2020-02-05 22:49:07','2020-02-05 22:49:07','d68fe417-543c-420d-8ef9-74c117a0d01b'),(6,2,4,4,0,1,'2020-02-05 22:49:07','2020-02-05 22:49:07','fb4e8bdf-e66e-42d5-a87d-dd946f79291a'),(7,2,4,5,0,2,'2020-02-05 22:49:07','2020-02-05 22:49:07','3c11eee6-916f-44cd-b6fc-a9c61793d8dc'),(8,3,5,1,0,1,'2020-02-05 22:49:59','2020-02-05 22:49:59','84a39606-2a59-4a07-a0cb-a4250f3ef9b0'),(64,4,36,2,0,1,'2020-02-05 23:33:18','2020-02-05 23:33:18','a4277653-2722-451e-b55e-8522d20e2ab4'),(65,4,37,4,0,1,'2020-02-05 23:33:18','2020-02-05 23:33:18','6f6f3668-970d-43c5-b7c6-2ac33f9f2010'),(66,4,37,5,0,2,'2020-02-05 23:33:18','2020-02-05 23:33:18','1c7dbfe8-5b1a-43bf-bd31-bc8f7a8fcdb9'),(67,6,38,6,0,1,'2020-02-05 23:33:18','2020-02-05 23:33:18','74e506e4-5f7c-4295-86d0-e8b5caab44e4'),(68,6,39,7,0,2,'2020-02-05 23:33:18','2020-02-05 23:33:18','ddc9538a-d281-43a7-a82a-c461c8825a55'),(69,6,39,8,0,1,'2020-02-05 23:33:18','2020-02-05 23:33:18','c1c2cc8c-8aa5-4ce6-be6d-b82c394a59d9'),(70,8,40,9,0,1,'2020-02-05 23:33:18','2020-02-05 23:33:18','f8d99060-d7a6-4ced-bb03-ff2dc75a3864'),(71,8,41,10,0,2,'2020-02-05 23:33:18','2020-02-05 23:33:18','3916cf10-8d88-4edc-9601-03b29f9a0ae6'),(72,8,41,11,0,1,'2020-02-05 23:33:18','2020-02-05 23:33:18','9068a8fb-e126-4a86-af39-caddd5710de9'),(73,1,42,2,0,1,'2020-02-06 04:48:43','2020-02-06 04:48:43','efd2eedb-070a-4273-85ca-acf854131425'),(74,1,42,4,0,2,'2020-02-06 04:48:43','2020-02-06 04:48:43','97910549-eedf-4bbb-a55e-32df3a0b2559'),(75,1,42,5,0,3,'2020-02-06 04:48:43','2020-02-06 04:48:43','8f017a3b-391c-449f-8e48-62f2614bdbbc'),(76,5,43,6,0,1,'2020-02-06 04:48:43','2020-02-06 04:48:43','3169fb69-15b0-4e64-89de-6dd563508324'),(77,5,43,7,0,3,'2020-02-06 04:48:43','2020-02-06 04:48:43','30b51e5a-406c-44fe-a17c-7037932559bb'),(78,5,43,8,0,2,'2020-02-06 04:48:43','2020-02-06 04:48:43','9bb4f28f-3b9e-493b-8553-9200d3414c29'),(79,7,44,10,0,3,'2020-02-06 04:48:43','2020-02-06 04:48:43','d1db67fc-09b4-4608-a7d5-3c4097bf88e5'),(80,7,44,11,0,2,'2020-02-06 04:48:43','2020-02-06 04:48:43','2a885823-760b-42dd-b319-fab3e2990dd8'),(81,7,44,9,0,1,'2020-02-06 04:48:43','2020-02-06 04:48:43','4d356746-64fb-4af1-a535-50620bfc15f6');
/*!40000 ALTER TABLE `fieldlayoutfields` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `fieldlayouts`
--

LOCK TABLES `fieldlayouts` WRITE;
/*!40000 ALTER TABLE `fieldlayouts` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `fieldlayouts` VALUES (1,'craft\\elements\\MatrixBlock','2020-02-05 21:47:13','2020-02-05 21:47:13',NULL,'cc16cc83-8470-48b8-bbaa-fcda87beb1ea'),(2,'angellco\\spoon\\models\\BlockType','2020-02-05 22:49:07','2020-02-05 22:49:07',NULL,'21bf98ed-d17a-4918-be8a-7df2aab7776d'),(3,'craft\\elements\\Entry','2020-02-05 22:49:59','2020-02-05 22:49:59',NULL,'47f51c95-5f9f-4a34-900c-e4301d1cffcf'),(4,'angellco\\spoon\\models\\BlockType','2020-02-05 22:50:40','2020-02-05 22:50:40',NULL,'e5cc210c-5c07-4e10-bb32-30b3a89d2499'),(5,'craft\\elements\\MatrixBlock','2020-02-05 23:24:30','2020-02-05 23:24:30',NULL,'3c6f922b-8c79-41b1-a050-c921a89d41de'),(6,'angellco\\spoon\\models\\BlockType','2020-02-05 23:25:20','2020-02-05 23:25:20',NULL,'405529ec-20c5-431d-b5a4-e0bd63f3de45'),(7,'craft\\elements\\MatrixBlock','2020-02-05 23:29:34','2020-02-05 23:29:34',NULL,'fe6d1ad7-77ef-4195-8592-4dfc70bc03ed'),(8,'angellco\\spoon\\models\\BlockType','2020-02-05 23:33:16','2020-02-05 23:33:16',NULL,'d8f27a2c-3694-4cc5-8c68-dc46b25fe8d6');
/*!40000 ALTER TABLE `fieldlayouts` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `fieldlayouttabs`
--

LOCK TABLES `fieldlayouttabs` WRITE;
/*!40000 ALTER TABLE `fieldlayouttabs` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `fieldlayouttabs` VALUES (3,2,'Content',1,'2020-02-05 22:49:07','2020-02-05 22:49:07','cfd32dde-f867-4f2f-a316-027315847835'),(4,2,'Layout',2,'2020-02-05 22:49:07','2020-02-05 22:49:07','0cab0072-7cef-4413-989e-605a3d364499'),(5,3,'Content',1,'2020-02-05 22:49:59','2020-02-05 22:49:59','87994857-8f5d-44af-a2c6-8c9bd33a4716'),(36,4,'Content',1,'2020-02-05 23:33:18','2020-02-05 23:33:18','9ad7be9a-5eb8-4028-91ec-5f4499ec2349'),(37,4,'Layout',2,'2020-02-05 23:33:18','2020-02-05 23:33:18','ef1997a5-f2a7-4fe8-8224-c39d78a47346'),(38,6,'Content',1,'2020-02-05 23:33:18','2020-02-05 23:33:18','537a8af9-071b-471c-86aa-f12a5d09bd6f'),(39,6,'Layout',2,'2020-02-05 23:33:18','2020-02-05 23:33:18','2ca1f47a-8ce3-4171-a78e-2d3b408411e5'),(40,8,'Content',1,'2020-02-05 23:33:18','2020-02-05 23:33:18','a1d54513-0fbb-4038-be79-30aa414ff718'),(41,8,'Layout',2,'2020-02-05 23:33:18','2020-02-05 23:33:18','be8adc31-7b93-480f-a7b0-2f7f5b683477'),(42,1,'Content',1,'2020-02-06 04:48:43','2020-02-06 04:48:43','d351f570-c6b5-4d1f-be9f-7138295e3c36'),(43,5,'Content',1,'2020-02-06 04:48:43','2020-02-06 04:48:43','f42b0ca7-5461-481c-b5cd-d84c97b83ac9'),(44,7,'Content',1,'2020-02-06 04:48:43','2020-02-06 04:48:43','e578185a-c7fc-40ae-ba71-8eddae124624');
/*!40000 ALTER TABLE `fieldlayouttabs` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `fields`
--

LOCK TABLES `fields` WRITE;
/*!40000 ALTER TABLE `fields` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `fields` VALUES (1,2,'Panels','panels','global','',0,'site',NULL,'craft\\fields\\Matrix','{\"contentTable\":\"{{%matrixcontent_panels}}\",\"maxBlocks\":\"\",\"minBlocks\":\"\",\"propagationMethod\":\"all\"}','2020-02-05 21:47:13','2020-02-05 21:47:13','57439ba8-7b9a-4a6f-925c-791faec8269a'),(2,NULL,'__blank__','text','matrixBlockType:bd566221-af4b-40b9-a950-8f04d2c59b8c','',1,'none',NULL,'craft\\redactor\\Field','{\"availableTransforms\":\"*\",\"availableVolumes\":\"*\",\"cleanupHtml\":true,\"columnType\":\"text\",\"purifierConfig\":\"\",\"purifyHtml\":\"1\",\"redactorConfig\":\"\",\"removeEmptyTags\":\"1\",\"removeInlineStyles\":\"1\",\"removeNbsp\":\"1\"}','2020-02-05 21:47:13','2020-02-05 21:47:13','03b34141-8ace-49bf-83cd-070779334bac'),(4,NULL,'Padding','padding','matrixBlockType:bd566221-af4b-40b9-a950-8f04d2c59b8c','',0,'none',NULL,'craft\\fields\\Dropdown','{\"optgroups\":true,\"options\":[{\"label\":\"None\",\"value\":\"p-0\",\"default\":\"\"},{\"label\":\"Small\",\"value\":\"p-2\",\"default\":\"\"},{\"label\":\"Medium\",\"value\":\"p-4\",\"default\":\"\"},{\"label\":\"Large\",\"value\":\"p-5\",\"default\":\"\"}]}','2020-02-05 22:48:06','2020-02-06 04:48:43','10777443-a139-4a09-a2d1-dcf4c8c93597'),(5,NULL,'Margin','margin','matrixBlockType:bd566221-af4b-40b9-a950-8f04d2c59b8c','',0,'none',NULL,'craft\\fields\\Dropdown','{\"optgroups\":true,\"options\":[{\"label\":\"None\",\"value\":\"m-0\",\"default\":\"\"},{\"label\":\"Small\",\"value\":\"m-1\",\"default\":\"\"},{\"label\":\"Medium\",\"value\":\"m-2\",\"default\":\"\"},{\"label\":\"Large\",\"value\":\"m-3\",\"default\":\"\"}]}','2020-02-05 22:48:06','2020-02-05 22:48:06','27854c4e-fdce-42da-b6c2-85f68395135f'),(6,NULL,'__blank__','embed','matrixBlockType:ca4a9a7e-193b-499a-88cd-b1f889361bc0','',0,'none',NULL,'craft\\fields\\PlainText','{\"byteLimit\":null,\"charLimit\":null,\"code\":\"1\",\"columnType\":null,\"initialRows\":\"4\",\"multiline\":\"1\",\"placeholder\":\"\"}','2020-02-05 23:24:30','2020-02-05 23:24:30','5d36ed79-72af-4edb-b06b-3c9acab5044e'),(7,NULL,'Margin','margin','matrixBlockType:ca4a9a7e-193b-499a-88cd-b1f889361bc0','',0,'none',NULL,'craft\\fields\\Dropdown','{\"optgroups\":true,\"options\":[{\"label\":\"None\",\"value\":\"m-0\",\"default\":\"\"},{\"label\":\"Small\",\"value\":\"m-1\",\"default\":\"\"},{\"label\":\"Medium\",\"value\":\"m-2\",\"default\":\"\"},{\"label\":\"Large\",\"value\":\"m-3\",\"default\":\"\"}]}','2020-02-05 23:24:30','2020-02-05 23:32:12','a1d312b0-6ec3-4aee-98fc-dc88d84c984d'),(8,NULL,'Padding','padding','matrixBlockType:ca4a9a7e-193b-499a-88cd-b1f889361bc0','',0,'none',NULL,'craft\\fields\\Dropdown','{\"optgroups\":true,\"options\":[{\"label\":\"None\",\"value\":\"p-0\",\"default\":\"\"},{\"label\":\"Small\",\"value\":\"p-1\",\"default\":\"\"},{\"label\":\"Medium\",\"value\":\"p-2\",\"default\":\"\"},{\"label\":\"Large\",\"value\":\"p-3\",\"default\":\"\"}]}','2020-02-05 23:24:30','2020-02-05 23:24:30','a90b7884-a1ae-4406-9272-d47261cc9f83'),(9,NULL,'__blank__','image','matrixBlockType:909cb47c-43ec-42b7-a7c0-c62dca2bbb08','',0,'site',NULL,'craft\\fields\\Assets','{\"allowedKinds\":[\"image\"],\"defaultUploadLocationSource\":\"\",\"defaultUploadLocationSubpath\":\"\",\"limit\":\"1\",\"localizeRelations\":false,\"restrictFiles\":\"1\",\"selectionLabel\":\"\",\"showUnpermittedFiles\":false,\"showUnpermittedVolumes\":false,\"singleUploadLocationSource\":\"\",\"singleUploadLocationSubpath\":\"\",\"source\":null,\"sources\":\"*\",\"targetSiteId\":null,\"useSingleFolder\":true,\"validateRelatedElements\":\"\",\"viewMode\":\"list\"}','2020-02-05 23:29:34','2020-02-05 23:29:34','d8193927-d011-4f5e-a6f2-244e8be9de3c'),(10,NULL,'Margin','margin','matrixBlockType:909cb47c-43ec-42b7-a7c0-c62dca2bbb08','',0,'none',NULL,'craft\\fields\\Dropdown','{\"optgroups\":true,\"options\":[{\"label\":\"None\",\"value\":\"m-0\",\"default\":\"\"},{\"label\":\"Small\",\"value\":\"m-1\",\"default\":\"\"},{\"label\":\"Medium\",\"value\":\"m-2\",\"default\":\"\"},{\"label\":\"Large\",\"value\":\"m-3\",\"default\":\"\"}]}','2020-02-05 23:32:12','2020-02-05 23:32:12','84a8c477-8e17-4f1a-a658-6602b973979e'),(11,NULL,'Padding','padding','matrixBlockType:909cb47c-43ec-42b7-a7c0-c62dca2bbb08','',0,'none',NULL,'craft\\fields\\Dropdown','{\"optgroups\":true,\"options\":[{\"label\":\"None\",\"value\":\"p-0\",\"default\":\"\"},{\"label\":\"Small\",\"value\":\"p-1\",\"default\":\"\"},{\"label\":\"Medium\",\"value\":\"p-2\",\"default\":\"\"},{\"label\":\"Large\",\"value\":\"p-3\",\"default\":\"\"}]}','2020-02-05 23:32:12','2020-02-05 23:32:12','a860e0df-26ec-48e1-9cc7-f78e62f6b07d');
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
INSERT INTO `info` VALUES (1,'3.4.14','3.4.10',0,'[]','CyKeDpEaas9F','2020-02-05 21:43:45','2020-04-08 22:21:08','26775f8e-f8fd-416d-a58e-68ba19457018');
/*!40000 ALTER TABLE `info` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `matrixblocks`
--

LOCK TABLES `matrixblocks` WRITE;
/*!40000 ALTER TABLE `matrixblocks` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `matrixblocks` VALUES (3,2,1,1,1,NULL,'2020-02-05 22:50:09','2020-02-05 22:50:09','bc424181-5ece-4ff8-9981-58a73fa3e035'),(5,4,1,1,1,0,'2020-02-05 22:50:49','2020-02-05 22:50:49','22593083-7b96-47fa-a51d-5a6b09303185'),(6,4,1,1,1,0,'2020-02-05 22:50:59','2020-02-05 22:50:59','36429b92-efac-4045-a7b5-4f37dc327865'),(7,4,1,1,1,0,'2020-02-05 22:51:00','2020-02-05 22:51:00','1d7a1a9e-ccb9-43cd-9d70-52ceff7eeba4'),(8,4,1,1,1,0,'2020-02-05 22:51:02','2020-02-05 22:51:02','e53fe283-49e3-46a0-9b9d-c6256c8bebe9'),(9,4,1,1,1,0,'2020-02-05 22:51:03','2020-02-05 22:51:03','97774553-7f60-44e7-8c89-1ffc89b80ae2'),(10,4,1,1,1,0,'2020-02-05 22:51:05','2020-02-05 22:51:05','695688dd-8a2d-4088-9e39-ca7f05db5a4b'),(11,4,1,1,1,0,'2020-02-05 22:51:07','2020-02-05 22:51:07','dd2ca0fb-4ab5-45b2-9a4f-83cb27e0c587'),(12,4,1,1,1,0,'2020-02-05 22:51:09','2020-02-05 22:51:09','4605ca0d-09bd-46ac-ad5e-3c0574256628'),(13,4,1,1,1,NULL,'2020-02-05 22:51:10','2020-02-05 22:51:10','4a392e63-b880-4e19-87ad-a598a57414a3'),(15,14,1,1,1,NULL,'2020-02-05 22:52:10','2020-02-05 22:52:10','b9f94131-a04e-4270-8eba-211d4a12df42'),(17,16,1,1,1,NULL,'2020-02-05 22:52:44','2020-02-05 22:52:44','167422c5-91ef-4135-87d1-15f0a7a74261'),(20,19,1,1,1,0,'2020-02-05 23:25:29','2020-02-05 23:25:29','273167a7-d107-4600-b22e-32dabe40fb4b'),(21,19,1,1,1,0,'2020-02-05 23:25:31','2020-02-05 23:25:31','49449dc9-6b96-4d3a-8209-74f7fce8ad8c'),(22,19,1,2,2,0,'2020-02-05 23:25:31','2020-02-05 23:25:31','2e623c22-3955-43e8-94c9-b1dc09f5f624'),(23,19,1,1,1,0,'2020-02-05 23:27:09','2020-02-05 23:27:09','069cd0d1-62c0-4796-8d83-ac3432151a21'),(24,19,1,2,2,0,'2020-02-05 23:27:09','2020-02-05 23:27:09','5e584eae-e0e0-4307-8009-6acc354c9b73'),(25,19,1,1,1,0,'2020-02-05 23:27:17','2020-02-05 23:27:17','3a08c8a5-f4ff-4fd0-9c28-3909c32e6fbd'),(26,19,1,2,2,0,'2020-02-05 23:27:18','2020-02-05 23:27:18','261de8bf-f910-49f0-9cf3-9852276dc1e5'),(27,19,1,1,1,NULL,'2020-02-05 23:27:19','2020-02-05 23:27:19','e0cca440-170b-4711-ba6b-cb13901b957d'),(28,19,1,2,2,NULL,'2020-02-05 23:27:19','2020-02-05 23:27:19','bf4d4d07-0d4a-42d9-8baa-a64e0504f45c'),(38,37,1,1,1,NULL,'2020-02-05 23:34:00','2020-02-05 23:34:00','cbcf7992-d2c6-40ff-9689-429a3be6697c'),(39,37,1,2,2,NULL,'2020-02-05 23:34:00','2020-02-05 23:34:00','758788fb-4118-4bcb-8bd6-7d4164b31d3d'),(40,37,1,3,3,NULL,'2020-02-05 23:34:00','2020-02-05 23:34:00','d72d8c7e-40df-4ebe-b232-9591caacd62b');
/*!40000 ALTER TABLE `matrixblocks` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `matrixblocktypes`
--

LOCK TABLES `matrixblocktypes` WRITE;
/*!40000 ALTER TABLE `matrixblocktypes` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `matrixblocktypes` VALUES (1,1,1,'Text','text',1,'2020-02-05 21:47:13','2020-02-05 21:47:13','bd566221-af4b-40b9-a950-8f04d2c59b8c'),(2,1,5,'Embed','embed',2,'2020-02-05 23:24:30','2020-02-05 23:24:30','ca4a9a7e-193b-499a-88cd-b1f889361bc0'),(3,1,7,'Image','image',3,'2020-02-05 23:29:34','2020-02-05 23:29:34','909cb47c-43ec-42b7-a7c0-c62dca2bbb08');
/*!40000 ALTER TABLE `matrixblocktypes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `matrixcontent_panels`
--

LOCK TABLES `matrixcontent_panels` WRITE;
/*!40000 ALTER TABLE `matrixcontent_panels` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `matrixcontent_panels` VALUES (1,3,1,'2020-02-05 22:50:09','2020-02-05 22:50:09','85387d0b-4c11-4f82-9dad-1c212bccfc28',NULL,'p-0','m-0',NULL,NULL,NULL,NULL,NULL),(2,5,1,'2020-02-05 22:50:49','2020-02-05 22:50:49','97cf75c9-a312-400e-9828-8e4595940cc9',NULL,'p-0','m-0',NULL,NULL,NULL,NULL,NULL),(3,6,1,'2020-02-05 22:50:59','2020-02-05 22:50:59','f4e2a06b-5876-4561-aa3b-f65468c4a21b',NULL,'p-2','m-0',NULL,NULL,NULL,NULL,NULL),(4,7,1,'2020-02-05 22:51:00','2020-02-05 22:51:00','867768cb-b088-4c9a-a7a7-bdbd042aad6c',NULL,'p-1','m-0',NULL,NULL,NULL,NULL,NULL),(5,8,1,'2020-02-05 22:51:02','2020-02-05 22:51:02','847f1d60-9c04-482b-b0ee-1f6a09782381',NULL,'p-3','m-0',NULL,NULL,NULL,NULL,NULL),(6,9,1,'2020-02-05 22:51:03','2020-02-05 22:51:03','40891f62-e566-4451-832b-a485bed5978d',NULL,'p-3','m-2',NULL,NULL,NULL,NULL,NULL),(7,10,1,'2020-02-05 22:51:05','2020-02-05 22:51:05','abc400a7-e37a-4110-86ac-d043ca6cafe5',NULL,'p-3','m-0',NULL,NULL,NULL,NULL,NULL),(8,11,1,'2020-02-05 22:51:07','2020-02-05 22:51:07','cff91892-d9de-4ba3-98eb-f70b1e6b9c45',NULL,'p-3','m-1',NULL,NULL,NULL,NULL,NULL),(9,12,1,'2020-02-05 22:51:09','2020-02-05 22:51:09','55303dc4-6b18-41cb-848d-0b8c5745ea8a',NULL,'p-0','m-1',NULL,NULL,NULL,NULL,NULL),(10,13,1,'2020-02-05 22:51:10','2020-02-05 22:51:10','0830a669-0536-49a5-a6a7-ef29ec21ca1b',NULL,'p-1','m-1',NULL,NULL,NULL,NULL,NULL),(11,15,1,'2020-02-05 22:52:10','2020-02-05 22:52:10','581eea4c-e123-4aef-aa34-aaa058c41889',NULL,'p-0','m-0',NULL,NULL,NULL,NULL,NULL),(12,17,1,'2020-02-05 22:52:44','2020-02-05 22:52:44','3c3a13cb-9d26-4d40-a0f2-87bd7853fecd',NULL,'p-0','m-0',NULL,NULL,NULL,NULL,NULL),(13,20,1,'2020-02-05 23:25:29','2020-02-05 23:25:29','41f0b665-d31b-49c7-88c8-864825bd475a',NULL,'p-0','m-0',NULL,NULL,NULL,NULL,NULL),(14,21,1,'2020-02-05 23:25:31','2020-02-05 23:25:31','14071c1a-9c65-4256-a0e7-f7e1d6705e1a',NULL,'p-0','m-0',NULL,NULL,NULL,NULL,NULL),(15,22,1,'2020-02-05 23:25:31','2020-02-05 23:25:31','a3f5b713-c9eb-4ea2-83ab-3a22376971eb',NULL,NULL,NULL,NULL,'m-1','p-0',NULL,NULL),(16,23,1,'2020-02-05 23:27:09','2020-02-05 23:27:09','a90aa5d5-61e8-4912-9442-d6bf22e5e3f2',NULL,'p-0','m-0',NULL,NULL,NULL,NULL,NULL),(17,24,1,'2020-02-05 23:27:09','2020-02-05 23:27:09','2dcbb01a-0ebe-4b82-983a-d9d231502fbb',NULL,NULL,NULL,NULL,'m-1','p-1',NULL,NULL),(18,25,1,'2020-02-05 23:27:17','2020-02-05 23:27:17','e488fbf6-7f2f-44f3-8ce3-08ee87e9137d',NULL,'p-2','m-0',NULL,NULL,NULL,NULL,NULL),(19,26,1,'2020-02-05 23:27:18','2020-02-05 23:27:18','6d0082c3-0805-4340-a533-e1fdbfce8428',NULL,NULL,NULL,NULL,'m-1','p-1',NULL,NULL),(20,27,1,'2020-02-05 23:27:19','2020-02-05 23:27:19','569204de-bfe1-434b-8076-8868d54a86ca',NULL,'p-2','m-2',NULL,NULL,NULL,NULL,NULL),(21,28,1,'2020-02-05 23:27:19','2020-02-05 23:27:19','893419a5-4774-47d3-87da-592b52aa33aa',NULL,NULL,NULL,NULL,'m-1','p-1',NULL,NULL),(22,31,1,'2020-02-05 23:33:42','2020-02-05 23:33:42','4506f68a-c4be-4987-979e-45e138af44f3',NULL,'p-0','m-0',NULL,NULL,NULL,NULL,NULL),(23,32,1,'2020-02-05 23:33:45','2020-02-05 23:33:45','3db99dc1-8df9-4fa1-9e50-771cf937cd04',NULL,'p-0','m-0',NULL,NULL,NULL,NULL,NULL),(24,33,1,'2020-02-05 23:33:45','2020-02-05 23:33:45','a09fe405-727a-4f0f-a915-04798c2099b5',NULL,NULL,NULL,NULL,'m-0','p-0',NULL,NULL),(28,38,1,'2020-02-05 23:34:00','2020-02-05 23:40:14','d62ecccf-0ec4-4245-8ffc-425e4f77ed2e','<h2>Lorem ipsum dolor sit amet</h2><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis a risus feugiat, malesuada nisi sed, pulvinar ligula. Integer quis urna at lacus tincidunt viverra. Aenean sollicitudin enim ultricies libero vulputate, in hendrerit odio faucibus. Nam eu consectetur quam. Nunc orci lectus, accumsan eu augue eget, tristique vestibulum tortor. Mauris sodales turpis orci, ac blandit libero consectetur in. Sed efficitur enim ligula, et sagittis neque cursus in. Phasellus eu dui facilisis, bibendum libero id, elementum ante. In hac habitasse platea dictumst. Phasellus eget magna ut libero semper egestas. Aliquam ornare volutpat posuere.</p><h2>Integer dapibus urna</h2><p>Integer dapibus urna ut neque ornare, vel feugiat eros interdum. Duis cursus commodo convallis. Donec lectus ipsum, pulvinar eu dui in, venenatis molestie risus. Curabitur mollis risus risus, eu finibus est venenatis id. Donec sit amet libero a mi sagittis luctus et non nibh. Nullam non rhoncus massa. Mauris lacinia bibendum lectus, pharetra fermentum diam consequat vel. Nam id purus rutrum, molestie mi dignissim, rhoncus mi. Pellentesque nec auctor nulla.</p><h2>Donec justo ipsum</h2><p>Donec justo ipsum, pretium in ornare ut, rhoncus eget risus. Nam tempus finibus magna, non ultricies urna gravida ac. Cras id lectus suscipit, imperdiet tellus in, pretium ante. Maecenas nibh erat, laoreet fermentum volutpat quis, finibus sed dui. Nullam dolor arcu, mattis vitae lectus vel, vulputate dictum velit. Donec commodo accumsan justo ut tempor. Quisque enim erat, dapibus sit amet lectus sit amet, tincidunt interdum arcu. Vivamus vitae ex ligula. Praesent vel ipsum id nunc tempor tincidunt. Integer non euismod urna. Duis non urna non lectus feugiat iaculis. Quisque elit elit, porttitor vitae lacus et, consectetur fringilla urna.</p>','p-0','m-0',NULL,NULL,NULL,NULL,NULL),(29,39,1,'2020-02-05 23:34:00','2020-02-05 23:42:26','2e6769d5-e763-4f79-8cb6-5c4c6ec5e360',NULL,NULL,NULL,'<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/k7s1sr4JdlI\" frameborder=\"0\" allow=\"accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture\" allowfullscreen></iframe>','m-0','p-0',NULL,NULL),(30,40,1,'2020-02-05 23:34:00','2020-02-05 23:34:00','f6ec9dca-04c0-447f-8bdb-63ea7d462cd1',NULL,NULL,NULL,NULL,NULL,NULL,'m-0','p-0');
/*!40000 ALTER TABLE `matrixcontent_panels` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `migrations` VALUES (1,NULL,'app','Install','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','5d0b7fb8-6e3e-4592-aa97-abce8c5c8c8e'),(2,NULL,'app','m150403_183908_migrations_table_changes','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','3bf726dd-017c-4903-985e-17d75dbe9f08'),(3,NULL,'app','m150403_184247_plugins_table_changes','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','e09ea518-7cc1-4f57-9fbb-3c8a81f6b7d0'),(4,NULL,'app','m150403_184533_field_version','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','9f8c5fea-3c8e-4925-b13a-dae29ea3df96'),(5,NULL,'app','m150403_184729_type_columns','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','f320eee9-3daa-4149-9f92-6d3e239814a5'),(6,NULL,'app','m150403_185142_volumes','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','22c152d5-f79b-493a-93c0-c74fdac438cd'),(7,NULL,'app','m150428_231346_userpreferences','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','02d9cfd8-73b4-4be2-9923-9c8d85ec9136'),(8,NULL,'app','m150519_150900_fieldversion_conversion','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','ce41c1eb-d14c-4614-8dfd-ba515ed4636a'),(9,NULL,'app','m150617_213829_update_email_settings','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','50cdc6d1-9c3e-44e1-8bb3-6bb3ccb06b90'),(10,NULL,'app','m150721_124739_templatecachequeries','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','8d1724df-249e-4280-a982-abd22f5b5c03'),(11,NULL,'app','m150724_140822_adjust_quality_settings','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','4fc3cdc6-1a5f-4917-b818-73fc8ff05173'),(12,NULL,'app','m150815_133521_last_login_attempt_ip','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','75374f18-6a3c-4256-912e-348ab2bc9778'),(13,NULL,'app','m151002_095935_volume_cache_settings','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','edbed53f-4e02-4497-b8c0-9090b059cac9'),(14,NULL,'app','m151005_142750_volume_s3_storage_settings','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','42bd1485-eaa1-4f32-ba73-c2a960c78c4a'),(15,NULL,'app','m151016_133600_delete_asset_thumbnails','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','13cb5348-8390-41cb-bc41-04046e2932a1'),(16,NULL,'app','m151209_000000_move_logo','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','5cde5ecc-55e4-4dde-a4c7-a3b31c485723'),(17,NULL,'app','m151211_000000_rename_fileId_to_assetId','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','a43d70bf-d64a-4a42-aae2-26062a90a52f'),(18,NULL,'app','m151215_000000_rename_asset_permissions','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','1f24453c-ba38-40f3-a7e0-321a61ccdcec'),(19,NULL,'app','m160707_000001_rename_richtext_assetsource_setting','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','0288095d-38bd-4fca-ab12-9da4bd8580f7'),(20,NULL,'app','m160708_185142_volume_hasUrls_setting','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','53f9bc3f-c9d4-4713-8e27-f6c1e0c6a859'),(21,NULL,'app','m160714_000000_increase_max_asset_filesize','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','dd546277-1ab1-4071-9a82-d627b0098802'),(22,NULL,'app','m160727_194637_column_cleanup','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','b224de3b-62c1-4c7d-9660-95ac4ec9273a'),(23,NULL,'app','m160804_110002_userphotos_to_assets','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','8a12b4a2-eeb4-4065-a00c-8b69fc8a770a'),(24,NULL,'app','m160807_144858_sites','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','822ec139-09fa-411c-b008-7a77f11fc29a'),(25,NULL,'app','m160829_000000_pending_user_content_cleanup','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','c086186e-94f5-4e05-a492-655b5552b62f'),(26,NULL,'app','m160830_000000_asset_index_uri_increase','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','d4cd1b5b-6b2d-41a5-8a7c-1ca698dba5ae'),(27,NULL,'app','m160912_230520_require_entry_type_id','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','25bf6087-33b8-4220-8525-b75fc5bcd7b7'),(28,NULL,'app','m160913_134730_require_matrix_block_type_id','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','abb9788a-1402-4ef5-91cb-3f912a5f68c2'),(29,NULL,'app','m160920_174553_matrixblocks_owner_site_id_nullable','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','21d6d25c-00a3-4b6c-afcc-427642e2cba7'),(30,NULL,'app','m160920_231045_usergroup_handle_title_unique','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','761dfa7c-27d8-4e92-aab4-383692f8df79'),(31,NULL,'app','m160925_113941_route_uri_parts','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','8bd8f28e-0f1b-446e-8577-3893664f5f50'),(32,NULL,'app','m161006_205918_schemaVersion_not_null','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','eec0b481-c6c2-454e-9f54-f3fe20756657'),(33,NULL,'app','m161007_130653_update_email_settings','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','8ab17f81-2010-4a87-b74d-530d3f3cf568'),(34,NULL,'app','m161013_175052_newParentId','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','2e229a0a-d414-4203-9c4d-fc43845f1688'),(35,NULL,'app','m161021_102916_fix_recent_entries_widgets','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','9cfe8e40-7bac-4527-ab6c-1a7779e714f1'),(36,NULL,'app','m161021_182140_rename_get_help_widget','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','b4a10981-a843-4146-8776-51d3d46f1c91'),(37,NULL,'app','m161025_000000_fix_char_columns','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','3c099f1a-558b-4a4c-9af9-29de72d0cfe0'),(38,NULL,'app','m161029_124145_email_message_languages','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','e1e9a282-131c-4feb-9edf-d0ee78e71871'),(39,NULL,'app','m161108_000000_new_version_format','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','3a17dca3-05c6-44b5-9039-f600a9bec13b'),(40,NULL,'app','m161109_000000_index_shuffle','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','d4b0c07b-70cb-4f37-99e2-7ee235dda473'),(41,NULL,'app','m161122_185500_no_craft_app','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','598281ea-2dca-48c8-bc4b-9bbde47e4c8b'),(42,NULL,'app','m161125_150752_clear_urlmanager_cache','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','7af2f65f-2f20-4204-a522-f4986aa15077'),(43,NULL,'app','m161220_000000_volumes_hasurl_notnull','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','defc6244-9990-4c96-b8b1-0b9ff629b833'),(44,NULL,'app','m170114_161144_udates_permission','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','0fb82fd4-660a-407b-b6e3-14b8c8088f84'),(45,NULL,'app','m170120_000000_schema_cleanup','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','08e917c8-3fc6-4054-b600-5a93994a783a'),(46,NULL,'app','m170126_000000_assets_focal_point','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','bdd9e538-b113-4ee1-9d20-7639d9b1210b'),(47,NULL,'app','m170206_142126_system_name','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','ac4f3753-f0e9-4d47-ab04-47950bb5aad8'),(48,NULL,'app','m170217_044740_category_branch_limits','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','88069097-c453-45bd-8fd5-7e3d5b6f4710'),(49,NULL,'app','m170217_120224_asset_indexing_columns','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','0fe92297-f9c7-411c-a901-f9427a5c6dc4'),(50,NULL,'app','m170223_224012_plain_text_settings','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','7f5f092b-bcfb-4f9e-9c56-886a71e7aa0e'),(51,NULL,'app','m170227_120814_focal_point_percentage','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','b204ec51-c25f-4789-b53a-c7c885222eef'),(52,NULL,'app','m170228_171113_system_messages','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','3b617d42-f238-4596-b064-4079553c6c0b'),(53,NULL,'app','m170303_140500_asset_field_source_settings','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','a5e68bfa-ef48-408d-b468-9516c441f719'),(54,NULL,'app','m170306_150500_asset_temporary_uploads','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','a5452eeb-15bb-42d9-be5a-045b0d9ae0fd'),(55,NULL,'app','m170523_190652_element_field_layout_ids','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','352a9b11-3bf5-4379-b4c5-4617e9865d0b'),(56,NULL,'app','m170612_000000_route_index_shuffle','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','c379f01d-fdd0-4034-964a-4028299f77fb'),(57,NULL,'app','m170621_195237_format_plugin_handles','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','f786d32c-70d2-487a-ae12-8d968daa185f'),(58,NULL,'app','m170630_161027_deprecation_line_nullable','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','02bc5622-4b55-409b-b001-75e03800a7b8'),(59,NULL,'app','m170630_161028_deprecation_changes','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','91dc1a52-828e-4d74-bc28-54605eed69d4'),(60,NULL,'app','m170703_181539_plugins_table_tweaks','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','6bce21c5-34e5-44b3-98a3-a44d7e6c6a03'),(61,NULL,'app','m170704_134916_sites_tables','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','ac1656b3-b657-4a54-aa39-e59f3bdfb493'),(62,NULL,'app','m170706_183216_rename_sequences','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','f1d298d6-985f-4a09-8e58-f00d99b3d3ee'),(63,NULL,'app','m170707_094758_delete_compiled_traits','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','2ff00e56-70a0-4c6c-b9e7-7cd682d357e9'),(64,NULL,'app','m170731_190138_drop_asset_packagist','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','ababdf5e-e2a0-49fa-b95a-5b7fcfd8283a'),(65,NULL,'app','m170810_201318_create_queue_table','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','90ee2d64-f7fa-4ede-b775-5f11aa854336'),(66,NULL,'app','m170903_192801_longblob_for_queue_jobs','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','2768477d-0e83-4457-bb81-5c2b74c20608'),(67,NULL,'app','m170914_204621_asset_cache_shuffle','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','9ae2fd43-e8be-4866-a4b0-0feb8e294cb8'),(68,NULL,'app','m171011_214115_site_groups','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','c9f00cea-86b1-4163-9f99-fc0c961ff015'),(69,NULL,'app','m171012_151440_primary_site','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','2a7e2ec0-a357-42aa-87a1-8db6e49e6a6e'),(70,NULL,'app','m171013_142500_transform_interlace','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','3aa782e4-260c-4d57-822d-dfbc9d15c67c'),(71,NULL,'app','m171016_092553_drop_position_select','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','cfd795b2-1d0a-4bf1-afc9-7089db4fe7a5'),(72,NULL,'app','m171016_221244_less_strict_translation_method','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','1f661017-1ba2-435f-8a62-d9e4e215dca7'),(73,NULL,'app','m171107_000000_assign_group_permissions','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','c3bc7039-9e6c-4fb8-aff1-311c56fe83fa'),(74,NULL,'app','m171117_000001_templatecache_index_tune','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','25e27e1f-259f-4309-bca3-578311b91e28'),(75,NULL,'app','m171126_105927_disabled_plugins','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','6a3d44a4-ea9d-4115-909c-5025f65ffb80'),(76,NULL,'app','m171130_214407_craftidtokens_table','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','a18ecc03-67a0-4ec5-af69-d0aa94a95769'),(77,NULL,'app','m171202_004225_update_email_settings','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','bee9c871-4826-4acf-8851-6edc4269d33e'),(78,NULL,'app','m171204_000001_templatecache_index_tune_deux','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','5bcd42d0-b90c-49bd-8f03-fd4bb4385ade'),(79,NULL,'app','m171205_130908_remove_craftidtokens_refreshtoken_column','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','496b96de-82dd-4082-afc3-f06f3ca4f088'),(80,NULL,'app','m171218_143135_longtext_query_column','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','d3cb0111-440f-4288-b50e-797fabf75274'),(81,NULL,'app','m171231_055546_environment_variables_to_aliases','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','a49f4e20-dab2-41ca-9d94-13fcc702a8ef'),(82,NULL,'app','m180113_153740_drop_users_archived_column','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','cb58c6b7-98ac-4bbe-9eed-d9145f8765ed'),(83,NULL,'app','m180122_213433_propagate_entries_setting','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','f4df6cbc-da2f-46f4-a689-38310ed47587'),(84,NULL,'app','m180124_230459_fix_propagate_entries_values','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','a35cf311-f239-4482-89f3-07837867ed8c'),(85,NULL,'app','m180128_235202_set_tag_slugs','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','304774e5-5f3e-427f-879f-691efdb39448'),(86,NULL,'app','m180202_185551_fix_focal_points','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','4cfcba6e-c10d-4e15-8863-c0e85a11afc2'),(87,NULL,'app','m180217_172123_tiny_ints','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','e30a7bc4-152b-43d6-89ef-6be69f6431ef'),(88,NULL,'app','m180321_233505_small_ints','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','d8045fb2-75e7-4b7b-867e-99c6edff8f7b'),(89,NULL,'app','m180328_115523_new_license_key_statuses','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','95cb2ffe-a56c-4286-9b25-e5b28381f89c'),(90,NULL,'app','m180404_182320_edition_changes','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','e3f5f924-2c83-4fb4-b756-af80d0dd2b16'),(91,NULL,'app','m180411_102218_fix_db_routes','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','43463487-540f-48a9-b694-e06da2abe4d4'),(92,NULL,'app','m180416_205628_resourcepaths_table','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','ad7ab175-8f85-485f-8348-4c5177582aea'),(93,NULL,'app','m180418_205713_widget_cleanup','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','24cb2211-e8f1-44fa-8957-285122cba846'),(94,NULL,'app','m180425_203349_searchable_fields','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','729af053-35df-45b2-9bdf-27111a022a6c'),(95,NULL,'app','m180516_153000_uids_in_field_settings','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','fb34446e-bb3b-498e-a108-7c0132f2d5a4'),(96,NULL,'app','m180517_173000_user_photo_volume_to_uid','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','2a344094-5f0e-4bf1-8013-a1636f472e9b'),(97,NULL,'app','m180518_173000_permissions_to_uid','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','d26d4527-50e8-4410-8afd-5a1219bbe472'),(98,NULL,'app','m180520_173000_matrix_context_to_uids','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','d526a21a-80f8-4daf-96f7-e2a727a27264'),(99,NULL,'app','m180521_172900_project_config_table','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','56152982-6dbc-4229-874a-f46a47a87ed3'),(100,NULL,'app','m180521_173000_initial_yml_and_snapshot','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','c7e1cf75-57ee-4da2-bfe6-89dec134dab8'),(101,NULL,'app','m180731_162030_soft_delete_sites','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','11a875bf-8433-4131-9e4e-b7aa17a2a60b'),(102,NULL,'app','m180810_214427_soft_delete_field_layouts','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','3df9a1b6-daa2-4d07-863c-b013251e6fd8'),(103,NULL,'app','m180810_214439_soft_delete_elements','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','688b4f6c-c941-44c2-a30e-34d2203d6843'),(104,NULL,'app','m180824_193422_case_sensitivity_fixes','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','b38558f6-4ec9-409e-a08b-10f66ba0d981'),(105,NULL,'app','m180901_151639_fix_matrixcontent_tables','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','44d7c4ac-b826-48a6-b9f6-e666944c7b3c'),(106,NULL,'app','m180904_112109_permission_changes','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','9566cc35-135b-4184-9f26-b4a28a5e5d4e'),(107,NULL,'app','m180910_142030_soft_delete_sitegroups','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','8ce57f0d-c55f-498f-bc5e-ba9a4313ab8e'),(108,NULL,'app','m181011_160000_soft_delete_asset_support','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','6d4c3b9f-7402-4aec-9931-c1a31313527a'),(109,NULL,'app','m181016_183648_set_default_user_settings','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','a82db187-e0b0-407f-be9c-dfd20db001a9'),(110,NULL,'app','m181017_225222_system_config_settings','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','b52f5d55-0838-47f1-a420-b3f70e23f654'),(111,NULL,'app','m181018_222343_drop_userpermissions_from_config','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','a2b8ca7f-06c9-40bd-b477-55d411cb751a'),(112,NULL,'app','m181029_130000_add_transforms_routes_to_config','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','4b1d3261-b079-4b23-96fc-075cd59c1ae5'),(113,NULL,'app','m181112_203955_sequences_table','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','f721cae9-4b22-4484-9ce0-921fb77c42f1'),(114,NULL,'app','m181121_001712_cleanup_field_configs','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','735633c1-7124-4243-a0c1-417bba9d0ec6'),(115,NULL,'app','m181128_193942_fix_project_config','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','9446842c-39f8-44d9-a622-83f803fcd5e9'),(116,NULL,'app','m181130_143040_fix_schema_version','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','c082cda4-5d32-4ec3-abbd-04eff6bd99db'),(117,NULL,'app','m181211_143040_fix_entry_type_uids','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','d8c58482-be49-4c52-aa84-fc8aff7a4158'),(118,NULL,'app','m181213_102500_config_map_aliases','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','6d75162e-429a-44e1-bd35-7b877a4c08e2'),(119,NULL,'app','m181217_153000_fix_structure_uids','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','966b8d5a-035f-4f8b-b092-16416b90ddf3'),(120,NULL,'app','m190104_152725_store_licensed_plugin_editions','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','2e2d04f7-7d4e-4ce3-a566-1fa632119fb8'),(121,NULL,'app','m190108_110000_cleanup_project_config','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','ee637f68-b939-412a-aedf-740aad6b8b61'),(122,NULL,'app','m190108_113000_asset_field_setting_change','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','6c77eac4-d752-4483-9163-3a5ab84c0a14'),(123,NULL,'app','m190109_172845_fix_colspan','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','eec7695b-9ed9-4951-a28e-a118dc9e9ea3'),(124,NULL,'app','m190110_150000_prune_nonexisting_sites','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','0ab871e9-44a4-44fe-b003-a3939b7b95d3'),(125,NULL,'app','m190110_214819_soft_delete_volumes','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','4354bd44-eaa1-4491-a8f8-6e9101eb4898'),(126,NULL,'app','m190112_124737_fix_user_settings','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','8ba11d12-4299-4148-8a09-c3114feb6fd3'),(127,NULL,'app','m190112_131225_fix_field_layouts','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','49095efe-7c10-49a1-a4fc-ca5187cfaf3d'),(128,NULL,'app','m190112_201010_more_soft_deletes','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','540e3b36-3ea3-4261-8faa-79a761ec83ab'),(129,NULL,'app','m190114_143000_more_asset_field_setting_changes','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','ebd08408-1789-4383-bc39-ef2b90a21d6b'),(130,NULL,'app','m190121_120000_rich_text_config_setting','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','2df362a6-1d90-4422-9671-ee13816b81ca'),(131,NULL,'app','m190125_191628_fix_email_transport_password','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','79d98337-fe98-4e3e-a95f-ec5176055953'),(132,NULL,'app','m190128_181422_cleanup_volume_folders','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','21db3382-eb5a-4d50-9cbe-1d71534d1220'),(133,NULL,'app','m190205_140000_fix_asset_soft_delete_index','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','4183083d-bd61-4f7e-ad98-65bfba00b3cc'),(134,NULL,'app','m190208_140000_reset_project_config_mapping','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','2b461898-0bfc-41a1-9a63-78969c2a090e'),(135,NULL,'app','m190218_143000_element_index_settings_uid','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','f6971417-1864-4c1a-a0d6-7e62679e6fb3'),(136,NULL,'app','m190312_152740_element_revisions','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','60d5f8d8-b25e-48ad-b580-17ec5a52a059'),(137,NULL,'app','m190327_235137_propagation_method','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','8c9e668e-25c1-49f3-815a-27e26a5c2ce4'),(138,NULL,'app','m190401_223843_drop_old_indexes','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','d1154865-97de-433b-92fc-7e8b9f8f9dff'),(139,NULL,'app','m190416_014525_drop_unique_global_indexes','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','139b5371-f166-4a69-9541-b3735c76e524'),(140,NULL,'app','m190417_085010_add_image_editor_permissions','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','0a07ce10-34d2-4033-bf53-66a845a8b254'),(141,NULL,'app','m190502_122019_store_default_user_group_uid','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','ff74bcf7-3a21-4916-ac8d-72ee21ee071b'),(142,NULL,'app','m190504_150349_preview_targets','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','fd1664c2-6286-4ac6-af37-92927f917694'),(143,NULL,'app','m190516_184711_job_progress_label','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','b92217dc-b6aa-4e86-887b-cbb12dd5bca9'),(144,NULL,'app','m190523_190303_optional_revision_creators','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','9f0a869a-b705-42df-8da1-9daa492b8351'),(145,NULL,'app','m190529_204501_fix_duplicate_uids','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','b06385aa-1e92-4262-be4e-09108dcee200'),(146,NULL,'app','m190605_223807_unsaved_drafts','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','a04295ef-18d0-418d-9ac3-ffd59e74db5b'),(147,NULL,'app','m190607_230042_entry_revision_error_tables','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','92203902-9ba7-48a6-901a-1ba580182246'),(148,NULL,'app','m190608_033429_drop_elements_uid_idx','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','27e4baa3-39a8-45bb-9e6b-a7d060b54475'),(149,NULL,'app','m190617_164400_add_gqlschemas_table','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','1df500e5-a6a3-4ba7-9c1a-573471392442'),(150,NULL,'app','m190624_234204_matrix_propagation_method','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','cd06b155-a033-42f0-a229-2f4de665b2c2'),(151,NULL,'app','m190711_153020_drop_snapshots','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','b3ab6504-c8f4-4d6c-92fa-6723e9f264a7'),(152,NULL,'app','m190712_195914_no_draft_revisions','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','bfa9334c-5646-48c8-a86e-cc0eb3ec14d8'),(153,NULL,'app','m190723_140314_fix_preview_targets_column','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','b5924921-5e55-468e-a213-16014b8f5d68'),(154,NULL,'app','m190820_003519_flush_compiled_templates','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','7675fc9f-911a-4248-98d7-3370c8a404ab'),(155,NULL,'app','m190823_020339_optional_draft_creators','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','50f329f3-8167-4b4b-a0bb-249575a664e6'),(156,NULL,'app','m190913_152146_update_preview_targets','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','484838de-84d2-4ff6-be64-dd0a48a5f160'),(157,NULL,'app','m191107_122000_add_gql_project_config_support','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','f7c6ddf3-980e-4a15-b33e-76f4b36b04af'),(158,NULL,'app','m191204_085100_pack_savable_component_settings','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','13d03f70-9dac-4751-a507-b699eb6e7930'),(159,NULL,'app','m191206_001148_change_tracking','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','68d2e1d3-cadb-4f41-a397-111b35e5814d'),(160,NULL,'app','m191216_191635_asset_upload_tracking','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','25fefb76-44d3-4995-929a-9405ae04be30'),(161,NULL,'app','m191222_002848_peer_asset_permissions','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','4905a582-607f-437e-83a5-de9ddabc0516'),(162,NULL,'app','m200127_172522_queue_channels','2020-02-05 21:43:45','2020-02-05 21:43:45','2020-02-05 21:43:45','a43cda8a-55d1-446b-a96b-eb52778556db'),(163,1,'plugin','Install','2020-02-05 21:44:56','2020-02-05 21:44:56','2020-02-05 21:44:56','4a8d59d1-c044-49b5-a2d7-280ce6f89ff9'),(164,1,'plugin','m190815_143313_UpdateFieldLayouts','2020-02-05 21:44:56','2020-02-05 21:44:56','2020-02-05 21:44:56','3783dff2-2d63-44e3-b6c8-7ad03e14b788'),(165,1,'plugin','m190815_153234_UpdateBlockTypeContexts','2020-02-05 21:44:56','2020-02-05 21:44:56','2020-02-05 21:44:56','09969e27-9bf2-49a9-b875-02a145453b6b'),(166,1,'plugin','m191122_115434_UpgradeToSupportProjectConfig','2020-02-05 21:44:56','2020-02-05 21:44:56','2020-02-05 21:44:56','31496827-af13-4dc9-80b7-54c72835f931'),(167,1,'plugin','m200204_132923_FixBlockTypeSorting','2020-02-05 21:44:56','2020-02-05 21:44:56','2020-02-05 21:44:56','9c56426c-84d0-4022-b917-7f6329924355'),(168,2,'plugin','m180430_204710_remove_old_plugins','2020-02-05 21:45:03','2020-02-05 21:45:03','2020-02-05 21:45:03','c83d2bdc-b07f-451e-b3de-4d30770794db'),(169,2,'plugin','Install','2020-02-05 21:45:03','2020-02-05 21:45:03','2020-02-05 21:45:03','e1244dbd-1e3c-4d85-ab4b-753b636ab4b2'),(170,2,'plugin','m190225_003922_split_cleanup_html_settings','2020-02-05 21:45:03','2020-02-05 21:45:03','2020-02-05 21:45:03','70bb853d-4433-4116-a5d4-ce26f4de520c'),(171,NULL,'app','m200211_175048_truncate_element_query_cache','2020-04-08 22:19:10','2020-04-08 22:19:10','2020-04-08 22:19:10','08e4725e-3851-4ae5-97ff-faae073561c6'),(172,NULL,'app','m200213_172522_new_elements_index','2020-04-08 22:19:11','2020-04-08 22:19:11','2020-04-08 22:19:11','6abdce38-b60a-4df0-9c7d-bc17d83f64fd'),(173,NULL,'app','m200228_195211_long_deprecation_messages','2020-04-08 22:19:11','2020-04-08 22:19:11','2020-04-08 22:19:11','41a9606a-25eb-4bdf-86e4-11f456aa8599');
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `plugins`
--

LOCK TABLES `plugins` WRITE;
/*!40000 ALTER TABLE `plugins` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `plugins` VALUES (1,'spoon','3.5.2','3.5.0','invalid',NULL,'2020-02-05 21:44:56','2020-02-05 21:44:56','2020-04-08 22:21:12','d6d1da46-efee-4de9-a279-2edd6ffbe362'),(2,'redactor','2.6.1','2.3.0','unknown',NULL,'2020-02-05 21:45:03','2020-02-05 21:45:03','2020-04-08 22:21:12','a1217d16-e982-46fe-9e45-e86b0b72b8ce'),(3,'redactor-tweaks','2.0.2','1.0.0','unknown',NULL,'2020-02-05 21:45:06','2020-02-05 21:45:06','2020-04-08 22:21:12','a0187e66-db3e-4686-a0aa-347810491209'),(4,'redactor-custom-styles','3.0.3','1.0.0','unknown',NULL,'2020-02-05 21:45:12','2020-02-05 21:45:12','2020-04-08 22:21:12','3209926a-ff09-4591-8cef-9a9a1ebdb776'),(5,'matrix-colors','2.0.1','2.0.0','unknown',NULL,'2020-02-05 21:45:15','2020-02-05 21:45:15','2020-04-08 22:21:12','d3c007bd-41ce-4008-a24c-a3b231972379'),(6,'cp-field-inspect','1.1.3','1.0.0','unknown',NULL,'2020-02-05 23:20:13','2020-02-05 23:20:13','2020-04-08 22:21:12','15281d6c-3ffd-4d28-8e43-2221d50ebfca'),(7,'colour-swatches','1.2.3','1.0.0','unknown',NULL,'2020-02-06 04:44:33','2020-02-06 04:44:33','2020-04-08 22:21:12','885174d1-e1aa-433d-a29b-d1f96a472032');
/*!40000 ALTER TABLE `plugins` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `projectconfig`
--

LOCK TABLES `projectconfig` WRITE;
/*!40000 ALTER TABLE `projectconfig` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `projectconfig` VALUES ('dateModified','1586384351'),('email.fromEmail','\"support@doublesecretagency.com\"'),('email.fromName','\"Prototype\"'),('email.transportType','\"craft\\\\mail\\\\transportadapters\\\\Sendmail\"'),('fieldGroups.18d36d4e-9c72-4fcf-97a1-a668b70fd249.name','\"Matrix\"'),('fieldGroups.a49a5b87-47ff-421f-94c5-d11727a48206.name','\"Dropdown\"'),('fields.57439ba8-7b9a-4a6f-925c-791faec8269a.contentColumnType','\"string\"'),('fields.57439ba8-7b9a-4a6f-925c-791faec8269a.fieldGroup','\"18d36d4e-9c72-4fcf-97a1-a668b70fd249\"'),('fields.57439ba8-7b9a-4a6f-925c-791faec8269a.handle','\"panels\"'),('fields.57439ba8-7b9a-4a6f-925c-791faec8269a.instructions','\"\"'),('fields.57439ba8-7b9a-4a6f-925c-791faec8269a.name','\"Panels\"'),('fields.57439ba8-7b9a-4a6f-925c-791faec8269a.searchable','false'),('fields.57439ba8-7b9a-4a6f-925c-791faec8269a.settings.contentTable','\"{{%matrixcontent_panels}}\"'),('fields.57439ba8-7b9a-4a6f-925c-791faec8269a.settings.maxBlocks','\"\"'),('fields.57439ba8-7b9a-4a6f-925c-791faec8269a.settings.minBlocks','\"\"'),('fields.57439ba8-7b9a-4a6f-925c-791faec8269a.settings.propagationMethod','\"all\"'),('fields.57439ba8-7b9a-4a6f-925c-791faec8269a.translationKeyFormat','null'),('fields.57439ba8-7b9a-4a6f-925c-791faec8269a.translationMethod','\"site\"'),('fields.57439ba8-7b9a-4a6f-925c-791faec8269a.type','\"craft\\\\fields\\\\Matrix\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.field','\"57439ba8-7b9a-4a6f-925c-791faec8269a\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fieldLayouts.fe6d1ad7-77ef-4195-8592-4dfc70bc03ed.tabs.0.fields.84a8c477-8e17-4f1a-a658-6602b973979e.required','false'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fieldLayouts.fe6d1ad7-77ef-4195-8592-4dfc70bc03ed.tabs.0.fields.84a8c477-8e17-4f1a-a658-6602b973979e.sortOrder','3'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fieldLayouts.fe6d1ad7-77ef-4195-8592-4dfc70bc03ed.tabs.0.fields.a860e0df-26ec-48e1-9cc7-f78e62f6b07d.required','false'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fieldLayouts.fe6d1ad7-77ef-4195-8592-4dfc70bc03ed.tabs.0.fields.a860e0df-26ec-48e1-9cc7-f78e62f6b07d.sortOrder','2'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fieldLayouts.fe6d1ad7-77ef-4195-8592-4dfc70bc03ed.tabs.0.fields.d8193927-d011-4f5e-a6f2-244e8be9de3c.required','false'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fieldLayouts.fe6d1ad7-77ef-4195-8592-4dfc70bc03ed.tabs.0.fields.d8193927-d011-4f5e-a6f2-244e8be9de3c.sortOrder','1'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fieldLayouts.fe6d1ad7-77ef-4195-8592-4dfc70bc03ed.tabs.0.name','\"Content\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fieldLayouts.fe6d1ad7-77ef-4195-8592-4dfc70bc03ed.tabs.0.sortOrder','1'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.84a8c477-8e17-4f1a-a658-6602b973979e.contentColumnType','\"string\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.84a8c477-8e17-4f1a-a658-6602b973979e.fieldGroup','null'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.84a8c477-8e17-4f1a-a658-6602b973979e.handle','\"margin\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.84a8c477-8e17-4f1a-a658-6602b973979e.instructions','\"\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.84a8c477-8e17-4f1a-a658-6602b973979e.name','\"Margin\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.84a8c477-8e17-4f1a-a658-6602b973979e.searchable','false'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.84a8c477-8e17-4f1a-a658-6602b973979e.settings.optgroups','true'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.84a8c477-8e17-4f1a-a658-6602b973979e.settings.options.0.__assoc__.0.0','\"label\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.84a8c477-8e17-4f1a-a658-6602b973979e.settings.options.0.__assoc__.0.1','\"None\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.84a8c477-8e17-4f1a-a658-6602b973979e.settings.options.0.__assoc__.1.0','\"value\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.84a8c477-8e17-4f1a-a658-6602b973979e.settings.options.0.__assoc__.1.1','\"m-0\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.84a8c477-8e17-4f1a-a658-6602b973979e.settings.options.0.__assoc__.2.0','\"default\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.84a8c477-8e17-4f1a-a658-6602b973979e.settings.options.0.__assoc__.2.1','\"\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.84a8c477-8e17-4f1a-a658-6602b973979e.settings.options.1.__assoc__.0.0','\"label\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.84a8c477-8e17-4f1a-a658-6602b973979e.settings.options.1.__assoc__.0.1','\"Small\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.84a8c477-8e17-4f1a-a658-6602b973979e.settings.options.1.__assoc__.1.0','\"value\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.84a8c477-8e17-4f1a-a658-6602b973979e.settings.options.1.__assoc__.1.1','\"m-1\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.84a8c477-8e17-4f1a-a658-6602b973979e.settings.options.1.__assoc__.2.0','\"default\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.84a8c477-8e17-4f1a-a658-6602b973979e.settings.options.1.__assoc__.2.1','\"\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.84a8c477-8e17-4f1a-a658-6602b973979e.settings.options.2.__assoc__.0.0','\"label\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.84a8c477-8e17-4f1a-a658-6602b973979e.settings.options.2.__assoc__.0.1','\"Medium\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.84a8c477-8e17-4f1a-a658-6602b973979e.settings.options.2.__assoc__.1.0','\"value\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.84a8c477-8e17-4f1a-a658-6602b973979e.settings.options.2.__assoc__.1.1','\"m-2\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.84a8c477-8e17-4f1a-a658-6602b973979e.settings.options.2.__assoc__.2.0','\"default\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.84a8c477-8e17-4f1a-a658-6602b973979e.settings.options.2.__assoc__.2.1','\"\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.84a8c477-8e17-4f1a-a658-6602b973979e.settings.options.3.__assoc__.0.0','\"label\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.84a8c477-8e17-4f1a-a658-6602b973979e.settings.options.3.__assoc__.0.1','\"Large\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.84a8c477-8e17-4f1a-a658-6602b973979e.settings.options.3.__assoc__.1.0','\"value\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.84a8c477-8e17-4f1a-a658-6602b973979e.settings.options.3.__assoc__.1.1','\"m-3\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.84a8c477-8e17-4f1a-a658-6602b973979e.settings.options.3.__assoc__.2.0','\"default\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.84a8c477-8e17-4f1a-a658-6602b973979e.settings.options.3.__assoc__.2.1','\"\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.84a8c477-8e17-4f1a-a658-6602b973979e.translationKeyFormat','null'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.84a8c477-8e17-4f1a-a658-6602b973979e.translationMethod','\"none\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.84a8c477-8e17-4f1a-a658-6602b973979e.type','\"craft\\\\fields\\\\Dropdown\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.a860e0df-26ec-48e1-9cc7-f78e62f6b07d.contentColumnType','\"string\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.a860e0df-26ec-48e1-9cc7-f78e62f6b07d.fieldGroup','null'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.a860e0df-26ec-48e1-9cc7-f78e62f6b07d.handle','\"padding\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.a860e0df-26ec-48e1-9cc7-f78e62f6b07d.instructions','\"\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.a860e0df-26ec-48e1-9cc7-f78e62f6b07d.name','\"Padding\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.a860e0df-26ec-48e1-9cc7-f78e62f6b07d.searchable','false'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.a860e0df-26ec-48e1-9cc7-f78e62f6b07d.settings.optgroups','true'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.a860e0df-26ec-48e1-9cc7-f78e62f6b07d.settings.options.0.__assoc__.0.0','\"label\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.a860e0df-26ec-48e1-9cc7-f78e62f6b07d.settings.options.0.__assoc__.0.1','\"None\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.a860e0df-26ec-48e1-9cc7-f78e62f6b07d.settings.options.0.__assoc__.1.0','\"value\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.a860e0df-26ec-48e1-9cc7-f78e62f6b07d.settings.options.0.__assoc__.1.1','\"p-0\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.a860e0df-26ec-48e1-9cc7-f78e62f6b07d.settings.options.0.__assoc__.2.0','\"default\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.a860e0df-26ec-48e1-9cc7-f78e62f6b07d.settings.options.0.__assoc__.2.1','\"\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.a860e0df-26ec-48e1-9cc7-f78e62f6b07d.settings.options.1.__assoc__.0.0','\"label\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.a860e0df-26ec-48e1-9cc7-f78e62f6b07d.settings.options.1.__assoc__.0.1','\"Small\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.a860e0df-26ec-48e1-9cc7-f78e62f6b07d.settings.options.1.__assoc__.1.0','\"value\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.a860e0df-26ec-48e1-9cc7-f78e62f6b07d.settings.options.1.__assoc__.1.1','\"p-1\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.a860e0df-26ec-48e1-9cc7-f78e62f6b07d.settings.options.1.__assoc__.2.0','\"default\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.a860e0df-26ec-48e1-9cc7-f78e62f6b07d.settings.options.1.__assoc__.2.1','\"\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.a860e0df-26ec-48e1-9cc7-f78e62f6b07d.settings.options.2.__assoc__.0.0','\"label\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.a860e0df-26ec-48e1-9cc7-f78e62f6b07d.settings.options.2.__assoc__.0.1','\"Medium\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.a860e0df-26ec-48e1-9cc7-f78e62f6b07d.settings.options.2.__assoc__.1.0','\"value\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.a860e0df-26ec-48e1-9cc7-f78e62f6b07d.settings.options.2.__assoc__.1.1','\"p-2\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.a860e0df-26ec-48e1-9cc7-f78e62f6b07d.settings.options.2.__assoc__.2.0','\"default\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.a860e0df-26ec-48e1-9cc7-f78e62f6b07d.settings.options.2.__assoc__.2.1','\"\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.a860e0df-26ec-48e1-9cc7-f78e62f6b07d.settings.options.3.__assoc__.0.0','\"label\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.a860e0df-26ec-48e1-9cc7-f78e62f6b07d.settings.options.3.__assoc__.0.1','\"Large\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.a860e0df-26ec-48e1-9cc7-f78e62f6b07d.settings.options.3.__assoc__.1.0','\"value\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.a860e0df-26ec-48e1-9cc7-f78e62f6b07d.settings.options.3.__assoc__.1.1','\"p-3\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.a860e0df-26ec-48e1-9cc7-f78e62f6b07d.settings.options.3.__assoc__.2.0','\"default\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.a860e0df-26ec-48e1-9cc7-f78e62f6b07d.settings.options.3.__assoc__.2.1','\"\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.a860e0df-26ec-48e1-9cc7-f78e62f6b07d.translationKeyFormat','null'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.a860e0df-26ec-48e1-9cc7-f78e62f6b07d.translationMethod','\"none\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.a860e0df-26ec-48e1-9cc7-f78e62f6b07d.type','\"craft\\\\fields\\\\Dropdown\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.d8193927-d011-4f5e-a6f2-244e8be9de3c.contentColumnType','\"string\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.d8193927-d011-4f5e-a6f2-244e8be9de3c.fieldGroup','null'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.d8193927-d011-4f5e-a6f2-244e8be9de3c.handle','\"image\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.d8193927-d011-4f5e-a6f2-244e8be9de3c.instructions','\"\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.d8193927-d011-4f5e-a6f2-244e8be9de3c.name','\"__blank__\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.d8193927-d011-4f5e-a6f2-244e8be9de3c.searchable','false'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.d8193927-d011-4f5e-a6f2-244e8be9de3c.settings.allowedKinds.0','\"image\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.d8193927-d011-4f5e-a6f2-244e8be9de3c.settings.defaultUploadLocationSource','\"\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.d8193927-d011-4f5e-a6f2-244e8be9de3c.settings.defaultUploadLocationSubpath','\"\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.d8193927-d011-4f5e-a6f2-244e8be9de3c.settings.limit','\"1\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.d8193927-d011-4f5e-a6f2-244e8be9de3c.settings.localizeRelations','false'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.d8193927-d011-4f5e-a6f2-244e8be9de3c.settings.restrictFiles','\"1\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.d8193927-d011-4f5e-a6f2-244e8be9de3c.settings.selectionLabel','\"\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.d8193927-d011-4f5e-a6f2-244e8be9de3c.settings.showUnpermittedFiles','false'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.d8193927-d011-4f5e-a6f2-244e8be9de3c.settings.showUnpermittedVolumes','false'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.d8193927-d011-4f5e-a6f2-244e8be9de3c.settings.singleUploadLocationSource','\"\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.d8193927-d011-4f5e-a6f2-244e8be9de3c.settings.singleUploadLocationSubpath','\"\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.d8193927-d011-4f5e-a6f2-244e8be9de3c.settings.source','null'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.d8193927-d011-4f5e-a6f2-244e8be9de3c.settings.sources','\"*\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.d8193927-d011-4f5e-a6f2-244e8be9de3c.settings.targetSiteId','null'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.d8193927-d011-4f5e-a6f2-244e8be9de3c.settings.useSingleFolder','true'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.d8193927-d011-4f5e-a6f2-244e8be9de3c.settings.validateRelatedElements','\"\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.d8193927-d011-4f5e-a6f2-244e8be9de3c.settings.viewMode','\"list\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.d8193927-d011-4f5e-a6f2-244e8be9de3c.translationKeyFormat','null'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.d8193927-d011-4f5e-a6f2-244e8be9de3c.translationMethod','\"site\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.fields.d8193927-d011-4f5e-a6f2-244e8be9de3c.type','\"craft\\\\fields\\\\Assets\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.handle','\"image\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.name','\"Image\"'),('matrixBlockTypes.909cb47c-43ec-42b7-a7c0-c62dca2bbb08.sortOrder','3'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.field','\"57439ba8-7b9a-4a6f-925c-791faec8269a\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fieldLayouts.cc16cc83-8470-48b8-bbaa-fcda87beb1ea.tabs.0.fields.03b34141-8ace-49bf-83cd-070779334bac.required','false'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fieldLayouts.cc16cc83-8470-48b8-bbaa-fcda87beb1ea.tabs.0.fields.03b34141-8ace-49bf-83cd-070779334bac.sortOrder','1'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fieldLayouts.cc16cc83-8470-48b8-bbaa-fcda87beb1ea.tabs.0.fields.10777443-a139-4a09-a2d1-dcf4c8c93597.required','false'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fieldLayouts.cc16cc83-8470-48b8-bbaa-fcda87beb1ea.tabs.0.fields.10777443-a139-4a09-a2d1-dcf4c8c93597.sortOrder','2'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fieldLayouts.cc16cc83-8470-48b8-bbaa-fcda87beb1ea.tabs.0.fields.27854c4e-fdce-42da-b6c2-85f68395135f.required','false'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fieldLayouts.cc16cc83-8470-48b8-bbaa-fcda87beb1ea.tabs.0.fields.27854c4e-fdce-42da-b6c2-85f68395135f.sortOrder','3'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fieldLayouts.cc16cc83-8470-48b8-bbaa-fcda87beb1ea.tabs.0.name','\"Content\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fieldLayouts.cc16cc83-8470-48b8-bbaa-fcda87beb1ea.tabs.0.sortOrder','1'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.03b34141-8ace-49bf-83cd-070779334bac.contentColumnType','\"text\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.03b34141-8ace-49bf-83cd-070779334bac.fieldGroup','null'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.03b34141-8ace-49bf-83cd-070779334bac.handle','\"text\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.03b34141-8ace-49bf-83cd-070779334bac.instructions','\"\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.03b34141-8ace-49bf-83cd-070779334bac.name','\"__blank__\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.03b34141-8ace-49bf-83cd-070779334bac.searchable','true'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.03b34141-8ace-49bf-83cd-070779334bac.settings.availableTransforms','\"*\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.03b34141-8ace-49bf-83cd-070779334bac.settings.availableVolumes','\"*\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.03b34141-8ace-49bf-83cd-070779334bac.settings.cleanupHtml','true'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.03b34141-8ace-49bf-83cd-070779334bac.settings.columnType','\"text\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.03b34141-8ace-49bf-83cd-070779334bac.settings.purifierConfig','\"\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.03b34141-8ace-49bf-83cd-070779334bac.settings.purifyHtml','\"1\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.03b34141-8ace-49bf-83cd-070779334bac.settings.redactorConfig','\"\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.03b34141-8ace-49bf-83cd-070779334bac.settings.removeEmptyTags','\"1\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.03b34141-8ace-49bf-83cd-070779334bac.settings.removeInlineStyles','\"1\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.03b34141-8ace-49bf-83cd-070779334bac.settings.removeNbsp','\"1\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.03b34141-8ace-49bf-83cd-070779334bac.translationKeyFormat','null'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.03b34141-8ace-49bf-83cd-070779334bac.translationMethod','\"none\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.03b34141-8ace-49bf-83cd-070779334bac.type','\"craft\\\\redactor\\\\Field\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.10777443-a139-4a09-a2d1-dcf4c8c93597.contentColumnType','\"string\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.10777443-a139-4a09-a2d1-dcf4c8c93597.fieldGroup','null'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.10777443-a139-4a09-a2d1-dcf4c8c93597.handle','\"padding\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.10777443-a139-4a09-a2d1-dcf4c8c93597.instructions','\"\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.10777443-a139-4a09-a2d1-dcf4c8c93597.name','\"Padding\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.10777443-a139-4a09-a2d1-dcf4c8c93597.searchable','false'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.10777443-a139-4a09-a2d1-dcf4c8c93597.settings.optgroups','true'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.10777443-a139-4a09-a2d1-dcf4c8c93597.settings.options.0.__assoc__.0.0','\"label\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.10777443-a139-4a09-a2d1-dcf4c8c93597.settings.options.0.__assoc__.0.1','\"None\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.10777443-a139-4a09-a2d1-dcf4c8c93597.settings.options.0.__assoc__.1.0','\"value\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.10777443-a139-4a09-a2d1-dcf4c8c93597.settings.options.0.__assoc__.1.1','\"p-0\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.10777443-a139-4a09-a2d1-dcf4c8c93597.settings.options.0.__assoc__.2.0','\"default\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.10777443-a139-4a09-a2d1-dcf4c8c93597.settings.options.0.__assoc__.2.1','\"\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.10777443-a139-4a09-a2d1-dcf4c8c93597.settings.options.1.__assoc__.0.0','\"label\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.10777443-a139-4a09-a2d1-dcf4c8c93597.settings.options.1.__assoc__.0.1','\"Small\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.10777443-a139-4a09-a2d1-dcf4c8c93597.settings.options.1.__assoc__.1.0','\"value\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.10777443-a139-4a09-a2d1-dcf4c8c93597.settings.options.1.__assoc__.1.1','\"p-2\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.10777443-a139-4a09-a2d1-dcf4c8c93597.settings.options.1.__assoc__.2.0','\"default\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.10777443-a139-4a09-a2d1-dcf4c8c93597.settings.options.1.__assoc__.2.1','\"\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.10777443-a139-4a09-a2d1-dcf4c8c93597.settings.options.2.__assoc__.0.0','\"label\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.10777443-a139-4a09-a2d1-dcf4c8c93597.settings.options.2.__assoc__.0.1','\"Medium\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.10777443-a139-4a09-a2d1-dcf4c8c93597.settings.options.2.__assoc__.1.0','\"value\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.10777443-a139-4a09-a2d1-dcf4c8c93597.settings.options.2.__assoc__.1.1','\"p-4\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.10777443-a139-4a09-a2d1-dcf4c8c93597.settings.options.2.__assoc__.2.0','\"default\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.10777443-a139-4a09-a2d1-dcf4c8c93597.settings.options.2.__assoc__.2.1','\"\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.10777443-a139-4a09-a2d1-dcf4c8c93597.settings.options.3.__assoc__.0.0','\"label\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.10777443-a139-4a09-a2d1-dcf4c8c93597.settings.options.3.__assoc__.0.1','\"Large\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.10777443-a139-4a09-a2d1-dcf4c8c93597.settings.options.3.__assoc__.1.0','\"value\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.10777443-a139-4a09-a2d1-dcf4c8c93597.settings.options.3.__assoc__.1.1','\"p-5\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.10777443-a139-4a09-a2d1-dcf4c8c93597.settings.options.3.__assoc__.2.0','\"default\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.10777443-a139-4a09-a2d1-dcf4c8c93597.settings.options.3.__assoc__.2.1','\"\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.10777443-a139-4a09-a2d1-dcf4c8c93597.translationKeyFormat','null'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.10777443-a139-4a09-a2d1-dcf4c8c93597.translationMethod','\"none\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.10777443-a139-4a09-a2d1-dcf4c8c93597.type','\"craft\\\\fields\\\\Dropdown\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.27854c4e-fdce-42da-b6c2-85f68395135f.contentColumnType','\"string\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.27854c4e-fdce-42da-b6c2-85f68395135f.fieldGroup','null'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.27854c4e-fdce-42da-b6c2-85f68395135f.handle','\"margin\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.27854c4e-fdce-42da-b6c2-85f68395135f.instructions','\"\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.27854c4e-fdce-42da-b6c2-85f68395135f.name','\"Margin\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.27854c4e-fdce-42da-b6c2-85f68395135f.searchable','false'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.27854c4e-fdce-42da-b6c2-85f68395135f.settings.optgroups','true'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.27854c4e-fdce-42da-b6c2-85f68395135f.settings.options.0.__assoc__.0.0','\"label\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.27854c4e-fdce-42da-b6c2-85f68395135f.settings.options.0.__assoc__.0.1','\"None\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.27854c4e-fdce-42da-b6c2-85f68395135f.settings.options.0.__assoc__.1.0','\"value\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.27854c4e-fdce-42da-b6c2-85f68395135f.settings.options.0.__assoc__.1.1','\"m-0\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.27854c4e-fdce-42da-b6c2-85f68395135f.settings.options.0.__assoc__.2.0','\"default\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.27854c4e-fdce-42da-b6c2-85f68395135f.settings.options.0.__assoc__.2.1','\"\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.27854c4e-fdce-42da-b6c2-85f68395135f.settings.options.1.__assoc__.0.0','\"label\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.27854c4e-fdce-42da-b6c2-85f68395135f.settings.options.1.__assoc__.0.1','\"Small\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.27854c4e-fdce-42da-b6c2-85f68395135f.settings.options.1.__assoc__.1.0','\"value\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.27854c4e-fdce-42da-b6c2-85f68395135f.settings.options.1.__assoc__.1.1','\"m-1\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.27854c4e-fdce-42da-b6c2-85f68395135f.settings.options.1.__assoc__.2.0','\"default\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.27854c4e-fdce-42da-b6c2-85f68395135f.settings.options.1.__assoc__.2.1','\"\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.27854c4e-fdce-42da-b6c2-85f68395135f.settings.options.2.__assoc__.0.0','\"label\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.27854c4e-fdce-42da-b6c2-85f68395135f.settings.options.2.__assoc__.0.1','\"Medium\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.27854c4e-fdce-42da-b6c2-85f68395135f.settings.options.2.__assoc__.1.0','\"value\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.27854c4e-fdce-42da-b6c2-85f68395135f.settings.options.2.__assoc__.1.1','\"m-2\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.27854c4e-fdce-42da-b6c2-85f68395135f.settings.options.2.__assoc__.2.0','\"default\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.27854c4e-fdce-42da-b6c2-85f68395135f.settings.options.2.__assoc__.2.1','\"\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.27854c4e-fdce-42da-b6c2-85f68395135f.settings.options.3.__assoc__.0.0','\"label\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.27854c4e-fdce-42da-b6c2-85f68395135f.settings.options.3.__assoc__.0.1','\"Large\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.27854c4e-fdce-42da-b6c2-85f68395135f.settings.options.3.__assoc__.1.0','\"value\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.27854c4e-fdce-42da-b6c2-85f68395135f.settings.options.3.__assoc__.1.1','\"m-3\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.27854c4e-fdce-42da-b6c2-85f68395135f.settings.options.3.__assoc__.2.0','\"default\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.27854c4e-fdce-42da-b6c2-85f68395135f.settings.options.3.__assoc__.2.1','\"\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.27854c4e-fdce-42da-b6c2-85f68395135f.translationKeyFormat','null'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.27854c4e-fdce-42da-b6c2-85f68395135f.translationMethod','\"none\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.fields.27854c4e-fdce-42da-b6c2-85f68395135f.type','\"craft\\\\fields\\\\Dropdown\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.handle','\"text\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.name','\"Text\"'),('matrixBlockTypes.bd566221-af4b-40b9-a950-8f04d2c59b8c.sortOrder','1'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.field','\"57439ba8-7b9a-4a6f-925c-791faec8269a\"'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fieldLayouts.3c6f922b-8c79-41b1-a050-c921a89d41de.tabs.0.fields.5d36ed79-72af-4edb-b06b-3c9acab5044e.required','false'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fieldLayouts.3c6f922b-8c79-41b1-a050-c921a89d41de.tabs.0.fields.5d36ed79-72af-4edb-b06b-3c9acab5044e.sortOrder','1'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fieldLayouts.3c6f922b-8c79-41b1-a050-c921a89d41de.tabs.0.fields.a1d312b0-6ec3-4aee-98fc-dc88d84c984d.required','false'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fieldLayouts.3c6f922b-8c79-41b1-a050-c921a89d41de.tabs.0.fields.a1d312b0-6ec3-4aee-98fc-dc88d84c984d.sortOrder','3'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fieldLayouts.3c6f922b-8c79-41b1-a050-c921a89d41de.tabs.0.fields.a90b7884-a1ae-4406-9272-d47261cc9f83.required','false'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fieldLayouts.3c6f922b-8c79-41b1-a050-c921a89d41de.tabs.0.fields.a90b7884-a1ae-4406-9272-d47261cc9f83.sortOrder','2'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fieldLayouts.3c6f922b-8c79-41b1-a050-c921a89d41de.tabs.0.name','\"Content\"'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fieldLayouts.3c6f922b-8c79-41b1-a050-c921a89d41de.tabs.0.sortOrder','1'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.5d36ed79-72af-4edb-b06b-3c9acab5044e.contentColumnType','\"text\"'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.5d36ed79-72af-4edb-b06b-3c9acab5044e.fieldGroup','null'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.5d36ed79-72af-4edb-b06b-3c9acab5044e.handle','\"embed\"'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.5d36ed79-72af-4edb-b06b-3c9acab5044e.instructions','\"\"'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.5d36ed79-72af-4edb-b06b-3c9acab5044e.name','\"__blank__\"'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.5d36ed79-72af-4edb-b06b-3c9acab5044e.searchable','false'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.5d36ed79-72af-4edb-b06b-3c9acab5044e.settings.byteLimit','null'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.5d36ed79-72af-4edb-b06b-3c9acab5044e.settings.charLimit','null'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.5d36ed79-72af-4edb-b06b-3c9acab5044e.settings.code','\"1\"'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.5d36ed79-72af-4edb-b06b-3c9acab5044e.settings.columnType','null'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.5d36ed79-72af-4edb-b06b-3c9acab5044e.settings.initialRows','\"4\"'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.5d36ed79-72af-4edb-b06b-3c9acab5044e.settings.multiline','\"1\"'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.5d36ed79-72af-4edb-b06b-3c9acab5044e.settings.placeholder','\"\"'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.5d36ed79-72af-4edb-b06b-3c9acab5044e.translationKeyFormat','null'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.5d36ed79-72af-4edb-b06b-3c9acab5044e.translationMethod','\"none\"'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.5d36ed79-72af-4edb-b06b-3c9acab5044e.type','\"craft\\\\fields\\\\PlainText\"'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.a1d312b0-6ec3-4aee-98fc-dc88d84c984d.contentColumnType','\"string\"'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.a1d312b0-6ec3-4aee-98fc-dc88d84c984d.fieldGroup','null'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.a1d312b0-6ec3-4aee-98fc-dc88d84c984d.handle','\"margin\"'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.a1d312b0-6ec3-4aee-98fc-dc88d84c984d.instructions','\"\"'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.a1d312b0-6ec3-4aee-98fc-dc88d84c984d.name','\"Margin\"'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.a1d312b0-6ec3-4aee-98fc-dc88d84c984d.searchable','false'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.a1d312b0-6ec3-4aee-98fc-dc88d84c984d.settings.optgroups','true'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.a1d312b0-6ec3-4aee-98fc-dc88d84c984d.settings.options.0.__assoc__.0.0','\"label\"'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.a1d312b0-6ec3-4aee-98fc-dc88d84c984d.settings.options.0.__assoc__.0.1','\"None\"'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.a1d312b0-6ec3-4aee-98fc-dc88d84c984d.settings.options.0.__assoc__.1.0','\"value\"'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.a1d312b0-6ec3-4aee-98fc-dc88d84c984d.settings.options.0.__assoc__.1.1','\"m-0\"'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.a1d312b0-6ec3-4aee-98fc-dc88d84c984d.settings.options.0.__assoc__.2.0','\"default\"'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.a1d312b0-6ec3-4aee-98fc-dc88d84c984d.settings.options.0.__assoc__.2.1','\"\"'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.a1d312b0-6ec3-4aee-98fc-dc88d84c984d.settings.options.1.__assoc__.0.0','\"label\"'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.a1d312b0-6ec3-4aee-98fc-dc88d84c984d.settings.options.1.__assoc__.0.1','\"Small\"'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.a1d312b0-6ec3-4aee-98fc-dc88d84c984d.settings.options.1.__assoc__.1.0','\"value\"'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.a1d312b0-6ec3-4aee-98fc-dc88d84c984d.settings.options.1.__assoc__.1.1','\"m-1\"'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.a1d312b0-6ec3-4aee-98fc-dc88d84c984d.settings.options.1.__assoc__.2.0','\"default\"'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.a1d312b0-6ec3-4aee-98fc-dc88d84c984d.settings.options.1.__assoc__.2.1','\"\"'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.a1d312b0-6ec3-4aee-98fc-dc88d84c984d.settings.options.2.__assoc__.0.0','\"label\"'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.a1d312b0-6ec3-4aee-98fc-dc88d84c984d.settings.options.2.__assoc__.0.1','\"Medium\"'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.a1d312b0-6ec3-4aee-98fc-dc88d84c984d.settings.options.2.__assoc__.1.0','\"value\"'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.a1d312b0-6ec3-4aee-98fc-dc88d84c984d.settings.options.2.__assoc__.1.1','\"m-2\"'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.a1d312b0-6ec3-4aee-98fc-dc88d84c984d.settings.options.2.__assoc__.2.0','\"default\"'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.a1d312b0-6ec3-4aee-98fc-dc88d84c984d.settings.options.2.__assoc__.2.1','\"\"'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.a1d312b0-6ec3-4aee-98fc-dc88d84c984d.settings.options.3.__assoc__.0.0','\"label\"'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.a1d312b0-6ec3-4aee-98fc-dc88d84c984d.settings.options.3.__assoc__.0.1','\"Large\"'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.a1d312b0-6ec3-4aee-98fc-dc88d84c984d.settings.options.3.__assoc__.1.0','\"value\"'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.a1d312b0-6ec3-4aee-98fc-dc88d84c984d.settings.options.3.__assoc__.1.1','\"m-3\"'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.a1d312b0-6ec3-4aee-98fc-dc88d84c984d.settings.options.3.__assoc__.2.0','\"default\"'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.a1d312b0-6ec3-4aee-98fc-dc88d84c984d.settings.options.3.__assoc__.2.1','\"\"'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.a1d312b0-6ec3-4aee-98fc-dc88d84c984d.translationKeyFormat','null'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.a1d312b0-6ec3-4aee-98fc-dc88d84c984d.translationMethod','\"none\"'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.a1d312b0-6ec3-4aee-98fc-dc88d84c984d.type','\"craft\\\\fields\\\\Dropdown\"'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.a90b7884-a1ae-4406-9272-d47261cc9f83.contentColumnType','\"string\"'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.a90b7884-a1ae-4406-9272-d47261cc9f83.fieldGroup','null'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.a90b7884-a1ae-4406-9272-d47261cc9f83.handle','\"padding\"'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.a90b7884-a1ae-4406-9272-d47261cc9f83.instructions','\"\"'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.a90b7884-a1ae-4406-9272-d47261cc9f83.name','\"Padding\"'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.a90b7884-a1ae-4406-9272-d47261cc9f83.searchable','false'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.a90b7884-a1ae-4406-9272-d47261cc9f83.settings.optgroups','true'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.a90b7884-a1ae-4406-9272-d47261cc9f83.settings.options.0.__assoc__.0.0','\"label\"'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.a90b7884-a1ae-4406-9272-d47261cc9f83.settings.options.0.__assoc__.0.1','\"None\"'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.a90b7884-a1ae-4406-9272-d47261cc9f83.settings.options.0.__assoc__.1.0','\"value\"'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.a90b7884-a1ae-4406-9272-d47261cc9f83.settings.options.0.__assoc__.1.1','\"p-0\"'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.a90b7884-a1ae-4406-9272-d47261cc9f83.settings.options.0.__assoc__.2.0','\"default\"'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.a90b7884-a1ae-4406-9272-d47261cc9f83.settings.options.0.__assoc__.2.1','\"\"'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.a90b7884-a1ae-4406-9272-d47261cc9f83.settings.options.1.__assoc__.0.0','\"label\"'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.a90b7884-a1ae-4406-9272-d47261cc9f83.settings.options.1.__assoc__.0.1','\"Small\"'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.a90b7884-a1ae-4406-9272-d47261cc9f83.settings.options.1.__assoc__.1.0','\"value\"'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.a90b7884-a1ae-4406-9272-d47261cc9f83.settings.options.1.__assoc__.1.1','\"p-1\"'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.a90b7884-a1ae-4406-9272-d47261cc9f83.settings.options.1.__assoc__.2.0','\"default\"'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.a90b7884-a1ae-4406-9272-d47261cc9f83.settings.options.1.__assoc__.2.1','\"\"'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.a90b7884-a1ae-4406-9272-d47261cc9f83.settings.options.2.__assoc__.0.0','\"label\"'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.a90b7884-a1ae-4406-9272-d47261cc9f83.settings.options.2.__assoc__.0.1','\"Medium\"'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.a90b7884-a1ae-4406-9272-d47261cc9f83.settings.options.2.__assoc__.1.0','\"value\"'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.a90b7884-a1ae-4406-9272-d47261cc9f83.settings.options.2.__assoc__.1.1','\"p-2\"'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.a90b7884-a1ae-4406-9272-d47261cc9f83.settings.options.2.__assoc__.2.0','\"default\"'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.a90b7884-a1ae-4406-9272-d47261cc9f83.settings.options.2.__assoc__.2.1','\"\"'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.a90b7884-a1ae-4406-9272-d47261cc9f83.settings.options.3.__assoc__.0.0','\"label\"'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.a90b7884-a1ae-4406-9272-d47261cc9f83.settings.options.3.__assoc__.0.1','\"Large\"'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.a90b7884-a1ae-4406-9272-d47261cc9f83.settings.options.3.__assoc__.1.0','\"value\"'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.a90b7884-a1ae-4406-9272-d47261cc9f83.settings.options.3.__assoc__.1.1','\"p-3\"'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.a90b7884-a1ae-4406-9272-d47261cc9f83.settings.options.3.__assoc__.2.0','\"default\"'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.a90b7884-a1ae-4406-9272-d47261cc9f83.settings.options.3.__assoc__.2.1','\"\"'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.a90b7884-a1ae-4406-9272-d47261cc9f83.translationKeyFormat','null'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.a90b7884-a1ae-4406-9272-d47261cc9f83.translationMethod','\"none\"'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.fields.a90b7884-a1ae-4406-9272-d47261cc9f83.type','\"craft\\\\fields\\\\Dropdown\"'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.handle','\"embed\"'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.name','\"Embed\"'),('matrixBlockTypes.ca4a9a7e-193b-499a-88cd-b1f889361bc0.sortOrder','2'),('plugins.colour-swatches.edition','\"standard\"'),('plugins.colour-swatches.enabled','true'),('plugins.colour-swatches.schemaVersion','\"1.0.0\"'),('plugins.cp-field-inspect.edition','\"standard\"'),('plugins.cp-field-inspect.enabled','true'),('plugins.cp-field-inspect.schemaVersion','\"1.0.0\"'),('plugins.matrix-colors.edition','\"standard\"'),('plugins.matrix-colors.enabled','true'),('plugins.matrix-colors.schemaVersion','\"2.0.0\"'),('plugins.matrix-colors.settings.matrixBlockColors.0.__assoc__.0.0','\"blockType\"'),('plugins.matrix-colors.settings.matrixBlockColors.0.__assoc__.0.1','\"text\"'),('plugins.matrix-colors.settings.matrixBlockColors.0.__assoc__.1.0','\"backgroundColor\"'),('plugins.matrix-colors.settings.matrixBlockColors.0.__assoc__.1.1','\"#deecd5\"'),('plugins.matrix-colors.settings.matrixBlockColors.1.__assoc__.0.0','\"blockType\"'),('plugins.matrix-colors.settings.matrixBlockColors.1.__assoc__.0.1','\"embed\"'),('plugins.matrix-colors.settings.matrixBlockColors.1.__assoc__.1.0','\"backgroundColor\"'),('plugins.matrix-colors.settings.matrixBlockColors.1.__assoc__.1.1','\"#dbd8ee\"'),('plugins.matrix-colors.settings.matrixBlockColors.2.__assoc__.0.0','\"blockType\"'),('plugins.matrix-colors.settings.matrixBlockColors.2.__assoc__.0.1','\"image\"'),('plugins.matrix-colors.settings.matrixBlockColors.2.__assoc__.1.0','\"backgroundColor\"'),('plugins.matrix-colors.settings.matrixBlockColors.2.__assoc__.1.1','\"#ecddd5\"'),('plugins.redactor-custom-styles.edition','\"standard\"'),('plugins.redactor-custom-styles.enabled','true'),('plugins.redactor-custom-styles.schemaVersion','\"1.0.0\"'),('plugins.redactor-tweaks.edition','\"standard\"'),('plugins.redactor-tweaks.enabled','true'),('plugins.redactor-tweaks.schemaVersion','\"1.0.0\"'),('plugins.redactor.edition','\"standard\"'),('plugins.redactor.enabled','true'),('plugins.redactor.schemaVersion','\"2.3.0\"'),('plugins.spoon.edition','\"standard\"'),('plugins.spoon.enabled','true'),('plugins.spoon.schemaVersion','\"3.5.0\"'),('sections.b0ac9541-cb53-4dc6-86e4-56cb0604c874.enableVersioning','false'),('sections.b0ac9541-cb53-4dc6-86e4-56cb0604c874.entryTypes.e8ee1969-bc9d-4366-919d-bd9d88737188.fieldLayouts.47f51c95-5f9f-4a34-900c-e4301d1cffcf.tabs.0.fields.57439ba8-7b9a-4a6f-925c-791faec8269a.required','false'),('sections.b0ac9541-cb53-4dc6-86e4-56cb0604c874.entryTypes.e8ee1969-bc9d-4366-919d-bd9d88737188.fieldLayouts.47f51c95-5f9f-4a34-900c-e4301d1cffcf.tabs.0.fields.57439ba8-7b9a-4a6f-925c-791faec8269a.sortOrder','1'),('sections.b0ac9541-cb53-4dc6-86e4-56cb0604c874.entryTypes.e8ee1969-bc9d-4366-919d-bd9d88737188.fieldLayouts.47f51c95-5f9f-4a34-900c-e4301d1cffcf.tabs.0.name','\"Content\"'),('sections.b0ac9541-cb53-4dc6-86e4-56cb0604c874.entryTypes.e8ee1969-bc9d-4366-919d-bd9d88737188.fieldLayouts.47f51c95-5f9f-4a34-900c-e4301d1cffcf.tabs.0.sortOrder','1'),('sections.b0ac9541-cb53-4dc6-86e4-56cb0604c874.entryTypes.e8ee1969-bc9d-4366-919d-bd9d88737188.handle','\"articles\"'),('sections.b0ac9541-cb53-4dc6-86e4-56cb0604c874.entryTypes.e8ee1969-bc9d-4366-919d-bd9d88737188.hasTitleField','true'),('sections.b0ac9541-cb53-4dc6-86e4-56cb0604c874.entryTypes.e8ee1969-bc9d-4366-919d-bd9d88737188.name','\"Articles\"'),('sections.b0ac9541-cb53-4dc6-86e4-56cb0604c874.entryTypes.e8ee1969-bc9d-4366-919d-bd9d88737188.sortOrder','1'),('sections.b0ac9541-cb53-4dc6-86e4-56cb0604c874.entryTypes.e8ee1969-bc9d-4366-919d-bd9d88737188.titleFormat','\"\"'),('sections.b0ac9541-cb53-4dc6-86e4-56cb0604c874.entryTypes.e8ee1969-bc9d-4366-919d-bd9d88737188.titleLabel','\"Title\"'),('sections.b0ac9541-cb53-4dc6-86e4-56cb0604c874.handle','\"articles\"'),('sections.b0ac9541-cb53-4dc6-86e4-56cb0604c874.name','\"Articles\"'),('sections.b0ac9541-cb53-4dc6-86e4-56cb0604c874.propagationMethod','\"all\"'),('sections.b0ac9541-cb53-4dc6-86e4-56cb0604c874.siteSettings.1891a55f-7f04-4fc8-abfd-3fd84207d90b.enabledByDefault','true'),('sections.b0ac9541-cb53-4dc6-86e4-56cb0604c874.siteSettings.1891a55f-7f04-4fc8-abfd-3fd84207d90b.hasUrls','true'),('sections.b0ac9541-cb53-4dc6-86e4-56cb0604c874.siteSettings.1891a55f-7f04-4fc8-abfd-3fd84207d90b.template','\"\"'),('sections.b0ac9541-cb53-4dc6-86e4-56cb0604c874.siteSettings.1891a55f-7f04-4fc8-abfd-3fd84207d90b.uriFormat','\"articles/{slug}\"'),('sections.b0ac9541-cb53-4dc6-86e4-56cb0604c874.type','\"channel\"'),('siteGroups.57cd948a-2dfe-4550-b0f2-053ee01da77c.name','\"Prototype\"'),('sites.1891a55f-7f04-4fc8-abfd-3fd84207d90b.baseUrl','\"$DEFAULT_SITE_URL\"'),('sites.1891a55f-7f04-4fc8-abfd-3fd84207d90b.handle','\"default\"'),('sites.1891a55f-7f04-4fc8-abfd-3fd84207d90b.hasUrls','true'),('sites.1891a55f-7f04-4fc8-abfd-3fd84207d90b.language','\"en-US\"'),('sites.1891a55f-7f04-4fc8-abfd-3fd84207d90b.name','\"Prototype\"'),('sites.1891a55f-7f04-4fc8-abfd-3fd84207d90b.primary','true'),('sites.1891a55f-7f04-4fc8-abfd-3fd84207d90b.siteGroup','\"57cd948a-2dfe-4550-b0f2-053ee01da77c\"'),('sites.1891a55f-7f04-4fc8-abfd-3fd84207d90b.sortOrder','1'),('spoonBlockTypes.442ba350-df0e-4f73-a829-432be5815e42.context','\"global\"'),('spoonBlockTypes.442ba350-df0e-4f73-a829-432be5815e42.field','\"57439ba8-7b9a-4a6f-925c-791faec8269a\"'),('spoonBlockTypes.442ba350-df0e-4f73-a829-432be5815e42.fieldLayout.405529ec-20c5-431d-b5a4-e0bd63f3de45.tabs.0.fields.5d36ed79-72af-4edb-b06b-3c9acab5044e.required','false'),('spoonBlockTypes.442ba350-df0e-4f73-a829-432be5815e42.fieldLayout.405529ec-20c5-431d-b5a4-e0bd63f3de45.tabs.0.fields.5d36ed79-72af-4edb-b06b-3c9acab5044e.sortOrder','1'),('spoonBlockTypes.442ba350-df0e-4f73-a829-432be5815e42.fieldLayout.405529ec-20c5-431d-b5a4-e0bd63f3de45.tabs.0.name','\"Content\"'),('spoonBlockTypes.442ba350-df0e-4f73-a829-432be5815e42.fieldLayout.405529ec-20c5-431d-b5a4-e0bd63f3de45.tabs.0.sortOrder','1'),('spoonBlockTypes.442ba350-df0e-4f73-a829-432be5815e42.fieldLayout.405529ec-20c5-431d-b5a4-e0bd63f3de45.tabs.1.fields.a1d312b0-6ec3-4aee-98fc-dc88d84c984d.required','false'),('spoonBlockTypes.442ba350-df0e-4f73-a829-432be5815e42.fieldLayout.405529ec-20c5-431d-b5a4-e0bd63f3de45.tabs.1.fields.a1d312b0-6ec3-4aee-98fc-dc88d84c984d.sortOrder','2'),('spoonBlockTypes.442ba350-df0e-4f73-a829-432be5815e42.fieldLayout.405529ec-20c5-431d-b5a4-e0bd63f3de45.tabs.1.fields.a90b7884-a1ae-4406-9272-d47261cc9f83.required','false'),('spoonBlockTypes.442ba350-df0e-4f73-a829-432be5815e42.fieldLayout.405529ec-20c5-431d-b5a4-e0bd63f3de45.tabs.1.fields.a90b7884-a1ae-4406-9272-d47261cc9f83.sortOrder','1'),('spoonBlockTypes.442ba350-df0e-4f73-a829-432be5815e42.fieldLayout.405529ec-20c5-431d-b5a4-e0bd63f3de45.tabs.1.name','\"Layout\"'),('spoonBlockTypes.442ba350-df0e-4f73-a829-432be5815e42.fieldLayout.405529ec-20c5-431d-b5a4-e0bd63f3de45.tabs.1.sortOrder','2'),('spoonBlockTypes.442ba350-df0e-4f73-a829-432be5815e42.groupName','\"Add Block\"'),('spoonBlockTypes.442ba350-df0e-4f73-a829-432be5815e42.groupSortOrder','1'),('spoonBlockTypes.442ba350-df0e-4f73-a829-432be5815e42.matrixBlockType','\"ca4a9a7e-193b-499a-88cd-b1f889361bc0\"'),('spoonBlockTypes.442ba350-df0e-4f73-a829-432be5815e42.sortOrder','2'),('spoonBlockTypes.57609653-49e4-4da4-a34f-054524eaa959.context','\"global\"'),('spoonBlockTypes.57609653-49e4-4da4-a34f-054524eaa959.field','\"57439ba8-7b9a-4a6f-925c-791faec8269a\"'),('spoonBlockTypes.57609653-49e4-4da4-a34f-054524eaa959.fieldLayout.e5cc210c-5c07-4e10-bb32-30b3a89d2499.tabs.0.fields.03b34141-8ace-49bf-83cd-070779334bac.required','false'),('spoonBlockTypes.57609653-49e4-4da4-a34f-054524eaa959.fieldLayout.e5cc210c-5c07-4e10-bb32-30b3a89d2499.tabs.0.fields.03b34141-8ace-49bf-83cd-070779334bac.sortOrder','1'),('spoonBlockTypes.57609653-49e4-4da4-a34f-054524eaa959.fieldLayout.e5cc210c-5c07-4e10-bb32-30b3a89d2499.tabs.0.name','\"Content\"'),('spoonBlockTypes.57609653-49e4-4da4-a34f-054524eaa959.fieldLayout.e5cc210c-5c07-4e10-bb32-30b3a89d2499.tabs.0.sortOrder','1'),('spoonBlockTypes.57609653-49e4-4da4-a34f-054524eaa959.fieldLayout.e5cc210c-5c07-4e10-bb32-30b3a89d2499.tabs.1.fields.10777443-a139-4a09-a2d1-dcf4c8c93597.required','false'),('spoonBlockTypes.57609653-49e4-4da4-a34f-054524eaa959.fieldLayout.e5cc210c-5c07-4e10-bb32-30b3a89d2499.tabs.1.fields.10777443-a139-4a09-a2d1-dcf4c8c93597.sortOrder','1'),('spoonBlockTypes.57609653-49e4-4da4-a34f-054524eaa959.fieldLayout.e5cc210c-5c07-4e10-bb32-30b3a89d2499.tabs.1.fields.27854c4e-fdce-42da-b6c2-85f68395135f.required','false'),('spoonBlockTypes.57609653-49e4-4da4-a34f-054524eaa959.fieldLayout.e5cc210c-5c07-4e10-bb32-30b3a89d2499.tabs.1.fields.27854c4e-fdce-42da-b6c2-85f68395135f.sortOrder','2'),('spoonBlockTypes.57609653-49e4-4da4-a34f-054524eaa959.fieldLayout.e5cc210c-5c07-4e10-bb32-30b3a89d2499.tabs.1.name','\"Layout\"'),('spoonBlockTypes.57609653-49e4-4da4-a34f-054524eaa959.fieldLayout.e5cc210c-5c07-4e10-bb32-30b3a89d2499.tabs.1.sortOrder','2'),('spoonBlockTypes.57609653-49e4-4da4-a34f-054524eaa959.groupName','\"Add Block\"'),('spoonBlockTypes.57609653-49e4-4da4-a34f-054524eaa959.groupSortOrder','1'),('spoonBlockTypes.57609653-49e4-4da4-a34f-054524eaa959.matrixBlockType','\"bd566221-af4b-40b9-a950-8f04d2c59b8c\"'),('spoonBlockTypes.57609653-49e4-4da4-a34f-054524eaa959.sortOrder','1'),('spoonBlockTypes.edae9a34-d46c-4057-bd73-84e1b63b4ad9.context','\"global\"'),('spoonBlockTypes.edae9a34-d46c-4057-bd73-84e1b63b4ad9.field','\"57439ba8-7b9a-4a6f-925c-791faec8269a\"'),('spoonBlockTypes.edae9a34-d46c-4057-bd73-84e1b63b4ad9.fieldLayout.d8f27a2c-3694-4cc5-8c68-dc46b25fe8d6.tabs.0.fields.d8193927-d011-4f5e-a6f2-244e8be9de3c.required','false'),('spoonBlockTypes.edae9a34-d46c-4057-bd73-84e1b63b4ad9.fieldLayout.d8f27a2c-3694-4cc5-8c68-dc46b25fe8d6.tabs.0.fields.d8193927-d011-4f5e-a6f2-244e8be9de3c.sortOrder','1'),('spoonBlockTypes.edae9a34-d46c-4057-bd73-84e1b63b4ad9.fieldLayout.d8f27a2c-3694-4cc5-8c68-dc46b25fe8d6.tabs.0.name','\"Content\"'),('spoonBlockTypes.edae9a34-d46c-4057-bd73-84e1b63b4ad9.fieldLayout.d8f27a2c-3694-4cc5-8c68-dc46b25fe8d6.tabs.0.sortOrder','1'),('spoonBlockTypes.edae9a34-d46c-4057-bd73-84e1b63b4ad9.fieldLayout.d8f27a2c-3694-4cc5-8c68-dc46b25fe8d6.tabs.1.fields.84a8c477-8e17-4f1a-a658-6602b973979e.required','false'),('spoonBlockTypes.edae9a34-d46c-4057-bd73-84e1b63b4ad9.fieldLayout.d8f27a2c-3694-4cc5-8c68-dc46b25fe8d6.tabs.1.fields.84a8c477-8e17-4f1a-a658-6602b973979e.sortOrder','2'),('spoonBlockTypes.edae9a34-d46c-4057-bd73-84e1b63b4ad9.fieldLayout.d8f27a2c-3694-4cc5-8c68-dc46b25fe8d6.tabs.1.fields.a860e0df-26ec-48e1-9cc7-f78e62f6b07d.required','false'),('spoonBlockTypes.edae9a34-d46c-4057-bd73-84e1b63b4ad9.fieldLayout.d8f27a2c-3694-4cc5-8c68-dc46b25fe8d6.tabs.1.fields.a860e0df-26ec-48e1-9cc7-f78e62f6b07d.sortOrder','1'),('spoonBlockTypes.edae9a34-d46c-4057-bd73-84e1b63b4ad9.fieldLayout.d8f27a2c-3694-4cc5-8c68-dc46b25fe8d6.tabs.1.name','\"Layout\"'),('spoonBlockTypes.edae9a34-d46c-4057-bd73-84e1b63b4ad9.fieldLayout.d8f27a2c-3694-4cc5-8c68-dc46b25fe8d6.tabs.1.sortOrder','2'),('spoonBlockTypes.edae9a34-d46c-4057-bd73-84e1b63b4ad9.groupName','\"Add Block\"'),('spoonBlockTypes.edae9a34-d46c-4057-bd73-84e1b63b4ad9.groupSortOrder','1'),('spoonBlockTypes.edae9a34-d46c-4057-bd73-84e1b63b4ad9.matrixBlockType','\"909cb47c-43ec-42b7-a7c0-c62dca2bbb08\"'),('spoonBlockTypes.edae9a34-d46c-4057-bd73-84e1b63b4ad9.sortOrder','3'),('system.edition','\"solo\"'),('system.live','true'),('system.name','\"Prototype\"'),('system.schemaVersion','\"3.4.10\"'),('system.timeZone','\"America/Los_Angeles\"'),('users.allowPublicRegistration','false'),('users.defaultGroup','null'),('users.photoSubpath','\"\"'),('users.photoVolumeUid','null'),('users.requireEmailVerification','true');
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
/*!40000 ALTER TABLE `relations` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `resourcepaths`
--

LOCK TABLES `resourcepaths` WRITE;
/*!40000 ALTER TABLE `resourcepaths` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `resourcepaths` VALUES ('1103c397','@app/web/assets/utilities/dist'),('11c1cba7','@lib/jquery-ui'),('12db81e9','@craft/web/assets/feed/dist'),('148b7f02','@lib/fileupload'),('17f34be1','@bower/jquery/dist'),('19ce5a44','@app/web/assets/updater/dist'),('1a5b1374','@lib/jquery.payment'),('1b168bee','@lib/axios'),('1f994c15','@app/web/assets/installer/dist'),('243d9d15','@lib/fabric'),('25c80b60','@craft/web/assets/login/dist'),('274fc6d0','@app/web/assets/dashboard/dist'),('2a6c6d98','@app/web/assets/cp/dist'),('2c65ead','@lib/d3'),('2dcebcad','@craft/web/assets/craftsupport/dist'),('2e5278e6','@app/web/assets/login/dist'),('315420b3','@app/web/assets/pluginstore/dist'),('317b492b','@lib/garnishjs'),('36fd289b','@lib/vue'),('37214a15','@app/web/assets/recententries/dist'),('3863e014','@lib/element-resize-detector'),('38b209a1','@app/web/assets/updates/dist'),('3b2d140e','@doublesecretagency/matrixcolors/resources'),('413d4156','@app/web/assets/tablesettings/dist'),('434fffea','@lib/jquery.payment'),('48172f09','@app/web/assets/utilities/dist'),('48d52739','@lib/jquery-ui'),('4a63aec1','@carlcs/redactorcustomstyles/assets/redactorplugin/dist'),('4b3e6522','@craft/web/assets/editentry/dist'),('4ee7a77f','@bower/jquery/dist'),('508fe4e5','@app/web/assets/updateswidget/dist'),('527117f2','@lib/xregexp'),('53772626','@app/web/assets/feed/dist'),('5480227d','@verbb/redactortweaks/resources/dist'),('581d5378','@lib/selectize'),('5e1d4824','@app/web/assets/craftsupport/dist'),('5e327631','@craft/web/assets/cp/dist'),('5f685002','@lib/velocity'),('61770c8a','@lib/element-resize-detector'),('62bd7249','@app/web/assets/matrixsettings/dist'),('67cbc9c','@lib/velocity'),('6b98a722','@craft/web/assets/dashboard/dist'),('6e35a68b','@app/web/assets/recententries/dist'),('709a4ba','@app/web/assets/craftsupport/dist'),('7452444e','@craft/web/assets/matrixsettings/dist'),('7568717e','@angellco/spoon/assetbundles/dist'),('76e191f0','@vendor/craftcms/redactor/lib/redactor'),('80c9427b','@bower/jquery/dist'),('83b17698','@lib/fileupload'),('8639ca0d','@app/web/assets/utilities/dist'),('8923bc95','@rias/colourswatches/assetbundles/colourswatchesfield/dist'),('8a232636','@mmikkel/cpfieldinspect/resources'),('8a624aa4','@craft/web/assets/updateswidget/dist'),('8cb26e4','@app/web/assets/matrix/dist'),('8d611aee','@lib/jquery.payment'),('8f3d4069','@app/web/assets/dbbackup/dist'),('90d30d4a','@app/web/assets/editentry/dist'),('9146b506','@lib/velocity'),('941ed5fe','@carlcs/redactorcustomstyles/assets/redactorplugin/dist'),('95fc5737','@lib/d3'),('9633b67c','@lib/selectize'),('9967a348','@craft/web/assets/pluginstore/dist'),('99b087b','@app/web/assets/updateswidget/dist'),('9b597766','@lib/picturefill'),('9c5ff2f6','@lib/xregexp'),('9cfd4ba4','@lib/jquery-touch-events'),('9d59c322','@app/web/assets/feed/dist'),('9ff12f7e','@app/web/assets/matrix/dist'),('a195a5ff','@app/web/assets/editsection/dist'),('a3a0aa83','@lib/timepicker'),('a63cab8','@app/web/assets/feed/dist'),('a64140b1','@lib/garnishjs'),('abaa6ec7','@app/web/assets/plugins/dist'),('ad10edfc','@mmikkel/cpfieldinspect/resources'),('af59e98e','@lib/element-resize-detector'),('af88003b','@app/web/assets/updates/dist'),('b075cf4a','@app/web/assets/dashboard/dist'),('b307948f','@lib/fabric'),('b333bc45','@vendor/craftcms/redactor/lib/redactor'),('b4d808ca','@craft/web/assets/recententries/dist'),('b7a4e784','@app/web/assets/admintable/dist'),('bbb0c70','@craft/redactor/assets/field/dist'),('bc7423e','@lib/jquery-touch-events'),('bd1b4e95','@craft/web/assets/updater/dist'),('c2357f86','@craft/web/assets/matrix/dist'),('c24d9bf8','@lib/picturefill'),('c2c40389','@craft/web/assets/tablesettings/dist'),('c54b1e68','@lib/xregexp'),('c59a7bbf','@lib/axios'),('c5e9a73a','@lib/jquery-touch-events'),('c637efc','@lib/picturefill'),('c6e5c3e0','@app/web/assets/matrix/dist'),('c7b5ed7f','@app/web/assets/updateswidget/dist'),('c9087fab','@craft/web/assets/cp/dist'),('c92741be','@app/web/assets/craftsupport/dist'),('c9c7e1d4','@app/web/assets/editentry/dist'),('cce8bba9','@lib/d3'),('ce6921c5','@craft/redactor/assets/field/dist'),('cf275ae2','@lib/selectize'),('d5386eea','@lib/axios'),('d7e0bf40','@app/web/assets/updater/dist'),('daa59a06','@lib/fileupload'),('dfef2ea3','@lib/jquery-ui'),('e07c9de2','@app/web/assets/login/dist'),('e96123d4','@app/web/assets/dashboard/dist'),('ea137811','@lib/fabric'),('ee060d9a','@app/web/assets/fields/dist'),('f69ceca5','@app/web/assets/updates/dist'),('f7f7a16','@craft/web/assets/plugins/dist'),('f90faf11','@app/web/assets/recententries/dist'),('fab4461d','@lib/timepicker'),('fd1a62db','@angellco/spoon/assetbundles/dist'),('ff55ac2f','@lib/garnishjs');
/*!40000 ALTER TABLE `resourcepaths` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `revisions`
--

LOCK TABLES `revisions` WRITE;
/*!40000 ALTER TABLE `revisions` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `revisions` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `searchindex`
--

LOCK TABLES `searchindex` WRITE;
/*!40000 ALTER TABLE `searchindex` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `searchindex` VALUES (1,'username',0,1,' support doublesecretagency com '),(1,'firstname',0,1,''),(1,'lastname',0,1,''),(1,'fullname',0,1,''),(1,'email',0,1,' support doublesecretagency com '),(1,'slug',0,1,''),(37,'slug',0,1,' lorem ipsum '),(38,'slug',0,1,''),(39,'slug',0,1,''),(40,'slug',0,1,''),(37,'title',0,1,' lorem ipsum '),(38,'field',2,1,' lorem ipsum dolor sit ametlorem ipsum dolor sit amet consectetur adipiscing elit duis a risus feugiat malesuada nisi sed pulvinar ligula integer quis urna at lacus tincidunt viverra aenean sollicitudin enim ultricies libero vulputate in hendrerit odio faucibus nam eu consectetur quam nunc orci lectus accumsan eu augue eget tristique vestibulum tortor mauris sodales turpis orci ac blandit libero consectetur in sed efficitur enim ligula et sagittis neque cursus in phasellus eu dui facilisis bibendum libero id elementum ante in hac habitasse platea dictumst phasellus eget magna ut libero semper egestas aliquam ornare volutpat posuere integer dapibus urnainteger dapibus urna ut neque ornare vel feugiat eros interdum duis cursus commodo convallis donec lectus ipsum pulvinar eu dui in venenatis molestie risus curabitur mollis risus risus eu finibus est venenatis id donec sit amet libero a mi sagittis luctus et non nibh nullam non rhoncus massa mauris lacinia bibendum lectus pharetra fermentum diam consequat vel nam id purus rutrum molestie mi dignissim rhoncus mi pellentesque nec auctor nulla donec justo ipsumdonec justo ipsum pretium in ornare ut rhoncus eget risus nam tempus finibus magna non ultricies urna gravida ac cras id lectus suscipit imperdiet tellus in pretium ante maecenas nibh erat laoreet fermentum volutpat quis finibus sed dui nullam dolor arcu mattis vitae lectus vel vulputate dictum velit donec commodo accumsan justo ut tempor quisque enim erat dapibus sit amet lectus sit amet tincidunt interdum arcu vivamus vitae ex ligula praesent vel ipsum id nunc tempor tincidunt integer non euismod urna duis non urna non lectus feugiat iaculis quisque elit elit porttitor vitae lacus et consectetur fringilla urna ');
/*!40000 ALTER TABLE `searchindex` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `sections`
--

LOCK TABLES `sections` WRITE;
/*!40000 ALTER TABLE `sections` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `sections` VALUES (1,NULL,'Articles','articles','channel',0,'all',NULL,'2020-02-05 22:49:39','2020-02-05 22:49:39',NULL,'b0ac9541-cb53-4dc6-86e4-56cb0604c874');
/*!40000 ALTER TABLE `sections` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `sections_sites`
--

LOCK TABLES `sections_sites` WRITE;
/*!40000 ALTER TABLE `sections_sites` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `sections_sites` VALUES (1,1,1,1,'articles/{slug}','',1,'2020-02-05 22:49:39','2020-02-05 22:49:39','6ce7b4e4-cc78-4d49-8717-47fe8cddce90');
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
INSERT INTO `sitegroups` VALUES (1,'Prototype','2020-02-05 21:43:45','2020-02-05 21:43:45',NULL,'57cd948a-2dfe-4550-b0f2-053ee01da77c');
/*!40000 ALTER TABLE `sitegroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `sites`
--

LOCK TABLES `sites` WRITE;
/*!40000 ALTER TABLE `sites` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `sites` VALUES (1,1,1,'Prototype','default','en-US',1,'$DEFAULT_SITE_URL',1,'2020-02-05 21:43:45','2020-02-05 21:43:45',NULL,'1891a55f-7f04-4fc8-abfd-3fd84207d90b');
/*!40000 ALTER TABLE `sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `spoon_blocktypes`
--

LOCK TABLES `spoon_blocktypes` WRITE;
/*!40000 ALTER TABLE `spoon_blocktypes` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `spoon_blocktypes` VALUES (16,1,1,4,'Add Block','global',1,1,'2020-02-05 23:33:18','2020-02-05 23:33:18','57609653-49e4-4da4-a34f-054524eaa959'),(17,1,2,6,'Add Block','global',1,2,'2020-02-05 23:33:18','2020-02-05 23:33:18','442ba350-df0e-4f73-a829-432be5815e42'),(18,1,3,8,'Add Block','global',1,3,'2020-02-05 23:33:18','2020-02-05 23:33:18','edae9a34-d46c-4057-bd73-84e1b63b4ad9');
/*!40000 ALTER TABLE `spoon_blocktypes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `structureelements`
--

LOCK TABLES `structureelements` WRITE;
/*!40000 ALTER TABLE `structureelements` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `structureelements` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `structures`
--

LOCK TABLES `structures` WRITE;
/*!40000 ALTER TABLE `structures` DISABLE KEYS */;
set autocommit=0;
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
INSERT INTO `userpreferences` VALUES (1,'{\"language\":\"en-US\"}');
/*!40000 ALTER TABLE `userpreferences` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `users` VALUES (1,'support@doublesecretagency.com',NULL,NULL,NULL,'support@doublesecretagency.com','$2y$13$rQ8/xG8Jz9ZqurEzNBUFcetb0g04Rnob.1xOWqjiBNcnvNxmQ9msS',1,0,0,0,'2020-04-08 22:19:19',NULL,NULL,NULL,'2020-02-05 21:43:56',NULL,1,NULL,NULL,NULL,0,'2020-02-05 21:43:45','2020-02-05 21:43:45','2020-04-08 22:19:19','6fe58302-4703-4c94-ab59-b431c6231623');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `volumefolders`
--

LOCK TABLES `volumefolders` WRITE;
/*!40000 ALTER TABLE `volumefolders` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `volumefolders` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `volumes`
--

LOCK TABLES `volumes` WRITE;
/*!40000 ALTER TABLE `volumes` DISABLE KEYS */;
set autocommit=0;
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
-- Dumping routines for database 'support_prototype'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-04-08 19:09:25
