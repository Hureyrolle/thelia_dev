SET FOREIGN_KEY_CHECKS = 0;

UPDATE `config` SET `value`='2.1.0-alpha2' WHERE `name`='thelia_version';
UPDATE `config` SET `value`='1' WHERE `name`='thelia_minus_version';
UPDATE `config` SET `value`='0' WHERE `name`='thelia_release_version';
UPDATE `config` SET `value`='alpha2' WHERE `name`='thelia_extra_version';

UPDATE `config` SET `name`='form_firewall_active' WHERE `name`='from_firewall_active';

SELECT @max_id := IFNULL(MAX(`id`),0) FROM `config`;

INSERT INTO `config` (`id`, `name`, `value`, `secured`, `hidden`, `created_at`, `updated_at`) VALUES
(@max_id + 1, 'cart.use_persistent_cookie', '1', 0, 0, NOW(), NOW()),
(@max_id + 2, 'cart.cookie_name', 'thelia_cart', 0, 0, NOW(), NOW()),
(@max_id + 3, 'cart.cookie_lifetime', '31536060', 0, 0, NOW(), NOW()),
(@max_id + 4, 'allow_slash_ended_uri', 1, 0, 0, NOW(), NOW())
;


INSERT INTO `config_i18n` (`id`, `locale`, `title`, `description`, `chapo`, `postscriptum`) VALUES
(@max_id + 1, 'en_US', 'Use a persistent cookie to keep track of customer cart', NULL, NULL, NULL),
(@max_id + 1, 'fr_FR', 'Nom du cookie de stockage du panier', NULL, NULL, NULL),
(@max_id + 2, 'en_US', 'Name the cart cookie', NULL, NULL, NULL),
(@max_id + 2, 'fr_FR', 'Nom du cookie de stockage du panier', NULL, NULL, NULL),
(@max_id + 3, 'en_US', 'Life time of the cart cookie in the customer browser, in seconds', NULL, NULL, NULL),
(@max_id + 3, 'fr_FR', 'Durée de vie du cookie du panier dans le navigateur du client, en secondes', NULL, NULL, NULL),
(@max_id + 4, 'en_US', 'Allow slash ended uri', NULL, NULL, NULL),
(@max_id + 4, 'fr_FR', 'Autoriser les URI terminées par un slash', NULL, NULL, NULL)
;

DELETE FROM `config` WHERE `name`='currency_rate_update_url';

SELECT @max_id := IFNULL(MAX(`id`),0) FROM `hook`;

INSERT INTO `hook` (`id`, `code`, `type`, `by_module`, `block`, `native`, `activate`, `position`, `created_at`, `updated_at`) VALUES
  (@max_id+1, 'order-edit.cart-top', 2, 0, 0, 1, 1, 1, NOW(), NOW()),
  (@max_id+2, 'order-edit.cart-bottom', 2, 0, 0, 1, 1, 1, NOW(), NOW()),
  (@max_id+3, 'order-edit.bill-top', 2, 0, 0, 1, 1, 1, NOW(), NOW()),
  (@max_id+4, 'order-edit.bill-bottom', 2, 0, 0, 1, 1, 1, NOW(), NOW()),
  (@max_id+5, 'order-edit.before-order-product-list', 2, 0, 0, 1, 1, 1, NOW(), NOW()),
  (@max_id+6, 'order-edit.before-order-product-row', 2, 0, 0, 1, 1, 1, NOW(), NOW()),
  (@max_id+7, 'order-edit.after-order-product-row', 2, 0, 0, 1, 1, 1, NOW(), NOW()),
  (@max_id+8, 'order-edit.after-order-product-list', 2, 0, 0, 1, 1, 1, NOW(), NOW()),
  (@max_id+9, 'sales.top', 2, 0, 0, 1, 1, 1, NOW(), NOW()),
  (@max_id+10, 'sales.table-header', 2, 0, 0, 1, 1, 1, NOW(), NOW()),
  (@max_id+11, 'sales.table-row', 2, 0, 0, 1, 1, 1, NOW(), NOW()),
  (@max_id+12, 'sales.bottom', 2, 0, 0, 1, 1, 1, NOW(), NOW()),
  (@max_id+13, 'sale.create-form', 2, 0, 0, 1, 1, 1, NOW(), NOW()),
  (@max_id+14, 'sale.delete-form', 2, 0, 0, 1, 1, 1, NOW(), NOW()),
  (@max_id+15, 'sales.js', 2, 0, 0, 1, 1, 1, NOW(), NOW()),
  (@max_id+16, 'product.combinations-row', 2, 0, 1, 1, 1, 1, NOW(), NOW()),
  (@max_id+17, 'main.before-content', 2, 0, 0, 1, 1, 1, NOW(), NOW()),
  (@max_id+18, 'main.after-content', 2, 0, 0, 1, 1, 1, NOW(), NOW())
;

