#pragma once

#include <QGeoCoordinate>
#include <QJSValue>
#include <QObject>

#include <mapbox/cheap_ruler.hpp>

namespace cr = mapbox::cheap_ruler;

class QCheapRuler : public QObject {
    Q_OBJECT
    Q_PROPERTY(double distance READ distance NOTIFY distanceChanged)
    Q_PROPERTY(double currentDistance READ currentDistance WRITE setCurrentDistance NOTIFY currentDistanceChanged)
    Q_PROPERTY(unsigned segmentIndex READ segmentIndex NOTIFY segmentIndexChanged)
    Q_PROPERTY(QGeoCoordinate currentPosition READ currentPosition NOTIFY currentPositionChanged)
    Q_PROPERTY(QJSValue path READ path WRITE setPath NOTIFY pathChanged)

public:
    QCheapRuler() = default;

    double distance() const;

    double currentDistance() const;
    void setCurrentDistance(double);

    unsigned segmentIndex() const;

    QGeoCoordinate currentPosition() const;

    QJSValue path() const;
    void setPath(const QJSValue &value);

signals:
    void distanceChanged();
    void currentDistanceChanged();
    void currentPositionChanged();
    void segmentIndexChanged();
    void pathChanged();

private:
    cr::CheapRuler ruler() const;

    double m_distance = 0.;
    double m_currentDistance = 0.;
    QGeoCoordinate m_currentPosition = QGeoCoordinate(0., 0.);
    unsigned m_segmentIndex = 0;

    cr::line_string m_path;
};
