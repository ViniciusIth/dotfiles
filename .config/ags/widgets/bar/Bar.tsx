import { App, Astal, Gdk, Gtk } from "astal/gtk4"
import Battery from "widgets/bar/components/Battery"
import Clock from "widgets/bar/components/Clock"
import Weather from "widgets/bar/components/Weather"

const StartWidgets = () => (
    <box spacing={4} halign={Gtk.Align.START}>
        <Weather />
    </box>
)

const CenterWidgets = () => (
    <box spacing={4}>
        <Clock />
    </box>
)

const EndWidgets = () => (
    <box spacing={4} halign={Gtk.Align.END}>
        <Battery />
    </box>
)


export default function Bar(gdkmonitor: Gdk.Monitor) {
    const { TOP, LEFT, RIGHT } = Astal.WindowAnchor

    return <window
        gdkmonitor={gdkmonitor}
        exclusivity={Astal.Exclusivity.EXCLUSIVE}
        anchor={TOP | RIGHT | LEFT}
        application={App}
        visible={true}
    >
        <centerbox cssClasses={["bar"]} valign={Gtk.Align.CENTER}>
            <StartWidgets />
            <CenterWidgets />
            <EndWidgets />
        </centerbox>
    </window >
}
