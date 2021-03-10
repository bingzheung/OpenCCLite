#include <stdint.h>

#ifdef __cplusplus
extern "C"
{
#endif

enum BridgeError {
        BridgeErrorFileNotFound = 1,
        BridgeErrorInvalidFormat,
        BridgeErrorInvalidTextDictionary,
        BridgeErrorInvalidUTF8,
        BridgeErrorUnknown,
} __attribute__((enum_extensibility(open)));

typedef enum BridgeError BridgeError;

BridgeError bridgeError;


typedef void* BridgeDict;

BridgeDict _Nullable createMarisaDict(const char * _Nonnull path);

BridgeDict _Nonnull createDictGroup(BridgeDict _Nonnull * const _Nonnull dictGroup, intptr_t count);


typedef void* BridgeConverter;

BridgeConverter _Nonnull createConverter(const char * _Nonnull name, BridgeDict _Nonnull segmentation, BridgeDict _Nonnull * const _Nonnull conversionChain, intptr_t chainCount);

void destroyConverter(BridgeConverter _Nonnull dict);

typedef void* STLString;

STLString _Nullable converterConvert(BridgeConverter _Nonnull converter, const char * _Nonnull str);

const char* _Nonnull utf8StringFrom(STLString _Nonnull str);

void destroySTLString(STLString _Nonnull str);

#ifdef __cplusplus
}
#endif
