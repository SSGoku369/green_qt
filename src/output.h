#ifndef GREEN_OUTPUT_H
#define GREEN_OUTPUT_H

#include <QtQml>
#include <QObject>
#include <QJsonObject>

QT_FORWARD_DECLARE_CLASS(Account)
QT_FORWARD_DECLARE_CLASS(Asset)

class Output : public QObject
{
    Q_OBJECT
    Q_PROPERTY(Account* account READ account CONSTANT)
    Q_PROPERTY(QJsonObject data READ data NOTIFY dataChanged)
    Q_PROPERTY(Asset* asset READ asset NOTIFY assetChanged)
    Q_PROPERTY(bool dust READ dust NOTIFY dustChanged)
    Q_PROPERTY(bool locked READ locked NOTIFY lockedChanged)
    Q_PROPERTY(bool confidential READ confidential NOTIFY confidentialChanged)
    Q_PROPERTY(bool expired READ expired NOTIFY expiredChanged)
    Q_PROPERTY(bool unconfirmed READ unconfirmed NOTIFY unconfirmedChanged)
    Q_PROPERTY(QString addressType READ addressType NOTIFY addressTypeChanged)
    QML_ELEMENT
    QML_UNCREATABLE("Output is instanced by Account.")
public:
    explicit Output(const QJsonObject& data, Account* account);
    Account* account() const { return m_account; }
    Asset* asset() const { return m_asset; }
    QJsonObject data() const { return m_data; }
    void updateFromData(const QJsonObject& data);
    bool dust() const { return m_dust; }
    bool locked() const { return m_locked; }
    bool confidential() const { return m_confidential; }
    bool expired() const { return m_expired; }
    bool unconfirmed() const { return m_unconfirmed; }
    QString addressType() const { return m_address_type; }
signals:
    void dataChanged(const QJsonObject& data);
    void assetChanged(const Asset* asset);
    void dustChanged(bool dust);
    void lockedChanged(bool locked);
    void confidentialChanged(bool confidential);
    void expiredChanged(bool expired);
    void unconfirmedChanged(bool unconfirmed);
    void addressTypeChanged(const QString& address_type);
private:
    void setDust(bool dust);
    void setLocked(bool locked);
    void setConfidential(bool confidential);
    void setExpired(bool expired);
    void setUnconfirmed(bool unconfirmed);
    void setAddressType(const QString& address_type);
public:
    Account* const m_account;
    Asset* m_asset{nullptr};
    QJsonObject m_data;
    bool m_dust{false};
    bool m_locked{false};
    bool m_confidential{false};
    bool m_expired{false};
    bool m_unconfirmed{false};
    QString m_address_type;
};

#endif // GREEN_OUTPUT_H