import { bind, Variable } from "astal";
import { App, Gtk, Astal, Widget } from "astal/gtk4";
import AstalApps from "gi://AstalApps";
import AppItem from "windows/launcher/app";
import PopupWindow from "lib/PopupWindow";
import CalculatorEntry from "windows/launcher/calculator";

export default function Launcher() {
    const apps = new AstalApps.Apps();
    const query = Variable<string>("")

    const items = query((text: string) =>
        apps.fuzzy_query(text).map((app: AstalApps.Application) => AppItem(app))
    )

    // Expose the grab focus
    const SearchEntry = Widget.Entry({
        text: bind(query),
        onActivate: () => {
            App.toggle_window("launcher");
        },
        canFocus: true,
        placeholderText: "Search",
        cssClasses: ["search"]
    })

    return (
        <PopupWindow
            name="launcher"
            namespace="launcher"
            cssClasses={["launcher"]}
            visible={false}
            application={App}
            margin={12}
            vexpand={false}
            hexpand={false}
            anchor={Astal.WindowAnchor.TOP | Astal.WindowAnchor.LEFT | Astal.WindowAnchor.RIGHT | Astal.WindowAnchor.BOTTOM}
            setup={(self) => {
                self.connect("notify::visible", () => {
                    SearchEntry.grab_focus();
                })
            }}
        >
            <box vertical={true} cssClasses={["container"]}>
                {SearchEntry}
                <Gtk.ScrolledWindow cssClasses={["entry-list"]} vexpand>
                    <box vertical={true}>
                        {items}
                    </box>
                </Gtk.ScrolledWindow>
            </box>
        </PopupWindow >
    )
}
