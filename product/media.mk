# Media
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/configs/media_codecs.xml:system/etc/media_codecs.xml \
    $(DEVICE_PATH)/configs/media_codecs_performance.xml:system/etc/media_codecs_performance.xml \
    $(DEVICE_PATH)/configs/media_profiles.xml:system/etc/media_profiles.xml \
    $(DEVICE_PATH)/configs/media_profiles.xml:system/etc/media_profiles_vendor.xml \
    $(DEVICE_PATH)/configs/media_profiles_V1_0.xml:system/etc/media_profiles_V1_0.xml \
    $(DEVICE_PATH)/configs/media_profiles_V1_0.xml:system/etc/media_profiles.xml

PRODUCT_COPY_FILES += \
    frameworks/av/media/libstagefright/data/media_codecs_google_audio.xml:system/etc/media_codecs_google_audio.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_telephony.xml:system/etc/media_codecs_google_telephony.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_video.xml:system/etc/media_codecs_google_video.xml

# OMX
PRODUCT_PACKAGES += \
    libc2dcolorconvert \
    libmm-omxcore \
    libOmxAacEnc \
    libOmxAmrEnc \
    libOmxCore \
    libOmxEvrcEnc \
    libOmxQcelp13Enc \
    libOmxSwVencHevc \
    libOmxVdec \
    libOmxVenc \
    libstagefrighthw

# Properties
PRODUCT_PROPERTY_OVERRIDES += \
    drm.service.enabled=true \
    media.aac_51_output_enabled=true \
    mm.enable.smoothstreaming=true \
    vendor.audio.hw.aac.encoder=true \
    vendor.vidc.disable.split.mode=1 \
    vendor.vidc.enc.disable.pq=true \
    vendor.vidc.enc.disable_bframes=1 \
    vidc.enc.narrow.searchrange=1 \
    vidc.disable.split.mode=1 \
    persist.media.treble_omx=false \
    vidc.debug.perf.mode=2
    

# Seccomp policy
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/seccomp/mediacodec-seccomp.policy:$(TARGET_COPY_OUT_VENDOR)/etc/seccomp_policy/mediacodec.policy \
    $(DEVICE_PATH)/seccomp/mediaextractor-seccomp.policy:$(TARGET_COPY_OUT_VENDOR)/etc/seccomp_policy/mediaextractor.policy
