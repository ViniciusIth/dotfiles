import { App, Astal, Widget, hook } from "astal/gtk4"

type PopupWindowProps = { name: string, cssClasses: string[] } & Widget.WindowProps;

export default function PopupWindow({
    application = App,
    layer = Astal.Layer.OVERLAY,
    keymode = Astal.Keymode.EXCLUSIVE,
    visible = false,
    child, setup,
    cssClasses, ...props }: PopupWindowProps) {

    return (
        <window
            cssClasses={[`popup-window`, ...cssClasses]}
            application={application}
            layer={layer}
            keymode={keymode}
            visible={visible}
            setup={(self) => {
                // hook(self, self, "notify::visible", () => {
                // });
                //
                // if (setup) setup(self);
            }}
            {...props}
        >
            {child}
        </window >
    )
}
