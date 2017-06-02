#include "qcheapruler.hpp"

#include <QString>

double QCheapRuler::distance() const
{
    return m_distance;
}

double QCheapRuler::currentDistance() const
{
    return m_currentDistance;
}

void QCheapRuler::setCurrentDistance(double current)
{
    m_currentDistance = qMin(qMax(0., current), distance());

    emit currentDistanceChanged();
    emit currentPositionChanged();
}

QGeoCoordinate QCheapRuler::currentPosition() const
{
    if (m_path.empty())
        return QGeoCoordinate(0., 0.);

    cr::point c = ruler().along(m_path, m_currentDistance);

    return QGeoCoordinate(c.y, c.x);
}

QJSValue QCheapRuler::path() const
{
    // Should neveer be called.
    return QJSValue();
}

void QCheapRuler::setPath(const QJSValue &value)
{
    if (!value.isArray())
        return;

    m_path.clear();
    quint32 length = value.property(QStringLiteral("length")).toUInt();

    for (unsigned i = 0; i < length; ++i) {
        auto property = value.property(i);
        cr::point coordinate = { 0., 0. };

        if (property.hasProperty(QStringLiteral("latitude")))
            coordinate.y = property.property(QStringLiteral("latitude")).toNumber();

        if (property.hasProperty(QStringLiteral("longitude")))
            coordinate.x = property.property(QStringLiteral("longitude")).toNumber();

        m_path.push_back(coordinate);
    }

    m_currentDistance = 0.;
    m_distance = ruler().lineDistance(m_path);

    emit pathChanged();
    emit distanceChanged();
    emit currentDistanceChanged();
    emit currentPositionChanged();
}

cr::CheapRuler QCheapRuler::ruler() const
{
    if (m_path.empty()) {
        return cr::CheapRuler(0., cr::CheapRuler::Kilometers);
    } else {
        return cr::CheapRuler(m_path[0].y, cr::CheapRuler::Kilometers);
    }
}
