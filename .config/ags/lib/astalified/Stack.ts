import { Gtk, astalify, type ConstructProps } from "astal/gtk4";
// import { GObject } from "astal";
import GObject from "gi://GObject"

export type StackProps = ConstructProps<Gtk.Stack, Gtk.Stack.ConstructorProps>
const Stack = astalify<Gtk.Stack, Gtk.Stack.ConstructorProps>(Gtk.Stack, {
	// if it is a container widget, define children setter and getter here
	getChildren(self) { return [] },
	setChildren(self, children) { },
})

export default Stack;