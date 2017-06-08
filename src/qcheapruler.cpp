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
    if (m_path.empty()) {
        m_currentDistance = 0.;
        m_currentPosition = QGeoCoordinate(0., 0.);
        m_segmentIndex = 0;

        return;
    }

    double currentDistance = qMin(qMax(0., current), distance());
    if (m_currentDistance != currentDistance) {
        m_currentDistance = currentDistance;
        emit currentDistanceChanged();
    }

    cr::point c = ruler().along(m_path, m_currentDistance);
    if (m_currentPosition != QGeoCoordinate(c.y, c.x)) {
        m_currentPosition = QGeoCoordinate(c.y, c.x);
        emit currentPositionChanged();
    }

    unsigned segmentIndex = ruler().pointOnLine(m_path, c).second;
    if (m_segmentIndex != segmentIndex) {
        m_segmentIndex = segmentIndex;
        emit segmentIndexChanged();
    }
}

QGeoCoordinate QCheapRuler::currentPosition() const
{
    return m_currentPosition;
}

unsigned QCheapRuler::segmentIndex() const
{
    return m_segmentIndex;
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

    double distance = ruler().lineDistance(m_path);
    if (m_distance != distance) {
        m_distance = distance;
        emit distanceChanged();
    }

    setCurrentDistance(0.);

    emit pathChanged();
}

cr::CheapRuler QCheapRuler::ruler() const
{
    if (m_path.empty()) {
        return cr::CheapRuler(0., cr::CheapRuler::Kilometers);
    } else {
        return cr::CheapRuler(m_currentPosition.latitude(), cr::CheapRuler::Kilometers);
    }
}
