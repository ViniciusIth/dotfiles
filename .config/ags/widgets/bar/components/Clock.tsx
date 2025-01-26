import { GLib, Variable } from "astal";
import { Gtk } from "astal/gtk4";

export default function Clock() {
    const timeFormat = "%a %d %b, %H:%M";
    const time = Variable<string>("").poll(
        1000,
        () => GLib.DateTime.new_now_local().format(timeFormat)!
    );

    return (
        <box cssClasses={["clock", "bar-item"]} valign={Gtk.Align.CENTER} >
            <label
                label={time()}
                onDestroy={() => time.drop()}
            />
        </box>
    )
}
