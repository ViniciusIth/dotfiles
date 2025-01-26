import { exec, GLib, monitorFile } from "astal";
import { App } from "astal/gtk4";

export function reloadCSS() {
    print("reloading css")
    const target = "/tmp/astal/style.css";
    exec(
        `sass ${GLib.getenv("HOME")}/.config/ags/style/main.scss ${target}`,
    );
    App.apply_css(target, true);
}

export function monitorColorsChange() {
    monitorFile(`${GLib.getenv("HOME")}/.config/ags/style/colors.scss`, () => {
        reloadCSS()
    });
}
