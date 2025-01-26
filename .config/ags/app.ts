import { App, Gdk, Gtk } from "astal/gtk4"
import style from "./style/main.scss"
import Bar from "widgets/bar/Bar"
import Launcher from "windows/launcher/launcher"
import { reloadCSS } from "utils/monitors"

const windows = new Map<Gdk.Monitor, Gtk.Widget[]>();

function makeWindowsForMonitor(monitor: Gdk.Monitor) {
    const bar = Bar(monitor);
    // const notificationCenter = NotificationCenter(monitor);
    return [bar];
}

App.start({
    requestHandler(request: string, res: (response: any) => void) {
        for (const monitor of App.get_monitors()) {
            if (request == "css") {
                reloadCSS()
            }
        }
    },
    css: style,
    main() {
        for (const monitor of App.get_monitors()) {
            windows.set(monitor, makeWindowsForMonitor(monitor));
            Launcher();
        }
    },
})
