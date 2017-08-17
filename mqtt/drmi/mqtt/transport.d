module drmi.mqtt.transport;

import std.exception : enforce;

public import drmi.ps.iface;

import mosquitto;

///
class MqttTransport : Transport
{
private:
    MosquittoClient cli;
    MosquittoClient ecli() @property { return enforce(cli, "cli is null"); }

public:

    ///
    this() { initMosquittoLib(); }

    ///
    void init(string name)
    {
        MosquittoClient.Settings sets;
        sets.clientId = name;
        cli = new MosquittoClient(sets);
    }

    ///
    void connect() { ecli.connect(); }

    ///
    void loop() { ecli.loop(); }

    ///
    void publish(string topic, const(ubyte)[] data, QoS qos)
    { ecli.publish(topic, data, qos); }

    ///
    void subscribe(string topic, void delegate(string, const(ubyte)[]) dlg, QoS qos)
    { ecli.subscribe(topic, dlg, qos); }
}