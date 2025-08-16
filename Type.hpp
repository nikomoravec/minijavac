#pragma once

#include <cstdint>

namespace minijavac
{
    class Type final
    {
    public:
        enum class Kind : uint32_t
        {
            UNKNOWN,
            INTEGER_ARRAY,
            INTEGER,
            BOOLEAN,
            STRING,
            IDENTIFIER
        };

    public:
        Type();
        Type(Kind kind);

        Kind getKind() const;

    private:
        Kind m_kind;
    };
}