INSERT INTO  `hook_i18n` (`id`, `locale`, `title`, `description`, `chapo`) VALUES
  (@max_id+1, 'en_US', 'Order - cart top', '', ''),
  (@max_id+1, 'fr_FR', 'Commande - panier haut', '', ''),
  (@max_id+2, 'en_US', 'Order - cart bottom', '', ''),
  (@max_id+2, 'fr_FR', 'Commande - panier bas', '', ''),
  (@max_id+3, 'en_US', 'Order - bill top', '', ''),
  (@max_id+3, 'fr_FR', 'Commande - facture haut', '', ''),
  (@max_id+4, 'en_US', 'Order - bill bottom', '', ''),
  (@max_id+4, 'fr_FR', 'Commande - facture bas', '', ''),
  (@max_id+5, 'en_US', 'Order - Before product list', '', ''),
  (@max_id+5, 'fr_FR', 'Commande - Avant la liste des produits', '', ''),
  (@max_id+6, 'en_US', 'Order - Before starting product row', '', ''),
  (@max_id+6, 'fr_FR', 'Commande - Avant d''ouvrir la ligne produit', '', ''),
  (@max_id+7, 'en_US', 'Order - After closing product row', '', ''),
  (@max_id+7, 'fr_FR', 'Commande - Après avoir fermé la ligne produit', '', ''),
  (@max_id+8, 'en_US', 'Order - After product list', '', ''),
  (@max_id+8, 'fr_FR', 'Commande - Après la liste des produits', '', ''),
  (@max_id+9, 'en_US', 'Sales - at the top', '', ''),
  (@max_id+9, 'fr_FR', 'Promotions - en haut', '', ''),
  (@max_id+10, 'en_US', 'Sales - table header', '', ''),
  (@max_id+10, 'fr_FR', 'Promotions - colonne tableau', '', ''),
  (@max_id+11, 'en_US', 'Sales - table row', '', ''),
  (@max_id+11, 'fr_FR', 'Promotions - ligne du tableau', '', ''),
  (@max_id+12, 'en_US', 'Sales - at the bottom', '', ''),
  (@max_id+12, 'fr_FR', 'Promotions - en bas', '', ''),
  (@max_id+13, 'en_US', 'Sale - create form', '', ''),
  (@max_id+13, 'fr_FR', 'Promotion - formulaire de création', '', ''),
  (@max_id+14, 'en_US', 'Sale - delete form', '', ''),
  (@max_id+14, 'fr_FR', 'Promotion - formulaire de suppression', '', ''),
  (@max_id+15, 'en_US', 'Sales - JavaScript', '', ''),
  (@max_id+15, 'fr_FR', 'Promotions - JavaScript', '', ''),
  (@max_id+16, 'en_US', 'Product - at the bottom of a product combination', '', ''),
  (@max_id+16, 'fr_FR', 'Produit - en bas d''une combinaison de déclinaisons', '', ''),
  (@max_id+17, 'en_US', 'Layout - Before the main content', '', ''),
  (@max_id+17, 'fr_FR', 'Layout - Avant le contenu principal', '', ''),
  (@max_id+18, 'en_US', 'Admin layout - After the main content', '', ''),
  (@max_id+18, 'fr_FR', 'Admin layout - Après le contenu principal', '', '')
;

# ======================================================================================================================
# Module version, min & max Thelia version supported
# ======================================================================================================================

ALTER TABLE `module`
  ADD COLUMN `category` VARCHAR(50) DEFAULT 'classic' NOT NULL
  AFTER `type`
;

UPDATE `module` SET `category` = 'classic' WHERE `type` = 1;
UPDATE `module` SET `category` = 'delivery' WHERE `type` = 2;
UPDATE `module` SET `category` = 'payment' WHERE `type` = 3;

ALTER TABLE `module`
  ADD COLUMN `version` VARCHAR(10) DEFAULT '' NOT NULL
  AFTER `code`
;

UPDATE `country` SET `isoalpha2` = 'BH' WHERE `isoalpha3` = 'BHR';
UPDATE `country` SET `isoalpha2` = 'MG' WHERE `isoalpha3` = 'MDG';


SELECT @max_id := IFNULL(MAX(`id`),0) FROM `module`;
SELECT @max_classic_position := IFNULL(MAX(`position`),0) FROM `module` WHERE `type`=1;


INSERT INTO `module` (`id`, `code`, `type`, `activate`, `position`, `full_namespace`, `created_at`, `updated_at`) VALUES
(@max_id+1, 'TheliaSmarty', 1, 1, @max_classic_position+1, 'TheliaSmarty\\TheliaSmarty', NOW(), NOW()),
(@max_id+2, 'VirtualProductControl', 1, 1, @max_classic_position+2, 'VirtualProductControl\\VirtualProductControl', NOW(), NOW())
;

INSERT INTO  `module_i18n` (`id`, `locale`, `title`, `description`, `chapo`, `postscriptum`) VALUES
(@max_id+1, 'en_US',  'Smarty template engine integration', NULL,  NULL,  NULL),
(@max_id+1, 'fr_FR',  'intégration du moteur de template Smarty', NULL,  NULL,  NULL),
(@max_id+2, 'en_US',  'Virtual Product Controller', 'Check if a virtual product delivery module is enabled if at least one product is virtual',  NULL,  NULL),
(@max_id+2, 'fr_FR',  'Contôle de produit virtuel', 'Vérifie qu''un module de livraison pour produit virtuel soit activé si des produits virtuels existent',  NULL,  NULL)
;

SET FOREIGN_KEY_CHECKS = 1;
