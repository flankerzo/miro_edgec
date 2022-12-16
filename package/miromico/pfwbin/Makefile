include $(TOPDIR)/rules.mk

PKG_NAME:=pfwbin
PKG_VERSION:=1
PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

define Package/pfwbin
	SECTION:=net
	CATEGORY:=Miromico
	TITLE:=Binaries and config files for the miro Edge
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/pfwbin/install
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_DIR) $(1)/etc/opt
	$(INSTALL_DIR) $(1)/etc/hotplug.d/usb
	$(INSTALL_DIR) $(1)/etc/config
	$(CP) ./files/* $(1)/
endef

$(eval $(call BuildPackage,pfwbin))
