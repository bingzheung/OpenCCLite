#include "Conversion.hpp"
#include "ConversionChain.hpp"
#include "Converter.hpp"
#include "DictGroup.hpp"
#include "MaxMatchSegmentation.hpp"
#include "MarisaDict.hpp"

#include "bridge.h"

void* catchException(void* (^block)()) {
        try {
                return block();
        } catch (opencc::FileNotFound& ex) {
                bridgeError = BridgeErrorFileNotFound;
                return NULL;
        } catch (opencc::InvalidFormat& ex) {
                bridgeError = BridgeErrorInvalidFormat;
                return NULL;
        } catch (opencc::InvalidTextDictionary& ex) {
                bridgeError = BridgeErrorInvalidTextDictionary;
                return NULL;
        } catch (opencc::InvalidUTF8& ex) {
                bridgeError = BridgeErrorInvalidUTF8;
                return NULL;
        } catch (opencc::Exception& ex) {
                bridgeError = BridgeErrorUnknown;
                return NULL;
        }
}


BridgeDict _Nullable createMarisaDict(const char * _Nonnull path) {
        return catchException(^{
                auto dict = opencc::SerializableDict::NewFromFile<opencc::MarisaDict>(std::string(path));
                auto dictPtr = new opencc::DictPtr(dict);
                return static_cast<void*>(dictPtr);
        });
}

BridgeDict _Nonnull createDictGroup(BridgeDict _Nonnull * const _Nonnull dictGroup, intptr_t count) {
        std::list<opencc::DictPtr> list;
        for (int i = 0; i < count; i++) {
                auto *dictPtr = static_cast<opencc::DictPtr*>(dictGroup[i]);
                list.push_back(*dictPtr);
        }
        auto dict = new opencc::DictGroupPtr(new opencc::DictGroup(list));
        return static_cast<void*>(dict);
}


BridgeConverter _Nonnull createConverter(const char * _Nonnull name, BridgeDict _Nonnull segmentation, BridgeDict _Nonnull * const _Nonnull conversionChain, intptr_t chainCount) {
        auto *segmentationPtr = static_cast<opencc::DictPtr*>(segmentation);
        std::list<opencc::ConversionPtr> conversions;
        for (int i = 0; i < chainCount; i++) {
                auto *dictPtr = static_cast<opencc::DictPtr*>(conversionChain[i]);
                auto conversion = opencc::ConversionPtr(new opencc::Conversion(*dictPtr));
                conversions.push_back(conversion);
        }
        auto covName = std::string(name);
        auto covSeg = opencc::SegmentationPtr(new opencc::MaxMatchSegmentation(*segmentationPtr));
        auto covChain = opencc::ConversionChainPtr(new opencc::ConversionChain(conversions));
        auto converter = new opencc::Converter(covName, covSeg, covChain);
        return static_cast<void*>(converter);
}

void destroyConverter(BridgeConverter _Nonnull dict) {
        auto converter = static_cast<opencc::Converter*>(dict);
        delete converter;
}

STLString _Nullable converterConvert(BridgeConverter _Nonnull converter, const char * _Nonnull str) {
        return catchException(^{
                auto converterPtr = static_cast<opencc::Converter*>(converter);
                auto string = new std::string(converterPtr->Convert(str));
                return static_cast<void*>(string);
        });
}

const char* _Nonnull utf8StringFrom(STLString _Nonnull str) {
        auto string = static_cast<std::string*>(str);
        return string->c_str();
}

void destroySTLString(STLString _Nonnull str) {
        auto string = static_cast<std::string*>(str);
        delete string;
}
