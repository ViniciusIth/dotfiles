import { Gtk, astalify, type ConstructProps } from "astal/gtk4";
// import { GObject } from "astal";
import GObject from "gi://GObject"

export type FlowboxChildProps = ConstructProps<Gtk.FlowBoxChild, Gtk.FlowBoxChild.ConstructorProps>
const FlowboxChild = astalify<Gtk.FlowBoxChild, Gtk.FlowBoxChild.ConstructorProps>(Gtk.FlowBoxChild, {
    // if it is a container widget, define children setter and getter here
    getChildren(self) { return [] },
    setChildren(self, children) { },
})

export default FlowboxChild;
