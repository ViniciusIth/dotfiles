import { Gtk } from "astal/gtk4";
import AstalApps from "gi://AstalApps";

export default function AppItem(app: AstalApps.Application) {
    return (
        <button
            onClicked={() => app.launch()}
            cssClasses={["app-item"]}
        >
            <box >
                <image iconName={app.icon_name} icon_size={Gtk.IconSize.LARGE} valign={Gtk.Align.CENTER} />
                <box cssClasses={["container"]} vertical={true} valign={Gtk.Align.CENTER}>
                    <label
                        label={app.name}
                        cssClasses={["title"]}
                        valign={Gtk.Align.CENTER}
                        halign={Gtk.Align.START}
                    />
                    <label
                        label={app.description}
                        cssClasses={["description"]}
                        valign={Gtk.Align.CENTER}
                        halign={Gtk.Align.START}
                    />
                </box>
            </box>
        </button>
    )
}
