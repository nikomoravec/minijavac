#include "Type.hpp"

namespace minijavac
{
    Type::Type() : m_kind(Kind::UNKNOWN)
    {
    }

    Type::Type(Type::Kind kind) : m_kind(kind)
    {
    }

    Type::Kind Type::getKind() const
    {
        return m_kind;
    }
}
