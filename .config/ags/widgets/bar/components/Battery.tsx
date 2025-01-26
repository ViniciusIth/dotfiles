import { bind } from "astal";
import { Gtk } from "astal/gtk4";
import AstalBattery from "gi://AstalBattery?version=0.1";

export default function Battery() {
    const battery = AstalBattery.get_default();

    return (
        <box cssClasses={["battery", "bar-item"]} valign={Gtk.Align.CENTER} spacing={4}>
            <image iconName={bind(battery, "batteryIconName").as(String)} />
            <label label={
                bind(battery, "percentage").as(
                    (p) => `${p * 100 > 99 ? Math.ceil(p * 100) : Math.floor(p * 100)}%`,
                )
            } />
        </box>
    )
}
