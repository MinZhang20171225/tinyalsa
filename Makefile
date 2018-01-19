#
# Copyright (C) 2012 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_VERSION:=1.1.0
PKG_RELEASE:=1

include $(BUILD_DIR)/package.mk

define Package/tinyplay
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=ALSA play
  DEPENDS:=+alsa-lib +libpthread
endef

define Package/tinymix
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=ALSA mixer
  DEPENDS:=+alsa-lib +libpthread
endef

define Package/tinypcminfo
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=ALSA pcm info
  DEPENDS:=+alsa-lib +libpthread
endef


define Build/Prepare
	mkdir -p $(COMPILE_DIR)/tinyplay
	$(CP) ./src/Makefile_tinyplay $(COMPILE_DIR)/tinyplay/Makefile
	$(CP) ./src/*.c $(COMPILE_DIR)/tinyplay/
	$(CP) ./src/asoundlib.h $(COMPILE_DIR)/tinyplay/

	mkdir -p $(COMPILE_DIR)/tinymix
	$(CP) ./src/Makefile_tinymix $(COMPILE_DIR)/tinymix/Makefile
	$(CP) ./src/*.c $(COMPILE_DIR)/tinymix/
	$(CP) ./src/asoundlib.h $(COMPILE_DIR)/tinymix/

	mkdir -p $(COMPILE_DIR)/tinypcminfo
	$(CP) ./src/Makefile_tinypcminfo $(COMPILE_DIR)/tinypcminfo/Makefile
	$(CP) ./src/*.c $(COMPILE_DIR)/tinypcminfo/
	$(CP) ./src/asoundlib.h $(COMPILE_DIR)/tinypcminfo/
endef



define Build/Compile
	$(MAKE) -C $(COMPILE_DIR)/tinyplay \
		CC="$(TARGET_CC)" \
		CFLAGS="$(TARGET_CFLAGS) -Wall" \
		LDFLAGS="$(TARGET_LDFLAGS)"
	
	$(MAKE) -C $(COMPILE_DIR)/tinymix \
		CC="$(TARGET_CC)" \
		CFLAGS="$(TARGET_CFLAGS) -Wall" \
		LDFLAGS="$(TARGET_LDFLAGS)"
		
	$(MAKE) -C $(COMPILE_DIR)/tinypcminfo \
		CC="$(TARGET_CC)" \
		CFLAGS="$(TARGET_CFLAGS) -Wall" \
		LDFLAGS="$(TARGET_LDFLAGS)"
endef

define Package/tinyplay/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(COMPILE_DIR)/tinyplay/tinyplay $(1)/usr/sbin/

	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(COMPILE_DIR)/tinymix/tinymix $(1)/usr/sbin/

	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(COMPILE_DIR)/tinypcminfo/tinypcminfo $(1)/usr/sbin/
endef

$(eval $(call BuildPackage,tinyplay))
