import { clock } from "lib/variables"
import PanelButton from "../PanelButton"
import options from "options"
import icons from "lib/icons"

const n = await Service.import("notifications")
const notifs = n.bind("notifications")

const { format, action } = options.bar.date

const time = Utils.derive([clock, format], (c, f) => c.format(f) || "")

export default () => PanelButton({
    window: "datemenu",
    on_clicked: action.bind(),
    child: Widget.Box([
        Widget.Box({
            children: [
                Widget.Icon(icons.notifications.message),
                Widget.Separator({ margin_left: 8, margin_right: 8 }),
            ],
            visible: notifs.as(n => n.length > 0),
        }),
        Widget.Label({
            justification: "center",
            label: time.bind(),
        })
    ])
})
