#pragma once

#include <stddef.h>

#ifdef __cplusplus
extern "C" {
#endif

void callfRaw(void* funcPtr, void* pushData, size_t pushSize, void* popData, size_t popType);

#ifdef __cplusplus
}
#endif